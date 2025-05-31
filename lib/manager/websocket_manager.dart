import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  late WebSocketChannel _channel;

  factory WebSocketManager() {
    return _instance;
  }

  WebSocketManager._internal();

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  WebSocketChannel get channel => _channel;

  void send(String message) {
    _channel.sink.add(message);
  }

  Stream get stream => _channel.stream;

  void dispose() {
    _channel.sink.close(status.normalClosure);
  }
}
