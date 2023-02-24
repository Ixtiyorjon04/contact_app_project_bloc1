

import '../../../../pages/user_model.dart';

abstract class ListState {}

class InitialState extends ListState {}

class LoadingState extends ListState {
  final List<UserModel> users;

  LoadingState(this.users);
}

class SuccessState extends ListState {
  final List<UserModel> users;

  SuccessState(this.users);
}

class FailState extends ListState {
  final String message;

  FailState(this.message);
}
