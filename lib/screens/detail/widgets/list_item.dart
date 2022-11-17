import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/transaction.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5),
      color: transaction.isEntry ? Colors.green : Colors.red,
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
          style: GoogleFonts.nunito(color: Colors.white),
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
  }
}
