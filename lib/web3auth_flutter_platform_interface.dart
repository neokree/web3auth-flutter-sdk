import 'dart:collection';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

import 'web3auth_flutter_method_channel.dart';

abstract class Web3authFlutterPlatform extends PlatformInterface {
  /// Constructs a Web3authFlutterPlatform.
  Web3authFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static Web3authFlutterPlatform _instance = MethodChannelWeb3authFlutter();

  /// The default instance of [Web3authFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWeb3authFlutter].
  static Web3authFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Web3authFlutterPlatform] when
  /// they register themselves.
  static set instance(Web3authFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init({
    required String clientId,
    Network? network,
    required String redirectUri,
    WhiteLabelData? whiteLabelData,
    HashMap<String, LoginConfigItem>? loginConfig,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

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

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
