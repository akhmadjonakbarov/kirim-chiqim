import 'package:flutter/foundation.dart';
import '../database/dbhelper.dart';
import '../models/person.dart';
import 'providerclass.dart';

class Persons extends ProviderClass {
  List<Person> _persons = [
    Person(
      id: UniqueKey().toString(),
      name: "Akhmadjon Akbarov",
      phoneNumber: "998999921684",
    )
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
        phoneNumber: phoneNumber,
      );
      _persons.add(newPerson);
      notifyListeners();
      PersonOperations.insertPersons(
        data: newPerson.toMap(),
      );
    }
  }

  @override
  void update({String? personId}) {}

  @override
  void delete({String? personId}) {
    _persons.removeWhere((element) => element.id == personId);
    notifyListeners();
  }

  Future getPersons() async {
    List<Person> persons = await PersonOperations.getPersons();

    if (persons.isNotEmpty) {
      _persons = persons;
      notifyListeners();
    }
  }
}
