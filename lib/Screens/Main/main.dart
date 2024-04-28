import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instantgram/Constants/Posts/user_post_view.dart';
import 'package:instantgram/Dialog/general_dialog.dart';
import 'package:instantgram/Dialog/log_out_dialog.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
            ),
            IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await LogOutDialog().present(context).then(
                      (
                        value,
                      ) =>
                          value ?? false,
                    );

                if (shouldLogOut) {
                  await ref
                      .read(
                        authStateProvider.notifier,
                      )
                      .logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostView(),
            UserPostView(),
            UserPostView(),
          ],
        ),
      ),
    );
  }
}
