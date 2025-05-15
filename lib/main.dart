import 'package:esp_arm_controller_flutter/presentation/automatic_control_mode.dart';
import 'package:esp_arm_controller_flutter/presentation/manual_control_mode.dart';
import 'package:flutter/material.dart';

import 'manager/automatic_manager.dart';

String consoleText = '';
late final AutomaticManager automaticManager;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  automaticManager = AutomaticManager();

  runApp(const ESPControllerApp());
}

class ESPControllerApp extends StatelessWidget {
  const ESPControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP Servo Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ControlHomePage(),
    );
  }
}

class ControlHomePage extends StatefulWidget {
  const ControlHomePage({super.key});

  @override
  _ControlHomePageState createState() => _ControlHomePageState();
}

class _ControlHomePageState extends State<ControlHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [AutomaticControlMode(), ManualControlMode()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.auto_mode), label: 'Auto'),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Manual'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withValues(alpha: 0.9),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: _navBarItems,
        onTap: _onTabTapped,
      ),
    );
  }
}

//
// class ServoControlPage extends StatefulWidget {
//   const ServoControlPage({super.key});
//
//   @override
//   State<ServoControlPage> createState() => _ServoControlPageState();
// }
//
// class _ServoControlPageState extends State<ServoControlPage> {
//   late WebSocketChannel channel;
//   double servoAngle = 90.0;
//
//   @override
//   void initState() {
//     super.initState();
//     channel = WebSocketChannel.connect(
//       Uri.parse('ws://192.168.4.1:81'),
//     );
//   }
//
//   void updateServoAngle(double angle) {
//     servoAngle = angle;
//     channel.sink.add('SET_SERVO:$servoAngle');
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ESP Servo Controller')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Slider(
//               value: servoAngle,
//               min: 0,
//               max: 180,
//               divisions: 180,
//               label: '$servoAngle°',
//               onChanged: updateServoAngle,
//             ),
//             Text(
//               'Servo Angle: ${servoAngle.toStringAsFixed(0)}°',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
