import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/person.dart';
import '../../../providers/persons.dart';
import 'person_list_item.dart';

class ListPersons extends StatelessWidget {
  const ListPersons({
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
            return Consumer<Persons>(
              builder: (context, persons, _) {
                if (persons.personsList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: persons.personsList.length,
                    itemBuilder: (context, index) {
                      Person person = persons.personsList[index];
                      return PersonListItem(
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
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
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
