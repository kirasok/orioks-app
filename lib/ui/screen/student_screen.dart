import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentLoaded) {
          return Column(
            children: [
              Text(
                state.student.department,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                state.student.group,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                state.student.fullName,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Divider(),
              Text(state.student.studyDirection),
              Text(state.student.studyProfile),
              Text("Course ${state.student.course}"),
              Text("Semester ${state.student.semester}"),
              Text(state.student.year),
              // TODO: list notifications
              // TODO: list tokens
            ],
          );
        } else if (state is StudentLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is StudentFailed) {
          return Text(state.exception.toString());
        } else {
          return const Text("Can't load info!");
        }
      },
    );
  }
}
