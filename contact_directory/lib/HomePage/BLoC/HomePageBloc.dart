import 'package:flutter_bloc/flutter_bloc.dart';

import '../Navigator/HomePageNavigator.dart';
import 'HomePageEvent.dart';
import 'HomePageState.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(initialState, HomePageNavigator _navigator)
      : super(initialState) {
    on<HomePageSwitchToNewContactPageEvent>((event, emit) =>
        _navigator.navigate(event, arguments: HomePageNewContactState()));
  }
}
