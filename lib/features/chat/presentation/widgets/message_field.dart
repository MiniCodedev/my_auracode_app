import 'package:flutter/material.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';

class MessageField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function() onPressed;
  const MessageField(
      {super.key,
      required this.textEditingController,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor),
      child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: "Message",
            prefixIcon: Icon(Icons.message_rounded),
            suffixIcon: IconButton(
                onPressed: onPressed, icon: Icon(Icons.stars_rounded)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: Theme.of(context).cardColor, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 2)),
          )),
    );
  }
}
