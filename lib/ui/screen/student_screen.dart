import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/student.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) {
          final studentState = context.watch<StudentCubit>().state;
          if (studentState is StudentLoaded) {
            return Column(
              children: _generateStudentWidget(studentState.student),
            );
          } else if (studentState is StudentLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return const Text("Can't load info!");
          }
        },
      );

  List<Widget> _generateStudentWidget(Student student) => [
        Text(
          student.department,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
        Text(
          student.group,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        Text(
          student.fullName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const Divider(),
        Text(student.studyDirection),
        Text(student.studyProfile),
        Text("Course ${student.course}"),
        Text("Semester ${student.semester}"),
        Text(student.year),
        // TODO: list notifications
      ];
}
