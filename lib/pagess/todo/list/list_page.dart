
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../input/input_page.dart';
import 'bloc/list_bloc.dart';

class ListPage extends StatelessWidget {
  final String name;

  const ListPage({Key? key, required this.name}) : super(key: key);

  Widget get page {
    return BlocProvider(
      create: (context) => ListBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ListBloc>().add(AddEvent("name", "phone"));
    // context.watch<ListBloc>().state.users;
    final bloc = context.read<ListBloc>();
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Builder(
            builder: (context) {
              switch (state.status) {
                case Status.initial:
                  return const Center(
                    child: Text(
                      "message",
                      style: TextStyle(fontSize: 32),
                    ),
                  );
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.success:
                  return Center(
                    child: Text(
                      "${state.users.length}",
                      style: const TextStyle(fontSize: 32),
                    ),
                  );
                case Status.fail:
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
                MaterialPageRoute(
                  builder: (_) => InputPage(
                    callback: (name, phone) => bloc.add(
                      AddEvent(name, phone),
                    ),
                  ).page,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
