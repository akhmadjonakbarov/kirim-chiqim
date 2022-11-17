import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/transactions.dart';

class ShowExpenditure extends StatelessWidget {
  const ShowExpenditure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              style: GoogleFonts.nunito(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
