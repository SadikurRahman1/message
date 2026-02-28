import '../../../../core/exported_files/exported_file.dart';
import '../../model/chat_models.dart';
import '../../service/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();

  final RxList<ChatModel> chatList = <ChatModel>[].obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxString currentChatId = ''.obs;

  final messageController = TextEditingController();
  final searchController = TextEditingController();

  final RxBool isLoadingMessages = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadChatsFromFirebase();
    _updateOnlineStatus(true);
  }

  @override
  void onClose() {
    messageController.dispose();
    searchController.dispose();
    _updateOnlineStatus(false);
    super.onClose();
  }

  /// Load chats from Firebase - Real-time stream
  void _loadChatsFromFirebase() {
    try {
      _chatService.getChatsStream().listen((chats) {
        chatList.assignAll(chats);
        DService().info('Chats loaded: ${chats.length}');
      }, onError: (error) {
        DService().error('Error loading chats: $error');
      });
    } catch (e) {
      DService().error('Error setting up chats listener: $e');
    }
  }

  /// Select a chat and load its messages
  void selectChat(String chatId) {
    currentChatId.value = chatId;
    _loadMessagesFromFirebase(chatId);
    _markMessagesAsRead(chatId);
  }

  /// Load messages from Firebase - Real-time stream
  void _loadMessagesFromFirebase(String chatId) {
    try {
      isLoadingMessages.value = true;
      _chatService.getMessagesStream(chatId).listen((msgs) {
        messages.assignAll(msgs.reversed.toList());
        isLoadingMessages.value = false;
        DService().info('Messages loaded: ${msgs.length}');
      }, onError: (error) {
        DService().error('Error loading messages: $error');
        isLoadingMessages.value = false;
      });
    } catch (e) {
      DService().error('Error setting up messages listener: $e');
      isLoadingMessages.value = false;
    }
  }

  /// Send message
  void sendMessage(String text) {
    if (text.trim().isEmpty) {
      DService().warning('Cannot send empty message');
      return;
    }

    if (currentChatId.value.isEmpty) {
      DService().error('No chat selected');
      return;
    }

    _sendMessageToFirebase(text);
  }

  /// Send message to Firebase
  Future<void> _sendMessageToFirebase(String text) async {
    try {
      // Extract other user ID from chat ID
      final chatIdParts = currentChatId.value.split('_');
      if (chatIdParts.length != 2) {
        DService().error('Invalid chat ID format');
        return;
      }

      final otherUserId = chatIdParts[0];

      await _chatService.sendMessage(
        chatId: currentChatId.value,
        text: text,
        otherUserId: otherUserId,
      );

      messageController.clear();
      DService().info('Message sent');
    } catch (e) {
      DService().error('Error sending message: $e');
    }
  }

  /// Mark messages as read
  Future<void> _markMessagesAsRead(String chatId) async {
    try {
      await _chatService.markMessagesAsRead(chatId);
    } catch (e) {
      DService().error('Error marking messages as read: $e');
    }
  }

  /// Search chats
  void searchChats(String query) {
    searchQuery.value = query;
  }

  /// Get filtered chats
  List<ChatModel> getFilteredChats() {
    if (searchQuery.value.isEmpty) {
      return chatList;
    }
    return chatList
        .where((chat) =>
            chat.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  /// Update online status
  Future<void> _updateOnlineStatus(bool isOnline) async {
    try {
      await _chatService.updateUserOnlineStatus(isOnline);
    } catch (e) {
      DService().error('Error updating online status: $e');
    }
  }

  /// Set typing status
  Future<void> setTypingStatus(String otherUserId, bool typing) async {
    try {
      isTyping.value = typing;
      await _chatService.setTypingStatus(
        currentChatId.value,
        otherUserId,
        typing,
      );
    } catch (e) {
      DService().error('Error setting typing status: $e');
    }
  }

  /// Create or get chat with user
  Future<void> createOrGetChat(String userId, String userName) async {
    try {
      final chatId = await _chatService.createOrGetChat(userId, userName);
      currentChatId.value = chatId;
      _loadMessagesFromFirebase(chatId);
    } catch (e) {
      DService().error('Error creating chat: $e');
    }
  }
}
