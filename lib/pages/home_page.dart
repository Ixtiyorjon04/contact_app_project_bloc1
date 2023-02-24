import 'package:contact_app_project_bloc/pages/bloc_new/list_state.dart';
import 'package:flutter/material.dart';

import 'bloc_new/list_bloc.dart';
import 'bloc_new/list_event.dart';

class HomePage1 extends StatefulWidget {
  HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  final bloc = ListBloc();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    numbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final state = snapshot.data ?? ListState();
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text("Contact App"),
              centerTitle: true,
            ),
            body: Builder(builder: (context) {
              switch (state.status) {
                case Status.loading:
                case Status.success:
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.users.length +
                            (state.status == Status.loading ? 1 : 0),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                                  if(state.users.length == index){
                                    return Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(),
                                    );
                                  }
                          return ListTile(
                            leading: Icon(Icons.perm_contact_cal_outlined),
                            title: Text(user.name),
                            subtitle: Text(user.phone),
                            trailing: Icon(Icons.arrow_forward_ios),
                          );
                        }),
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
            }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Add Contact",
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextField(
                          controller: namecontroller,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: numbercontroller,
                          decoration: const InputDecoration(
                            hintText: "Number",
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  callback:
                                  (name, phone) {
                                    bloc.event.add(AddEvent(name, phone));
                                    //print("$name, $phone");
                                    Navigator.pop(context);
                                  };
                                },
                                child: Text("Send")))
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
