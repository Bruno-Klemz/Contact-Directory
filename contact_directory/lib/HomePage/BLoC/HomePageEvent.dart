import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:flutter/cupertino.dart';

abstract class HomePageEvent {}

class HomePageSwitchToNewContactPageEvent extends HomePageEvent {
  final BuildContext context;
  final ContactModel? contact;
  final String? key;

  HomePageSwitchToNewContactPageEvent(
      {required this.context, this.contact, this.key});
}

class HomePageFetchContactEvent extends HomePageEvent {}

class HomePageDeleteContactEvent extends HomePageEvent {
  final String key;
  final List<ContactModel> contactList;
  final ContactModel contact;

  HomePageDeleteContactEvent(
      {required this.key, required this.contactList, required this.contact});
}
