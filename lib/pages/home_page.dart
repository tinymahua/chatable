import 'package:chatable/widgets/common/page_window_widget.dart';
import 'package:chatable/widgets/partials/chat_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildContent(BuildContext context){
    return Column(
      children: [
        Expanded(child: Container()),
        SizedBox(
          height: 60,
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

  @override
  Widget build(BuildContext context) {
    return PageWindowWidget(
      isHome: true, content: buildContent(context), sidebar: null, extra: null,);
  }
}
