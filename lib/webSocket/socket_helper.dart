import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'block.dart';

class SocketManager {
  static final SocketManager sigleton = SocketManager._internal();
  SocketManager._internal();
  IO.Socket? socket;
  static SocketManager get shared => sigleton;


  final CounterBloc _counterBloc = CounterBloc();
  CounterBloc get counterBloc => _counterBloc;

  void initSocket() {
    socket = IO.io('http://192.168.0.9:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true
    });

    socket?.on("connect", (data) {
      if (kDebugMode) {
        print("Socket Connect Done");
      }

    });

    socket?.on("connect_error", (data) {
      if (kDebugMode) {
        print("Socket connect_error");
        print(data);
      }
    });

    socket?.on("error", (data) {
      if (kDebugMode) {
        print("Socket error");
        print(data);
      }
    });

    socket?.on('atualizarContador', (data) {
      if (kDebugMode) {
        print("DADOS AQUI:");
        print(data);
        // Atualiza o BLoC com o novo valor do contador
        _counterBloc.updateCounter(data);
      }
    });

    socket?.on("disconnect", (data) {
      if (kDebugMode) {
        print("Socket disconnect");
        print(data);
      }
    });


  }

  Future<void> subscribeToCounterUpdates(void Function(List<dynamic>) onUpdate) async {
    _counterBloc.counterStream.listen(onUpdate);
  }

  void cancelSubscription() {
    _counterBloc.dispose();
  }

}