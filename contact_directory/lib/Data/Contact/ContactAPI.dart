import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ContactAPI {
  final url = Uri.parse(
      "https://contact-directory-50a47-default-rtdb.firebaseio.com/Contacts.json");
  Future<void> createNewContact(String newContactJson) async {
    await http.post(url, body: newContactJson);
  }

  Future<Response> getContacts() async {
    Response response = await http.get(url);
    return response;
  }

  Future<void> deleteContact(String key) async {
    final url = Uri.parse(
        "https://contact-directory-50a47-default-rtdb.firebaseio.com/Contacts/$key.json");
    await http.delete(url);
  }

  Future<void> updateContact(String updateContactJson, String contactKey) async {
    final url = Uri.parse(
        "https://contact-directory-50a47-default-rtdb.firebaseio.com/Contacts/$contactKey.json");

    await http.put(url, body: updateContactJson);
  }
}
