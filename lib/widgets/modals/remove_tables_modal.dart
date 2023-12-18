import 'package:flutter/material.dart';

import 'package:cardapio_v_0/widgets/widgets.dart';

class RemoveTablesModal extends StatefulWidget {
  const RemoveTablesModal({Key? key}) : super(key: key);

  @override
  State<RemoveTablesModal> createState() => _RemoveTablesModalState();
}

class _RemoveTablesModalState extends State<RemoveTablesModal> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4.26,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantidade de mesas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black,
                        child: IconButton(
                          onPressed: increment,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: DefaultButton(
                onPressed: () {},
                buttonText: "Remover mesas",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
