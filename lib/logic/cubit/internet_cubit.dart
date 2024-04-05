import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {}

class InternetDisconnected extends InternetState {}

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivity.checkConnectivity().then((value) => _emit(value.last));
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) => _emit(event.last));
  }

  void _emit(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        emit(InternetConnected());
        break;
      case ConnectivityResult.none:
      default:
        emit(InternetDisconnected());
    }
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
