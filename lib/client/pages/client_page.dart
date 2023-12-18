import 'package:flutter/material.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xffF2693F),
        centerTitle: true,
        title:const Text(
          'Cardápio Web',
          style: TextStyle(
            color: Color(0xFFF2F2F7),
            fontSize: 28,
            fontFamily: 'Figtree',
            fontWeight: FontWeight.w400,
            height: 0.04,
            letterSpacing: 0.36,
          ),
        ),
      ),
    );
  }
}
