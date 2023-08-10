import 'package:get/get.dart';

class ClientNavigationController extends GetxController {

final RxBool isCartNotEmpty = false.obs;

  int selectedIndex = 0;

  paginate(pageIndex) {
      selectedIndex = pageIndex;
      update();
  }
  

}