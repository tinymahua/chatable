import 'package:chatable/events/chat_session_events.dart';
import 'package:chatable/events/events.dart';
import 'package:chatable/models/chat_msg_models.dart';
import 'package:chatable/models/chat_session_models.dart';
import 'package:chatable/theme.dart';
import 'package:chatable/utils/db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path/path.dart' as p;

class ChatBoxWidget extends StatefulWidget {
  const ChatBoxWidget({super.key});

  @override
  State<ChatBoxWidget> createState() => _ChatBoxWidgetState();
}

class _ChatBoxWidgetState extends State<ChatBoxWidget> {
  ChatSessionsDb chatSessionsDb = Get.find<ChatSessionsDb>();
  TextEditingController msgInputController = TextEditingController();

  ChatMsgRecord msgRecord = ChatMsgRecord.getDefault();
  List<(ChatMsgPartialFile, ChatSessionCreateStatus)>
  chatMsgFilesCreateSessionStatusList = [];

  bool get canAddFile => msgRecord.files.isEmpty;

  Widget buildFileList(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: msgRecord.files.length,
            itemBuilder: (BuildContext context, int idx) {
              var file = msgRecord.files[idx];
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).extension<ChatableColors>()!.floatBgColor,
                        border: Border.all(
                          color:
                              Theme.of(
                                context,
                              ).extension<ChatableColors>()!.floatBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        file.name,
                        style: TextStyle(
                          color:
                              Theme.of(
                                context,
                              ).extension<ChatableColors>()!.floatTextColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        removeFileAtIndex(idx);
                      },
                      child: Icon(Icons.delete_forever_rounded, size: 16),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).extension<ChatableColors>()!.borderColor,
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          if (msgRecord.files.isNotEmpty)
            SizedBox(height: 25, child: buildFileList(context)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: msgInputController,
                  onChanged: (value) {
                    setState(() {
                      msgRecord.text.text = value;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed:
                    canAddFile
                        ? () {
                          selectTableFile();
                        }
                        : null,
                icon: Icon(Icons.add_circle_outline),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(CircleBorder()),
                ),
                onPressed:
                    msgRecord.isEmpty
                        ? null
                        : () {
                          print(msgRecord);
                          sendMsg();
                        },
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Icon(Icons.send_outlined),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  selectTableFile() async {
    var selectedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      allowedExtensions: tableFileTypes,
    );
    if (selectedFiles == null) {
      return;
    }
    if (selectedFiles.files.isEmpty) {
      return;
    }
    var selectedFile = selectedFiles.files.first;

    if (kDebugMode) {
      print('Selected: ${selectedFile}');
    }

    var filePath = selectedFile.path ?? '';
    if (filePath.isNotEmpty) {
      var name = p.basename(filePath);
      setState(() {
        msgRecord.files.add(ChatMsgPartialFile(name: name, path: filePath));
      });
    }
  }

  sendMsg() async {
    var filesAllSuccess = true;
    for (var file in msgRecord.files) {
      var (record, status) = await chatSessionsDb.createSession(
        ChatSessionItemRecord.fromFilePath(file.path),
      );
      if (status == ChatSessionCreateStatus.success) {
        eventBus.fire(ChatSessionCreatedEvent(record!));
      } else if (status == ChatSessionCreateStatus.exists) {
        filesAllSuccess = false;
        setState(() {
          chatMsgFilesCreateSessionStatusList.add((file, status));
        });
      }
    }
    if (filesAllSuccess) {
      // Clear Msg Box
      setState(() {
        msgRecord = ChatMsgRecord.getDefault();
        chatMsgFilesCreateSessionStatusList.clear();
      });
    } else {
      print("Show toast: ${chatMsgFilesCreateSessionStatusList}");
      showToastWidget(
        Container(
          color: Theme.of(context).extension<ChatableColors>()!.warningBlockBgColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(chatMsgFilesCreateSessionStatusList.length, (
              int idx,
            ) {
              var (fileItem, status) = chatMsgFilesCreateSessionStatusList[idx];
              var statusText = '';
              if (status == ChatSessionCreateStatus.exists) {
                statusText = '已存在';
              }
              return Text("${fileItem.name}: ${statusText}", style: TextStyle(color: Theme.of(context).extension<ChatableColors>()!.warningBlockTextColor),);
            }),
          ),
        ),
        position: ToastPosition.top,
        duration: Duration(seconds: 2),
      );
      setState(() {
        chatMsgFilesCreateSessionStatusList.clear();
      });
    }
  }

  removeFileAtIndex(int index) {
    setState(() {
      msgRecord.files.removeAt(index);
    });
  }
}
