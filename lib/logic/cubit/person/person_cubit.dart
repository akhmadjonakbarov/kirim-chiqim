import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../database/person_operations.dart';
import '../../models/person.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial()) {
    List<Person> persons = [];
    PersonOperations.getPersons().then((value) {
      if (value.isEmpty) {
        emit(PersonWelcome());
      } else {
        persons = value;
        emit(PersonLoaded(persons: persons));
      }
    });
  }

  Person getPerson({String? personId}) {
    Person person =
        state.persons!.firstWhere((element) => element.id == personId);
    return person;
  }

  void addPerson({String? name, String? phoneNumber}) {
    List<Person> persons = [];
    if (state.persons == null || state.persons!.isEmpty) {
      persons = [];
    } else {
      persons = state.persons!;
    }
    try {
      emit(PersonWelcome());
      Person newPerson = Person(
        id: UniqueKey().toString(),
        name: name!,
        phoneNumber: phoneNumber!,
      );
      persons.add(newPerson);
      emit(PersonLoaded(persons: persons));
      PersonOperations.insertPersons(data: newPerson.toMap());
    } catch (e) {
      emit(
        PersonError(
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void updatePerson({Person? person}) {
    try {
      final persons = state.persons!.map((p) {
        if (p.id == person!.id) {
          return Person(
            id: person.id,
            name: person.name,
            phoneNumber: person.phoneNumber,
          );
        }
        return p;
      }).toList();
      emit(PersonLoaded(persons: persons));
      PersonOperations.updatePerson(person: person);
    } catch (e) {
      emit(
        PersonError(errorMsg: e.toString()),
      );
    }
  }

  void deletePerson({String? personId}) {
    List<Person> persons = state.persons!;
    try {
      persons.removeWhere((element) => element.id == personId);
      emit(PersonDelete(persons: persons));
      emit(PersonLoading());
      emit(PersonLoaded(persons: persons));
      PersonOperations.deletePerson(personId: personId);
    } catch (e) {
      emit(PersonError(
        errorMsg: e.toString(),
      ));
    }
  }

  List<Person> searchPersons(String name) {
    return state.persons!
        .where(
          (element) => element.name.toLowerCase().contains(
                name.toLowerCase(),
              ),
        )
        .toList();
  }
}
