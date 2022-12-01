// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

// flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../logic/cubit/person/person_cubit.dart';

import '../../../logic/models/person.dart';
// my packages

import '../home_screen.dart';

class EditPersonScreen extends StatelessWidget {
  Person person;
  EditPersonScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      BlocProvider.of<PersonCubit>(context).updatePerson(person: person);
      showAlert(context);
    }
  }

  void showAlert(BuildContext context) {
    // keyinchalik bildirish uchun yoziladi.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ma'lumot o'zgartirildi."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ));
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  AppBar(
                    title: const Text("Tahrirlash"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: person.name,
                          decoration: InputDecoration(
                            label: Text("Ism kiriting",
                                style: GoogleFonts.nunito()),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "Iltimos ism kiriting";
                            }
                            return null;
                          },
                          onSaved: (newName) {
                            person.name = newName!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: person.phoneNumber,
                          decoration: InputDecoration(
                            label: Text("Telefon raqam kiriting",
                                style: GoogleFonts.nunito()),
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (phoneNumber) {
                            if (phoneNumber == null || phoneNumber.isEmpty) {
                              return "Iltimos telefon raqam  kiriting";
                            }
                            return null;
                          },
                          onSaved: (newPhoneNumber) {
                            person.phoneNumber = newPhoneNumber!.toString();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              _submit(context);
                            },
                            child: Text(
                              "O'zgartirish",
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
