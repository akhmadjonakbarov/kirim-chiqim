import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/cubit/transaction/transaction_cubit.dart';
import '../../screens/home/widgets/no_data.dart';

import '../../logic/models/person.dart';
import '../../logic/models/transaction.dart';
import 'edit_transaction/edit_transaction_screen.dart';
import 'widgets/transaction_list_item.dart';

class DetailScreen extends StatefulWidget {
  Person person;

  DetailScreen({super.key, required this.person});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _init = true;
  double profit = 0.0;
  @override
  void didChangeDependencies() {
    if (_init) {
      BlocProvider.of<TransactionCubit>(context)
          .getTransactions(personId: widget.person.id)
          .then(
        (value) {
          setState(() {
            profit = BlocProvider.of<TransactionCubit>(context).profit;
          });
        },
      );
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
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
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  return Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color:
                          BlocProvider.of<TransactionCubit>(context).profit >= 0
                              ? Colors.green
                              : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${BlocProvider.of<TransactionCubit>(context).profit} \nso'm",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      // oldin BlocBuilderga uralmagan ekan, shuning uchun bu update bo'lmagan
                      // transaction loaded bo'lganda endi profitni olib update bo'ladi
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, state) {
                      if (state is TransactionWelcome) {
                        return const NoData();
                      } else if (state is TransactionLoaded) {
                        return state.transactions.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  Transaction transaction =
                                      state.transactions[index];
                                  return TransactionListItem(
                                    transaction: transaction,
                                  );
                                },
                              )
                            : const NoData();
                      } else if (state is TransactionLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is TransactionError) {
                        return Text(
                          state.errorMessage.toString(),
                          style: GoogleFonts.nunito(),
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
    );
  }
}
