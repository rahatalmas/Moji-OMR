import 'package:flutter/cupertino.dart';
import '../database/models/scholar.dart';
import '../handler/apis/scholarApi.dart';

class ScholarProvider with ChangeNotifier {
  List<Scholar> _scholars = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  // Getters
  List<Scholar> get scholars => _scholars;

  bool get isLoading => _isLoading;

  bool get dataUpdated => _dataUpdated;

  String get message => _message;

  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllScholars() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      _scholars = await ScholarApi().fetchScholars();
      _isLoading = false;
      _dataUpdated = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
