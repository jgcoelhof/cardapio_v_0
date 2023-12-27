import 'package:flutter/material.dart';

import 'package:cardapio_v_0/server/pages/initial_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitialPage(),
    );
  }
}
