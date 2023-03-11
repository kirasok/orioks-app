import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/logic/cubit/events_cubit.dart';
import 'package:orioks/ui/widget/event_tile.dart';

class EventsScreen extends StatelessWidget {
  final Discipline discipline;

  const EventsScreen({super.key, required this.discipline});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(discipline.name),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        if (state is EventsLoaded) {
          List<Widget> teachers = [];
          for (var value in discipline.teachers) {
            teachers.add(
              Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          List<Widget> disciplineInformations = [
                Text(
                  discipline.departament,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                discipline.examDate != ""
                    ? Text(discipline.examDate)
                    : const SizedBox(),
              ] +
              teachers +
              [const Divider()];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: disciplineInformations +
                [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          EventTile(event: state.events[index]),
                      itemCount: state.events.length,
                    ),
                  ),
                ],
          );
        } else if (state is EventsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is EventsFailed) {
          return Text(state.e.toString());
        } else {
          return const Text("Failed to fetch data");
        }
      }),
    );
  }
}
