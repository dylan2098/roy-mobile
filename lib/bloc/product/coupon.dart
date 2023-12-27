import 'dart:async';

class CouponBloc {
  StreamController _searchController = new StreamController.broadcast();

  Stream get searchStream => _searchController.stream;

  bool inValidInfo(String search) {
    if (search.length <= 0) {
      return false;
    }
    _searchController.sink.add("OK");
    return true;
  }

  void dispose() {
    _searchController.close();
  }
}
