import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';
import 'package:orioks/logic/cubit/tokens_cubit.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final studentState = context.watch<StudentCubit>().state;
        final tokensState = context.watch<TokensCubit>().state;
        if (studentState is StudentLoaded && tokensState is TokensLoaded) {
          return Column(
            children: [
              Text(
                studentState.student.department,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                studentState.student.group,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                studentState.student.fullName,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Divider(),
              Text(studentState.student.studyDirection),
              Text(studentState.student.studyProfile),
              Text("Course ${studentState.student.course}"),
              Text("Semester ${studentState.student.semester}"),
              Text(studentState.student.year),
              // TODO: list notifications
              // TODO: list tokens
              Column(
                children: List<Widget>.from(
                    tokensState.tokens.map((e) => Text(e.token))),
              )
            ],
          );
        } else if (studentState is StudentLoading ||
            tokensState is TokensLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return const Text("Can't load info!");
        }
      },
    );
  }
}
