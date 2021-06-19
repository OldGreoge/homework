
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework_call/ServiceLocator.dart';
import 'package:homework_call/TelAndSmsService.dart';

import 'package:easy_contact_picker/easy_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';

List<Contact> _list = new List();
final EasyContactPicker _contactPicker = new EasyContactPicker();


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
  String number="";
  String sms="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone And SMS'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            TextField(
              inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
              autofocus: true,
              onChanged: (v){
                number=v;
              },
              decoration: InputDecoration(
                hintText: "请输入手机号码",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              autofocus: true,
              onChanged: (v){
                sms=v;
              },
              decoration: InputDecoration(
                hintText: "请输入短信内容",
                prefixIcon: Icon(Icons.sms),
              ),
            ),
            SizedBox(height: 30,),
            RaisedButton(
                child: Text('打电话'),
                onPressed: ()=>_service.call(number)),
            SizedBox(height: 30,),
            RaisedButton(
                child: Text('发短信'),
                onPressed: () {
                  String uri="";
                  if (Platform.isAndroid) {
                    uri = '+86$number?body=$sms';
                  } else if (Platform.isIOS) {
                    uri = '$number&body=$sms';
                  }
                  _service.sendSms(uri);
                }),
          ],
        ),
      ),
    );
  }

/*  //获取通讯录好友
  _openAddressBook() async {
    // 申请权限
    Map<Permission, PermissionStatus> permissions =
    await [Permission.contacts].request();

    if (permissions[Permission.contacts] == PermissionStatus.granted) {
      return _getContactData();
    } else {
      return Fluttertoast.showToast(msg: "获取手机通讯录失败");
    }
  }

  _getContactData() async {
    List<Contact> list = await _contactPicker.selectContacts();
    setState(() {
      _list = list;
      print("--------${_list.length}");
    });
  }
  Widget _getContectItem(Contact contact) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(contact.fullName),
          Text(
            contact.phoneNumber,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          // Text(contact.firstLetter),
        ],
      ),
    );
  }*/
}


