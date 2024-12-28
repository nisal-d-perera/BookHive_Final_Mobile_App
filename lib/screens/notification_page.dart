import 'package:bookhive/helper/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bookhive/data/notification_data.dart'; // Import the notification data file

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // Sort notifications from newest to oldest based on notificationTime
    notifications.sort((a, b) => b.notificationTime.compareTo(a.notificationTime));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Notifications',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search notifications",
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length, // Use the length of the notification list
              itemBuilder: (context, index) {
                final notification = notifications[index]; // Fetch notification data
                return Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Reply action clicked")),
                          );
                        },
                        icon: Icons.reply,
                        foregroundColor: Colors.white,
                        label: 'Reply',
                        backgroundColor: Colors.blue,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Mark as read action clicked")),
                          );
                        },
                        icon: Icons.mark_email_read,
                        foregroundColor: Colors.white,
                        label: 'Read',
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: .3,
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Delete action clicked")),
                          );
                        },
                        icon: Icons.delete,
                        foregroundColor: Colors.white,
                        label: 'Delete',
                        backgroundColor: Colors.red,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: const AssetImage("assets/images/Logo.png"),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.notificationTitle,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          notification.time,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      notification.notificationMessage,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
