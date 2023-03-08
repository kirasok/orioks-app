import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/student.dart';
import 'package:orioks/data/repository/student_repository.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';

abstract class StudentState {}

class StudentLoaded extends StudentState {
  Student student;
  StudentLoaded(this.student);
}

class StudentLoading extends StudentState {}

class StudentFailed extends StudentState {
  Object exception;
  StudentFailed(this.exception) {
    Logger().e(exception);
  }
}

class StudentCubit extends Cubit<StudentState> {
  final InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  StudentCubit({required this.internetCubit}) : super(StudentLoading()) {
    try {
      streamSubscription = internetCubit.stream.listen((internetState) {
        if (internetState is InternetDisconnected) {
          throw Exception("No internet connection!");
        } else if (internetState is InternetConnected) {
          StudentRepository().get().then((value) => emit(StudentLoaded(value)));
        }
      });
    } catch (e) {
      emit(StudentFailed(e));
    }
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
