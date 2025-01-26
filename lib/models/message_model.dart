import 'package:chat_app/constants.dart';

class MessageModel {
  final String text;
  final String id;

  MessageModel(this.text, this.id);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kMessage], jsonData[kId]);
  }
}
