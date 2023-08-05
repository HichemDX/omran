import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/main.dart';
import 'package:bnaa/views/store_view/commands/commands_screen.dart';
import 'package:bnaa/views/store_view/store_home_screen/store_home_screen.dart';
import 'package:bnaa/views/store_view/store_profile_screen/store_profile_screen.dart';
import 'package:bnaa/views/store_view/store_settings_drawer/store_settings_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class StoreNavigationPage extends StatefulWidget {
  @override
  State<StoreNavigationPage> createState() => _StoreNavigationPageState();
}

class _StoreNavigationPageState extends State<StoreNavigationPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final bool _hideNavBar = false;

  final List<Widget> _pages = [
    StoreHomeScreen(),
    CommandsScreen(),
    StoreProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/bottom1.svg',
          color: AppColors.ORANGE_COLOR,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/bottom1.svg',
          color: AppColors.INACTIVE_GREY_COLOR,
        ),
        activeColorPrimary: AppColors.ORANGE_COLOR,
        textStyle: TextStyle(fontSize: 10.sp),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.ORANGE_COLOR,
        textStyle: TextStyle(fontSize: 10.sp),
        icon: SvgPicture.asset(
          'assets/icons/bottom2.svg',
          color: AppColors.ORANGE_COLOR,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/bottom2.svg',
          color: AppColors.INACTIVE_GREY_COLOR,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: AppColors.ORANGE_COLOR,
        textStyle: TextStyle(fontSize: 10.sp),
        icon: SvgPicture.asset(
          'assets/icons/bottom4.svg',
          color: AppColors.ORANGE_COLOR,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/bottom4.svg',
          color: AppColors.INACTIVE_GREY_COLOR,
        ),
      ),
    ];
  }

  int selectedIndex = 0;

  paginate(pageIndex) {
    setState(() {
      selectedIndex = pageIndex;
    });
  }

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
              style: TextStyle(color: Color(0xFFF7941D), fontWeight: FontWeight.bold),
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
          child: StoreSettingsDrawer(),
        ),
        body: _pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: selectedIndex,
          onTap: paginate,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottom1.svg', color: AppColors.INACTIVE_GREY_COLOR),
              activeIcon: SvgPicture.asset('assets/icons/bottom1.svg', color: AppColors.ORANGE_COLOR),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottom2.svg', color: AppColors.INACTIVE_GREY_COLOR),
              activeIcon: SvgPicture.asset('assets/icons/bottom2.svg', color: AppColors.ORANGE_COLOR),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/bottom4.svg', color: AppColors.INACTIVE_GREY_COLOR),
              activeIcon: SvgPicture.asset('assets/icons/bottom4.svg', color: AppColors.ORANGE_COLOR),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
