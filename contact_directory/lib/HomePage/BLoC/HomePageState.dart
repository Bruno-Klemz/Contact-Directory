import 'package:contact_directory/Data/Contact/ContactModel.dart';

abstract class HomePageState {}

class HomePageInitialState extends HomePageState {}

class HomePageContactDetailsState extends HomePageState {}

class HomePageEditContactState extends HomePageState {
  final String name, email, phone;

  HomePageEditContactState(this.name, this.email, this.phone);
}

class HomePageFetchedContactListState extends HomePageState {
  final List<ContactModel> contactList;
  final List<String> keyList;

  HomePageFetchedContactListState({required this.contactList, required this.keyList});
}
