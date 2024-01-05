import 'dart:io';

import 'package:cardapio_v_0/server/pages/widget_tables.dart';
import 'package:cardapio_v_0/widgets/modals/remove_tables_modal.dart';
import 'package:flutter/material.dart';

import 'package:cardapio_v_0/widgets/modals/add_tables_modal.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../webSocket/block.dart';
import '../../webSocket/socket_helper.dart';

class TablesPage extends StatefulWidget {
  final int count;

  const TablesPage({Key? key, required this.count}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  late List<TableStatus> tables;
  IO.Socket? socket;
  late SocketManager socketManager;
  late CounterBloc counterBloc;


  @override
  void initState() {
    super.initState();
    //tables = createTables(widget.numberOfTables);
    socketManager = SocketManager.shared;
    counterBloc = socketManager.counterBloc;
    tables = createTables(widget.count);


    // if (!isSubscribed) {
    // SocketManager.shared.subscribeToCounterUpdates((data) {
    //   if (data.isNotEmpty){
    //     String tableNumber = data[0];
    //     String tableStatus = data[1];
    //
    //     changeTableStatus(tableNumber,tableStatus);
    //   }
    // });
    // }

    // isSubscribed = true;

  }

  // List<Widget> buildTables() {
  //   List<Widget> tables = [];
  //
  //   for (int i = 1; i <= widget.count; i++) {
  //     final int digitCount = i >= 10 ? 2 : 1;
  //     final double leftValue = digitCount == 1 ? 41.0 : 35.0;
  //
  //     tables.add(
  //       GestureDetector(
  //         onTap: () {
  //           // Adicione aqui a lógica para remover a notificação da mesa
  //           // Este é apenas um exemplo, você pode substituir por sua própria lógica.
  //           print('Toque na mesa $i');
  //         },
  //         child: Stack(
  //           children: [
  //             ColorFiltered(
  //               colorFilter: ColorFilter.mode(
  //                 Colors.blue.withOpacity( 100 / 255), // Substitua pela cor desejada
  //                 BlendMode.srcIn,
  //               ),
  //               child: Image.asset(
  //               'assets/icons/empty_table.png',
  //               height: 95,
  //               width: 95,
  //               ),
  //             ),
  //             Positioned(
  //               top: 28,
  //               left: 60,
  //               child: Text(
  //                 '$i',
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 20,
  //                   fontFamily: 'Figtree',
  //                   fontWeight: FontWeight.w400,
  //                   height: 0,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return tables;
  // }
  List<TableStatus> createTables(int numberOfTables) {
    List<TableStatus> result = [];
    for (int i = 1; i <= numberOfTables; i++) {
      result.add(TableStatus('$i', 'free'));
    }
    return result;
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: TablesCardapio(numberOfTables: widget.count),
            ),
          ),

          // Adicione o GridView para exibir as mesas
          // StreamBuilder<List<dynamic>>(
          //     stream: socketManager.counterBloc.counterStream,
          //     builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //
          //       String tableNumber = snapshot.data?[0];
          //       String tableStatus = snapshot.data?[1];
          //
          //       // changeTableStatus(tableNumber,tableStatus);
          //       return Scaffold(
          //         body: GridView.builder(
          //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //             maxCrossAxisExtent: 150.0,
          //             mainAxisSpacing: 8.0,
          //             crossAxisSpacing: 8.0,
          //             childAspectRatio: 3 / 2,
          //           ),
          //           itemCount: tables.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             return buildTableBlock(tables[index]);
          //           },
          //         ),
          //
          //       );
          //     } else {
          //     return Text('Aguardando dados...');
          //     }
          //     },
          // )],
      ],
    ),
    );
  }

  void changeTableStatus(String tableNumber, String newStatus) {
    setState(() {
      // Encontre a mesa com o número correspondente
      try {
        // Encontra a mesa correspondente e atualiza o status
        TableStatus table = tables.firstWhere(
              (table) => table.tableNumber == tableNumber,
        );

        //table.status = newStatus;
        table.status = newStatus;
        print(table.status);
      } catch (e) {
        // Lida com o caso em que a mesa não é encontrada
        print('Mesa $tableNumber não encontrada.');
      }

    });
  }

  Widget buildTableBlock(TableStatus table) {
    Color blockColor = Colors.white; // Cor padrão

    switch (table.status) {
      case 'callingWaiter':
        blockColor = Colors.red;
        break;
      case 'payingBill':
        blockColor = Colors.green;
        break;
      case 'readingQR':
        blockColor = Colors.amber;
        break;
    }

    return InkWell(
      onTap: () {
        // Adicione lógica para lidar com o clique na mesa
        // Isso pode incluir a navegação para a página do cardápio, etc.
        // Por enquanto, apenas imprima o número da mesa.
        print('Clicou na ${table.tableNumber}');
      },
      child: Container(
        color: blockColor,
        child: Center(
          child: Text(
            table.tableNumber,
            style: TextStyle(color: Colors.black), // Cor do texto
          ),
        ),
      ),
    );
  }

}

class TableStatus {
  late String tableNumber;
  late String status;

  TableStatus(this.tableNumber, this.status);
}
