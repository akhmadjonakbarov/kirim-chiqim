import 'package:bloc/bloc.dart';
import 'package:kirim_chiqim/models/person.dart';
import 'package:meta/meta.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());
}
