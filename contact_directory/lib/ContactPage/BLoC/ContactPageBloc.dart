import 'package:contact_directory/ContactPage/Navigator/ContactPageNavigator.dart';
import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:contact_directory/Data/Contact/ContactRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ContactPageEvent.dart';
import 'ContactPageState.dart';

class ContactPageBloc extends Bloc<ContactPageEvent, ContactPageState> {
  final ContactRepository _repository;
  ContactPageBloc(
      initialState, this._repository, ContactPageNavigator navigator)
      : super(initialState) {
    on<ContactPageSaveContactEvent>((event, emit) async {
      final model = ContactModel(
          name: event.name, email: event.email, phone: event.phone);

      await _repository.createNewContact(model);
      navigator.navigate(ContactPageSwitchToHomeEvent(context: event.context));
    });
  }
}
