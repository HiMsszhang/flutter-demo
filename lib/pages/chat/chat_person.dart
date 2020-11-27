import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_im_plugin/entity/find_message_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/image_type_enum.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/sound_message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:molan_edu/widgets/emoji_list.dart';

/// 临时目录
String _tempPath;

class ChatPersonPage extends StatefulWidget {
  final String id;
  final String name;
  final int courseId;
  const ChatPersonPage({
    Key key,
    this.id,
    this.name,
    this.courseId,
  }) : super(key: key);

  @override
  _ChatPersonPageState createState() => _ChatPersonPageState();
}

class _ChatPersonPageState extends State<ChatPersonPage> with UtilsMixin, WidgetsBindingObserver {
  String _message = '';

  /// 消息列表
  List<MessageEntity> _list = [];
  TextEditingController _inputController;
  int _userId;
  UserEntity _userInfo;

  /// 是否显示更多功能
  bool _isMore = false;

  ///是否录音
  bool _isRecord = false;

  ///是否显示表情
  bool _isEmoji = false;

  ///正在录音
  bool _recording = false;
  List<Map> _toolsList = [
    {'title': '照片', 'name': 'gallery', 'icon': MyIcons.Iconimage},
    {'title': '拍照', 'name': 'camera', 'icon': MyIcons.Iconcamera},
  ];

