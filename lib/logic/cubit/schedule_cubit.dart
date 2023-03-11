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

  List<ScheduleItem> getScheduleOnDay(DateTime now) {
    if (now.weekday == 6) now = now.add(const Duration(days: 2));
    if (now.weekday == 7) now = now.add(const Duration(days: 1));
    final difference = now.difference(schedule.sessionStart ?? DateTime.now());
    int week = difference.inDays ~/
        7 %
        scheduleOfGroup.pairs.first.weekRecurrence.toInt();
    List<ScheduleItem> list = List.from(scheduleOfGroup.pairs.where(
        (element) => element.week == week && element.day == now.weekday - 1));
    list.sort((a, b) => a.pair.compareTo(b.pair));
    return list;
  }
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
