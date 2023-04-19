import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/constants.dart';
import 'package:orioks/data/repository/token_repository.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginState {}

class LoginSuccessful extends LoginState {}

class LoginFailed extends LoginState {
  Object e;
  LoginFailed(this.e) {
    Logger().e(e);
  }
}

class LoginProgress extends LoginState {}

class LoginCubit extends Cubit<LoginState> {
  InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  LoginCubit({required this.internetCubit}) : super(LoginProgress()) {
    try {
      if (internetCubit.state is InternetConnected) {
        writeToken(null, null);
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! LoginSuccessful) {
            writeToken(null, null);
          }
        });
      }
    } catch (e) {
      emit(LoginFailed(e));
    }
  }

  Future<void> writeToken(String? login, String? password) => TokenRepository()
      .get(
        login: login,
        password: password,
      )
      .then((value) => emit(LoginSuccessful()));

  Future<void> enableDemo() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.demoModeKey, true);
    emit(LoginSuccessful());
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
