import 'package:flutter/material.dart';
import 'package:my_auracode_app/core/model/user.dart';

class ContactTile extends StatelessWidget {
  final User user;
  final void Function() onPressed;

  const ContactTile({super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Colors.white,
        child: Text(
          user.name[0],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(user.name),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
