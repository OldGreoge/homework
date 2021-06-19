import 'package:url_launcher/url_launcher.dart';

class TelAndSmsService{
  void call(String number)=>launch("tel:+86$number");
  void sendSms(String number)=>launch("sms:$number");
}