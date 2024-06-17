import 'package:fitness_app_tutorial/screen/home/view/home.dart';
import 'package:fitness_app_tutorial/utils/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
    );
  }
}
