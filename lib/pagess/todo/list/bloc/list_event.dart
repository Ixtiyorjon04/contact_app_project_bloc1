part of 'list_bloc.dart';

@immutable
abstract class ListEvent {}

class AddEvent extends ListEvent {
  final String name;
  final String phone;

  AddEvent(this.name, this.phone);
}

class DeleteEvent extends ListEvent {
  final int index;

  DeleteEvent(this.index);
}
