import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../webSocket/block.dart';
import '../../webSocket/socket_helper.dart';

class TablesCardapio extends StatefulWidget {
  final int numberOfTables;


  TablesCardapio({required this.numberOfTables});

  @override
  _TablesCardapioState createState() => _TablesCardapioState();
}

class _TablesCardapioState extends State<TablesCardapio> {
  late List<TableStatus> tables;
  IO.Socket? socket;
  late SocketManager socketManager;
  late CounterBloc counterBloc;

  // Variável para rastrear se a subscrição já foi feita
  // bool isSubscribed = false;


  @override
  void initState() {
    super.initState();
    tables = createTables(widget.numberOfTables);
    socketManager = SocketManager.shared;
    // //socketManager.initSocket();
    counterBloc = socketManager.counterBloc;


    // if (!isSubscribed) {
      SocketManager.shared.subscribeToCounterUpdates((data) {
        if (data.isNotEmpty){
          String tableNumber = data[0];
          String tableStatus = data[1];

          changeTableStatus(tableNumber,tableStatus);
        }
      });
    // }

    // isSubscribed = true;

  }

  // @override
  // void dispose() {
  //   // Cancelar a subscrição ao sair do widget
  //   // Certifique-se de que a subscrição só seja cancelada se ela tiver sido feita
  //   if (isSubscribed) {
  //     SocketManager.shared.cancelSubscription();
  //   }
  //
  //   super.dispose();
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.1,
        ),
        itemCount: tables.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTableBlock(tables[index]);
        },
      ),



      // StreamBuilder<List<dynamic>>(
      //   stream: counterBloc.counterStream,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       // Lógica para atualizar o estado das mesas com base nos dados do stream
      //       print(snapshot.data);
      //       if (snapshot.data!.isNotEmpty){
      //         String tableNumber = snapshot.data?[0];
      //         String tableStatus = snapshot.data?[1];
      //
      //         changeTableStatus(tableNumber,tableStatus);
      //       }
      //
      //       // Retorna o GridView.builder com as mesas atualizadas
      //       return GridView.builder(
      //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //           maxCrossAxisExtent: 150.0,
      //           mainAxisSpacing: 8.0,
      //           crossAxisSpacing: 8.0,
      //           childAspectRatio: 3 / 2,
      //         ),
      //         itemCount: tables.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return buildTableBlock(tables[index]);
      //         },
      //       );
      //     } else {
      //       // Retorna um widget de carregamento ou outra coisa enquanto os dados estão sendo carregados
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),

    );
  }

  // void changeTableStatus(String tableNumber, String newStatus) {
  //   setState(() {
  //     // Encontre a mesa com o número correspondente
  //     try {
  //       // Encontra a mesa correspondente e atualiza o status
  //       TableStatus? table = tables.firstWhere(
  //             (table) => table.tableNumber == tableNumber,
  //         orElse: () => null,
  //       );
  //
  //       if (table != null) {
  //         table.status = newStatus;
  //       } else {
  //         // Lida com o caso em que a mesa não é encontrada
  //         print('Mesa $tableNumber não encontrada.');
  //       }
  //     } catch (e) {
  //       // Lida com outras exceções
  //       print('Ocorreu um erro: $e');
  //     }
  //   });
  // }

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
    String imagePath = 'assets/icons/empty_table.png'; // Imagem padrão

    switch (table.status) {
      case 'callingWaiter':
        imagePath = 'assets/icons/alert_table.png';
        break;
      case 'payingBill':
        imagePath = 'assets/icons/alert_table.png';
        break;
      case 'readingQR':
        imagePath = 'assets/icons/active_table.png';
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
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
        ),
        child: Center(
          child: Text(
            table.tableNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Figtree',
              fontWeight: FontWeight.w400,
              height: 0,
            ), // Cor do texto
          ),
        ),
      ),
    );
  }
  // Widget buildTableBlock(TableStatus table) {
  //   Color blockColor = Colors.white; // Cor padrão
  //
  //   switch (table.status) {
  //     case 'callingWaiter':
  //       blockColor = Colors.red;
  //       break;
  //     case 'payingBill':
  //       blockColor = Colors.green;
  //       break;
  //     case 'readingQR':
  //       blockColor = Colors.amber;
  //       break;
  //   }
  //
  //   return InkWell(
  //     onTap: () {
  //       // Adicione lógica para lidar com o clique na mesa
  //       // Isso pode incluir a navegação para a página do cardápio, etc.
  //       // Por enquanto, apenas imprima o número da mesa.
  //       print('Clicou na ${table.tableNumber}');
  //     },
  //     child: Container(
  //       color: blockColor,
  //       child: Center(
  //         child: Text(
  //           table.tableNumber,
  //           style: TextStyle(color: Colors.black), // Cor do texto
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class TableStatus {
  late String tableNumber;
  late String status;

  TableStatus(this.tableNumber, this.status);
}