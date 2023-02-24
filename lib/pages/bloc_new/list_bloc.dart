import 'dart:async';

import '../user_model.dart';
import 'list_event.dart';
import 'list_state.dart';

class ListBloc {
  // final Api _api;
  final _eventController = StreamController<ListEvent>();
  final _stateController = StreamController<ListState>();

  ListBloc() {
    _eventController.stream.listen((event) async {
      if (event is AddEvent) {
        // try{
        //   // _stateController.add(await _api.products());
        //   //
        // }catch(e){}
        _stateController.add(ListState(
          status: Status.loading,
          users: _list,
        ));
        await Future.delayed(const Duration(seconds: 1));
        _list.add(UserModel(event.name, event.phone));
        _stateController.add(ListState(
          status: Status.success,
          users: _list,
        ));
        //_stateController.add(FailState("${_list}"));
      } else if (event is DeleteEvent) {
        if (_list.length > event.index) {
          _list.removeAt(event.index);
          _stateController.add(ListState(
            status: Status.success,
            users: _list,
          ));
        } else {
          _stateController.add(ListState(status: Status.fail, message: "Xato"));
        }
      }
    });
  }

  final _list = <UserModel>[];

  void close() {
    _stateController.close();
    _eventController.close();
  }

  StreamSink<ListEvent> get event => _eventController.sink;

  Stream<ListState> get stream => _stateController.stream;
}