  FlutterAudioRecorder _recorderModule;
  bool _isFloatShow = true;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _inputController = TextEditingController();
    TencentImPlugin.addListener(_imListener);
    delayed(() async {
      await _setRead();
      _tempPath = (await getTemporaryDirectory()).path;
      await context.read<UserState>().getUser();
      _userId = context.read<UserState>().userInfo.id;
      await _getUser();
      await _getData();
    });
    _timer = Timer(Duration(seconds: 6), () {
      _isFloatShow = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    _inputController.clear();
    _inputController.dispose();
    TencentImPlugin.removeListener(_imListener);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
        } else {
          //显示键盘
          _isMore = false;
          _isEmoji = false;
        }
      });
    });
  }

  /// IM监听器
  _imListener(type, params) {
    if (type == TencentImListenerTypeEnum.NewMessage) {
      setState(() {
        _list.insert(0, params);
      });
    }

    if (type == TencentImListenerTypeEnum.MessageSendSucc) {
      print("===================");
      print("消息发送成功");
      print("===================");
    }

    if (type == TencentImListenerTypeEnum.MessageSendFail) {
      print("===================");
      print("消息发送失败");
      print("===================");
    }
  }

  _setRead() async {
    await TencentImPlugin.markC2CMessageAsRead(userID: widget.id);
  }

  _getUser() async {
    List<UserEntity> res = await TencentImPlugin.getUsersInfo(userIDList: ['${_userId}user']);
    _userInfo = res[0];
    setState(() {});
  }

  _getData() async {
    _list = await TencentImPlugin.getC2CHistoryMessageList(userID: widget.id, count: 50);
    if (_list.isNotEmpty) {
      print(_list[0].toJson());
      // 下载语音
      for (var item in _list) {
        if (item.elemType == MessageElemTypeEnum.Sound) {
          File file = new File(_tempPath + "/" + (item.node as SoundMessageNode).uuid);
          if (!file.existsSync()) {
            TencentImPlugin.downloadSound(message: FindMessageEntity(msgId: item.msgID), path: file.path).then((value) {
              setState(() {});
            });
          }
        }
      }
    }
    setState(() {});
  }

  _onInput(String value) {
    setState(() {
      _message = value;
    });
  }

  _send() async {
    await _sendMessage(TextMessageNode(content: _message));
    if (widget.id.contains("teacher")) {
      await CommonAPI.saveMessage(
        teacherId: int.parse(widget.id.replaceAll("teacher", "")),
        courseId: widget.courseId,
        content: _message,
      );
    }
    _message = '';
    _inputController.clear();
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  _sendMessage(MessageNode node) async {
    String msgId = await TencentImPlugin.sendMessage(
      node: node,
      receiver: widget.id,
    );
    _list.insert(
      0,
      MessageEntity(
        msgID: msgId,
        node: node,
        elemType: node.nodeType,
        self: true,
        faceUrl: _userInfo.faceUrl,
      ),
    );
    setState(() {});
  }

  _onToolSelect(int index) {
    var name = _toolsList[index]['name'];
    switch (name) {
      case 'gallery':
        _onImageSelect(0);
        break;
      case 'camera':
        _onImageSelect(1);
        break;
      default:
    }
  }

  /// 图片选择按钮
  _onImageSelect(int value) async {
    // 图片
    if (value == 0) {
      final pickedFile = await ImagePickers.pickerPaths(galleryMode: GalleryMode.image, selectCount: 1, compressSize: 1500, cropConfig: CropConfig(enableCrop: true));
      if (pickedFile == null) return;
      _sendMessage(ImageMessageNode(path: pickedFile[0].path));
    }
    // 拍照
    if (value == 1) {
      final pickedFile = await ImagePickers.openCamera(cameraMimeType: CameraMimeType.photo, compressSize: 1500, cropConfig: CropConfig(enableCrop: true));
      if (pickedFile == null) return;
      _sendMessage(ImageMessageNode(path: pickedFile.path));
    }
  }

  _recordStart() async {
    try {
      await Permission.microphone.request();
      PermissionStatus status = await Permission.microphone.status;
      if (status != PermissionStatus.granted) {
        EasyLoading.showToast("未获取到麦克风权限");
        throw "未获取到麦克风权限";
      }
      print('===>  获取了权限');
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String path = '$_tempPath/$time${AudioFormat.AAC.index}';
      _recorderModule = FlutterAudioRecorder(path, audioFormat: AudioFormat.AAC);
      await _recorderModule.initialized;
      print('===>  准备开始录音$path');
      print('===>  开始录音');
      await _recorderModule.start();
      var recording = await _recorderModule.current(channel: 0);
      print(recording.status);
      print("path == $path");
    } catch (err) {
      setState(() {
        _recordEnd();
      });
    }
  }

  _recordEnd() async {
    try {
      var result = await _recorderModule.stop();
      _sendMessage(SoundMessageNode(path: result.path, duration: result.duration.inSeconds));
      print(">>>>>>>>>>>>>>${result.path}");
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.name ?? "",
      backgroundColor: Color(0xFFF1F1F1),
      body: Column(
        children: [
          _isFloatShow ? _widgetFloatInfo() : Container(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                var item = _list[index];
                return item.self ? _widgetRight(item) : _widgetLeft(item);
              },
            ),
          ),
          SafeArea(
            top: false,
            bottom: true,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: Styles.normalDecoration.copyWith(
                    color: Color(0xFFF9F9F9),
                    border: Border(top: BorderSide(width: 1, color: Color(0xFFEEEEEE))),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRecord = !_isRecord;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Image.asset('assets/images/chat/icon_${_isRecord ? "keyboard" : "voice"}.png', width: 56.w, height: 56.w),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(64.w),
                            border: Border.all(width: 1, color: Color(0xFFEEEEEE)),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: _isRecord
                              ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    _recording ? await _recordEnd() : await _recordStart();
                                    setState(() {
                                      _recording = !_recording;
                                    });
                                  },
                                  child: Center(child: Text(_recording ? '正在录音' : '点击开始录音', style: Styles.normalFont(fontSize: 30.sp))),
                                )
                              : TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                  ),
                                  onChanged: (value) {
                                    _onInput(value);
                                  },
                                  onSubmitted: (value) async {
                                    await _send();
                                  },
                                  controller: _inputController,
                                  textInputAction: TextInputAction.send,
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEmoji = !_isEmoji;
                            _isMore = false;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Image.asset('assets/images/chat/icon_${_isEmoji ? "keyboard" : "emoji"}.png', width: 56.w, height: 56.w),
                      ),
                      SizedBox(width: 20.w),
                      _message != ''
                          ? Container(
                              height: 56.w,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.w),
                                color: Theme.of(context).accentColor,
                              ),
                              child: InkWell(
                                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                // padding: EdgeInsets.zero,
                                onTap: () async {
                                  await _send();
                                },
                                child: Text(
                                  '发送',
                                  style: Styles.normalFont(color: Colors.white),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isMore = !_isMore;
                                  _isEmoji = false;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Image.asset('assets/images/chat/icon_${_isMore ? "keyboard" : "more"}.png', width: 56.w, height: 56.w),
                            ),
                    ],
                  ),
                ),
                Container(
                  width: 750.w,
                  height: _isMore ? 400.w : 0,
                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 40.w),
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 30.w,
                    children: List.generate(
                      _toolsList.length,
                      (index) => Container(
                        width: 170.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: Styles.normalDecoration.copyWith(
                                borderRadius: BorderRadius.circular(16.w),
                                color: Colors.white,
                              ),
                              child: RawMaterialButton(
                                padding: EdgeInsets.zero,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  _onToolSelect(index);
                                },
                                child: Icon(_toolsList[index]['icon'], size: 40.w, color: Theme.of(context).buttonColor),
                              ),
                            ),
                            SizedBox(height: 20.w),
                            Text(_toolsList[index]['title'], style: Styles.normalFont(fontSize: 24.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                EmojiList(
                  isEmoji: _isEmoji,
                  onTap: (value) {
                    setState(() {
                      _message = _message + value;
                      _inputController.text = _message;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _returnMessage(MessageEntity item) {
    switch (item.elemType) {
      case MessageElemTypeEnum.Text:
        return WidgetMessageTalk(item, isMe: item.self);
        break;
      case MessageElemTypeEnum.Sound:
        return WidgetMessageTalk(item, isMe: item.self);
        break;
      case MessageElemTypeEnum.Image:
        return _widgetMessagePic(item);
        break;
      default:
        return WidgetMessageTalk(item, isMe: item.self);
    }
  }

  Widget _widgetLeft(MessageEntity item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonAvatar(size: 72.w, showSex: false, avatar: item.faceUrl),
          SizedBox(width: 20.w),
          _returnMessage(item),
        ],
      ),
    );
  }

  Widget _widgetRight(MessageEntity item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _returnMessage(item),
          SizedBox(width: 20.w),
          CommonAvatar(size: 72.w, showSex: false, avatar: item?.faceUrl ?? ''),
        ],
      ),
    );
  }

  Widget _widgetMessagePic(MessageEntity item) {
    ImageMessageNode node = item.node;
    var path = (node.path == null || node.path == '') && node.imageData != null ? node.imageData[ImageTypeEnum.Thumb]?.url : node.path;
    return Container(
      constraints: BoxConstraints(
        maxHeight: 307.w,
        maxWidth: 250.w,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        onPressed: () {
          ///预览图片 Preview picture
          ImagePickers.previewImage(path);
        },
        child: (node.path == null || node.path == '') && node.imageData != null ? Image.network(path) : Image.file(File(path)),
      ),
    );
  }

  Widget _widgetFloatInfo() {
    return Container(
      width: 690.w,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.w),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/images/chat/icon_warn.png'),
                size: 20.w,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 10.w),
              Text('温馨提示', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
            ],
          ),
          SizedBox(height: 10.w),
          Text('15：00前老师在线实时回复。15：00后老师将次日回复', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.2)),
        ],
      ),
    );
  }
}

