import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/models/person.dart';
import '../../../logic/cubit/person/person_cubit.dart';
import '../../detail/detail_screen.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => query = '',
        child: const Text("Tozalash"),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final persons = BlocProvider.of<PersonCubit>(context).searchPersons(query);
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        Person person = persons[index];
        return ListTile(
          title: Text(person.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final persons =
          BlocProvider.of<PersonCubit>(context).searchPersons(query);
      if (persons.isEmpty) {
        return const Text("Bunday note mavjud emas!");
      }
      return ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          Person person = persons[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return DetailScreen(
                      person: person,
                    );
                  },
                ),
              );
            },
            title: Text(person.name),
          );
        },
      );
    }
    return Container();
  }
}
