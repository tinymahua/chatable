import 'package:chatable/models/chat_session_models.dart';

class ChatSessionCreatedEvent {
  final ChatSessionItemRecord record;
  ChatSessionCreatedEvent(this.record);
}

class ChatSessionSwitchedEvent {
  final ChatSessionItemRecord record;
  ChatSessionSwitchedEvent(this.record);
}