
import '../input/input_page.dart';
import 'bloc_new/list_bloc.dart';
import 'bloc_new/list_event.dart';
import 'bloc_new/list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final bloc = ListBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final state = snapshot.data ?? ListState();
          return Scaffold(
            appBar: AppBar(title: Text("ListPage: ${state.users.length}")),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case Status.loading:
                  case Status.success:
                    return ListView.separated(
                      itemCount: state.users.length +
                          (state.status == Status.loading ? 1 : 0),
                      separatorBuilder: (_, i) => const Divider(thickness: 5),
                      itemBuilder: (context, index) {
                        if (state.users.length == index) {
                          return Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }
                        final user = state.users[index];
                        return Text(
                          "User = ${user.name}, phone = ${user.phone}",
                          style: const TextStyle(fontSize: 32),
                        );
                      },
                    );
                  case Status.fail:
                  case Status.initial:
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(fontSize: 32),
                      ),
                    );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => InputPage(
                      callback: (name, phone) {
                        bloc.event.add(AddEvent(name, phone));
                        //print("$name, $phone");
                      },
                    ),
                  ),
                );
              },
            ),
          );
        });
    // return Scaffold(
    //   appBar: AppBar(title: const Text("ListPage")),
    //   body: StreamBuilder<ListState>(
    //       stream: bloc.stream,
    //       initialData: InitialState(),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           final state = snapshot.data ?? InitialState();
    //           if (state is FailState) {
    //             return Center(
    //               child: Text(
    //                 state.message,
    //                 style: const TextStyle(fontSize: 32),
    //               ),
    //             );
    //           }
    //           if (state is LoadingState) {
    //             if (state.users.isEmpty) {
    //               return const Center(child: CircularProgressIndicator());
    //             }
    //             return ListView.separated(
    //               itemCount: state.users.length + 1,
    //               separatorBuilder: (_, i) => const Divider(thickness: 5),
    //               itemBuilder: (context, index) {
    //                 if (state.users.length == index) {
    //                   return Container(
    //                     height: 40,
    //                     alignment: Alignment.center,
    //                     child: const CircularProgressIndicator(),
    //                   );
    //                 }
    //                 final user = state.users[index];
    //                 return Text(
    //                   "User = ${user.name}, phone = ${user.phone}",
    //                   style: const TextStyle(fontSize: 32),
    //                 );
    //               },
    //             );
    //           }
    //           if (state is SuccessState) {
    //             return ListView.separated(
    //               itemCount: state.users.length,
    //               separatorBuilder: (_, i) => const Divider(thickness: 5),
    //               itemBuilder: (context, index) {
    //                 final user = state.users[index];
    //                 return GestureDetector(
    //                   onTap: () {
    //                     bloc.event.add(DeleteEvent(index));
    //                   },
    //                   behavior: HitTestBehavior.opaque,
    //                   child: Text(
    //                     "User = ${user.name}, phone = ${user.phone}",
    //                     style: const TextStyle(fontSize: 32),
    //                   ),
    //                 );
    //               },
    //             );
    //           }
    //         }
    //         return Center(
    //           child: Text(
    //             "${snapshot.data}",
    //             style: const TextStyle(fontSize: 32),
    //           ),
    //         );
    //       }),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         CupertinoPageRoute(
    //           builder: (_) => InputPage(
    //             callback: (name, phone) {
    //               bloc.event.add(AddEvent(name, phone));
    //               //print("$name, $phone");
    //             },
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
