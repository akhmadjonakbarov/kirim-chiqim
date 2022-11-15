// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirim_chiqim/screens/home/edit/edit_screen.dart';
import '../../../providers/persons.dart';
import 'package:provider/provider.dart';

import '../../../models/person.dart';
import '../../detail/detail_screen.dart';

class ListItem extends StatelessWidget {
  Person person;
  ListItem({
    Key? key,
    required this.person,
  }) : super(key: key);

  void _deletePerson(BuildContext context, {String? personId}) {
    Provider.of<Persons>(context, listen: false).delete(personId: personId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5),
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditScreen(
                          person: person,
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                )),
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  _deletePerson(
                    context,
                    personId: person.id,
                  );
                },
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
