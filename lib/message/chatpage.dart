import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';

class UserChatPage extends StatefulWidget {
  final Map<String, String> user;

  const UserChatPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserChatPageState createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
final _textController = TextEditingController();
final _scrollController = ScrollController();
final _messages = <String>[];

void _sendMessage() {
  setState(() {
    _messages.add(_textController.text);
    _textController.clear();
  });
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.user["name"]!),
      backgroundColor: ClrConstant.primaryColor,
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ClrConstant.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _messages[index],
                        style: TextStyle(color: Colors.black), // Set message color to primary color
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  cursorColor: ClrConstant.primaryColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ClrConstant.primaryColor), // Border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ClrConstant.primaryColor), // Border color when focused
                    ),
                    hintText: 'Type a message',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // Hint text color with opacity
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ClrConstant.primaryColor, // Send button color
                ),
                child:  Text('Send',style: TextStyle(
                  color: ClrConstant.whiteColor
                ),),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}