import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/transactions.dart';

class ShowEntry extends StatelessWidget {
  const ShowEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
