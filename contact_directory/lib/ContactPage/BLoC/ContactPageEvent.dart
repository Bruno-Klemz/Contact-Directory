import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:flutter/material.dart';

abstract class ContactPageEvent {}

class ContactPageSaveContactEvent extends ContactPageEvent {
  final ContactModel contactModel;
  final BuildContext context;

  ContactPageSaveContactEvent(
      {required this.contactModel, required this.context});
}

class ContactPageUpdateContactEvent extends ContactPageEvent {
  final ContactModel contactModel;
  final String contactKey;
  final BuildContext context;

  ContactPageUpdateContactEvent(
      {required this.contactModel,
      required this.context,
      required this.contactKey});
}

class ContactPageDeleteContactEvent extends ContactPageEvent {
  final String? name;

  ContactPageDeleteContactEvent({required this.name});
}

class ContactPageSwitchToHomeEvent extends ContactPageEvent {
  final BuildContext context;

  ContactPageSwitchToHomeEvent({required this.context});
}
