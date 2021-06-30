import 'package:event_bus/event_bus.dart';

class ListPositon {
  final bool isScroll;
  final int positon;

  ListPositon(this.isScroll, this.positon);
}

class Event {
  static final EventBus eventBus = EventBus();

  static void fire(event) => eventBus.fire(event);

  static void listen<T>(func) {
    eventBus.on<T>().listen(func);
  }

  static void listenAll(func) {
    eventBus.on().listen(func);
  }
}
