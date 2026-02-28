class ChatModel {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  final String avatar;
  final bool isOnline;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.avatar,
    required this.isOnline,
    required this.unreadCount,
  });
}

class MessageModel {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });
}

