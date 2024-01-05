import 'dart:async';

class CounterBloc {
  final _controller = StreamController <List<dynamic>>.broadcast();
  Stream<List<dynamic>> get counterStream => _controller.stream;


  void updateCounter(List<dynamic> counter) {
    _controller.sink.add(counter);
  }

  void dispose() {
    _controller.close();
  }
}