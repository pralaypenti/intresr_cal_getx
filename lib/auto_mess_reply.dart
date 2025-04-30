import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';

class Message {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.text, required this.isUser, required this.timestamp})
    : id = DateTime.now().millisecondsSinceEpoch.toString();
}

class ChatController extends GetxController {
  final messages = <Message>[].obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();

  final List<String> autoReplies = [
    "Thank you for your message! Our team will get back to you shortly.",
    "We've received your inquiry. Please allow us 24-48 hours to respond.",
    "Thanks for reaching out! We're processing your request.",
    "Your message is important to us. We'll respond as soon as possible.",
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    textController.clear();

    messages.add(Message(text: text, isUser: true, timestamp: DateTime.now()));

    _scrollToBottom();

    Timer(const Duration(seconds: 1), () {
      final reply = autoReplies[Random().nextInt(autoReplies.length)];
      messages.add(
        Message(text: reply, isUser: false, timestamp: DateTime.now()),
      );
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: chatController.scrollController,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return _buildMessage(context, message);
                },
              ),
            ),
          ),
          _buildInputBar(chatController),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, Message message) {
    final isUser = message.isUser;
    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isUser ? Colors.purple[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  timeFormat.format(message.timestamp),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isUser ? Colors.purple[100] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(ChatController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: const Offset(0, -2), blurRadius: 4.0)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Colors.purple[900]!),
                  ),
                ),
                onSubmitted: controller.sendMessage,
              ),
            ),
            const SizedBox(width: 8.0),
            FloatingActionButton(
              onPressed: () {
                if (controller.textController.text.isNotEmpty) {
                  controller.sendMessage(controller.textController.text);
                }
              },
              backgroundColor: Colors.purple[900],
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
