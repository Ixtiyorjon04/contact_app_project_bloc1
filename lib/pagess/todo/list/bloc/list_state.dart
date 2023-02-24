part of 'list_bloc.dart';

@immutable
class ListState {
  final Status status;
  final List<UserModel> users;
  final String message;

  const ListState({
    this.status = Status.initial,
    this.users = const [],
    this.message = "",
  });

  ListState copyWith({
    Status? status,
    List<UserModel>? users,
    String? message,
  }) {
    return ListState(
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }
}

enum Status { initial, loading, success, fail }
