import 'package:get/get.dart';

class ClientNavigationController extends GetxController {



  int selectedIndex = 0;

  paginate(pageIndex) {
      selectedIndex = pageIndex;
      update();
  }

}