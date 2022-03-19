import 'package:flutter/material.dart';

abstract class ContactPageEvent {}

class ContactPageSaveContactEvent extends ContactPageEvent {
  final String name, email, phone;
  final BuildContext context;

  ContactPageSaveContactEvent(
      {required this.name, required this.email, required this.phone, required this.context});
}

class ContactPageSwitchToHomeEvent extends ContactPageEvent {
  final BuildContext context;

  ContactPageSwitchToHomeEvent({required this.context});
}
