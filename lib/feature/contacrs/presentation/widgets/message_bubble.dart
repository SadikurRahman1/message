import '../../../../core/exported_files/exported_file.dart';
import '../../model/chat_models.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isCurrentUser;

  const MessageBubble({
    required this.message,
    required this.isCurrentUser,
  });

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor.withValues(alpha: 0.2),
              ),
              child: Center(
                child: ResponsiveText(
                  text: 'R',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? AppColors.mainColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ResponsiveText(
                    text: message.text,
                    fontSize: 14,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                ResponsiveText(
                  text: _formatTime(message.timestamp),
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isCurrentUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor.withValues(alpha: 0.2),
              ),
              child: Center(
                child: ResponsiveText(
                  text: 'Y',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

