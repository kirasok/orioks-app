import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/student.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) {
          var localizations = AppLocalizations.of(context);
          final studentState = context.watch<StudentCubit>().state;
          if (studentState is StudentLoaded) {
            return Column(
              children:
                  _generateStudentWidget(studentState.student, localizations),
            );
          } else if (studentState is StudentLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return const Text("Can't load info!");
          }
        },
      );

  List<Widget> _generateStudentWidget(
          Student student, AppLocalizations? localizations) =>
      [
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
        Text("${localizations!.course} ${student.course}"),
        Text("${localizations.semester} ${student.semester}"),
        Text(student.year),
        // TODO: list notifications
      ];
}
