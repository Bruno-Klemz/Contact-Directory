import 'package:flutter/cupertino.dart';

abstract class HomePageEvent {}

class HomePageSwitchToNewContactPageEvent extends HomePageEvent {
  final BuildContext context;

  HomePageSwitchToNewContactPageEvent({required this.context});
}
