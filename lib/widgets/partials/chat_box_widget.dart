import 'package:chatable/theme.dart';
import 'package:flutter/material.dart';

class ChatBoxWidget extends StatefulWidget {
  const ChatBoxWidget({super.key});

  @override
  State<ChatBoxWidget> createState() => _ChatBoxWidgetState();
}

class _ChatBoxWidgetState extends State<ChatBoxWidget> {
  TextEditingController msgInputController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).extension<ChatableColors>()!.borderColor),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(
            decoration: InputDecoration(border: InputBorder.none),
            controller: msgInputController,)),
          ElevatedButton(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder())
            ),
            onPressed: () {
              print(msgInputController.text);
            },
            child:RotatedBox(quarterTurns: -1, child: Icon(Icons.send_outlined)),
          ),
        ],
      ),
    );
  }
}
