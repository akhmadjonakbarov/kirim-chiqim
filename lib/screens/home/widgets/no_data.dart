import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Sizda hech qanday ma'lumot mavjud emas!",
          style: GoogleFonts.nunito()),
    );
  }
}
