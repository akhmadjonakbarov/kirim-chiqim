// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirim_chiqim/screens/home/widgets/list_persons.dart';
import '../../providers/persons.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String phoneNumber = "";

  void _submit(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<Persons>(context, listen: false).add(
        name: name,
        phoneNumber: phoneNumber,
      );
      // Navigator.of(context).pop();
    }
  }

  void _personAddSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            25.0,
          ),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Ism kiriting", style: GoogleFonts.nunito()),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Iltimos ism kiriting";
                    }
                    return null;
                  },
                  onSaved: (newName) {
                    name = newName!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Telefon raqam kiriting",
                        style: GoogleFonts.nunito()),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Iltimos telefon raqam  kiriting";
                    }
                    return null;
                  },
                  onSaved: (newPhoneNumber) {
                    phoneNumber = newPhoneNumber.toString();
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
                      "Saqlash",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              AppBar(
                title: const Text("Mijozlar"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
              const ListPersons(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _personAddSheet(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
