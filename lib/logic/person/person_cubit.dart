import 'package:bloc/bloc.dart';
import 'package:kirim_chiqim/models/person.dart';
import 'package:meta/meta.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial()) {
    emit(PersonWelcome());
  }

  void addPerson() {
    try {} catch (e) {}
  }

  void updatePerson() {
    try {} catch (e) {}
  }

  void deletePerson() {
    try {} catch (e) {}
  }

  List<Person> searchPersons(String name) {
    return [];
  }
}
