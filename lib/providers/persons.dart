import 'package:kirim_chiqim/database/dbhelper.dart';
import 'package:kirim_chiqim/models/person.dart';
import 'package:kirim_chiqim/providers/providerclass.dart';

class Persons extends ProviderClass {
  List<Person> _persons = [];

  List<Person> get personsList {
    return [..._persons];
  }

  @override
  void add({Person? person}) {
    if (person != null) {
      Person newPerson = Person(
          id: person.id, name: person.name, phoneNumber: person.phoneNumber);
      _persons.add(newPerson);

      notifyListeners();

      PersonDBHelper.insertPersons(
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
}
