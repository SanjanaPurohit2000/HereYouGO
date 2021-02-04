import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:here_you_go_1/services/auth.dart';
import 'package:here_you_go_1/src/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
final String appTitle = "Expense App";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
=======
import 'package:here_you_go_1/src/expenses.dart';
import 'package:here_you_go_1/src/category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String appTitle = "Expense App";

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Expense(),
        debugShowCheckedModeBanner: false);
  }
}
>>>>>>> 656d9dc8f3b98eb9f5501db017f7af6a10dac0c9
