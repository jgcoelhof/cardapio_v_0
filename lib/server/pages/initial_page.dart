import 'package:cardapio_v_0/server/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -100,
            right: 20,
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image.asset(
                'assets/images/cutlery.png',
                height: 550,
                width: 300,
              ),
            ),
          ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(95, 181, 94.94, 80),
                  child: Image.asset(
                    'assets/images/cardapio-web.png',
                    height: 68,
                    width: 200.05719,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 43, horizontal: 43),
                  child: Column(
                    children: [
                      const Text(
                        "Qual o nome do seu estabelecimento?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      TextFormField(
                        style: textStyleInput,
                        decoration: textInputDecorationName.copyWith(
                          labelText: "Nome",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFB063),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        },
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.navigate_next,
          size: 31,
        ),
      ),
    );
  }
}
