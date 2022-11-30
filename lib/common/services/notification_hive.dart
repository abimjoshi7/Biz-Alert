import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'notification_hive.g.dart';

@HiveType(typeId: 5)
class NotificationHive with ChangeNotifier {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  DateTime time;

  NotificationHive({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  notifyListeners();
}
