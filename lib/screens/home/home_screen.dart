// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/cubit/person/person_cubit.dart';
import '../../screens/home/widgets/no_data.dart';
import '../../screens/home/widgets/person_list_item.dart';
import '../../screens/home/widgets/search_bar.dart';
import '../../widgets/app_drawer.dart';
import '../../logic/models/person.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String phoneNumber = "";

  void _submit(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      BlocProvider.of<PersonCubit>(context)
          .addPerson(name: name, phoneNumber: phoneNumber);
      Navigator.of(context).pop();
    }
  }

  void _personAddSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            25.0,
          ),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Ism kiriting", style: GoogleFonts.nunito()),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Iltimos ism kiriting";
                    }
                    return null;
                  },
                  onSaved: (newName) {
                    name = newName!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: "+998 ",
                  decoration: InputDecoration(
                    label: Text("Telefon raqam kiriting",
                        style: GoogleFonts.nunito()),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (phoneNumber) {
                    if (phoneNumber == null ||
                        phoneNumber.isEmpty ||
                        phoneNumber.length <= 3) {
                      return "Iltimos telefon raqam  kiriting";
                    }
                    return null;
                  },
                  onSaved: (newPhoneNumber) {
                    phoneNumber = newPhoneNumber.toString();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    child: Text(
                      "Saqlash",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              AppBar(
                title: Text("Mijozlar", style: GoogleFonts.nunito()),
                actions: [
                  IconButton(
                    onPressed: () => openSearchBar(context),
                    icon: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: BlocBuilder<PersonCubit, PersonState>(
                    builder: (context, state) {
                      if (state is PersonWelcome) {
                        return const NoData();
                      } else if (state is PersonLoaded) {
                        return state.persons != null &&
                                state.persons!.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.persons!.length,
                                itemBuilder: (context, index) {
                                  Person person = state.persons![index];
                                  return PersonListItem(person: person);
                                },
                              )
                            : const NoData();
                      } else if (state is PersonLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is PersonError) {
                        return Center(
                          child: Text(
                            state.errorMsg.toString(),
                            style: GoogleFonts.nunito(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _personAddSheet(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
