import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class UdpListenerPage extends StatefulWidget {
  const UdpListenerPage({Key? key}) : super(key: key);

  @override
  _UdpListenerPageState createState() => _UdpListenerPageState();
}

class _UdpListenerPageState extends State<UdpListenerPage> {
  String _message = 'Waiting for UDP broadcast...';

  @override
  void initState() {
    super.initState();
    listenToUdpBroadcast();
  }

  Future<void> listenToUdpBroadcast() async {
    try {
      final receiver = Platform.isAndroid
          ? await UDP.bind(Endpoint.broadcast(port: Port(5000)))
          : await UDP.bind(Endpoint.any(port: Port(5000)));

      receiver.asStream().listen((datagram) {
        if (datagram != null) {
          final data = String.fromCharCodes(datagram.data);
          setState(() {
            _message = "Received: $data";
          });
          print("UDP Message: $data from ${datagram.address.address}");
        }
      });
    } catch (e) {
      print("Error binding UDP socket: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UDP Broadcast Listener")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(_message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
