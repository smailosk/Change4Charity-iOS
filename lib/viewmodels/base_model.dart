import 'package:flutter/widgets.dart';
export 'package:provider_architecture/provider_architecture.dart';
export 'package:provider_architecture/provider_architecture.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
