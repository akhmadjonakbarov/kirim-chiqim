// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/person.dart';
import '../../../models/transaction.dart';
import '../../../providers/transactions.dart';
import './list_item.dart';

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
        alignment: Alignment.center,
        decoration: const BoxDecoration(),
        child: FutureBuilder(
          future: Provider.of<Transactions>(context)
              .getTransactionsByPerson(personId: person.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: 100,
                  height: 100,
                  child: const CircularProgressIndicator());
            }
            return Consumer<Transactions>(
              builder: (context, transactions, _) {
                if (transactions.transactionsList != null) {
                  return ListView.builder(
                    itemCount: transactions.transactionsList.length,
                    itemBuilder: (context, index) {
                      Transaction transaction =
                          transactions.transactionsList[index];
                      return ListItem(transaction: transaction);
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "${person.name}da hech qanday tranzaksiyalar mavjud emas",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
