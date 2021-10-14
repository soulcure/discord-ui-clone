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

typedef CallBack = void Function<T>(T event);

class Event<T> {
  static final EventBus eventBus = EventBus();

  static void fire<T>(T event) => eventBus.fire(event);

  static void listen<T>(CallBack func) {
    eventBus.on<T>().listen(func);
  }

  static void listenAll(CallBack func) {
    eventBus.on().listen(func);
  }
}
