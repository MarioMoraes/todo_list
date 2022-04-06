import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_todolist/app/core/auth/auth_provider.dart';
import 'package:flutter_todolist/app/core/ui/messages.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(50),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                  return authProvider.user?.photoURL ??
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png';
                }, builder: (_, value, __) {
                  return CircleAvatar(backgroundImage: NetworkImage(value));
                }),
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.displayName ?? 'Username';
                  },
                  builder: (_, value, __) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    elevation: 10,
                    backgroundColor: Colors.grey.shade300,
                    title: Text(
                      'Change Username',
                      style: context.textStyle.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    content: TextField(
                      onChanged: (value) {
                        nameVN.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: context.textStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red.shade400),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (nameVN.value.isEmpty) {
                            Messages.of(context).showError('Username Invalid!');
                          } else {
                            Loader.show(context);
                            await context
                                .read<UserRepository>()
                                .updateUserName(nameVN.value);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text('Change Username'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: const Text('Exit'),
          )
        ],
      ),
    );
  }
}
