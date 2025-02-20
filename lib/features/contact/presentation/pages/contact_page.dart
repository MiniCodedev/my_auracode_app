import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auracode_app/core/common/widgets/basic_field.dart';
import 'package:my_auracode_app/core/cubit/app_user/app_user_cubit.dart';
import 'package:my_auracode_app/core/model/user.dart';
import 'package:my_auracode_app/core/utils/loader.dart';
import 'package:my_auracode_app/features/chat/presentation/pages/chat_page.dart';
import 'package:my_auracode_app/features/contact/presentation/widgets/contact_tile.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            BasicField(
              textEditingController: searchController,
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No contacts"));
                  }

                  // Filter users based on search query
                  final filteredUsers = snapshot.data!.docs.where((doc) {
                    final user = User.fromMap(doc.data());
                    return user.name.toLowerCase().contains(searchQuery);
                  }).toList();

                  if (filteredUsers.isEmpty) {
                    return const Center(child: Text("No matching contacts"));
                  }

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final user = User.fromMap(filteredUsers[index].data());
                      if (user.uid != context.read<AppUserCubit>().user!.uid) {
                        return ContactTile(
                          user: user,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(user: user),
                            ));
                          },
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
