import 'package:flutter/foundation.dart';

import '../database/person_operations.dart';
import '../logic/models/person.dart';
import 'providerclass.dart';

class Persons extends ProviderClass {
  List<Person> _persons = [
    Person(
      id: "personid1",
      name: "Akhmadjon Akbarov",
      phoneNumber: "1324567",
    ),
  ];

  List<Person> get personsList {
    return [..._persons];
  }

  @override
  void add({String? name, String? phoneNumber}) {
    if (name != null && phoneNumber != null) {
      Person newPerson = Person(
        id: UniqueKey().toString(),
        name: name,
        phoneNumber: phoneNumber.toString(),
      );
      _persons.insert(0, newPerson);
      notifyListeners();
      PersonOperations.insertPersons(
        data: newPerson.toMap(),
      );
    }
  }

  @override
  void update({Person? person}) {
    if (person != null) {
      int indexOfPerson =
          _persons.indexWhere((element) => element.id == person.id);
      _persons[indexOfPerson] = person;
      notifyListeners();
      PersonOperations.updatePerson(person: person);
    }
  }

  @override
  void delete({String? personId}) {
    _persons.removeWhere((element) => element.id == personId);
    notifyListeners();
    PersonOperations.deletePerson(personId: personId);
  }

  Future<void> getPersons() async {
    List<Person> persons = await PersonOperations.getPersons();

    if (persons.isNotEmpty) {
      _persons = persons;
      notifyListeners();
    }
  }
}
