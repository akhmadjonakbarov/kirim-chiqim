// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirim_chiqim/models/transaction.dart';
import 'package:provider/provider.dart';

import '../../providers/transactions.dart';
import '../../models/person.dart';

class DetailScreen extends StatelessWidget {
  final Person person;
  DetailScreen({super.key, required this.person});
  final _transactionFormKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {}

  void addTransactionWindow(BuildContext context) {
    showBottomSheet(
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
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Form(
                key: _transactionFormKey,
                child: Column(
                  children: [
                    TextFormField(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double profit = Provider.of<Transactions>(context).profit;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              AppBar(
                title: Text(person.name),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: profit > 0.0 ? Colors.green : Colors.red,
                    shape: BoxShape.circle),
                child: Text(
                  "$profit \n so'm",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Umumiy kirimlar",
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${Provider.of<Transactions>(context).totalSumEntry}",
                                style: GoogleFonts.nunito(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_downward,
                              size: 13,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              size: 13,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Umumiy chiqimlar",
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${Provider.of<Transactions>(context).totalSumExpenditure}",
                                style: GoogleFonts.nunito(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: FutureBuilder(
                    future: Provider.of<Transactions>(context)
                        .getTransactionsByPerson(personId: person.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Consumer<Transactions>(
                        builder: (context, transactions, _) {
                          if (transactions.transactionsList != null) {
                            return ListView.builder(
                              itemCount: transactions.transactionsList.length,
                              itemBuilder: (context, index) {
                                Transaction transaction =
                                    transactions.transactionsList[index];
                                return Card(
                                  margin: const EdgeInsets.only(top: 5),
                                  color: transaction.isEntry
                                      ? Colors.green
                                      : Colors.red,
                                  child: ListTile(
                                    title: Text(
                                      "${transaction.quantity}",
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${transaction.dateTime}",
                                      style: GoogleFonts.nunito(
                                          color: Colors.white),
                                    ),
                                    trailing: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        transaction.isEntry
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward,
                                        color: transaction.isEntry
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                );
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _submit(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
