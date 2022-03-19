import 'package:contact_directory/HomePage/BLoC/HomePageBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BLoC/HomePageEvent.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Directory"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<HomePageBloc>(context)
              .add(HomePageSwitchToNewContactPageEvent(context: context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
