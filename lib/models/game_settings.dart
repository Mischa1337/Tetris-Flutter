enum ControlMode { dpad, gesture, both }

class GameSettings {
  ControlMode controlMode;

  GameSettings() : controlMode = ControlMode.both;
}
