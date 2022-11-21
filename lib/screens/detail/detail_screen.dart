import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/person.dart';
import '../../models/transaction.dart';
import '../../providers/transactions.dart';
import 'edit_transaction/edit_transaction_screen.dart';

import 'widgets/transaction_list_item.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  Person person;

  DetailScreen({super.key, required this.person});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Transaction> _list = [];
  @override
  void didChangeDependencies() {
    Provider.of<Transactions>(context)
        .getTransactionsByPerson(
      personId: widget.person.id,
    )
        .then((value) {
      _list = value;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double profit = Provider.of<Transactions>(context).profit;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text(
                  widget.person.name,
                  style: GoogleFonts.nunito(),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return EditTransactionScreen(
                            person: widget.person,
                          );
                        },
                      ));
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: profit >= 0 ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$profit \nso'm",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      Transaction transaction = _list[index];
                      return TransactionListItem(
                        transaction: transaction,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
