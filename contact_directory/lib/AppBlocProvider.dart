import 'package:contact_directory/ContactPage/Navigator/ContactPageNavigator.dart';
import 'package:contact_directory/Data/Contact/ContactAPI.dart';
import 'package:contact_directory/Data/Contact/ContactRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ContactPage/BLoC/ContactPageBloc.dart';
import 'ContactPage/BLoC/ContactPageState.dart';
import 'HomePage/BLoC/HomePageBloc.dart';
import 'HomePage/BLoC/HomePageState.dart';
import 'HomePage/Navigator/HomePageNavigator.dart';

class AppBlocProvider {
  List<BlocProvider> getAppBlocProvider() {
    List<BlocProvider> blocProviderList = [
      BlocProvider<HomePageBloc>(
          create: (BuildContext context) =>
              HomePageBloc(HomePageInitialState(), HomePageNavigator(), ContactRepository(api: ContactAPI()))),
      BlocProvider<ContactPageBloc>(
          create: (BuildContext context) => ContactPageBloc(
              ContactPageInitialState(),
              ContactRepository(api: ContactAPI()),
              ContactPageNavigator())),
    ];
    return blocProviderList;
  }
}
