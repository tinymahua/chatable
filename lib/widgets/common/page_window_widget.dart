import 'package:chatable/events/events.dart';
import 'package:chatable/events/ui_events.dart';
import 'package:chatable/theme.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:window_manager/window_manager.dart';

@immutable
class PageWindowWidget extends StatefulWidget {
  const PageWindowWidget({
    super.key,
    required this.isHome,
    this.toolsSize = 48.0,
    this.statusSize = 24.0,
    this.sideSize = 200.0,
    this.sideSizeMin = 40.0,
    this.sideSizeMax = 400.0,
    this.extraSize = 300.0,
    this.extraSizeMin = 30.0,
    this.extraSizeMax = 400.0,
    this.toolbar,
    this.sidebar,
    this.statusBar,
    required this.content,
    this.extra,
  });

  final bool isHome;

  final double toolsSize;
  final double statusSize;
  final double sideSize;
  final double sideSizeMin;
  final double sideSizeMax;
  final double extraSize;
  final double extraSizeMin;
  final double extraSizeMax;

  final Widget? toolbar;
  final Widget? sidebar;
  final Widget? statusBar;
  final Widget content;
  final Widget? extra;

  @override
  State<PageWindowWidget> createState() => _PageWindowWidgetState();
}

class _PageWindowWidgetState extends State<PageWindowWidget> {
  bool _isMaximized = false;

  ThemeMode? themeMode;

  double _toolsSize = 48.0;
  double _statusSize = 24.0;
  double _sideSize = 200.0;
  double _sideSizeMin = 40.0;
  double _sideSizeMax = 400.0;
  double _extraSize = 300;
  double _extraSizeMin = 30;
  double _extraSizeMax = 400;

  final MultiSplitViewController _mainMultiSplitViewController =
      MultiSplitViewController();
  final MultiSplitViewController _middleMultiSplitViewController =
      MultiSplitViewController();

  bool _pushDividers = false;

  @override
  void initState() {
    super.initState();

    _toolsSize = widget.toolsSize;
    _statusSize = widget.statusSize;
    _sideSize = widget.sideSize;
    _sideSizeMin = widget.sideSizeMin;
    _sideSizeMax = widget.sideSizeMax;
    _extraSize = widget.extraSize;
    _extraSizeMax = widget.extraSizeMax;
    _extraSizeMin = widget.extraSizeMin;

    _middleMultiSplitViewController.areas = [
      Area(
        data: null,
        id: "side",
        size: _sideSize,
        min: _sideSizeMin,
        max: _sideSizeMax,
      ),
      Area(data: null, id: "content", flex: 1),
      Area(
        data: null,
        id: "extra",
        size: _extraSize,
        min: _extraSizeMin,
        max: _extraSizeMax,
      ),
    ];
    _mainMultiSplitViewController.areas = [
      Area(
        data: null,
        id: "tools",
        size: _toolsSize,
        min: _toolsSize,
        max: _toolsSize,
      ),
      Area(data: null, id: "middle", flex: 1),
      Area(
        data: null,
        id: "status",
        size: _statusSize,
        min: _statusSize,
        max: _statusSize,
      ),
    ];
    setupEvents();
  }

  setupEvents() {
    eventBus.on<InitThemeEvent>().listen((evt){
      setState(() {
        themeMode = evt.themeMode;
      });
    });
    print('Init theme: ${themeMode}');
  }

  maximizeWindow() {
    if (_isMaximized) {
      windowManager.restore();
      setState(() {
        _isMaximized = false;
      });
    } else {
      windowManager.maximize();
      setState(() {
        _isMaximized = true;
      });
    }
  }