class WidgetMessageTalk extends StatefulWidget {
  final MessageEntity item;
  final bool isMe;
  const WidgetMessageTalk(
    this.item, {
    Key key,
    this.isMe = false,
  }) : super(key: key);

  @override
  _WidgetMessageTalkState createState() => _WidgetMessageTalkState();
}

class _WidgetMessageTalkState extends State<WidgetMessageTalk> {
  AudioPlayer _playerModule = AudioPlayer();
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    if (widget.item.elemType == MessageElemTypeEnum.Sound) {
      _playerModule.onPlayerCompletion.listen((event) {
        if (_playerModule.state == AudioPlayerState.COMPLETED) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMe = widget.isMe;
    var item = widget.item;
    return Stack(
      overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        isMe
            ? Positioned(
                top: 24.w,
                right: -8.w,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  ),
                ),
              )
            : Positioned(
                top: 24.w,
                left: -8.w,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  ),
                ),
              ),
        GestureDetector(
          onTap: () async {
            if (item.elemType == MessageElemTypeEnum.Sound) {
              try {
                if (_isPlaying) {
                  _isPlaying = false;
                  _playerModule.stop();
                } else {
                  _isPlaying = true;
                  var node = item.node as SoundMessageNode;
                  String path = node.path == null || node.path == '' ? (_tempPath + "/" + node.uuid) : node.path;
                  int result = await _playerModule.play(path, isLocal: true);
                  print(result);
                }
                setState(() {});
              } catch (e) {
                print('error:$e');
              }
            }
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 506.w),
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 26.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: isMe ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
            ),
            child: Text(
              item.elemType == MessageElemTypeEnum.Sound ? '[${_isPlaying ? "正在播放" : "语音"}]' : (item.node as TextMessageNode).content,
              style: Styles.normalFont(fontSize: 28.sp, height: 1.5, color: isMe ? Colors.white : Styles.colorText),
              textAlign: isMe ? TextAlign.right : TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}
