import 'package:chatable/events/chat_session_events.dart';
import 'package:chatable/events/events.dart';
import 'package:chatable/generated/i10n/app_localizations.dart';
import 'package:chatable/models/chat_session_models.dart';
import 'package:chatable/src/rust/api/table_file.dart';
import 'package:chatable/widgets/common/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';


@immutable
class ChatMsgsHeaderWidget extends StatefulWidget {
  const ChatMsgsHeaderWidget({super.key, required this.sessionRecord});

  final ChatSessionItemRecord sessionRecord;

  @override
  State<ChatMsgsHeaderWidget> createState() => _ChatMsgsHeaderWidgetState();
}

class _ChatMsgsHeaderWidgetState extends State<ChatMsgsHeaderWidget> {
  TableFileMeta? meta;

  @override
  void initState() {
    super.initState();
    setupEvents();
  }

  setupEvents()async{
    var _meta = await metaTableFile(path: widget.sessionRecord.filePath);
    setState(() {
      meta = _meta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(child: Text("${widget.sessionRecord.filePath}", style: TextStyle(overflow: TextOverflow.ellipsis),)),
        ]),
        if (meta != null) Row(
          children: [
            Text("${AppLocalizations.of(context)!.tableFileMetaRowsCount}: ${meta!.rowsCount}"),
            SizedBox(width: 10,),
            Text("${AppLocalizations.of(context)!.tableFileMetaSize}: ${meta!.size}"),
            SizedBox(width: 10,),
            Expanded(child: Text("${AppLocalizations.of(context)!.tableFileMetaColumns}: ${meta!.titles.join(",")}", style: TextStyle(overflow: TextOverflow.ellipsis),),)
          ],
        )
      ],
    );
  }
}

/// Tabs

/// Summary Tab
class ChatMsgsSummaryWidget extends StatefulWidget {
  const ChatMsgsSummaryWidget({super.key});

  @override
  State<ChatMsgsSummaryWidget> createState() => _ChatMsgsSummaryWidgetState();
}

class _ChatMsgsSummaryWidgetState extends State<ChatMsgsSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Summary TODO'),);
  }
}


/// History Tab

class ChatMsgsHistoryWidget extends StatefulWidget {
  const ChatMsgsHistoryWidget({super.key});

  @override
  State<ChatMsgsHistoryWidget> createState() => _ChatMsgsHistoryWidgetState();
}

class _ChatMsgsHistoryWidgetState extends State<ChatMsgsHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('History TODO'),);
  }
}

@immutable
class ChatSessionDetailWidget extends StatefulWidget {
  const ChatSessionDetailWidget({super.key, required this.sessionRecord});

  final ChatSessionItemRecord sessionRecord;

  @override
  State<ChatSessionDetailWidget> createState() => _ChatSessionDetailWidgetState();
}

class _ChatSessionDetailWidgetState extends State<ChatSessionDetailWidget> with TickerProviderStateMixin {
  late TabController? tabController;
  List<Widget> tabViews = [];

  bool get isReady {
    return tabController != null;
  }

  @override
  void initState() {
    super.initState();
    setupEvents();
  }

  setupEvents()async{
    Future.delayed(Duration(milliseconds: 100), makeTabs());
  }

  makeTabs(){
    setState(() {
      tabViews = [
        KeepAliveWrapper(child: ChatMsgsSummaryWidget()),
        KeepAliveWrapper(child: ChatMsgsHistoryWidget()),
      ];
    });

    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isReady ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          child: ChatMsgsHeaderWidget(sessionRecord: widget.sessionRecord,),
        ),
        TabBar(tabs: [
          Tab(text: AppLocalizations.of(context)!.tableDetailSummary,),
          Tab(text: AppLocalizations.of(context)!.tableDetailOperations,),
        ], controller: tabController!,
        ),
        Expanded(child: TabBarView(
          controller: tabController,
          children: tabViews,
        )),
      ],
    ): Container(child: Text('loading TODO'),);
  }
}


class ChatMsgsPagesWidget extends StatefulWidget {
  const ChatMsgsPagesWidget({super.key});

  @override
  State<ChatMsgsPagesWidget> createState() => _ChatMsgsPagesWidgetState();
}

class _ChatMsgsPagesWidgetState extends State<ChatMsgsPagesWidget> {
  List<Widget> pageItems = [];
  Map<String, int> pageIndexes = {};
  PageController? pageController;

  bool get isReady {
    return pageController != null;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    pageItems.add(KeepAliveWrapper(
      keepAlive: true,
      child: Container(),
    ));
    setupEvents();
  }

  setupEvents()async{
    eventBus.on<ChatSessionSwitchedEvent>().listen((evt){
      var record = evt.record;
      var oldLen = pageItems.length;
      if (pageIndexes.keys.contains(record.filePath)){
        var atIndex = pageIndexes[record.filePath];
        pageController!.jumpToPage(atIndex!);
      }else{
        setState(() {
          pageItems.add(KeepAliveWrapper(
              keepAlive: true,
              child: ChatSessionDetailWidget(sessionRecord: record,),
            ));
        });
        pageIndexes[record.filePath] = oldLen;
        print("${pageIndexes}, ${pageItems}");
        pageController!.jumpToPage(oldLen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isReady ? PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      children: pageItems,
    ): Container(child: Text('loading TODO'),);
  }
}
