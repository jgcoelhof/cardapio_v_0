import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CardapioPage extends StatefulWidget {
  const CardapioPage({Key? key}) : super(key: key);

  @override
  State<CardapioPage> createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Cardápio",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 100, 25, 100),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 2,
              dashPattern: const [8, 5],
              child: SizedBox(
                height: 424,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 90, 18, 120),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/cloud-upload.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 306,
                      height: 48,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Faça o upload do cardápio em pdf aqui.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w300,
                          height: 0.09,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DefaultButton(
            onPressed: () {
              // Lógica específica para essa tela
            },
            buttonText: "Salvar",
          ),
        ],
      ),
    );
  }
}
