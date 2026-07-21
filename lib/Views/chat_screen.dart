import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_foodapp/Models/chat_message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SimpleChatScreen extends StatefulWidget {
  final String currentUserId;
  final String receiverName;
  final String orderId;

  const SimpleChatScreen({super.key, required this.currentUserId, required this.receiverName, required this.orderId});

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messagesList = [];
  late WebSocketChannel _socketChannel;

  @override
  void initState() {
    super.initState();
    // Connects seamlessly to your standard custom server gateway pipeline
    _socketChannel = WebSocketChannel.connect(Uri.parse('ws://://your-backend-server.com{widget.orderId}'));
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final newMsg = ChatMessage(messageText: _controller.text.trim(), senderId: widget.currentUserId, time: DateTime.now());

    // Send encoded string to backend server
    _socketChannel.sink.add(jsonEncode(newMsg.toJson()));

    setState(() {
      _messagesList.insert(0, newMsg); // Show locally instantly
    });
    _controller.clear();
  }

  @override
  void dispose() {
    _socketChannel.sink.close(); // Clean connection immediately on page exit
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeGreen = Color.fromRGBO(84, 163, 18, 1);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          widget.receiverName,
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // 1. Real-time Live Message stream engine
          Expanded(
            child: StreamBuilder(
              stream: _socketChannel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    Map<String, dynamic> rawJson = jsonDecode(snapshot.data.toString());
                    ChatMessage receivedMsg = ChatMessage.fromJson(rawJson);

                    // Prevent double adding own message echo events
                    if (receivedMsg.senderId != widget.currentUserId) {
                      _messagesList.insert(0, receivedMsg);
                    }
                  } catch (_) {}
                }

                if (_messagesList.isEmpty) {
                  return const Center(
                    child: Text("Say Hello to start conversation!", style: TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messagesList.length,
                  itemBuilder: (context, index) {
                    final currentMsg = _messagesList[index];
                    final bool isSentByMe = currentMsg.senderId == widget.currentUserId;

                    return Align(
                      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSentByMe ? themeGreen : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(14),
                            topRight: const Radius.circular(14),
                            bottomLeft: Radius.circular(isSentByMe ? 14 : 0),
                            bottomRight: Radius.circular(isSentByMe ? 0 : 14),
                          ),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))],
                        ),
                        child: Text(currentMsg.messageText, style: TextStyle(color: isSentByMe ? Colors.white : Colors.black87, fontSize: 14)),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // 2. Clean Modern Text Input Field Area
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      fillColor: const Color(0xFFF5F5F5),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: themeGreen,
                    child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
