import 'package:flutter/material.dart';
import 'package:homework_call/ServiceLocator.dart';
import 'package:homework_call/TelAndSmsService.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone and SMS',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: ViewPage(),
    );
  }
}

class ViewPage extends StatefulWidget {
  const ViewPage({Key key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool toggle = true;
  final TelAndSmsService _service=locator<TelAndSmsService>();
  final String number="123456789";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone And SMS'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text('打电话'),
                onPressed: ()=>_service.call(number)),
            RaisedButton(
                child: Text('打电话'),
                onPressed: ()=>_service.sendSms(number)),
          ],
        ),
      ),
    );
  }
}


