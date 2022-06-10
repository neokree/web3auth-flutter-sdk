import 'dart:async';
import 'dart:collection';

import 'package:web3auth_flutter/web3auth_flutter_platform_interface.dart';

enum Network { mainnet, testnet, cyan }

enum Provider {
  google,
  facebook,
  reddit,
  discord,
  twitch,
  github,
  apple,
  linkedin,
  twitter,
  line,
  email_passwordless,
  jwt
}

enum TypeOfLogin {
  google,
  facebook,
  reddit,
  discord,
  twitch,
  github,
  apple,
  kakao,
  linkedin,
  twitter,
  weibo,
  wechat,
  line,
  email_passwordless,
  email_password,
  jwt
}

enum Display { page, popup, touch, wap }

enum Prompt { none, login, consent, select_account }

class LoginParams {
  final Provider loginProvider;
  final bool? reLogin;
  final bool? skipTKey;
  final ExtraLoginOptions? extraLoginOptions;
  final Uri? redirectUrl;
  final String? appState;

  LoginParams({
    required this.loginProvider,
    this.reLogin,
    this.skipTKey,
    this.extraLoginOptions,
    this.redirectUrl,
    this.appState,
  });
}

class LoginConfigItem {
  final String verifier;
  final TypeOfLogin typeOfLogin;
  final String name;
  final String? description;
  final String? clientId;
  final String? verifierSubIdentifier;
  final String? logoHover;
  final String? logoLight;
  final String? logoDark;
  final bool? mainOption;
  final bool? showOnModal;
  final bool? showOnDesktop;
  final bool? showOnMobile;

  LoginConfigItem({
    required this.verifier,
    required this.typeOfLogin,
    required this.name,
    this.description,
    this.clientId,
    this.verifierSubIdentifier,
    this.logoHover,
    this.logoLight,
    this.logoDark,
    this.mainOption,
    this.showOnModal,
    this.showOnDesktop,
    this.showOnMobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'verifier': verifier,
      'typeOfLogin': typeOfLogin.toString(),
      'name': name,
      'description': description,
      'clientId': clientId,
      'verifierSubIdentifier': verifierSubIdentifier,
      'logoHover': logoHover,
      'logoLight': logoLight,
      'logoDark': logoDark,
      'mainOption': mainOption,
      'showOnModal': showOnModal,
      'showOnDesktop': showOnDesktop,
      'showOnMobile': showOnMobile
    };
  }
}

class ExtraLoginOptions {
  final Map? additionalParams;
  final String? domain;
  final String? client_id;
  final String? leeway;
  final String? verifierIdField;
  final bool? isVerifierIdCaseSensitive;
  final Display? display;
  final Prompt? prompt;
  final String? max_age;
  final String? ui_locales;
  final String? id_token_hint;
  final String? login_hint;
  final String? acr_values;
  final String? scope;
  final String? audience;
  final String? connection;
  final String? state;
  final String? response_type;
  final String? nonce;
  final String? redirect_uri;

  ExtraLoginOptions({
    this.additionalParams = const {},
    this.domain,
    this.client_id,
    this.leeway,
    this.verifierIdField,
    this.isVerifierIdCaseSensitive,
    this.display,
    this.prompt,
    this.max_age,
    this.ui_locales,
    this.id_token_hint,
    this.login_hint,
    this.acr_values,
    this.scope,
    this.audience,
    this.connection,
    this.state,
    this.response_type,
    this.nonce,
    this.redirect_uri,
  });
}

class Web3AuthOptions {
  final String clientId;
  final Network network;
  final Uri? redirectUrl;
  final String? sdkUrl;

  Web3AuthOptions({
    required this.clientId,
    required this.network,
    this.redirectUrl,
    this.sdkUrl,
  });
}

class WhiteLabelData {
  final String? name;
  final String? logoLight;
  final String? logoDark;
  final String? defaultLanguage;
  final bool? dark;
  final HashMap? theme;

  WhiteLabelData({
    this.name,
    this.logoLight,
    this.logoDark,
    this.defaultLanguage,
    this.dark,
    this.theme,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoLight': logoLight,
      'logoDark': logoDark,
      'defaultLanguage': defaultLanguage,
      'dark': dark,
      'theme': theme
    };
  }
}

class Web3AuthResponse {
  final String privKey;
  final TorusUserInfo userInfo;
  final String? error;

  Web3AuthResponse(this.privKey, this.userInfo, this.error);

  @override
  String toString() {
    return "{privKey=$privKey, userInfo = ${userInfo.toString()}}";
  }
}

class TorusUserInfo {
  final String? email;
  final String? name;
  final String? profileImage;
  final String? verifier;
  final String? verifierId;
  final String? typeOfLogin;
  final String? aggregateVerifier;
  final String? dappShare;

  const TorusUserInfo({
    required this.email,
    required this.name,
    this.profileImage,
    this.verifier,
    this.verifierId,
    this.typeOfLogin,
    this.aggregateVerifier,
    this.dappShare,
  });

  @override
  String toString() {
    return "{email=$email, name=$name, profileImage=$profileImage, verifier=$verifier,"
        "verifierId=$verifierId, typeOfLogin=$typeOfLogin}";
  }
}

class UserCancelledException implements Exception {}

class UnKnownException implements Exception {
  final String? message;

  UnKnownException(this.message);
}

class Web3AuthFlutter {
  static Future<void> init({
    required String clientId,
    Network? network,
    required String redirectUri,
    WhiteLabelData? whiteLabelData,
    HashMap<String, LoginConfigItem>? loginConfig,
  }) =>
      Web3authFlutterPlatform.instance.init(
        clientId: clientId,
        network: network,
        redirectUri: redirectUri,
        whiteLabelData: whiteLabelData,
        loginConfig: loginConfig,
      );

  static Future<Web3AuthResponse> login({
    required Provider provider,
    String? appState,
    bool? relogin,
    String? redirectUrl,
    String? dappShare,
    ExtraLoginOptions? extraLoginOptions,
  }) =>
      Web3authFlutterPlatform.instance.login(
        provider: provider,
        appState: appState,
        relogin: relogin,
        redirectUrl: redirectUrl,
        dappShare: dappShare,
        extraLoginOptions: extraLoginOptions,
      );

  static Future<void> logout() => Web3authFlutterPlatform.instance.logout();
}
