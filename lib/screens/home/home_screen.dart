import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirim_chiqim/models/person.dart';
import 'package:kirim_chiqim/providers/persons.dart';
import 'package:kirim_chiqim/screens/screens.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              _ListPersons(),
            ],
          ),
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
          builder: (context, snapshot) {
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
        title: Text(""),
      ),
    );
  }
}
