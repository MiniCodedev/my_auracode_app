import 'package:flutter/material.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';

class BasicField extends StatefulWidget {
  const BasicField({super.key});

  @override
  State<BasicField> createState() => _BasicFieldState();
}

class _BasicFieldState extends State<BasicField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor),
      child: TextField(
          decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search_rounded),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).cardColor, width: 2)),
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).cardColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
      )),
    );
  }
}
