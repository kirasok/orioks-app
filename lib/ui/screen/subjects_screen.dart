import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';
import 'package:orioks/logic/cubit/subjects_cubit.dart';
import 'package:orioks/ui/widget/discipline_tile.dart';

import 'events_screen.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsCubit, SubjectsState>(builder: (context, state) {
      if (state is SubjectsLoaded) {
        return ListView.builder(
          itemCount: state.subjects.length,
          itemBuilder: (context, index) => DisciplineTile(
            discipline: state.subjects[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<InternetCubit>(context),
                    child: EventsScreen(
                      disciplineName: state.subjects[index].name,
                      disciplineId: state.subjects[index].id,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else if (state is SubjectsLoading) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state is SubjectsFailed) {
        return Text(state.e.toString());
      } else {
        return const Text("Can't load info");
      }
    });
  }
}
