import 'package:flutter/material.dart';

class ManualControlMode extends StatelessWidget {
  const ManualControlMode({super.key});

  final double sliderWidth = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Manual Control Mode',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      body: Row(
        children: [
          Image.asset('assets/manipulator.png'),
          Column(
            children: [
              SizedBox(height: 140),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(value: 0.5, onChanged: (value) {}),
                  ),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(value: 0.5, onChanged: (value) {}),
                  ),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 115),
              Row(
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(value: 0.5, onChanged: (value) {}),
                  ),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 100),
              Row(
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(value: 0.5, onChanged: (value) {}),
                  ),
                  Text('90°'),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(
                    width: sliderWidth,
                    child: Slider(value: 0.5, onChanged: (value) {}),
                  ),
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
