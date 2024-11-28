import 'package:amplitude_flutter/amplitude.dart';

class AmplitudeFunc {
  // Create an instance of Amplitude class
  final Amplitude _amplitude = Amplitude.getInstance();

  // Initialize the Amplitude SDK with your API key
  void initAmplitude() {
    _amplitude.init('22c53704f4c2c4cca29ac95c94a12b01');
  }

  void logEvent(String eventName, [Map<String, dynamic>? properties]) {
    _amplitude.logEvent(eventName, eventProperties: properties);
  }

  void setUserProperties(Map<String, dynamic> properties) {
    _amplitude.setUserProperties(properties);
  }
}
