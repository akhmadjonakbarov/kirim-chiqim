// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/person.dart';
import '../../providers/persons.dart';
import '../screens.dart';
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
              Container(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                ),
                child: Row(
                  children: [
                    const Text(""),
                    const Text(
                      "Istemolchilar",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
              const _ListPersons(),
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

class _ListPersons extends StatelessWidget {
  const _ListPersons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: FutureBuilder(
          future: Provider.of<Persons>(context).getPersons(),
          builder: (context, snapshot) {
            print(Provider.of<Persons>(context).getPersons());
            return Consumer<Persons>(
              builder: (context, persons, _) {
                if (persons.personsList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: persons.personsList.length,
                    itemBuilder: (context, index) {
                      Person person = persons.personsList[index];
                      return _ListItem(
                        person: person,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "Sizda hech qanday ma'lumot mavjud emas!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  Person person;
  _ListItem({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const DetailScreen();
              },
            ),
          );
        },
        title: Text(
          person.name,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          person.phoneNumber,
          style: GoogleFonts.nunito(
            color: Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                )),
            IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
