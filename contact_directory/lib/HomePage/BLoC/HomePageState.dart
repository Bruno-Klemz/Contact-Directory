abstract class HomePageState {}

class HomePageInitialState extends HomePageState {}

class HomePageNewContactState extends HomePageState {}

class HomePageEditContactState extends HomePageState {
  final String name, email, phone;

  HomePageEditContactState(this.name, this.email, this.phone);
}
