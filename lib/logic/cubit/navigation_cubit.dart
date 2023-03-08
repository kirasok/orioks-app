import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavBarItem { schedule, subjects, student }

class NavigationState extends Equatable {
  final NavBarItem navBarItem;
  final int index;

  const NavigationState(this.navBarItem, this.index);

  @override
  List<Object> get props => [navBarItem, index];
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavBarItem.schedule, 0));

  void getNavBarItem(NavBarItem navBarItem) {
    switch (navBarItem) {
      case NavBarItem.schedule:
        emit(const NavigationState(NavBarItem.schedule, 0));
        break;
      case NavBarItem.subjects:
        emit(const NavigationState(NavBarItem.subjects, 1));
        break;
      case NavBarItem.student:
        emit(const NavigationState(NavBarItem.student, 2));
        break;
    }
  }
}
