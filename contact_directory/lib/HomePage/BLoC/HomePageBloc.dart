import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:contact_directory/Data/Contact/ContactRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Navigator/HomePageNavigator.dart';
import 'HomePageEvent.dart';
import 'HomePageState.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(
      initialState, HomePageNavigator _navigator, ContactRepository repository)
      : super(initialState) {
    on<HomePageSwitchToNewContactPageEvent>((event, emit) {
      if (event.contact != null) {
        _navigator.navigate(event, arguments: {
          'state': HomePageContactDetailsState(),
          'contact': event.contact,
          'key': event.key
        });
      } else {
        _navigator.navigate(event,
            arguments: {'state': HomePageContactDetailsState()});
      }
    });

    on<HomePageFetchContactEvent>((event, emit) async {
      Map<String, dynamic> contactMap = await repository.getContacts();
      if (contactMap['contactList'] == null) {
        emit(HomePageFetchedContactListState(contactList: [], keyList: []));
      } else {
        emit(HomePageFetchedContactListState(
            contactList: contactMap['contactList'],
            keyList: contactMap['keyList']));
      }
    });
    on<HomePageDeleteContactEvent>((event, emit) async {
      await repository.deleteContact(event.key);
      event.contactList.remove(event.contact);
    });
  }
}
