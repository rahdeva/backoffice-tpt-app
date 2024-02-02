// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import '/model/user.dart';

enum AppType { 
  INITIAL, 
  UNAUTHENTICATED, 
  LOAD, 
  AUTHENTICATED,
}

class AuthState extends Equatable {
  final UserData? user;
  final AppType appStatus;

  const AuthState({this.user, this.appStatus = AppType.INITIAL});

  AuthState copyWith({
    UserData? user,
    AppType? appStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      appStatus: appStatus ?? this.appStatus,
    );
  }

  @override
  List<Object?> get props => [user, appStatus];
}
