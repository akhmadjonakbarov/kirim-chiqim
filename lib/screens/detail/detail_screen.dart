// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kirim_chiqim/screens/detail/widgets/list_transactions.dart';
import 'package:kirim_chiqim/screens/detail/widgets/show_entry.dart';
import 'package:kirim_chiqim/screens/detail/widgets/show_expenditure.dart';
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
              _CircleShowProfit(profit: profit),
              const _ShowEntryAndExpenditure(),
              ListTransactions(person: person),
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

class _ShowEntryAndExpenditure extends StatelessWidget {
  const _ShowEntryAndExpenditure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShowEntry(),
            ShowExpenditure(),
          ],
        ),
      ),
    );
  }
}

class _CircleShowProfit extends StatelessWidget {
  const _CircleShowProfit({
    Key? key,
    required this.profit,
  }) : super(key: key);

  final double profit;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
