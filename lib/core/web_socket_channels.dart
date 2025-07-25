import 'dart:async';
import 'dart:io';


class WebSocketChannels {
  static final WebSocketChannels _instance = WebSocketChannels._internal();
  factory WebSocketChannels() => _instance;
  WebSocketChannels._internal();

  WebSocket? _webSocket;
  StreamSubscription<dynamic>? _messageSubscription;
  bool _isConnected = false;
  final _connectionCompleter = Completer<void>();
  StreamController<dynamic>? _messageController;

  Future<void> connect(String token, String url) async {
    if (_isConnected) return _connectionCompleter.future;

    try {
      final uri = Uri.parse(url);
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      _webSocket = await WebSocket.connect(uri.toString(), headers: headers)
        ..pingInterval = const Duration(seconds: 30);

      // Create a broadcast controller to allow multiple listeners
      _messageController = StreamController.broadcast();
      
      // Set up the single subscription to the raw websocket
      _messageSubscription = _webSocket!.listen(
        (data) => _messageController?.add(data),
        onError: (error) {
          _handleDisconnection();
          _messageController?.addError(error);
        },
        onDone: () {
          _handleDisconnection();
          _messageController?.close();
        },
        cancelOnError: true,
      );

      _isConnected = true;
      _connectionCompleter.complete();

    } catch (e) {
      _connectionCompleter.completeError(e);
      _handleDisconnection();
      rethrow;
    }
  }

  bool get isConnected => _isConnected;

  Future<void> disconnect() async {
    try {
      await _messageSubscription?.cancel();
      await _messageController?.close();
      await _webSocket?.close();
    } finally {
      _handleDisconnection();
    }
  }

  void _handleDisconnection() {
    _isConnected = false;
    _messageSubscription?.cancel();
    _messageSubscription = null;
    _messageController?.close();
    _messageController = null;
    _webSocket = null;
    if (!_connectionCompleter.isCompleted) {
      _connectionCompleter.completeError(Exception('Connection terminated'));
    }
  }

  void sendMessage(dynamic message) {
    if (!_isConnected || _webSocket == null) {
      throw Exception("WebSocket not connected.");
    }
    try {
      _webSocket!.add(message);
    } catch (e) {
      _handleDisconnection();
      throw Exception("Failed to send message: ${e.toString()}");
    }
  }

  Stream<dynamic> getMessages() {
    if (!_isConnected || _messageController == null) {
      throw Exception("WebSocket not connected.");
    }
    return _messageController!.stream;
  }

  Future<void> waitForConnection() => _connectionCompleter.future;

  void dispose() {
    disconnect();
  }
}