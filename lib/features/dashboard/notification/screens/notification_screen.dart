import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification-screen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(notificationBox);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        content: const Text(
                            "Are you sure you want to delete all the notifications?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              box.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Confirm"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      )),
                );
              },
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: box.length,
            itemBuilder: ((context, index) => ListTile(
                  title: Column(children: [
                    Text(
                      box.get(index).title,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(box.get(index).body),
                  ]),
                  trailing: Text(
                      box.get(index).time.toString().substring(
                          0, box.get(index).time.toString().length - 7),
                      style: const TextStyle(fontSize: 10)),
                )))
        // StreamBuilder<RemoteMessage>(
        //   stream: FirebaseMessaging.onMessage,
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       return const Center(
        //         child: Text('No notification available right now.'),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //           return const CustomLoader();
        //         case ConnectionState.active:
        //           return ListView.builder(
        //               itemCount: 1,
        //               itemBuilder: (context, index) {
        //                 return ListTile(
        //                   title: Column(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       Text(snapshot.data!.notification!.title!),
        //                       Text(snapshot.data!.notification!.body!),
        //                     ],
        //                   ),
        //                   trailing: Text(
        //                     snapshot.data!.sentTime.toString(),
        //                     style: const TextStyle(fontSize: 10),
        //                   ),
        //                 );
        //               });

        //         default:
        //           return const Center(
        //             child: Text("Something went wrong. Please try again later"),
        //           );
        //       }
        //     }
        //     return const SizedBox.shrink();
        //   },
        // ),
        );
  }
}
