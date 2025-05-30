import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../utils/constant/data.dart';

class ChatSocketManager {
  IO.Socket createSocket({required String userId}) {
    final socket = IO.io(
      Local_data.socket_io,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({"userId": userId})
          .build(),
    );
    socket.connect();
    return socket;
  }
}
