import 'package:contact_directory/ContactPage/BLoC/ContactPageBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ContactAPI {
  Future<void> createNewContact(String newContactJson) async {
    final url = Uri.parse(
        "https://contact-directory-50a47-default-rtdb.firebaseio.com/Contacts.json");

    await http.post(url, body: newContactJson);
  }
}
