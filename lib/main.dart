import 'package:deriv_go/deriv_go_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StartApp());
}

/// startup App
class StartApp extends StatelessWidget {
  /// Initializes
  const StartApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Deriv Go',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DerivGoApp(),
      );
}
