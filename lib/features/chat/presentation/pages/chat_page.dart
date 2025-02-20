import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:my_auracode_app/core/cubit/app_user/app_user_cubit.dart';
import 'package:my_auracode_app/core/key/api_key.dart';
import 'package:my_auracode_app/core/model/user.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';
import 'package:my_auracode_app/features/chat/presentation/widgets/message_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_auracode_app/features/chat/presentation/widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: ApiKey.geminiApiKey,
  );

  void checkGrammer() async {
    final prompt =
        "'${messageController.text}' correct this grammer and return only the correct sentence or you can not correct then return the same sentence.";
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    messageController.text = response.text ?? "";
  }

  String getChatId() {
    final currentUser = context.read<AppUserCubit>().user!;
    final userIds = [currentUser.uid, widget.user.uid];
    userIds.sort();
    return userIds.join('_');
  }

  Future<void> submit() async {
    final message = messageController.text.trim();
    messageController.clear();
    if (message.isNotEmpty) {
      try {
        final chatId = getChatId();

        await _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .add({
          'senderId': context.read<AppUserCubit>().user!.uid,
          'message': message,
          "messageTime": DateTime.now(),
          'timestamp': FieldValue.serverTimestamp(),
        });
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .doc(getChatId())
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data?.docs ?? [];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageData =
                          messages[index].data() as Map<String, dynamic>;
                      final messageText = messageData['message'] ?? '';
                      final senderId = messageData['senderId'] ?? '';

                      return MessageTile(
                        message: messageText,
                        timestamp: messageData["messageTime"],
                        uid: senderId,
                        user: context.read<AppUserCubit>().user!,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MessageField(
                    textEditingController: messageController,
                    onPressed: checkGrammer,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: submit,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
