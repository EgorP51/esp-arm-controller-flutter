import 'package:flutter/material.dart';

class ManualControlMode extends StatelessWidget {
  const ManualControlMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Manual Control Mode'),
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Image.asset('assets/manipulator.png'),
          Column(
            children: [
              SizedBox(height: 140),
              Row(
                children: [
                  Slider(value: 0.5, onChanged: (value) {}),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Slider(value: 0.5, onChanged: (value) {}),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 115),
              Row(
                children: [
                  Slider(value: 0.5, onChanged: (value) {}),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 100),
              Row(
                children: [
                  Slider(value: 0.5, onChanged: (value) {}),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Slider(value: 0.5, onChanged: (value) {}),
                  Text('90°'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
