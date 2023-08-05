import 'package:bnaa/controllers/faq_controller.dart';
import 'package:bnaa/views/pages/faq_page/components/faq_item_widget.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/faq.dart';
import '../../widgets/appBar/appBar.dart';

class FaqPage extends StatelessWidget {
  final faqController = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(
        title: 'questions'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: FutureBuilder<List<Faq>>(
        future: faqController.getFaqs(),
        builder: (BuildContext context, AsyncSnapshot<List<Faq>> snapshot) {
          if (snapshot.hasData) {
            if (faqController.faqs.isEmpty) {

              return  Center(child: Text('no result found'.tr));
            }
            return ListView.builder(
              padding: EdgeInsets.only(top: 27.h),
              itemCount: faqController.faqs.length,
              itemBuilder: (context, index) {
                return FaqCard(
                  model: faqController.faqs[index],
                  index: index,
                );
              },
            );
          }
          return Center(child: LoaderStyleWidget());
        },
      ),
    );
  }
}
