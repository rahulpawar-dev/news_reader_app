import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers/user_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              _showEditProfileDialog(context, ref, user);
            },
          ),

          // ✅ Added the Bookmarks Button here!
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved Articles'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              context.push('/bookmarks'); // Navigate to Bookmarks screen
            },
          ),

          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              // 1. Close the drawer first to prevent UI blocking
              Navigator.pop(context);

              // 2. Clear session in Hive
              ref.read(userProvider.notifier).logout();

              // 3. Navigate back to Login Screen
              context.go('/login');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref, UserProfile user) {
    final nameController = TextEditingController(text: user.name);
    final imageController = TextEditingController(text: user.imageUrl);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Display Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'Profile Image URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).updateProfile(
                  nameController.text.trim(),
                  imageController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}