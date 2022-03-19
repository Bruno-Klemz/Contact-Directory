import 'package:flutter/material.dart';

import 'ContactPage/View/ContactPageView.dart';
import 'HomePage/BLoC/HomePageState.dart';
import 'HomePage/View/HomePageView.dart';

class AppRouter {
  static Route? navigate(RouteSettings settings) {
    switch (settings.name) {
      case 'initialRoute':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case 'ToNewContact':
        final _state = settings.arguments as HomePageNewContactState;
        return MaterialPageRoute(builder: (_) => ContactPage(state: _state));

      case 'ToHome':
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return null;
    }
  }
}
