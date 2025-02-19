import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_auracode_app/core/theme/app_colors.dart';
import 'package:my_auracode_app/core/theme/app_theme.dart';
import 'package:my_auracode_app/features/contact/presentation/pages/contact_page.dart';
import 'package:my_auracode_app/features/home/presentation/pages/home_page.dart';
import 'package:my_auracode_app/features/settings/presentation/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  final pages = [HomePage(), ContactPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.themeBoxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[selectedPage],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      selectedPage = 0;
                    });
                  },
                  icon: Icon(
                    Icons.home_rounded,
                    color: selectedPage == 0 ? AppColors.primaryColor : null,
                  )),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 1;
                  });
                },
                icon: Icon(
                  Icons.person_pin_rounded,
                  color: selectedPage == 1 ? AppColors.primaryColor : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPage = 2;
                  });
                },
                icon: Icon(
                  Icons.settings_rounded,
                  color: selectedPage == 2 ? AppColors.primaryColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
