import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/person.dart';
import '../../../providers/transactions.dart';
import 'package:provider/provider.dart';

class EditTransactionScreen extends StatefulWidget {
  Person person;
  EditTransactionScreen({super.key, required this.person});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _trFormKey = GlobalKey<FormState>();
  int isEntry = 0;
  bool isEntryBool = false;
  num moneyQuantity = 0;
  _submit() {
    bool isValid = _trFormKey.currentState!.validate();
    if (isValid) {
      _trFormKey.currentState!.save();

      Provider.of<Transactions>(context, listen: false).add(
        isEntry: isEntry,
        personId: widget.person.id,
        moneyQuantity: moneyQuantity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title:
                    Text("Tranzaksiya qo'shish", style: GoogleFonts.nunito()),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Form(
                  key: _trFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text("Pul miqdorini kiriting",
                              style: GoogleFonts.nunito()),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (quantityMoney) {
                          if (quantityMoney == null || quantityMoney.isEmpty) {
                            return "Iltimos ism kiriting";
                          }
                          return null;
                        },
                        onSaved: (quantityMoney) {
                          setState(() {
                            moneyQuantity = num.parse(quantityMoney!);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        title: const Text("Kirim"),
                        value: isEntryBool,
                        onChanged: (value) {
                          setState(() {
                            isEntryBool = value!;
                          });
                          if (value == true) {
                            setState(() {
                              isEntry = 1;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Text(
                            "Saqlash",
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
