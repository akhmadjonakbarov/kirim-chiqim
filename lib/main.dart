import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/persons.dart';
import 'providers/transactions.dart';
import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Persons(),
        ),
        ChangeNotifierProvider.value(
          value: Transactions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}
