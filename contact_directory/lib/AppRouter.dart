import 'package:contact_directory/Data/Contact/ContactModel.dart';
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
        final _castedArguments = settings.arguments as Map<String, dynamic>;
        if (_castedArguments['contact'] != null) {
          return MaterialPageRoute(
              builder: (_) => ContactPage(
                  state: _castedArguments['state'],
                  contact: _castedArguments['contact'], contactKey: _castedArguments['key'],));
        } 
        else {
          return MaterialPageRoute(
              builder: (_) => ContactPage(
                    state: _castedArguments['state']
                  ));
        }

      case 'ToHome':
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return null;
    }
  }
}
