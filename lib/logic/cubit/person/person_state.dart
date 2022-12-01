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
  List<Person>? persons;
  PersonLoaded({required this.persons}) : super(persons: persons);
}

class PersonAdded extends PersonState {
  Person person;
  PersonAdded({required this.person});
}

class PersonDelete extends PersonState {
  final List<Person> persons;
  PersonDelete({required this.persons});
}

class PersonError extends PersonState {
  String errorMsg;
  PersonError({required this.errorMsg});
}
