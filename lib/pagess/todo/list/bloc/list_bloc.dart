import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../user_model.dart';

part 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const ListState()) {
    on<AddEvent>((event, emit) => _emitAdd(event, emit));
    on<DeleteEvent>((event, emit) => _emitDelete(event, emit));
  }

  Future<void> _emitAddOld(AddEvent event, Emitter<ListState> emit) async {
    emit(ListState(
      status: Status.loading,
      users: state.users,
      message: state.message,
    ));
    await Future.delayed(const Duration(seconds: 1));

    emit(ListState(
      status: Status.fail,
      users: state.users,
      message: "Xatolik",
    ));
    await Future.delayed(const Duration(seconds: 1));

    //state.users; // o'zgaruvchilarni olish uchun
    //state.users.add(UserModel(event.name, event.phone));//bunaqa ishlatilmaydi
    final list = <UserModel>[];
    list.addAll(state.users);
    list.add(UserModel(event.name, event.phone));
    emit(ListState(status: Status.success, users: list, message: ""));
  }

  Future<void> _emitAdd(AddEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: Status.fail, message: "Xatolik"));
    await Future.delayed(const Duration(seconds: 1));

    //state.users; // o'zgaruvchilarni olish uchun
    //state.users.add(UserModel(event.name, event.phone));//bunaqa ishlatilmaydi

    // final list = <UserModel>[];
    // list.addAll(state.users);
    // list.add(UserModel(event.name, event.phone));

    // final list = <UserModel>[...[],UserModel("name", "phone"),...[]];//..addAll([]);

    emit(state.copyWith(
      status: Status.success,
      users: [...state.users, UserModel(event.name, event.phone)],
    ));

    // emit(state.copyWith(status: Status.loading));
    // try {
    //   emit(state.copyWith(
    //     status: Status.success,
    //     users: await _api.users(),
    //   ));
    // } catch (e) {
    //   emit(state.copyWith(status: Status.fail, message: "$e"));
    // }
  }

  Future<void> _emitDelete(DeleteEvent event, Emitter<ListState> emit) async {}
}
