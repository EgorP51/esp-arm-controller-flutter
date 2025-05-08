import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const ESPControllerApp());
}

class ESPControllerApp extends StatelessWidget {
  const ESPControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP Servo Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ServoControlPage(),
    );
  }
}

class ServoControlPage extends StatefulWidget {
  const ServoControlPage({super.key});

  @override
  State<ServoControlPage> createState() => _ServoControlPageState();
}

class _ServoControlPageState extends State<ServoControlPage> {
  late WebSocketChannel channel;
  double servoAngle = 90.0; // Initial angle (default 90 degrees)

  @override
  void initState() {
    super.initState();
    // Connect to ESP32 WebSocket server
    channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.4.1:81'), // ESP32 AP IP and WebSocket port
    );
  }

  // Send servo angle to ESP32
  void updateServoAngle(double angle) {
    servoAngle = angle;
    channel.sink.add('SET_SERVO:$servoAngle'); // Command to ESP32
    setState(() {});
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESP Servo Controller')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: servoAngle,
              min: 0,
              max: 180,
              divisions: 180,
              label: '$servoAngle°',
              onChanged: updateServoAngle,
            ),
            Text(
              'Servo Angle: ${servoAngle.toStringAsFixed(0)}°',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}