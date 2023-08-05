import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/locale_controller.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends StatefulWidget {
  static const routeName = 'languages_page';

  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  String? language;
  bool isLoading = false;

  LocaleController localeController = Get.find();

  save(String value) async {
    setState(() {
      language = value.substring(0, 2);
      isLoading = true;
    });
    localeController.setLocale(Locale(value));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(localeController.locale.toString());
    return Scaffold(
        appBar: AppBarWidget(title: 'language'.tr, icon: ''),
        body: SafeArea(
          child: GetBuilder<LocaleController>(builder: (context) {
            return ListView(children: [
              ListTile(
                onTap: () {
                  save('ar');
                  Get.updateLocale(const Locale('ar'));
                },
                title: const Text('العربية'),
                trailing: localeController.locale.toString().contains('ar')
                    ? _buildTrailing()
                    : const SizedBox(),
              ),
              ListTile(
                onTap: () {
                  save('fr');
                  Get.updateLocale(const Locale('fr'));

                },
                title: const Text('Francais'),
                trailing: localeController.locale.toString().contains('fr')
                    ? _buildTrailing()
                    : const SizedBox(),
              ),
            ]);
          }),
        ));
  }

  _buildTrailing() {
    return isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ))
        : const Icon(
            Icons.check,
            color: AppColors.BLUE_COLOR,
          );
  }
}
