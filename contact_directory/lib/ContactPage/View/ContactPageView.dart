import 'package:contact_directory/ContactPage/BLoC/ContactPageBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../HomePage/BLoC/HomePageState.dart';
import '../BLoC/ContactPageEvent.dart';

class ContactPage extends StatelessWidget {
  final HomePageState state;
  final layoutConstrains = ContactPageLayoutConstrains();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  ContactPage({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mapStateToAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveButton(context);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: layoutConstrains.verticalPadding,
            horizontal: layoutConstrains.horizontalPadding),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildContactPhoto(),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.verticalPadding),
                child: _buildTextInput(
                    label: "Name",
                    context: context,
                    keyboardType: TextInputType.name,
                    controller: nameController),
              ),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.verticalPadding),
                child: _buildTextInput(
                    label: "Email",
                    context: context,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController),
              ),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.verticalPadding),
                child: _buildTextInput(
                    label: "Phone",
                    context: context,
                    keyboardType: TextInputType.phone,
                    controller: phoneController),
              ),
            ],
          ),
        ),
      )),
    );
  }

  AppBar _mapStateToAppBar() {
    switch (state.runtimeType) {
      case HomePageNewContactState:
        return AppBar(
          backgroundColor: Colors.red,
          title: const Text("New Contact"),
        );

      case HomePageEditContactState:
        final _castedState = state as HomePageEditContactState;
        return AppBar(
          backgroundColor: Colors.red,
          title: Text(_castedState.name),
        );
      default:
        return AppBar(
          backgroundColor: Colors.red,
          title: const Text(""),
        );
    }
  }

  Widget _buildContactPhoto() {
    switch (state.runtimeType) {
      case HomePageNewContactState:
        return Container(
          width: layoutConstrains.photoSize,
          height: layoutConstrains.photoSize,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/person.png"), fit: BoxFit.cover)),
        );
      default:
        return Container(
          width: layoutConstrains.photoSize,
          height: layoutConstrains.photoSize,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/person.png"), fit: BoxFit.cover)),
        );
    }
  }

  Widget _buildTextInput(
      {required String label,
      required TextEditingController controller,
      required BuildContext context,
      required TextInputType keyboardType}) {
    return SizedBox(
        height: layoutConstrains.textFieldHeight,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              labelText: label,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w100,
            fontFamily: 'Roboto',
          ),
        ));
  }

  void _saveButton(BuildContext context) {
    BlocProvider.of<ContactPageBloc>(context).add(ContactPageSaveContactEvent(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text, context: context));
  }
}

class ContactPageLayoutConstrains {
  double verticalPadding = 15,
      horizontalPadding = 10,
      photoSize = 150,
      textFieldHeight = 41;
}
