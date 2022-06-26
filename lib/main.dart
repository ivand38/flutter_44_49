import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_http_req/pages/add_pages.dart';
import 'package:firebase_http_req/pages/detail_pages.dart';
import 'package:firebase_http_req/pages/home_pages.dart';
import 'package:firebase_http_req/providers/players.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>Players(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          AddPlayer.routeName:(context) => AddPlayer(),
          DetailPlayer.routeName:(context) => DetailPlayer(),
        },
      ),
    );
  }
}
