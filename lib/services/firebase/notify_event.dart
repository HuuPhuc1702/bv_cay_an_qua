class NotifyEvent {
  static List<ModelEvent> _listListener = [];

  static callListener({required String key, dynamic dataValue}) {
    int indexItemEvent =
        _listListener.indexWhere((element) => element.key == key);
    if (indexItemEvent >= 0)
      _listListener[indexItemEvent].function.call(dataValue);
  }

  static addItemListener(
      {required String key, required Function(dynamic) function}) {
    final index = _listListener.lastIndexWhere((element) => element.key == key);
    if (index >= 0) {
      _listListener.removeAt(index);
    }
    _listListener.add(new ModelEvent(function: function, key: key));
  }

  static void removeListener({required String key}) {
    try {
      for (var item in _listListener) {
        if (item.key == key) {
          _listListener.remove(item);
          break;
        }
      }
    } catch (error) {
      print("NotifyEventResponse - removeListener : $error");
      throw (error);
    }
  }
}

class ModelEvent {
  final Function(dynamic) function;
  final String key;

  ModelEvent({required this.function, required this.key});
}
