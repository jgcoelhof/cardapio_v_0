import 'package:cardapio_v_0/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  bool get isEmpty => count == 0;

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
                padding:
                    const EdgeInsets.symmetric(vertical: 43, horizontal: 43),
                child: Column(
                  children: const [
                    Text(
                      "Bem vindo ao Cardápio Web, cadastre as mesas, os QR code de acesso serão gerados automaticamente na área Adesivos",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Quantas mesas tem seu\n estabelecimento?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      color: Colors.black,
                      icon: const Icon(
                        Icons.remove,
                        size: 14,
                        color: Colors.white,
                      ),
                      onPressed: isEmpty ? null : decrement,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      padding: const EdgeInsets.all(21.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFF81919C),
                        ),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: increment,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        )),
                  ),
                ],
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
            MaterialPageRoute(builder: (context) => NavBar(count: count,)),
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
