import 'package:chatable/models/chat_session_models.dart';
import 'package:chatable/theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';


class ChatSessionItemWidget extends StatelessWidget {
  const ChatSessionItemWidget({super.key, required this.record});

  final ChatSessionItemRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      child: GFListTile(
        margin: EdgeInsets.only(left: 5),
        padding: EdgeInsets.only(top: 3, left: 0, bottom: 3),
          title: Text(record.name, style: TextStyle(fontSize: ChatableTextSize.huge,),),
          subTitle: Text(record.filePath, style: TextStyle(
            overflow: TextOverflow.ellipsis,
              fontSize: ChatableTextSize.medium, ),),
      ),
    );
  }
}
