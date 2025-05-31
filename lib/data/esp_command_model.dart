enum ServoName { servo1, servo2, servo3, servo4, servo5 }

extension ServoNameExtension on ServoName {
  String get name {
    switch (this) {
      case ServoName.servo1:
        return 'M1';
      case ServoName.servo2:
        return 'M2';
      case ServoName.servo3:
        return 'M3';
      case ServoName.servo4:
        return 'M3';
      case ServoName.servo5:
        return 'M5';
      }
  }
}

abstract class EspCommandModel<T> {
  final String _name;
  final T _value;

  EspCommandModel(this._name, this._value);

  String get name => _name;

  T get value => _value;

  String get command => '$_name:$_value';
}

class ServoCommandModel extends EspCommandModel<int> {
  ServoCommandModel(super.elementName, super.value);

  @override
  String toString() {
    return 'ServoCommandModel{elementName: $name, value: $value}';
  }
}

class LightCommandModel extends EspCommandModel<int> { // int -> duration
  LightCommandModel(super.elementName, super.value);

  @override
  String toString() {
    return 'LightCommandModel{elementName: $name, value: $value}';
  }
}
