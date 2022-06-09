/*
 * *
 *  * Created by wangjun on 3/7/22, 11:02 AM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/7/22, 11:02 AM
 *
 */

import 'package:chat_view_demo/util/color_util.dart';
import 'package:chat_view_demo/util/screen_ext.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

class ChatBottomWidget extends StatefulWidget {
  ValueChanged<String>? onSend;
  ValueChanged<bool>? hasFocus;

  ChatBottomWidget({this.onSend, this.hasFocus});

  @override
  State<StatefulWidget> createState() {
    return _ChatBottomWidgetState();
  }
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  late TextEditingController _messageController;

  final GlobalKey _key = GlobalKey();
  final _focusNode = FocusNode();
  bool emojiShowing = false;

  @override
  void initState() {
    _messageController = TextEditingController();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
        widget.hasFocus?.call(_focusNode.hasFocus);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 58.dp, right: 56.dp),
          child: Row(
            children: [
              Expanded(child: _buildMessageText()),
              SizedBox(
                width: 30.dp,
              ),
              _buildSendMessage(context)
            ],
          )),
      SizedBox(
        height: emojiShowing ? 73.dp : 147.dp,
      ),
    ]);
  }

  Widget _buildMessageText() {
    return Container(
      height: 107.dp,
      color: Colors.white,
      child: ExtendedTextField(
          key: _key,
          strutStyle: const StrutStyle(),
          controller: _messageController,
          maxLines: 5,
          minLines: 1,
          focusNode: _focusNode,
          style: TextStyle(
              fontSize: 44.dp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(53.dp),
                borderSide: BorderSide(width: 3.dp, color: colorFF666666)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(53.dp),
                borderSide: BorderSide(width: 3.dp, color: colorFF666666)),
            contentPadding: EdgeInsets.only(left: 40.dp, right: 10.dp),
            //textDirection: TextDirection.rtl,
          )),
    );
  }

  void insertText(String text) {
    final TextEditingValue value = _messageController.value;
    final int start = value.selection.baseOffset;
    int end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }
      _messageController.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
    } else {
      _messageController.value = TextEditingValue(
          text: text,
          selection:
              TextSelection.fromPosition(TextPosition(offset: text.length)));
    }
  }

  Widget _buildSendMessage(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onSend?.call(_messageController.text);
          _messageController.text = "";
        },
        child: Icon(
          Icons.send,
          size: 93.dp,
        ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
