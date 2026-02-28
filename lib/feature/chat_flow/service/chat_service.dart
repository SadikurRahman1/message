import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exported_files/exported_file.dart';
import '../model/chat_models.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _currentUserId => _auth.currentUser?.uid ?? '';

  /// Get all chats for current user - Real-time stream
  Stream<List<ChatModel>> getChatsStream() {
    try {
      return _firestore
          .collection('chats')
          .where('participants', arrayContains: _currentUserId)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ChatModel(
            id: doc.id,
            name: doc['otherUserName'] ?? 'Unknown',
            lastMessage: doc['lastMessage'] ?? '',
            timestamp: (doc['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
            avatar: doc['otherUserAvatar'] ?? '',
            isOnline: doc['otherUserOnline'] ?? false,
            unreadCount: doc['unreadCount'] ?? 0,
          );
        }).toList();
      });
    } catch (e) {
      DService().error('Error fetching chats stream: $e');
      return Stream.value([]);
    }
  }

  /// Get messages for a specific chat - Real-time stream
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    try {
      return _firestore
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .orderBy('timestamp', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return MessageModel(
            id: doc.id,
            senderId: doc['senderId'] ?? '',
            text: doc['text'] ?? '',
            timestamp: (doc['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
            isRead: doc['isRead'] ?? false,
          );
        }).toList();
      });
    } catch (e) {
      DService().error('Error fetching messages stream: $e');
      return Stream.value([]);
    }
  }

  /// Send a message
  Future<void> sendMessage({
    required String chatId,
    required String text,
    required String otherUserId,
  }) async {
    try {
      final now = DateTime.now();

      // Add message to messages collection
      await _firestore.collection('messages').add({
        'chatId': chatId,
        'senderId': _currentUserId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      // Update chat with last message
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': text,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastSenderId': _currentUserId,
      });

      DService().info('Message sent successfully');
    } catch (e) {
      DService().error('Error sending message: $e');
      rethrow;
    }
  }

  /// Create or get chat between two users
  Future<String> createOrGetChat(String otherUserId, String otherUserName) async {
    try {
      final currentUserId = _currentUserId;

      // Create a unique chat ID (sort user IDs to ensure consistency)
      final userIds = [currentUserId, otherUserId]..sort();
      final chatId = '${userIds[0]}_${userIds[1]}';

      final chatDoc = _firestore.collection('chats').doc(chatId);
      final docSnapshot = await chatDoc.get();

      if (!docSnapshot.exists) {
        // Create new chat
        await chatDoc.set({
          'participants': [currentUserId, otherUserId],
          'otherUserId': otherUserId,
          'otherUserName': otherUserName,
          'otherUserOnline': false,
          'otherUserAvatar': '',
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
          'lastSenderId': currentUserId,
          'unreadCount': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
        DService().info('New chat created');
      }

      return chatId;
    } catch (e) {
      DService().error('Error creating/getting chat: $e');
      rethrow;
    }
  }

  /// Search chats by user name
  Future<List<ChatModel>> searchChats(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final snapshot = await _firestore
          .collection('chats')
          .where('participants', arrayContains: _currentUserId)
          .get();

      return snapshot.docs
          .where((doc) => doc['otherUserName']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((doc) {
        return ChatModel(
          id: doc.id,
          name: doc['otherUserName'] ?? 'Unknown',
          lastMessage: doc['lastMessage'] ?? '',
          timestamp: (doc['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          avatar: doc['otherUserAvatar'] ?? '',
          isOnline: doc['otherUserOnline'] ?? false,
          unreadCount: doc['unreadCount'] ?? 0,
        );
      }).toList();
    } catch (e) {
      DService().error('Error searching chats: $e');
      rethrow;
    }
  }

  /// Mark messages as read
  Future<void> markMessagesAsRead(String chatId) async {
    try {
      final snapshot = await _firestore
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .where('senderId', isNotEqualTo: _currentUserId)
          .where('isRead', isEqualTo: false)
          .get();

      for (final doc in snapshot.docs) {
        await doc.reference.update({'isRead': true});
      }

      // Update unread count in chat
      await _firestore.collection('chats').doc(chatId).update({
        'unreadCount': 0,
      });

      DService().info('Messages marked as read');
    } catch (e) {
      DService().error('Error marking messages as read: $e');
    }
  }

  /// Delete a chat
  Future<void> deleteChat(String chatId) async {
    try {
      // Delete all messages in this chat
      final messagesSnapshot = await _firestore
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .get();

      for (final doc in messagesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete chat document
      await _firestore.collection('chats').doc(chatId).delete();

      DService().info('Chat deleted successfully');
    } catch (e) {
      DService().error('Error deleting chat: $e');
      rethrow;
    }
  }

  /// Update user online status
  Future<void> updateUserOnlineStatus(bool isOnline) async {
    try {
      await _firestore.collection('users').doc(_currentUserId).update({
        'isOnline': isOnline,
        'lastSeen': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      DService().error('Error updating online status: $e');
    }
  }

  /// Get current user info
  Future<Map<String, dynamic>?> getCurrentUserInfo() async {
    try {
      final doc = await _firestore.collection('users').doc(_currentUserId).get();
      return doc.data();
    } catch (e) {
      DService().error('Error getting user info: $e');
      return null;
    }
  }

  /// Listen to typing status
  Stream<bool> getTypingStatusStream(String chatId, String otherUserId) {
    try {
      return _firestore
          .collection('typing')
          .doc('$chatId:$otherUserId')
          .snapshots()
          .map((doc) => doc['isTyping'] ?? false);
    } catch (e) {
      DService().error('Error listening to typing status: $e');
      return Stream.value(false);
    }
  }

  /// Set typing status
  Future<void> setTypingStatus(String chatId, String otherUserId, bool isTyping) async {
    try {
      await _firestore
          .collection('typing')
          .doc('$chatId:$otherUserId')
          .set({
        'isTyping': isTyping,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      DService().error('Error setting typing status: $e');
    }
  }
}

