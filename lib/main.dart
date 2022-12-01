import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './logic/cubit/person/person_cubit.dart';
import './logic/cubit/transaction/transaction_cubit.dart';

import 'screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: PersonCubit(),
        ),
        BlocProvider.value(
          value: TransactionCubit(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
