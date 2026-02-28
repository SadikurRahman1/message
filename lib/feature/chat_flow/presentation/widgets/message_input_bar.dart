import '../../../../core/exported_files/exported_file.dart';
import '../controllers/chat_controller.dart';

class MessageInputBar extends StatelessWidget {
  final ChatController controller;

  const MessageInputBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Attachment Button
          IconButton(
            icon: Icon(Icons.attachment, color: AppColors.mainColor),
            onPressed: () {},
          ),

          // Text Input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                minLines: 1,
                maxLines: 4,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send Button
          Container(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                controller.sendMessage(controller.messageController.text);
              },
            ),
          ),

          // Emoji Button
          IconButton(
            icon: Icon(Icons.emoji_emotions, color: AppColors.mainColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

