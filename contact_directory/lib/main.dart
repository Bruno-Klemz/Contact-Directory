import 'package:contact_directory/AppBlocProvider.dart';
import 'package:contact_directory/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: AppBlocProvider().getAppBlocProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'initialRoute',
        onGenerateRoute: AppRouter.navigate,
      )));
}
