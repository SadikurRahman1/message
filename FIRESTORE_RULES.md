📋 FIRESTORE SECURITY RULES FOR MESSAGING APP

════════════════════════════════════════════════════════════════════════════════

Firestore Console এ এই rules paste করুন:

Location: Firebase Console → Firestore Database → Rules

════════════════════════════════════════════════════════════════════════════════

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection - Public read, authenticated write own
    match /users/{userId} {
      allow read: if request.auth != null;
      allow create: if request.auth.uid == userId;
      allow update, delete: if request.auth.uid == userId;
    }
    
    // Chats collection - Only participants can read/write
    match /chats/{chatId} {
      allow read: if request.auth.uid in resource.data.participants;
      allow create: if request.auth.uid in request.resource.data.participants;
      allow update: if request.auth.uid in resource.data.participants;
      allow delete: if request.auth.uid in resource.data.participants;
    }
    
    // Messages collection - Only chat participants can read/write
    match /messages/{messageId} {
      allow read: if request.auth.uid in get(/databases/$(database)/documents/chats/$(resource.data.chatId)).data.participants;
      allow create: if request.auth.uid == request.resource.data.senderId && 
                       request.auth.uid in get(/databases/$(database)/documents/chats/$(request.resource.data.chatId)).data.participants;
      allow update: if request.auth.uid == resource.data.senderId;
      allow delete: if request.auth.uid == resource.data.senderId;
    }
    
    // Typing status - Real-time updates
    match /typing/{typingId} {
      allow read, write: if request.auth != null;
    }
  }
}

════════════════════════════════════════════════════════════════════════════════

Collection Structure:

users/{userId}
  ├─ uid: string
  ├─ name: string
  ├─ email: string
  ├─ isOnline: boolean
  ├─ photoUrl: string
  ├─ bio: string
  ├─ createdAt: timestamp
  └─ lastSeen: timestamp

chats/{chatId}  (e.g., "user1_user2")
  ├─ participants: array [userId1, userId2]
  ├─ otherUserId: string
  ├─ otherUserName: string
  ├─ otherUserOnline: boolean
  ├─ otherUserAvatar: string
  ├─ lastMessage: string
  ├─ lastMessageTime: timestamp
  ├─ lastSenderId: string
  ├─ unreadCount: number
  └─ createdAt: timestamp

messages/{messageId}
  ├─ chatId: string
  ├─ senderId: string
  ├─ text: string
  ├─ timestamp: timestamp
  └─ isRead: boolean

typing/{chatId:userId}
  ├─ isTyping: boolean
  └─ timestamp: timestamp

════════════════════════════════════════════════════════════════════════════════

