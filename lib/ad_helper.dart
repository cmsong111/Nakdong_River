import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid && kDebugMode) {
      return 'ca-app-pub-3940256099942544/9214589741';
    } else if (Platform.isAndroid && !kDebugMode) {
      return 'ca-app-pub-9883771255224638/6548098375';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
