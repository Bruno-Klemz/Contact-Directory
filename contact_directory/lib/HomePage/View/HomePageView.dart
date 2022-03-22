import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:contact_directory/HomePage/BLoC/HomePageBloc.dart';
import 'package:contact_directory/HomePage/BLoC/HomePageState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BLoC/HomePageEvent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contactList = [];
  List<String> keyList = [];
  final layoutConstrains = HomeLayoutConstrains();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageBloc>(context).add(HomePageFetchContactEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Directory"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<HomePageBloc>(context)
              .add(HomePageSwitchToNewContactPageEvent(context: context));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: layoutConstrains.verticalPadding,
            horizontal: layoutConstrains.horizontalPadding),
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (BuildContext context, HomePageState state) {
            return _mapStateToListView(context, state);
          },
        ),
      )),
    );
  }

  Widget _mapStateToListView(BuildContext context, HomePageState state) {
    switch (state.runtimeType) {
      case HomePageFetchedContactListState:
        final _castedState = state as HomePageFetchedContactListState;
        contactList = _castedState.contactList;
        keyList = _castedState.keyList;
        return ListView.builder(
            shrinkWrap: true,
            itemCount: contactList.length,
            itemBuilder: _buildContactItems);
      default:
        return const CircularProgressIndicator();
    }
  }

  Widget _buildContactItems(BuildContext context, int index) {
    const snackBar = SnackBar(
      content: Text('Contact removed'),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.blue,
    );
    return Padding(
      padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                BlocProvider.of<HomePageBloc>(context).add(
                    HomePageSwitchToNewContactPageEvent(
                        context: context,
                        contact: contactList[index],
                        key: keyList[index]));
              },
              child: _buildInfosListView(index)),
          IconButton(
            onPressed: () {
              BlocProvider.of<HomePageBloc>(context).add(
                  HomePageDeleteContactEvent(
                      key: keyList[index], contactList: contactList, contact: contactList[index]));

              BlocProvider.of<HomePageBloc>(context)
                  .add(HomePageFetchContactEvent());
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfosListView(int index) {
    return Row(
      children: [
        Container(
            height: layoutConstrains.photoSize,
            width: layoutConstrains.photoSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/person.png"), fit: BoxFit.cover),
            )),
        Padding(
          padding: EdgeInsets.only(left: layoutConstrains.widgetPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(contactList[index].name,
                  layoutConstrains.mainLabelFontSize, FontWeight.bold),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.textPadding),
                child: _buildText(contactList[index].email,
                    layoutConstrains.secondaryLabelFontSize, FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.textPadding),
                child: _buildText(contactList[index].phone,
                    layoutConstrains.secondaryLabelFontSize, FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }

  Text _buildText(String title, double fontSize, FontWeight fontWeight) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.black),
    );
  }
}

class HomeLayoutConstrains {
  double horizontalPadding = 15.0,
      verticalPadding = 15.0,
      textPadding = 5,
      photoSize = 75.0,
      mainLabelFontSize = 16,
      secondaryLabelFontSize = 14,
      widgetPadding = 10.0;
}
