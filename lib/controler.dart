import 'package:flutter/material.dart';
import 'package:flutter_sqlite/ui/entryform.dart';
import 'package:flutter_sqlite/ui/home.dart';
import 'beranda.dart' as beranda;
import 'ui/home.dart' as home;
import 'produklist.dart' as listproduk;
import 'detailproduk.dart' as detailproduk;

void main() {
  runApp(new MaterialApp(
    title: "tab Bar",
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  // ignore: missing_return

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new beranda.Beranda(),
            new listproduk.ProdukList(),
            //new beranda.Kategori(),
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.green,
          child: new TabBar(controller: controller, tabs: <Widget>[
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.list_rounded)),
          ]),
        ));
  }
}
