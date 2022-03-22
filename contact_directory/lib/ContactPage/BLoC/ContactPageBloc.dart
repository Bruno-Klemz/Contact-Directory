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
      await _repository.createNewContact(event.contactModel);
      BlocProvider.of<ContactPageBloc>(event.context)
          .add(ContactPageSwitchToHomeEvent(context: event.context));
    });
    on<ContactPageUpdateContactEvent>((event, emit) async {
      await _repository.updateContact(event.contactModel, event.contactKey);
      BlocProvider.of<ContactPageBloc>(event.context)
          .add(ContactPageSwitchToHomeEvent(context: event.context));
    });
    on<ContactPageDeleteContactEvent>((event, emit) async =>
        await _repository.deleteContact(event.name.toString()));

    on<ContactPageSwitchToHomeEvent>(
        (event, emit) => navigator.navigate(event));
  }
}
