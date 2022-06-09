import 'package:chat_view_demo/model/chat_model.dart';
import 'package:chat_view_demo/util/keyboard_util.dart';
import 'package:chat_view_demo/util/page_util.dart';
import 'package:chat_view_demo/util/screen_ext.dart';
import 'package:chat_view_demo/util/time_util.dart';
import 'package:chat_view_demo/view/chat_bottom_widget.dart';
import 'package:chat_view_demo/view/title_bar/index.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatList = [];
  String from = "Jerry";
  String to = "Nancy";
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _refreshTop();
    // _delayAddFromData();
    _delayAddToData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(),
        titleWidget: TitleBarUtil.commonTitleBarNoMore(title: "Chat Demo"));
  }

  // void _delayAddFromData() {
  //   Future.delayed(Duration(seconds: 5), () {
  //     setState(() {
  //       _chatList.add(ChatModel(
  //           dateTime: DateTime.now(), from: from, content: "Good Time"));
  //     });
  //     _delayAddFromData();
  //   });
  // }

  void _delayAddToData() {
    Future.delayed(Duration(seconds: 10), () {
      _chatList.add(ChatModel(
          dateTime: DateTime.now(), from: to, content: " add to data Hello "));
      setState(() {});
      Future.delayed(Duration(milliseconds: 1000), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      _delayAddToData();
    });
  }

  Future<bool> _refreshTop() async {
    _chatList.insert(0,
        ChatModel(dateTime: DateTime.now(), from: from, content: "from top"));
    setState(() {});
    return true;
  }

  Widget _buildBody() {
    return InkWell(
        onTap: () {
          KeyboardUtil.hideKeyboard();
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: () {
                        return _refreshTop();
                      },
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          itemCount: _chatList.length,
                          itemBuilder: (context, index) {
                            return _buildItem(index);
                          }))),
              70.vGap,
              Container(
                  color: Colors.white,
                  child: ChatBottomWidget(
                    hasFocus: (value) {
                      print("ChatBottomWidget:$value");
                      if (value) {
                        // setState(() {});
                        Future.delayed(Duration(milliseconds: 1000), () {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        });
                      }
                    },
                    onSend: (message) {
                      // KeyboardUtil.hideKeyboard();
                      setState(() {
                        _chatList.add(ChatModel(
                            dateTime: DateTime.now(),
                            from: from,
                            content: message));

                        setState(() {});
                        Future.delayed(Duration(milliseconds: 1000), () {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        });
                      });
                    },
                  )),
            ],
          ),
        ));
  }

  Widget _buildItem(int index) {
    return Container(
      padding: EdgeInsets.all(20.dp),
      margin: EdgeInsets.all(20.dp),
      constraints: BoxConstraints(minHeight: 120.dp),
      decoration: BoxDecoration(
          color: _chatList[index].from == from ? Colors.grey : Colors.green,
          borderRadius: BorderRadius.circular(
            30.dp,
          )),
      child: Text(
          "${_chatList[index].content}: ${TimeUtil.yyyyMMddHHmmss.format(_chatList[index].dateTime)}"),
    );
  }
}
