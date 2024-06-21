import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider with ChangeNotifier {
  PackageInfoProvider() {
    _init();
  }

  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;

  Future<void> _init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
