import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'web3auth_flutter.dart';
import 'web3auth_flutter_platform_interface.dart';

/// An implementation of [Web3authFlutterPlatform] that uses method channels.
class MethodChannelWeb3authFlutter extends Web3authFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel channel = const MethodChannel('web3auth_flutter');

  @override
  Future<void> init({
    required String clientId,
    Network? network,
    required String redirectUri,
    WhiteLabelData? whiteLabelData,
    HashMap<String, LoginConfigItem>? loginConfig,
  }) async {
    final String? networkString = network?.toString();
    await channel.invokeMethod('init', {
      'network': (networkString != null)
          ? networkString.substring(networkString.lastIndexOf('.') + 1)
          : null,
      'redirectUri': redirectUri,
      'clientId': clientId,
      'white_label_data': jsonEncode(whiteLabelData),
      'login_config': jsonEncode(loginConfig)
    });
  }

  @override
  Future<Web3AuthResponse> login({
    required Provider provider,
    String? appState,
    bool? relogin,
    String? redirectUrl,
    String? dappShare,
    ExtraLoginOptions? extraLoginOptions,
  }) async {
    try {
      final Map loginResponse = await channel.invokeMethod('login', {
        'provider': provider
            .toString()
            .substring(provider.toString().lastIndexOf('.') + 1),
        'appState': appState,
        'relogin': relogin,
        'redirectUrl': redirectUrl,
        'dappShare': dappShare,
        'additionalParams': extraLoginOptions?.additionalParams,
        'client_id': extraLoginOptions?.client_id,
        'connection': extraLoginOptions?.connection,
        'domain': extraLoginOptions?.domain,
        'id_token_hint': extraLoginOptions?.id_token_hint,
        'login_hint': extraLoginOptions?.login_hint,
        'leeway': extraLoginOptions?.leeway,
        'verifierIdField': extraLoginOptions?.verifierIdField,
        'isVerifierIdCaseSensitive':
            extraLoginOptions?.isVerifierIdCaseSensitive,
        'display': extraLoginOptions?.display.toString(),
        'prompt': extraLoginOptions?.prompt.toString(),
        'max_age': extraLoginOptions?.max_age,
        'ui_locales': extraLoginOptions?.ui_locales,
        'acr_values': extraLoginOptions?.acr_values,
        'scope': extraLoginOptions?.scope,
        'audience': extraLoginOptions?.audience,
        'state': extraLoginOptions?.state,
        'response_type': extraLoginOptions?.response_type,
        'nonce': extraLoginOptions?.nonce,
        'redirect_uri': extraLoginOptions?.redirect_uri
      });
      return Web3AuthResponse(
          loginResponse['privateKey'],
          _convertUserInfo(loginResponse['userInfo']).first,
          loginResponse['error']);
    } on PlatformException catch (e) {
      switch (e.code) {
        case "UserCancelledException":
          throw UserCancelledException();
        case "NoAllowedBrowserFoundException":
          throw UnKnownException(e.message);
        default:
          rethrow;
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      await channel.invokeMethod('logout', {});
      return;
    } on PlatformException catch (e) {
      switch (e.code) {
        case "UserCancelledException":
          throw UserCancelledException();
        case "NoAllowedBrowserFoundException":
          throw UnKnownException(e.message);
        default:
          rethrow;
      }
    }
  }

  List<TorusUserInfo> _convertUserInfo(dynamic obj) {
    if (obj == null) {
      return [];
    }
    if (obj is List<dynamic>) {
      return obj
          .whereType<Map>()
          .map((e) => TorusUserInfo(
              email: e['email'],
              name: e['name'],
              profileImage: e['profileImage'],
              dappShare: e['dappShare'],
              aggregateVerifier: e['aggregateVerifier'],
              verifier: e['verifier'],
              verifierId: e['verifierId'],
              typeOfLogin: e['typeOfLogin']))
          .toList();
    }
    if (obj is Map) {
      final Map e = obj;
      return [
        TorusUserInfo(
            email: e['email'],
            name: e['name'],
            profileImage: e['profileImage'],
            dappShare: e['dappShare'],
            aggregateVerifier: e['aggregateVerifier'],
            verifier: e['verifier'],
            verifierId: e['verifierId'],
            typeOfLogin: e['typeOfLogin'])
      ];
    }
    throw Exception("incorrect userInfo format");
  }
}
