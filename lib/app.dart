import 'package:esp_arm_controller_flutter/presentation/automatic_control_mode.dart';
import 'package:esp_arm_controller_flutter/presentation/manual_control_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'manager/automatic_manager.dart';
import 'manager/websocket_manager.dart';

String consoleText = '';
late final AutomaticManager automaticManager;
final ws = WebSocketManager();

class ESPControllerApp extends StatefulWidget {
  const ESPControllerApp({super.key});

  @override
  State<ESPControllerApp> createState() => _ESPControllerAppState();
}

class _ESPControllerAppState extends State<ESPControllerApp> {
  @override
  void initState() {
    super.initState();
    ws.connect('ws://192.168.4.1:81');
    automaticManager = AutomaticManager();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size); // 1000 x 795
    return MaterialApp(
      title: 'ESP Servo Controller',
      debugShowCheckedModeBanner: false,
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
