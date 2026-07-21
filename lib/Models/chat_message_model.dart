class ChatMessage {
  final String messageText;
  final String senderId;
  final DateTime time;

  ChatMessage({required this.messageText, required this.senderId, required this.time});

  // Convert Server JSON data to local model
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageText: json['messageText'] ?? '',
      senderId: json['senderId'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
    );
  }

  // Convert local message data to JSON string format for server delivery
  Map<String, dynamic> toJson() {
    return {'messageText': messageText, 'senderId': senderId, 'time': time.toIso8601String()};
  }
}
