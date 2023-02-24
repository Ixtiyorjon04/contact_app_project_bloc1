

import '../user_model.dart';

enum Status { initial, loading, success, fail }

class ListState {
  final Status status;
  final List<UserModel> users;
  final String message;

  ListState({
    this.status = Status.initial,
    this.users = const [],
    this.message = "",
  });
}
