import 'package:chatable/widgets/common/page_window_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWindowWidget(isHome: true, content: Text("Content"), sidebar: null, extra: null,);
  }
}
