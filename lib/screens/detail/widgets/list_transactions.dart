// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../../../logic/models/person.dart';

class ListTransactions extends StatelessWidget {
  const ListTransactions({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: Center(),
      ),
    );
  }
}
