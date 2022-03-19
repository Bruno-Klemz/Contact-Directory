import 'package:flutter/material.dart';

import '../BLoC/ContactPageEvent.dart';

class ContactPageNavigator {
  void navigate(ContactPageEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case ContactPageSwitchToHomeEvent:
        final castedEvent = event as ContactPageSwitchToHomeEvent;
        const String _routeName = 'ToHome';
        Navigator.of(castedEvent.context).popAndPushNamed(
          _routeName,
          arguments: arguments,
        );
    }
  }
}