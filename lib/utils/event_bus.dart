import 'package:event_bus/event_bus.dart';

class ListPositon {
  final int type; //0 scroll, 1 jump
  final int positon;

  ListPositon(this.type, this.positon);
}

class InnerDrawerStatus {
  final int status; //0 close ,1 open

  InnerDrawerStatus(this.status);
}

class NavBarStatus {
  final int status; //0 show ,1 hide

  NavBarStatus(this.status);
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
