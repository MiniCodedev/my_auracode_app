import 'package:flutter/material.dart';
import 'package:my_auracode_app/core/model/user.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';
import 'package:my_auracode_app/features/chat/presentation/widgets/message_field.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              child: Text(
                widget.user.name[0],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              widget.user.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child:
                        MessageField(textEditingController: messageController)),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primaryColor),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.send_rounded,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
