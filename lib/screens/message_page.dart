import 'package:bookhive/helper/appcolors.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Map<String, String>> messages = [
    {"sender": "Company", "message": "Welcome to BookHive! \nSri Lanka's largest online bookstore."},
    {"sender": "Company", "message": "Do you need help with anything?\n Feel free to ask!"},
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({"sender": "User", "message": _controller.text});
        messages.add({"sender": "Company", "message": "Thank you for reaching out! \nWe will get back to you shortly."});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Row(
          children: [
            Text(
              "Chat with us",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message["sender"] == "Company" ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: message["sender"] == "Company" ? const EdgeInsets.only(left: 20) : null, // Add left padding for company messages
                      decoration: BoxDecoration(
                        color: message["sender"] == "Company" ? Colors.grey[300] : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message["message"]!,
                        style: TextStyle(
                          color: message["sender"] == "Company" ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
