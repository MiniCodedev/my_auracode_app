import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_auracode_app/core/model/user.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';

class MessageTile extends StatefulWidget {
  final String uid;
  final String message;
  final Timestamp timestamp;
  final User user;
  const MessageTile(
      {super.key,
      required this.message,
      required this.uid,
      required this.timestamp,
      required this.user});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        alignment: widget.user.uid == widget.uid
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Column(
          crossAxisAlignment: widget.user.uid == widget.uid
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                      topLeft: widget.user.uid != widget.uid
                          ? Radius.circular(0)
                          : Radius.circular(18),
                      topRight: widget.user.uid == widget.uid
                          ? Radius.circular(0)
                          : Radius.circular(18))),
              child: Text(
                widget.message,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                formatTimestamp(widget.timestamp),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
