import '../../../../core/exported_files/exported_file.dart';
import '../controllers/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
