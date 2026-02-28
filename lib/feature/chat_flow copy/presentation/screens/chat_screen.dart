import 'package:message/feature/chat_flow/model/chat_models.dart';
import 'package:message/feature/chat_flow/presentation/controllers/chat_controller.dart';
import 'package:message/feature/chat_flow/presentation/widgets/message_bubble.dart';
import 'package:message/feature/chat_flow/presentation/widgets/message_input_bar.dart';

import '../../../../core/exported_files/exported_file.dart';

class ChatScreen extends StatelessWidget {
  final ChatModel chat;

  const ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              text: chat.name,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ResponsiveText(
              text: chat.isOnline ? 'Online' : 'Offline',
              fontSize: 12,
              color: Colors.white70,
            ),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[controller.messages.length - 1 - index];
                  final isCurrentUser = message.senderId == 'current_user';

                  return MessageBubble(
                    message: message,
                    isCurrentUser: isCurrentUser,
                  );
                },
              ),
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: Colors.grey[200],
          ),

          // Message Input
          MessageInputBar(controller: controller),
          

        ],
      ),
    );
  }
}







