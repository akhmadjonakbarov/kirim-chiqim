// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import './../../../logic/cubit/person/person_cubit.dart';
import '/screens/home/edit_person_screen/edit_person_screen.dart';

import '../../../logic/models/person.dart';
import '../../detail/detail_screen.dart';

class PersonListItem extends StatelessWidget {
  Person person;
  PersonListItem({
    Key? key,
    required this.person,
  }) : super(key: key);

  void _deletePerson(BuildContext context, {String? personId}) {
    BlocProvider.of<PersonCubit>(context).deletePerson(personId: personId);
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
                return DetailScreen(person: person);
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
                        return EditPersonScreen(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
