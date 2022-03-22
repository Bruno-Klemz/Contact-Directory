import 'package:contact_directory/ContactPage/BLoC/ContactPageBloc.dart';
import 'package:contact_directory/Data/Contact/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../HomePage/BLoC/HomePageState.dart';
import '../BLoC/ContactPageEvent.dart';

class ContactPage extends StatefulWidget {
  final HomePageState state;
  final ContactModel? contact;
  final String? contactKey;

  const ContactPage(
      {Key? key, required this.state, this.contact, this.contactKey})
      : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final layoutConstrains = ContactPageLayoutConstrains();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _setControllersValue();
    }
  }

  void _setControllersValue() {
    nameController.text = widget.contact?.name as String;
    emailController.text = widget.contact?.email as String;
    phoneController.text = widget.contact?.phone as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mapStateToAppBar(context),
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
                    label: "name",
                    context: context,
                    keyboardType: TextInputType.name,
                    controller: nameController),
              ),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.verticalPadding),
                child: _buildTextInput(
                    label: "email",
                    context: context,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController),
              ),
              Padding(
                padding: EdgeInsets.only(top: layoutConstrains.verticalPadding),
                child: _buildTextInput(
                    label: "phone",
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

  AppBar _mapStateToAppBar(BuildContext context) {
    switch (widget.state.runtimeType) {
      case HomePageContactDetailsState:
        return AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: widget.contact == null
              ? const Text("New Contact")
              : Text(widget.contact?.name as String),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<ContactPageBloc>(context)
                  .add(ContactPageSwitchToHomeEvent(context: context));
            },
            icon: const Icon(Icons.close),
          ),
        );
      default:
        return AppBar(
          backgroundColor: Colors.red,
          title: const Text(""),
        );
    }
  }

  Widget _buildContactPhoto() {
    switch (widget.state.runtimeType) {
      case HomePageContactDetailsState:
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

  String? _buildTextInputInitialValue(String label, String? initialValue) {
    if (widget.contact != null) {
      return initialValue;
    } else {
      return null;
    }
  }

  void _saveButton(BuildContext context) {
    final contactModel = ContactModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    if (widget.contact == null) {
      BlocProvider.of<ContactPageBloc>(context).add(ContactPageSaveContactEvent(
          contactModel: contactModel, context: context));
    } else {
      BlocProvider.of<ContactPageBloc>(context).add(
          ContactPageUpdateContactEvent(
              contactModel: contactModel,
              context: context,
              contactKey: widget.contactKey as String));
    }
  }
}

class ContactPageLayoutConstrains {
  double verticalPadding = 15,
      horizontalPadding = 10,
      photoSize = 150,
      textFieldHeight = 41;
}
