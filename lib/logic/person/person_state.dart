part of 'person_cubit.dart';

@immutable
abstract class PersonState {
  List<Person>? persons;
  PersonState({this.persons});
}

class PersonWelcome extends PersonState {}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonLoaded extends PersonState {
  List<Person> personsLoaded;
  PersonLoaded({required this.personsLoaded});
}

class PersonAdded extends PersonState {
  Person person;
  PersonAdded({required this.person});
}

class PersonDelete extends PersonState {
  List<Person> personsDeleted;
  PersonDelete({required this.personsDeleted});
}

class PersonError extends PersonState {
  String errorMsg;
  PersonError({required this.errorMsg});
}
