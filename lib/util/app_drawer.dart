import 'package:flutter/material.dart';
import 'package:todo/data/database.dart';

class AppDrawer extends StatelessWidget {
  final Tododatabase db;
  final String sortOrder;
  final Function(String) onSortChanged;
  final VoidCallback onClearCompleted;
  final VoidCallback onClearAll;

  const AppDrawer({
    super.key,
    required this.db,
    required this.sortOrder,
    required this.onSortChanged,
    required this.onClearCompleted,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.task_alt, size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    'TODO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Statistics Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistics',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildStatCard(
                    'Total Tasks',
                    db.getTotalTasks(),
                    Icons.list,
                    Colors.blue,
                  ),
                  _buildStatCard(
                    'Completed',
                    db.getCompletedTasks(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _buildStatCard(
                    'Pending',
                    db.getPendingTasks(),
                    Icons.pending,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            const Divider(),
            // Sort Options
            ListTile(
              leading: const Icon(Icons.sort, color: Colors.blue),
              title: const Text('Sort by Newest'),
              trailing: sortOrder == 'newest'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                onSortChanged('newest');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort, color: Colors.blue),
              title: const Text('Sort by Oldest'),
              trailing: sortOrder == 'oldest'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                onSortChanged('oldest');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            // Clear Completed Tasks
            ListTile(
              leading: const Icon(Icons.clear_all, color: Colors.red),
              title: const Text('Clear Completed Tasks'),
              onTap: () {
                onClearCompleted();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Completed tasks cleared!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Clear All Tasks'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm'),
                    content: const Text(
                      'Are you sure you want to delete all tasks?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          onClearAll();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All tasks cleared!')),
                          );
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            // About
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'TODO App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.task_alt,
                    size: 50,
                    color: Colors.blue,
                  ),
                  children: [
                    const Text(
                      'Hi, I’m Ayan Pal.\n'
                      'I’m a Flutter and full-stack developer passionate about building smooth, user-friendly applications.\n'
                      'I enjoy creating meaningful apps, exploring new technologies, and improving my skills through real-world projects.\n'
                      'Visit my portfolio at: https://www.ayanpal.tech',
                      textAlign: TextAlign.left,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
