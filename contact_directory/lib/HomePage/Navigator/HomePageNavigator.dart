import 'package:flutter/material.dart';

import '../BLoC/HomePageEvent.dart';

class HomePageNavigator {
  void navigate(HomePageEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case HomePageSwitchToNewContactPageEvent:
        final castedEvent = event as HomePageSwitchToNewContactPageEvent;
        const String _routeName = 'ToNewContact';
        Navigator.of(castedEvent.context).popAndPushNamed(
          _routeName,
          arguments: arguments,
        );
    }
  }
}