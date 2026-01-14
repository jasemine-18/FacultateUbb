import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../core/log.dart';

class WsService {
  final String wsUrl;
  WebSocketChannel? _ch;

  WsService(this.wsUrl);

  Stream<Map<String, dynamic>> connect() {
    _ch = WebSocketChannel.connect(Uri.parse(wsUrl));
    log.d("WS connected $wsUrl");

    return _ch!.stream.map((msg) {
      final m = jsonDecode(msg.toString()) as Map<String, dynamic>;
      return m;
    });
  }

  void dispose() {
    _ch?.sink.close();
    _ch = null;
  }
}