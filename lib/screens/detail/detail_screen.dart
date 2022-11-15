// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:kirim_chiqim/providers/transactions.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final _transactionFormKey = GlobalKey<FormState>();

  void addTransactionWindow(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
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
                title: const Text(""),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Consumer<Transactions>(
                    builder: (context, transactionsList, _) {
                      if (transactionsList != null) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text(
                                index.toString(),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
