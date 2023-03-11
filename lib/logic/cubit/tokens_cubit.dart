import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/token.dart';
import 'package:orioks/data/repository/token_repository.dart';

import 'internet_cubit.dart';

abstract class TokensState {}

class TokensLoaded extends TokensState {
  List<Token> tokens;
  TokensLoaded({required this.tokens});
}

class TokensLoading extends TokensState {}

class TokensFailed extends TokensState {
  Object e;
  TokensFailed(this.e) {
    Logger().e(e);
  }
}

class TokensCubit extends Cubit<TokensState> {
  final InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  TokensCubit({required this.internetCubit}) : super(TokensLoading()) {
    try {
      if (internetCubit.state is InternetConnected) {
        loadTokens();
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! TokensLoaded) {
            loadTokens();
          }
        });
      }
    } catch (e) {
      emit(TokensFailed(e));
    }
  }

  Future<void> loadTokens() => TokenRepository()
      .getAllTokens()
      .then((value) => emit(TokensLoaded(tokens: value)));

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
