import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/schedule_of_group.dart';
import 'package:orioks/logic/cubit/schedule_cubit.dart';
import 'package:orioks/ui/widget/schedule_title.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(builder: (context, state) {
      // TODO: handle double pairs
      if (state is ScheduleLoaded) {
        var schedule =
            List<ScheduleItem>.from(state.getScheduleOnDay(DateTime.now()));
        return ListView.builder(
          itemBuilder: (context, index) => ScheduleTile(
            timetable: state.timetable,
            pair: schedule[index],
          ),
          itemCount: schedule.length,
        );
      } else if (state is ScheduleLoading) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state is ScheduleFailed) {
        return Text(state.e.toString());
      } else {
        return const Text("Can't load info!");
      }
    });
  }
}
