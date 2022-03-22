import 'dart:convert';

import 'package:contact_directory/Data/Contact/ContactAPI.dart';
import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:http/http.dart';

class ContactRepository {
  final ContactAPI api;

  ContactRepository({required this.api});

  Future<void> createNewContact(ContactModel model) async {
    String newContactJson = jsonEncode(model);
    await api.createNewContact(newContactJson);
  }

  Future<Map<String, dynamic>> getContacts() async {
    List<ContactModel> contactList = [];
    List<String> keyList = [];
    Map<String, dynamic> contactMap = {};
    Response response = await api.getContacts();
    try {
      if (response.statusCode == 200 && response.body.runtimeType != Null) {
        Map<String, dynamic> jsonDecoded =
            jsonDecode(response.body) as Map<String, dynamic>;

        jsonDecoded.forEach((key, value) {
          final contact = ContactModel.fromJson(value);
          keyList.add(key);
          contactList.add(contact);
        });
        contactMap = {
          'contactList' : contactList,
          'keyList' : keyList
        };
        return contactMap;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<void> deleteContact(String key) async {
    await api.deleteContact(key);
  }

  Future<void> updateContact(ContactModel model, String contactKey) async {
    String updateContactJson = jsonEncode(model);
    await api.updateContact(updateContactJson, contactKey);
  }
}
