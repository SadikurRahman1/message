import '../../../../../../../core/exported_files/exported_file.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
  }
}

