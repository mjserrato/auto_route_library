import 'package:auto_route/auto_route.dart';
import 'package:example/data/books_data.dart';
import 'package:example/mobile/router/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final booksDb = BooksDB();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerConfig = MyRouterConfig();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      routerDelegate: RootRouterDelegate(
        routerConfig,
        // initialDeepLink: '/books/5',
        // same as
        // defaultHistory: [
        //   HomePageRoute(),
        //   BookListPageRoute(),
        //   BookDetails(id: 5),// ],
      ),
      routeInformationParser: routerConfig.nativeRouteParser,
    );
  }
}