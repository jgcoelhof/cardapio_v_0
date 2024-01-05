import 'dart:io';

import 'package:cardapio_v_0/server/pages/cardapio_page.dart';
import 'package:cardapio_v_0/webSocket/my_http_overrides.dart';
import 'package:cardapio_v_0/webSocket/socket_helper.dart';

import 'package:flutter/material.dart';
import 'package:cardapio_v_0/server/pages/initial_page.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SocketManager.shared.initSocket();

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
