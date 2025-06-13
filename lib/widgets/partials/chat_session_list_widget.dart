import 'package:chatable/events/chat_session_events.dart';
import 'package:chatable/events/events.dart';
import 'package:chatable/models/chat_session_models.dart';
import 'package:chatable/utils/db.dart';
import 'package:chatable/widgets/partials/chat_session_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSessionListWidget extends StatefulWidget {
  const ChatSessionListWidget({super.key});

  @override
  State<ChatSessionListWidget> createState() => _ChatSessionListWidgetState();
}

class _ChatSessionListWidgetState extends State<ChatSessionListWidget> {
  ChatSessionsDb chatSessionsDb = Get.find<ChatSessionsDb>();

  int hoveredIndex = -1;
  int selectedIndex = -1;
  List<ChatSessionItemRecord> sessionItemRecords = [];

  @override
  void initState() {
    super.initState();
    setupEvents();
  }

  setupEvents() async {
    var chatSessions = await chatSessionsDb.read<ChatSessions>();
    setState(() {
      sessionItemRecords = chatSessions.sessions;
    });

    eventBus.on<ChatSessionCreatedEvent>().listen((evt) {
      setState(() {
        sessionItemRecords.add(evt.record);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (BuildContext context, int index) {
      var itemRecord = sessionItemRecords[index];
      Color selectedColor = selectedIndex == index
          ? Colors.lightBlueAccent.withValues(alpha: 0.2) // grey.withValues(alpha: 0.2)
          : Colors.transparent;
      Color hoveredColor = hoveredIndex == index
          ? Colors.grey.withValues(alpha: 0.2)
          : Colors.transparent;
      return MouseRegion(
          onHover: (_) {
            setState(() {
              hoveredIndex = index;
            });
          },
          onExit: (_) {
            setState(() {
              hoveredIndex = -1;
            });
          },
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
                decoration: BoxDecoration(color: hoveredColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Container(
                    decoration: BoxDecoration(color: selectedColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ChatSessionItemWidget(record: itemRecord,))),
          ));
    }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 2,);
    }, itemCount: sessionItemRecords.length);
  }
}
