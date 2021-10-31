import 'dart:io';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

String? symbolID = stdin.readLineSync();
void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick);
    final marketName = decodedMessage['active_symbols'];
    final displayName = decodedMessage['active_symbols'];
    final activeSymbol = decodedMessage['active_symbols'];

    print('\nList of Symbol ID: \n');

    for (var i = 0; i < 10; i++) {
      var marketNameID = marketName[i]['market_display_name'];
      var displayNameID = displayName[i]['display_name'];
      var activeSymbolID = activeSymbol[i]['symbol'];
      print('$displayNameID, $marketNameID');
      print('Active Symbol : $activeSymbolID\n');
    }
    // channel.sink.close();
    displayTickInfo();
  });

  channel.sink.add('{"active_symbols":"brief"}');
}

void displayTickInfo() {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick); //convert to readable json
    final tickName = decodedMessage['tick']['symbol'];
    final tickPrice = decodedMessage['tick']['quote'];
    final tickEpoch = decodedMessage['tick']['epoch'];
    final serverTime = DateTime.fromMillisecondsSinceEpoch(tickEpoch * 1000);
    print('Active Symbol: $tickName\t Price: \$$tickPrice\t Time: $serverTime');
    // channel.sink.close();
  });

  print('Enter Active Symbol: ');
  channel.sink.add('{ "ticks": "$symbolID"}');
}
