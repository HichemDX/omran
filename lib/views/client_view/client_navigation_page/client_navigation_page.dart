import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/client_controllers/client_navigation_controller.dart';
import 'package:bnaa/main.dart';
import 'package:bnaa/services/notification_service.dart';
import 'package:bnaa/views/client_view/client_cart_page/chariotScreen.dart';
import 'package:bnaa/views/client_view/client_orders_page//client_orders_page.dart';
import 'package:bnaa/views/client_view/client_home_page/client_home_page.dart';
import 'package:bnaa/views/client_view/client_settings_drawer/client_settings_drawer.dart';
import 'package:bnaa/views/client_view/client_stores_page/client_stores_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ClientNavigationScreen extends StatefulWidget {
  @override
  State<ClientNavigationScreen> createState() => _ClientNavigationScreenState();
}

class _ClientNavigationScreenState extends State<ClientNavigationScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  static Future initNotificationService() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    await pushNotificationService.initialise();
  }

  @override
  void initState() {
    initNotificationService();
    super.initState();
  }

  final bool _hideNavBar = false;

  List<Widget> pages = [
    ClientHomePage(),
    ClientOrdersPage(),
    ChariotScreen(),
    ClientStoresPage(),
  ];

  final navigationController = Get.put(ClientNavigationController());
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? exitApp = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Row(
                children: [
                  Text(
                    "Really?",
                    style: TextStyle(
                        color: Color(0xFFF7941D), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Text(
                  "Are you sure you want to exit?",
                  style: TextStyle(color: Color(0xFF346780)),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "NO",
                    style: TextStyle(color: Color(0xFF346780)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Color(0xFFF7941D)),
                  ),
                ),
              ],
            );
          },
        );
        return exitApp ?? false;
      },
      child: Scaffold(
        key: MyApp.scaffoldKey,
        drawer: Drawer(
            child:
                ClientSettingsDrawer() // Populate the Drawer in the next step.
            ),
        body: GetBuilder<ClientNavigationController>(builder: (_) {
          return pages[navigationController.selectedIndex];
        }),
        bottomNavigationBar: GetBuilder<ClientNavigationController>(
          builder: (_) {
            return BottomNavigationBar(
              backgroundColor: Colors.white,
              unselectedItemColor: AppColors.INACTIVE_GREY_COLOR,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                color: Color(0xFFB3B3B3),
              ),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: navigationController.selectedIndex,
              onTap: navigationController.paginate,

              // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottom1.svg',
                    color: AppColors.INACTIVE_GREY_COLOR,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/bottom1.svg',
                    color: AppColors.ORANGE_COLOR,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottom2.svg',
                    color: AppColors.INACTIVE_GREY_COLOR,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/bottom2.svg',
                    color: AppColors.ORANGE_COLOR,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottom3.svg',
                    color: AppColors.INACTIVE_GREY_COLOR,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/bottom3.svg',
                    color: AppColors.ORANGE_COLOR,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottom4.svg',
                    color: AppColors.INACTIVE_GREY_COLOR,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/bottom4.svg',
                    color: AppColors.ORANGE_COLOR,
                  ),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
