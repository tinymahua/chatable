import 'package:chatable/theme.dart';
import 'package:chatable/widgets/common/page_window_widget.dart';
import 'package:chatable/widgets/partials/chat_box_widget.dart';
import 'package:chatable/widgets/partials/chat_msgs_widget.dart';
import 'package:chatable/widgets/partials/chat_session_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildContent(BuildContext context){
    return Column(
      children: [
        Expanded(child: ChatMsgsPagesWidget()),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: ChatBoxWidget()),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSidebar(BuildContext context){
    return Column(
      children: [
        Expanded(child: ChatSessionListWidget()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).extension<ChatableColors>()!.windowBorderColor)),
      child: PageWindowWidget(
        isHome: true, content: buildContent(context), sidebar: buildSidebar(context), extra: null,),
    );
  }
}
