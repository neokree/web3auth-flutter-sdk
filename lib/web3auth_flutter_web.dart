// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:collection';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

import 'web3auth_flutter_platform_interface.dart';

/// A web implementation of the Web3authFlutterPlatform of the Web3authFlutter plugin.
class Web3authFlutterWeb extends Web3authFlutterPlatform {
  /// Constructs a Web3authFlutterWeb
  Web3authFlutterWeb();

  static void registerWith(Registrar registrar) {
    Web3authFlutterPlatform.instance = Web3authFlutterWeb();
  }

  @override
  Future<void> init({
    required String clientId,
    Network? network,
    required String redirectUri,
    WhiteLabelData? whiteLabelData,
    HashMap<String, LoginConfigItem>? loginConfig,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  @override
  Future<Web3AuthResponse> login({
    required Provider provider,
    String? appState,
    bool? relogin,
    String? redirectUrl,
    String? dappShare,
    ExtraLoginOptions? extraLoginOptions,
  }) {
    throw UnimplementedError('login() has not been implemented.');
  }

  @override
  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
