import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/group.dart';
import 'package:orioks/data/model/schedule.dart';
import 'package:orioks/data/model/schedule_of_group.dart';
import 'package:orioks/data/model/timetable.dart';
import 'package:orioks/data/repository/schedule_of_group_repository.dart';
import 'package:orioks/data/repository/schedule_repository.dart';
import 'package:orioks/data/repository/timetable_repository.dart';

import 'groups_cubit.dart';
import 'internet_cubit.dart';
import 'student_cubit.dart';

abstract class ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  Timetable timetable;
  Schedule schedule;
  ScheduleOfGroup scheduleOfGroup;
  ScheduleLoaded(
      {required this.timetable,
      required this.schedule,
      required this.scheduleOfGroup});

  ScheduleOfGroup getScheduleOnDay(DateTime datetime) {
    final week = getWeekNumberOnDay(datetime) % 2;
    // Select pairs on the current week and weekday
    scheduleOfGroup.pairs = List.from(scheduleOfGroup.pairs.where((element) =>
        element.week == week && element.day == datetime.weekday - 1));
    // On 2023-04-19 server sends double pairs in one object
    List<ScheduleItem> list = List.from(scheduleOfGroup.pairs);
    for (var element in scheduleOfGroup.pairs) {
      if (element.name.endsWith("(2 пары)")) {
        element.name = element.name.replaceAll("(2 пары)", "");
        ScheduleItem second = element.copy();
        second.pair++;
        list.add(second);
      }
    }
    // On 2023-04-19 server sends pair with variable location in two objects
    for (int a = 0; a < list.length - 1; a++) {
      for (int b = a + 1; b < list.length; b++) {
        if (a != b) {
          if (list[a].name == list[b].name &&
              list[a].day == list[b].day &&
              list[a].pair == list[b].pair) {
            list[a].location = "${list[a].location}\n${list[b].location}";
            list.removeAt(b);
          }
        }
      }
    }
    // Sort list by class
    list.sort((a, b) => a.pair.compareTo(b.pair));
    // Return schedule of group
    scheduleOfGroup.pairs = list;
    return scheduleOfGroup;
  }

  ScheduleOfGroup getScheduleOnToday() => getScheduleOnDay(DateTime.now());

  int getWeekNumberOnDay(DateTime datetime) {
    // Move to the next week if it's weekend
    if (datetime.weekday == 6) datetime = datetime.add(const Duration(days: 2));
    if (datetime.weekday == 7) datetime = datetime.add(const Duration(days: 1));
    // Find the difference between the start of current week and start of week when semester started
    final weekstart = datetime.subtract(Duration(days: datetime.weekday));
    final scheduleStart = schedule.semesterStart ?? DateTime.now();
    final difference = weekstart.difference(
        scheduleStart.subtract(Duration(days: scheduleStart.weekday)));
    // Find if it's numerator or denominator
    return difference.inDays ~/ 7;
  }

  int getWeekNumberOnToday() => getWeekNumberOnDay(DateTime.now());
}

class ScheduleLoading extends ScheduleState {}

class ScheduleFailed extends ScheduleState {
  Object e;
  ScheduleFailed(this.e) {
    Logger().e(e);
  }
}

class ScheduleCubit extends Cubit<ScheduleState> {
  final InternetCubit internetCubit;
  final StudentCubit studentCubit;
  final GroupsCubit groupsCubit;
  StreamSubscription? internetSubscription;
  StreamSubscription? studentSubscription;
  StreamSubscription? groupsSubscription;

  ScheduleCubit(
      {required this.internetCubit,
      required this.studentCubit,
      required this.groupsCubit})
      : super(ScheduleLoading()) {
    try {
      if (internetCubit.state is InternetConnected &&
          studentCubit.state is StudentLoaded &&
          groupsCubit.state is GroupsLoaded) {
        loadSchedule(loadGroupId());
      } else {
        internetSubscription = internetCubit.stream.listen((internetState) {
          if (internetCubit.state is InternetConnected &&
              studentCubit.state is StudentLoaded &&
              groupsCubit.state is GroupsLoaded) {
            loadSchedule(loadGroupId());
          }
        });
        studentSubscription = studentCubit.stream.listen((event) {
          if (internetCubit.state is InternetConnected &&
              studentCubit.state is StudentLoaded &&
              groupsCubit.state is GroupsLoaded) {
            loadSchedule(loadGroupId());
          }
        });
        groupsSubscription = groupsCubit.stream.listen((event) {
          if (internetCubit.state is InternetConnected &&
              studentCubit.state is StudentLoaded &&
              groupsCubit.state is GroupsLoaded) {
            loadSchedule(loadGroupId());
          }
        });
      }
    } catch (e) {
      emit(ScheduleFailed(e));
    }
  }

  Future<void> loadSchedule(int groupId) async {
    Future<Schedule> schedule = ScheduleRepository().get();
    Future<Timetable> timetable = TimetableRepository().get();
    Future<ScheduleOfGroup> scheduleOfGroup =
        ScheduleOfGroupRepository().get(groupId);
    Future.wait([timetable, schedule, scheduleOfGroup]).then((value) => {
          emit(
            ScheduleLoaded(
              timetable: value[0] as Timetable,
              schedule: value[1] as Schedule,
              scheduleOfGroup: value[2] as ScheduleOfGroup,
            ),
          ),
        });
  }

  int loadGroupId() {
    String group = (studentCubit.state as StudentLoaded).student.group;
    List<Group> list = (groupsCubit.state as GroupsLoaded).groups;
    list = List.from(
      list.map(
        (e) => Group(
          id: e.id,
          name: e.name.split(" ")[0],
        ),
      ),
    );
    for (var value in list) {
      if (value.name == group) return value.id;
    }
    return list[0].id;
  }

  @override
  Future<void> close() {
    internetSubscription?.cancel();
    studentSubscription?.cancel();
    groupsSubscription?.cancel();
    return super.close();
  }
}
