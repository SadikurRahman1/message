import '../../../../core/exported_files/exported_file.dart';
import '../bindings/chat_binding.dart';
import '../controllers/chat_controller.dart';
import '../../model/chat_models.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          text: 'Messages',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) => controller.searchChats(value),
                decoration: InputDecoration(
                  hintText: 'Search chats...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: Obx(
              () {
                final filteredChats = controller.getFilteredChats();

                if (filteredChats.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: AppColors.mainColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        ResponsiveText(
                          text: controller.searchQuery.value.isEmpty
                              ? 'No chats yet'
                              : 'No results found',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];
                    return _ChatTile(chat: chat, controller: controller);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatModel chat;
  final ChatController controller;

  const _ChatTile({
    required this.chat,
    required this.controller,
  });

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          controller.selectChat(chat.id);
          // Get.toNamed(AppRoutes.chatScreen, arguments: chat);
          Get.to(
            () => ChatScreen(chat: chat),
            binding: ChatBinding(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar with Online Status
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainColor.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Text(
                          chat.name[0],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                    if (chat.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),

                // Chat Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        text: chat.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 4),
                      ResponsiveText(
                        text: chat.lastMessage,
                        fontSize: 13,
                        color: Colors.grey[600],
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                // Time and Unread Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ResponsiveText(
                      text: _formatTime(chat.timestamp),
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    if (chat.unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ResponsiveText(
                          text: '${chat.unreadCount}',
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}