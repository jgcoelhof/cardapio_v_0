import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/tableStatus.dart';
import '../../provider/statusProvider.dart';
import '../../webSocket/block.dart';
import '../../webSocket/socket_helper.dart';

class TablesCardapio extends StatefulWidget {
  final int numberOfTables;


  TablesCardapio({required this.numberOfTables});

  @override
  _TablesCardapioState createState() => _TablesCardapioState();
}

class _TablesCardapioState extends State<TablesCardapio> {
  IO.Socket? socket;
  late SocketManager socketManager;
  late CounterBloc counterBloc;
  late AppState appState;


  @override
  void initState() {
    super.initState();

    appState = Provider.of<AppState>(context, listen: false);

    if (!appState.wasReinitialized) {
      Future.delayed(Duration.zero, () {
        appState.setTables(createTables(widget.numberOfTables));
        appState.setWasReinitialized(true);
      });
    }
    socketManager = SocketManager.shared;

    counterBloc = socketManager.counterBloc;



      SocketManager.shared.subscribeToCounterUpdates((data) {
        if (data.isNotEmpty){
          String tableNumber = data[0];
          String tableStatus = data[1];

          changeTableStatus(tableNumber,tableStatus);
        }
      });


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
        itemCount: appState.tables.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTableBlock(appState.tables[index]);
        },
      ),
    );
  }



  void changeTableStatus(String tableNumber, String newStatus) {
    setState(() {
      // Encontre a mesa com o número correspondente
      try {
        // Encontra a mesa correspondente e atualiza o status
        TableStatus table = appState.tables.firstWhere(
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
}