  Widget buildWindowControls() {
    IconData switchThemeIcon;
    print('Theme mode: ${themeMode}');
    if (themeMode == ThemeMode.light) {
      switchThemeIcon = Icons.light_mode;
    } else if (themeMode == ThemeMode.dark) {
      switchThemeIcon = Icons.dark_mode;
    }else {
      switchThemeIcon = Icons.brightness_auto_outlined;
    }

    return Row(
      children: [
        if (widget.isHome)
          IconButton(
            alignment: Alignment.center,
            icon: Icon(
              switchThemeIcon,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color!,
            ),
            onPressed: () {
              ThemeMode switchToThemeMode;
              if (themeMode == ThemeMode.light) {
                switchToThemeMode = ThemeMode.dark;
              } else if (themeMode == ThemeMode.dark) {
                switchToThemeMode = ThemeMode.system;
              }else {
                switchToThemeMode = ThemeMode.light;
              }

              setState(() {
                themeMode = switchToThemeMode;
              });
                eventBus.fire(ThemeChangedEvent(switchToThemeMode));
            },
          ),
        if (widget.isHome) VerticalDivider(width: 1),
        if (widget.isHome)
          IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.horizontal_rule_rounded,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color!,
            ),
            onPressed: () {
              windowManager.minimize();
            },
          ),
        if (widget.isHome)
          IconButton(
            icon: Icon(
              _isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color!,
            ),
            onPressed: maximizeWindow,
          ),
        IconButton(
          icon: Icon(
            Icons.close,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color!,
          ),
          onPressed: () {
            if (widget.isHome) {
              windowManager.close();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget buildToolsArea() {
    return GestureDetector(
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [widget.toolbar ?? Container(), buildWindowControls()],
        ),
      ),
    );
  }

  Widget buildSideArea() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: widget.sidebar,
    );
  }

  Widget buildContentArea() {
    return Container(
      padding: EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).extension<ChatableColors>()!.borderColor,
            width: 1,
          ),
          right: BorderSide(
            color: Theme.of(context).extension<ChatableColors>()!.borderColor,
            width: 1,
          ),
        ),
      ),
      // child: const LlFsEntitiesListWidget(),
      child: widget.content,
    );
  }

  Widget buildExtraArea() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: widget.extra,
    );
  }

  Widget buildMiddleArea() {
    MultiSplitView middleMultiSplitView = MultiSplitView(
      controller: _middleMultiSplitViewController,
      pushDividers: _pushDividers,
      dividerBuilder: (
        axis,
        index,
        resizable,
        dragging,
        highlighted,
        themeData,
      ) {
        Widget d = Container(color: Theme.of(context).dividerTheme.color!);
        if (index == 0 && _sideSizeMax == 0) {
          d = Container();
        }
        if (index == 2 && _extraSizeMax == 0) {
          d = Container();
        }
        if (_sideSizeMax == 0 && _extraSizeMax == 0) {
          d = Container();
        }
        return d;
      },
      axis: Axis.horizontal,
      builder: (BuildContext context, Area area) {
        if (area.id == "side") {
          return buildSideArea();
        } else if (area.id == "content") {
          return buildContentArea();
        } else if (area.id == "extra") {
          return buildExtraArea();
        }
        return Container();
      },
    );

    return MultiSplitViewTheme(
      data: MultiSplitViewThemeData(
        dividerThickness: Theme.of(context).dividerTheme.thickness!,
      ),
      child: middleMultiSplitView,
    );
  }

  Widget buildStatusArea() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarTheme.color,
      ),
      child: widget.statusBar,
    );
  }

  Widget buildLayout() {
    MultiSplitView mainMultiSplitView = MultiSplitView(
      controller: _mainMultiSplitViewController,
      pushDividers: _pushDividers,
      dividerBuilder: (
        axis,
        index,
        resizable,
        dragging,
        highlighted,
        themeData,
      ) {
        return Container(
          color: Theme.of(context).extension<ChatableColors>()!.borderColor,
        );
      },
      axis: Axis.vertical,
      builder: (BuildContext context, Area area) {
        if (area.id == "tools") {
          return buildToolsArea();
        } else if (area.id == "middle") {
          return buildMiddleArea();
        } else if (area.id == "status") {
          return buildStatusArea();
        }
        return Container();
      },
    );

    return MultiSplitViewTheme(
      data: MultiSplitViewThemeData(dividerThickness: 1),
      child: mainMultiSplitView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: themeMode != null ? Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: buildLayout(),
      ): Container(),
    );
  }
}
