import 'package:flutter/material.dart';
import 'package:kirim_chiqim/providers/persons.dart';
import 'package:kirim_chiqim/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Persons(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}
