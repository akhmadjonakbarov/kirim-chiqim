// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './transaction_list_item.dart';
import '../../../models/person.dart';
import '../../../models/transaction.dart';
import '../../../providers/transactions.dart';

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
        child: FutureBuilder(
          future: Provider.of<Transactions>(context)
              .getTransactionsByPerson(personId: person.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "Sizda xatolik bor iltimos keyinroq urunib ko'ring. \n${snapshot.error}",
                            style: GoogleFonts.nunito()),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Ok"),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasData) {
              return Consumer<Transactions>(
                builder: (context, transactions, _) {
                  return ListView.builder(
                    itemCount: transactions.transactionsList.length,
                    itemBuilder: (context, index) {
                      Transaction transaction =
                          transactions.transactionsList[index];
                      return TransactionListItem(
                        transaction: transaction,
                      );
                    },
                  );
                },
              );
            }
            return const Text("");
          },
        ),
      ),
    );
  }
}
