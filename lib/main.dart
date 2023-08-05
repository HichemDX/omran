
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/locale_controller.dart';
import 'package:bnaa/localization/locale_string.dart';
import 'package:bnaa/utils/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map user = {};

class Obj extends Equatable {
  int id;
  String name;

  Obj(this.id, this.name);

  @override
  List<Object?> get props => [id];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  try {
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
    final String? deviceId = await messaging.getToken();
    print("device id ::  $deviceId");
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('device_id', deviceId!);

    // messaging.subscribeToTopic('$deviceId');

    //await storage.clear();
  } catch (error) {
    print(error);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final localeController = Get.put(LocaleController());
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(394, 851),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          localizationsDelegates: const [DefaultWidgetsLocalizations.delegate],
          locale: localeController.locale,
          title: "Omran",
          translations: LocaleString(),
          theme: ThemeData(
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.BLUE_COLOR,
                //disabledBackgroundColor: AppColors.BLUE_LABEL_COLOR, // background// foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors.BLUE_COLOR,
              disabledColor: AppColors.BLUE_LABEL_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: routes,
        );
      },
    );
  }
}
