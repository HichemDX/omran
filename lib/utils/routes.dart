import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/views/client_view/client_complete_profile/client_complete_profile.dart';
import 'package:bnaa/views/client_view/client_navigation_page/client_navigation_page.dart';
import 'package:bnaa/views/pages/auth/authScreen.dart';
import 'package:bnaa/views/pages/auth/confirmEmail.dart';
import 'package:bnaa/views/store_view/store_complete_profile/store_complete_profile.dart';
import 'package:bnaa/views/store_view/store_navigation_page/store_navigation_page.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages/connectivity_page/connectivity_page.dart';

final routes = {
  '/': (context) => ConnectivityPage(child: Router()),
};

class Router extends StatelessWidget {
  final authController = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthProvider>(
      builder: (auth) {
        switch (auth.status) {
          case Status.Unauthenticated:
            return AuthScreen();
          case Status.ConfirmEmail:
            return ConfirmEmail();
          case Status.StoreAuthenticated:
            return StoreNavigationPage();
          case Status.ClientAuthenticated:
            return ClientNavigationScreen();
          case Status.ClientNoProfileCompleted:
            return ClientCompleteProfile();
          case Status.StoreNoProfileCompleted:
            return StoreCompleteProfile();
          case Status.Uninitialized:
            return Scaffold(
              body: Center(child: LoaderStyleWidget()),
            );
          default:
            return Scaffold(
              body: Center(child: LoaderStyleWidget()),
            );
        }
      },
    );
  }
}
