import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head projecti

  initNoti() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    // do your work.

   // await Navigator.push(
    //  context,
   //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
  //  );
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int i, String a, String c, String d) async {}

  testnoti() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'New Notification', 'Notification Plain Body', platformChannelSpecifics,
        payload: 'item x');
  }



  dailyNoti() async
  {
    var time = Time(10, 0, 0);
var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.showDailyAtTime(
    0,
    'show daily title',
    'Daily notification shown at approximately ${time.hour}:${time.minute}:${time.second}',
    time,
    platformChannelSpecifics);
  }

 weeklyNoti() async
 {
   var time = Time(10, 0, 0);
var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('show weekly channel id',
        'show weekly channel name', 'show weekly description');
var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    0,
    'show weekly title',
    'Weekly notification shown on Monday at approximately ${time.hour}:${time.minute}:${time.second}',
    Day.Monday,
    time,
    platformChannelSpecifics);
 }


 periodicNoti() async
 {
   var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeating channel id',
        'repeating channel name', 'repeating description');
var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
    'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
 }
  @override
  void initState() {
    initNoti();
    dailyNoti();
    weeklyNoti();
    periodicNoti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Local Notification'),
          ),
          body: Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Center(
                child: RaisedButton(
              onPressed: testnoti,
              child: Text('Show Notification',
                  style: TextStyle(color: Colors.white)),
              color: Colors.red,
            )),
          )),
    );
  }
}
