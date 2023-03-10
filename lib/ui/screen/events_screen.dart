import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/events_cubit.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';

class EventsScreen extends StatelessWidget {
  final int disciplineId;

  const EventsScreen({super.key, required this.disciplineId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(
        disciplineId: disciplineId,
        internetCubit: BlocProvider.of<InternetCubit>(context),
      ),
      child: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        if (state is EventsLoaded) {
          return Text(state.events.first.name ?? "NULL");
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
