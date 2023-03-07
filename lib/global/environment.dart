import 'dart:io';

class Environment {
  //static String apiUrl = 'http://192.168.0.105:3001/api';
  //static String socketUrl = 'http://192.168.0.105:3001';
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.0.105:3001/api'
      : 'http://localhost:3001/api';
  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.0.105:3001'
      : 'http://localhost:3001';
}
