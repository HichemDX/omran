import 'dart:async';

import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../constants/app_colors.dart';

class ConnectivityPage extends StatefulWidget {
  Widget child;

  ConnectivityPage({required this.child});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  late StreamSubscription subscription;

  bool isConnected = true;

  Widget? child;

  @override
  void initState() {
    checkConnectivity();
    getConnectivity();

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  checkConnectivity() async =>
      InternetConnectionChecker().hasConnection.then((value) {
        if (!value) {
          print('rani hna');
          child = noConnectionWidget();
        } else {
          child = widget.child;
        }
        setState(() {});
      });

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected) {
          print('rani hna');
          child = noConnectionWidget();
        } else {
          child = widget.child;
        }
        setState(() {});
      });

  @override
  Widget build(BuildContext context) {
    return child ?? LoaderStyleWidget();
  }

  Widget noConnectionWidget() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.BLUE_COLOR,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: AppColors.BLUE_COLOR,
            ),
            const SizedBox(height: 10),
            Text(
              'Pas de connexion Internet'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.BLUE_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
