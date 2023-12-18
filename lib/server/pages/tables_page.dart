import 'package:cardapio_v_0/widgets/modals/remove_tables_modal.dart';
import 'package:flutter/material.dart';

import 'package:cardapio_v_0/widgets/modals/add_tables_modal.dart';

class TablesPage extends StatefulWidget {
  final int count;

  const TablesPage({Key? key, required this.count}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  List<Widget> buildTables() {
    List<Widget> tables = [];

    for (int i = 1; i <= widget.count; i++) {
      final int digitCount = i >= 10 ? 2 : 1;
      final double leftValue = digitCount == 1 ? 41.0 : 35.0;

      tables.add(
        GestureDetector(
          onTap: () {
            // Adicione aqui a lógica para remover a notificação da mesa
            // Este é apenas um exemplo, você pode substituir por sua própria lógica.
            print('Toque na mesa $i');
          },
          child: Stack(
            children: [
              Image.asset(
                'assets/icons/empty_table.png',
                height: 95,
                width: 95,
              ),
              Positioned(
                top: 28,
                left: leftValue,
                child: Text(
                  '$i',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return tables;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset(
                'assets/images/cardapio-web.png',
                height: 48,
                width: 150,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 42, bottom: 25, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const RemoveTablesModal();
                          },
                        );
                      },
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFFFB063),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const AddTablesModal();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Total de mesas cadastradas:',
                  style: TextStyle(
                    color: Color(0xFF2F4858),
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.07,
                    letterSpacing: 0.36,
                  ),
                ),
                const TextSpan(
                  text: ' ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.07,
                    letterSpacing: 0.36,
                  ),
                ),
                TextSpan(
                  text: '${widget.count}',
                  style: const TextStyle(
                    color: Color(0xFFFFB063),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.03,
                    letterSpacing: 0.36,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: const Color(0xFFD4DADE),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Toque na mesa para remover a notificação.',
            style: TextStyle(
              color: Color(0xFF81919C),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0.10,
              letterSpacing: 0.36,
            ),
          ),

          // Adicione o GridView para exibir as mesas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GridView.count(
                crossAxisCount: 3,
                // Defina o número de colunas conforme necessário
                children: buildTables(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
