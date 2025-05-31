import 'package:esp_arm_controller_flutter/data/esp_command_model.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class AutomaticControlMode extends StatefulWidget {
  const AutomaticControlMode({super.key});

  @override
  State<AutomaticControlMode> createState() => _AutomaticControlModeState();
}

class _AutomaticControlModeState extends State<AutomaticControlMode> {
  @override
  void initState() {
    super.initState();
    ws.stream.listen(
      (event) {
        setState(() {
          consoleText += event.toString();
        });
        print('Received: $consoleText');

        if (event.toString().startsWith('ESP:OK')) {
          consoleText += 'app: command executed successfully\n';
          setState(() {
            automaticManager.clearCommands();
          });
        } else if (event.toString().startsWith('ESP:ERR')) {
          consoleText += 'app: command execution failed\n';
        } else {
          consoleText += 'app: unknown response\n';
        }
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('WebSocket closed');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Automatic Control Mode'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/manipulator.png'),
          const SizedBox(width: 10),
          VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runSpacing: 10,
                children: [
                  ...List.generate(automaticManager.commands.length, (index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommandItemWidget(
                          command: automaticManager.commands[index],
                          onDelete: () {
                            setState(() {
                              automaticManager.removeCommand(
                                automaticManager.commands[index],
                              );
                              consoleText +=
                                  'app: removed command: ${automaticManager.commands[index].command}\n';
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.arrow_forward, size: 30),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            color: Colors.grey[200],
            child: Column(
              children: [
                SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddCommandWidget(
                          onAddCommand: (command) {
                            setState(() {
                              automaticManager.addCommand(command);
                              Navigator.of(context).pop();
                              consoleText +=
                                  'app: added command: ${command.command}\n';
                            });
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add, size: 40),
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Clear Commands?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  automaticManager.clearCommands();
                                  Navigator.of(context).pop();
                                  consoleText += 'app: cleared all commands\n';
                                });
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, size: 40),
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    // TODO: Implement history functionality
                  },
                  icon: const Icon(Icons.history, size: 40),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        children: [
          Spacer(),
          Container(
            height: 140,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white, width: 1),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'console',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(height: 1, color: Colors.white70),
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Text(
                      consoleText,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.play_arrow, color: Colors.green),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Execute Commands?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          automaticManager.executeCommands();
                          Navigator.of(context).pop();
                          consoleText += 'app: executed commands\n';
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddCommandWidget extends StatefulWidget {
  const AddCommandWidget({super.key, required this.onAddCommand});

  final Function(EspCommandModel model) onAddCommand;

  @override
  State<AddCommandWidget> createState() => _AddCommandWidgetState();
}

class _AddCommandWidgetState extends State<AddCommandWidget> {
  double servoAngle = 0.0;
  ServoName selectedServo = ServoName.servo1;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        child: SizedBox(
          width: 400,
          height: 350,
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(60),
                      onTap: () {
                        setState(() {
                          selectedServo = ServoName.values[index];
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            color:
                                selectedServo == ServoName.values[index]
                                    ? Colors.purpleAccent
                                    : Colors.black,
                            width: 4,
                          ),
                        ),
                        child: Text(
                          ServoName.values[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Angle: ${servoAngle.toStringAsFixed(0)}°',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: servoAngle,
                min: 0,
                max: 180,
                divisions: 180,
                label: '${servoAngle.toStringAsFixed(0)}°',
                onChanged: (value) {
                  setState(() {
                    servoAngle = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          servoAngle--;
                        });
                      },
                      icon: const Icon(Icons.remove, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          servoAngle++;
                        });
                      },
                      icon: const Icon(Icons.add, size: 30),
                    ),
                  ],
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  widget.onAddCommand(
                    ServoCommandModel(selectedServo.name, servoAngle.toInt()),
                  );
                },
                child: Text(
                  'Add Command',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommandItemWidget extends StatelessWidget {
  const CommandItemWidget({super.key, required this.command, this.onDelete});

  final EspCommandModel command;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black54, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                command.name,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '${command.value}°',
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
            ],
          ),

          InkWell(
            onTap: () {
              if (onDelete != null) {
                onDelete!();
              }
            },
            child: const Icon(Icons.delete, color: Colors.red, size: 30),
          ),
        ],
      ),
    );
  }
}
