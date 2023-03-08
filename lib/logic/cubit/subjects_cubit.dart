import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/data/repository/disciplines_repository.dart';

import 'internet_cubit.dart';

abstract class SubjectsState {}

class SubjectsLoaded extends SubjectsState {
  final List<Discipline> subjects;
  SubjectsLoaded(this.subjects);
}

class SubjectsLoading extends SubjectsState {}

class SubjectsFailed extends SubjectsState {
  final Object e;
  SubjectsFailed(this.e) {
    Logger().e(e);
  }
}

class SubjectsCubit extends Cubit<SubjectsState> {
  final InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  SubjectsCubit({required this.internetCubit}) : super(SubjectsLoading()) {
    try {
      if (internetCubit.state is InternetConnected) {
        loadSubjects();
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! SubjectsLoaded) {
            loadSubjects();
          }
        });
      }
    } catch (e) {
      emit(SubjectsFailed(e));
    }
  }

  Future<void> loadSubjects() => DisciplinesRepository()
      .get()
      .then((value) => emit(SubjectsLoaded(value)));

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
