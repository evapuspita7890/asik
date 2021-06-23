import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/beranda.dart';
import 'package:flutter_sqlite/controler.dart';

import 'package:flutter_sqlite/ui/entryform.dart';
import 'package:flutter_sqlite/ui/home.dart';
import 'package:provider/provider.dart';

import 'login/auth.dart';
import 'login/auth1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
