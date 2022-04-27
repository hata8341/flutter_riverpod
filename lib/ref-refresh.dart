import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final githubUserProvider = FutureProvider<Map<String, Object?>>((ref) async {
  final response = await http.get(Uri.https(
    'api.github.com',
    'users/$username',
  ));

  return json.decode(response.body);
});

class RefreshWidget extends ConsumerWidget {
  const RefreshWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(githubUserProvider).when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error, $stack'),
        data: (user) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(_githubUserProvider),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                ListTile(
                  title: Text('login'),
                  subtitle: Text('${user['login'] ?? 'none'}'),
                ),
                ListTile(
                  title: Text('id'),
                  subtitle: Text('${user['id'] ?? 'none'}'),
                ),
                ListTile(
                  title: Text('html_url'),
                  subtitle: Text('${user['html_url'] ?? 'none'}'),
                ),
              ],
            ),
          );
        });
  }
}
