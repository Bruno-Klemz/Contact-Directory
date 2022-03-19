import 'dart:convert';

import 'package:contact_directory/Data/Contact/ContactAPI.dart';
import 'package:contact_directory/Data/Contact/ContactModel.dart';

class ContactRepository {
  final ContactAPI api;

  ContactRepository({required this.api});

  Future<void> createNewContact(ContactModel model) async {
    String newContactJson = jsonEncode(model);
    await api.createNewContact(newContactJson);
  }
}
