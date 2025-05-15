import '../data/esp_command_model.dart';


class AutomaticManager {
  static final AutomaticManager _instance = AutomaticManager._internal();

  AutomaticManager._internal();

  factory AutomaticManager() {
    return _instance;
  }

  final List<EspCommandModel> _commands = [];

  List<EspCommandModel> get commands => _commands;

  void addCommand(EspCommandModel command) {
    print('Adding command: ${command.command}');
    _commands.add(command);
  }

  void removeCommand(EspCommandModel command) {
    print('Removing command: ${command.command}');
    _commands.remove(command);
  }

  void clearCommands() {
    print('Clearing all commands');
    _commands.clear();
  }

  void executeCommands() {
    print('Executing commands:');
    for (var command in _commands) {
      print(command.command);
    }
  }
}
