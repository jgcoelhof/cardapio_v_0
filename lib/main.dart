import 'package:cardapio_v_0/server/pages/cardapio_page.dart';
import 'package:flutter/material.dart';

import 'package:cardapio_v_0/server/pages/initial_page.dart';

import 'client/pages/client_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CardapioPage(),
    );
  }
}
