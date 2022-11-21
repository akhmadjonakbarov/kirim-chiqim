import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Drawer(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text("Hello User!", style: GoogleFonts.nunito()),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  "Mijozlardan nusxa olish",
                  style: GoogleFonts.nunito(fontSize: 17),
                ),
                trailing: const Icon(
                  Icons.backup_table,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
