import 'package:flutter/material.dart';
import 'package:notes_app/provider/provider.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      Provider<NotesProvider>(create: (_)=>NotesProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  const NotesHomeScreen(),
    );
  }
}


