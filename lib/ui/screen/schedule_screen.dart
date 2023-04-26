import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/schedule_cubit.dart';
import 'package:orioks/ui/widget/schedule_title.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(builder: (context, state) {
      if (state is ScheduleLoaded) {
        var localizations = AppLocalizations.of(context);
        var schedule = state.getScheduleOnToday();
        var week = state.getWeekNumberOnToday();
        final List<Widget> list = [];
        String d = week % 2 == 0
            ? localizations!.numerator
            : localizations!.denominator;
        list.add(
          Center(
            child: Text(
              "${localizations.week} $week",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
        list.add(
          Center(
            child: Text(
              d,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
        for (var pair in schedule.pairs) {
          list.add(ScheduleTile(timetable: state.timetable, pair: pair));
        }
        return ListView.builder(
          itemBuilder: (context, index) => list[index],
          itemCount: list.length,
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
