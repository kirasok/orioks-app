import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/group.dart';
import 'package:orioks/data/repository/groups_repository.dart';

import 'internet_cubit.dart';

abstract class GroupsState {}

class GroupsLoaded extends GroupsState {
  List<Group> groups;
  GroupsLoaded(this.groups);
}

class GroupsLoading extends GroupsState {}

class GroupsFailed extends GroupsState {
  Object e;
  GroupsFailed(this.e) {
    Logger().e(e);
  }
}

class GroupsCubit extends Cubit<GroupsState> {
  final InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  GroupsCubit({required this.internetCubit}) : super(GroupsLoading()) {
    try {
      if (internetCubit.state is InternetConnected) {
        loadGroups();
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! GroupsFailed) {
            loadGroups();
          }
        });
      }
    } catch (e) {
      emit(GroupsFailed(e));
    }
  }

  Future<void> loadGroups() =>
      GroupsRepository().get().then((value) => emit(GroupsLoaded(value)));

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
