import 'package:bookhive/models/notification_model.dart';

List<Notification> notifications = [
  Notification(
    notificationTitle: "New Book Released!",
    notificationMessage: "The Silent Whispers by John Doe is now available! Follow detective Emma Cole as she uncovers secrets in her childhood home.",
    time: "2h Ago",
    notificationTime: DateTime.now().subtract(Duration(hours: 2)), // 2 hours ago
  ),
  Notification(
    notificationTitle: "Limited Time Discount!",
    notificationMessage: "Get 20% off on all fiction books today only! Don't miss out on the offer.",
    time: "4h Ago",
    notificationTime: DateTime.now().subtract(Duration(hours: 4)), // 4 hours ago
  ),
  Notification(
    notificationTitle: "Book Club Meetup",
    notificationMessage: "Join our Book Club meetup this Saturday. Let’s discuss your favorite books!",
    time: "1d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 1)), // 1 day ago
  ),
  Notification(
    notificationTitle: "New Arrival: Thriller Genre!",
    notificationMessage: "Discover the newest releases in the thriller genre. The latest books are waiting for you.",
    time: "1d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 1)), // 1 day ago
  ),
  Notification(
    notificationTitle: "Membership Renewal",
    notificationMessage: "Your membership will expire in 3 days. Renew now to continue enjoying exclusive member benefits.",
    time: "2d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 2)), // 2 days ago
  ),
  Notification(
    notificationTitle: "Holiday Sale Begins!",
    notificationMessage: "Our biggest sale of the year starts tomorrow! Save up to 50% on selected titles.",
    time: "3d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 3)), // 3 days ago
  ),
  Notification(
    notificationTitle: "Book Signing Event",
    notificationMessage: "Join us for a live book signing event with author John Doe! Reserve your spot today.",
    time: "5d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 5)), // 5 days ago
  ),
  Notification(
    notificationTitle: "New Genre Added: Sci-Fi",
    notificationMessage: "Explore the new Sci-Fi section in our store! Dive into futuristic stories and space adventures.",
    time: "7d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 7)), // 1 week ago
  ),
  Notification(
    notificationTitle: "Weekend Reading Challenge",
    notificationMessage: "Participate in our Weekend Reading Challenge! Read a book this weekend and get a chance to win a prize.",
    time: "8d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 8)), // 8 days ago
  ),
  Notification(
    notificationTitle: "Author Interview: John Doe",
    notificationMessage: "Catch our exclusive interview with bestselling author John Doe, only at our bookstore.",
    time: "10d Ago",
    notificationTime: DateTime.now().subtract(Duration(days: 10)), // 10 days ago
  ),
];
