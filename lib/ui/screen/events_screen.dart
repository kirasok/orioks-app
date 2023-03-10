import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/events_cubit.dart';
import 'package:orioks/ui/widget/event_tile.dart';

class EventsScreen extends StatelessWidget {
  final int disciplineId;
  final String disciplineName;

  const EventsScreen(
      {super.key, required this.disciplineId, required this.disciplineName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disciplineName),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        if (state is EventsLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) =>
                EventTile(event: state.events[index]),
            itemCount: state.events.length,
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
