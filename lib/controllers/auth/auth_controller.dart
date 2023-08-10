import 'dart:convert';
import 'dart:developer';
import 'package:bnaa/services/server_response.dart';
import 'package:bnaa/services/toast_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/models/user.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

enum Status {
  Uninitialized,
  StoreAuthenticated,
  ConfirmEmail,
  ClientAuthenticated,
  ClientNoProfileCompleted,
  StoreNoProfileCompleted,
  Unauthenticated,
}

class AuthProvider extends GetxController {
  static String version = 'api/v1';
  static String host = Network.host;
  late String _token;
  static CustomUser? client;
  static Store? store;

  Status _status = Status.Uninitialized;

  Status get status => _status;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthProvider() {
    initAuthController();
  }

  Future<bool> isClientProfileCompleted() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(storage.getString('client')!);
    print(json);
    client = CustomUser.fromJson(json);
    return client!.phone != null;
  }

  Future<bool> isStore() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString('store') != null;
  }

  Future<bool> isClient() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString('client') != null;
  }

  Future<bool> isStoreProfileCompleted() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(storage.getString('store')!);
    store = Store.fromJson(json);
    return store!.phone != null;
  }

  Future<bool> completeStoreProfile(
      {required Map<String, String> data, imageFile}) async {
    print(data);
    Network api = Network();
    try {
      var streamResponse = await api
          .miltipartPost(
            apiUrl: '/store/set_my_info',
            data: data,
            filePath: imageFile,
            fileData: "image",
          )
          .timeout(timeOutDuration);
      var response = await http.Response.fromStream(streamResponse);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        await updateStoreData(response.body);
        await initAuthController();
        update();
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e) {
      log(e.toString());
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<bool> completeClientProfile({
    required Map<String, String> data,
    imageFile,
  }) async {
    Network api = Network();
    try {
      var streamResponse = await api.miltipartPost(
        apiUrl: '/set_my_info',
        data: data,
        filePath: imageFile,
        fileData: "image",
      );

      var response = await http.Response.fromStream(streamResponse);
      log("response : ${response.statusCode}");
      log("complete profile" + response.body);

      switch (response.statusCode) {
        case 201:
          await updateClientData(response.body);
          await initAuthController();
          update();
          return true;
        case 401:
          logout();
          return true;
        default:
          ServerResponse.serverResponseHandler(response: response);
          return false;
      }
    } catch (e) {
      log(e.toString());
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future initAuthController() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('access_token');

    if (token != null) {
      _token = token;

      if (await isClient()) {
        var isProfileCompleted = await isClientProfileCompleted();
        Map<String, dynamic> json = jsonDecode(storage.getString('client')!);
        CustomUser uss = CustomUser.fromJson(json);
        if (uss.validated == false) {
          _status = Status.ConfirmEmail;
          update();
          return;
        }

        print('isCompleted = $isProfileCompleted');
        if (!isProfileCompleted) {
          log("message");
          _status = Status.ClientNoProfileCompleted;
        } else {
          log("message2");

          _status = Status.ClientAuthenticated;
        }
      }

      if (await isStore()) {
        var isProfileCompleted = await isStoreProfileCompleted();
        Map<String, dynamic> json = jsonDecode(storage.getString('store')!);
        CustomUser uss = CustomUser.fromJson(json);
        if (uss.validated == false) {
          _status = Status.ConfirmEmail;
          update();
          return;
        }

        if (!isProfileCompleted) {
          _status = Status.StoreNoProfileCompleted;
        } else {
          _status = Status.StoreAuthenticated;
        }
      }
    } else {
      _status = Status.Unauthenticated;
    }
    update();
  }

  Future<bool> firstLogin(String phone, String password) async {
    var api = Network();

    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final String? fcm = await messaging.getToken();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('device_id', fcm!);
    print("fcm :: $fcm");

    var data = {
      'phone': phone,
      'password': password,
      'fcm': fcm,
    };
    try {
      final response = await api.post('/first_login', data);
      log("status code first login : ${response.statusCode}  \n respons first login :  ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storeUserDataFirstLogin(response.body);
        await initAuthController();
        if (data["data"]["validated"] == false) {
          await sendCode(phone);
        }
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<bool> confirmEmail(
      {required String code, required String verifId}) async {
    try {
      PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(verificationId: verifId, smsCode: code);

      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> register({
    required String name,
    required String phone,
    required String password,
    required String type,
  }) async {
    var api = Network();

    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    var data = {
      'name': name,
      'phone': phone,
      'password': password,
      'type': type,
    };
    try {
      final response = await api.post('/register', data);

      if (response.statusCode == 200) {
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<String> sendCode(String phone) async {
    String verifId = '';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+213 ${phone}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verifId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return verifId;
    
      }

  Future<bool> sendCodeForChangePassword(String email) async {
    var api = Network();

    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    try {
      final response = await api.post('/resetpassword', {"email": email});

      if (response.statusCode == 200) {
        ToastService.showSuccessToast("envoyé avec succès".tr);
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<bool> changePassword(
      {required String email,
      required String code,
      required String password}) async {
    var api = Network();

    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    try {
      final response = await api.post(
        '/changepassword',
        {
          "email": email,
          "code": code,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        ToastService.showSuccessToast(
            "Le mot de passe a été changé avec succès".tr);
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<bool> storeLogin(String phone, String password) async {
    var api = Network();
    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final String? fcm = await messaging.getToken();
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('device_id', fcm!);
    print("fcm :: $fcm");

    var data = {
      'phone': phone,
      'password': password,
      'fcm': fcm,
    };
    try {
      final response =
          await api.post('/store/login', data).timeout(timeOutDuration);
      log("status code login : ${response.statusCode}  \n respons login :  ${response.body}");
      if (response.statusCode == 200) {
        log(response.body);
        await storeStoreData(response.body);
        await initAuthController();
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e) {
      print(e);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<bool> clientLogin(String phone, String password) async {
    var api = Network();
    /* SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final String? fcm = await messaging.getToken();
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('device_id', fcm!);
    print("fcm :: $fcm");

    var data = {
      'phone': phone,
      'password': password,
      'fcm': fcm,
    };
    try {
      final response = await api.post('/login', data);
      log("status code login : ${response.statusCode}  \n respons login :  ${response.body}");

      if (response.statusCode == 200) {
        await storeUserData(response.body);
        await initAuthController();

        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  void logout() async {
    await FirebaseMessaging.instance.deleteToken();
    await GoogleSignIn().signOut();
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
    _status = Status.Unauthenticated;
    update();
  }

  storeUserDataFirstLogin(String response) async {
    var data = json.decode(response);
    SharedPreferences storage = await SharedPreferences.getInstance();
    if (data['isBanned'] == true) {
      Get.snackbar(
          "compte verrouillé".tr,
          "Votre compte a été verrouillé pour violation des conditions et de la politique"
              .tr,
          backgroundColor: Colors.amber);
      return;
    }
    if (data['token'] != null) {
      await storage.setString('access_token', data['token']);
      if (data['isClient']) {
        await storage.setString('client', json.encode(data['data']));
        await storage.setString('user', json.encode(data['data']));
        user = json.decode(storage.getString('user')!);
      } else {
        await storage.setString('store', json.encode(data['data']));
      }
    }
  }

  storeStoreData(String response) async {
    var data = json.decode(response);
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('access_token', data['data']['token']);
    await storage.setString('store', json.encode(data['data']['user']));
  }

  storeUserData(String response) async {
    var data = json.decode(response);
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('access_token', data['data']['token']);
    await storage.setString('client', json.encode(data['data']['user']));
    await storage.setString('user', json.encode(data['data']['user']));
    user = json.decode(storage.getString('user')!);
  }

  static updateStoreData(String response) async {
    var data = json.decode(response);
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('store', json.encode(data));
  }

  static updateClientData(String response) async {
    var data = json.decode(response);
    print(data);
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('client', json.encode(data));
    await storage.setString('user', json.encode(data));
    user = json.decode(storage.getString('user')!);
  }

  redirectToLogin() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
    /*ToastService.showErrorToast(
      AppLocalizations.of(MyApp.navigatorKey.currentContext).sessionExpiredTxt,
    );*/
    _status = Status.Unauthenticated;
  }
}
