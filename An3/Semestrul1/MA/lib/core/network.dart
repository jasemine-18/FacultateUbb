import 'package:connectivity_plus/connectivity_plus.dart';

class Network {
  Future<bool> isOnline() async {
    final r = await Connectivity().checkConnectivity();
    return r != ConnectivityResult.none;
  }
}