import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/student.dart';
import 'package:orioks/data/model/token.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';
import 'package:orioks/logic/cubit/tokens_cubit.dart';
import 'package:orioks/ui/widget/token_tile.dart';

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
          final tokensState = context.watch<TokensCubit>().state;
          if (studentState is StudentLoaded && tokensState is TokensLoaded) {
            return Column(
              children: _generateStudentWidget(studentState.student) +
                  _generateTokensWidget(tokensState.tokens, context),
            );
          } else if (studentState is StudentLoading ||
              tokensState is TokensLoading) {
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

  List<Widget> _generateTokensWidget(
          List<Token> tokens, BuildContext context) =>
      [
        const SizedBox(
          height: 8,
        ),
        Text(
          "Tokens",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tokens.length,
            itemBuilder: (context, index) => TokenTile(token: tokens[index]),
          ),
        ),
      ];
}
