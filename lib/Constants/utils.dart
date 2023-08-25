import 'package:flutter/material.dart';
import 'package:flutter_creddeck/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/colors.dart';

ButtonStyle buttonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
    padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.only(left: 35, right: 35, top: 7, bottom: 7)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ),
  );
  ;
}

enum AlertDialogType {
  success,
  error,
  warning,
  info,
}

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final String label;
  final Widget? icon;

  CustomAlertDialog({
    super.key,
    required this.type,
    required this.title,
    required this.content,
    required this.label,
    required this.icon,
  });

  final TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dialogBackgroundWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              icon ?? getIconType(type),
              SizedBox(
                height: 10,
              ),
              Text(title, style: textStyle, textAlign: TextAlign.center),
              Divider(),
              Text(content, style: textStyle, textAlign: TextAlign.center),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(5),
                  ),
                  child: Text(label),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getIconType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.warning:
        return Icon(Icons.warning_amber_rounded,
            color: Colors.orange, size: 50);
      case AlertDialogType.info:
        return Icon(Icons.info_outline_rounded, color: Colors.blue, size: 50);
      case AlertDialogType.error:
        return Icon(Icons.error_outline, color: Colors.red, size: 50);
      case AlertDialogType.success:
        return Icon(Icons.check_circle_outline_rounded,
            color: Colors.green, size: 50);
    }
  }
}

class ChangeLanguage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangeLanguageDialogState();
}

class ChangeLanguageDialogState extends State<ChangeLanguage> {
  String? groupSelectedValue;

  final TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  @override
  void initState() {
    getValue();
    super.initState();
  }

  getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString("Lang")!;
    setState(() {
      groupSelectedValue = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dialogBackgroundWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.english, style: textStyle),
                    Radio(
                        value: "en",
                        groupValue: groupSelectedValue,
                        onChanged: groupChanges)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Divider(),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.hindi, style: textStyle),
                    Radio(
                        value: "hi",
                        groupValue: groupSelectedValue,
                        onChanged: groupChanges)
                  ],
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    MyApp.of(context)?.setLocale(
                        Locale.fromSubtags(languageCode: groupSelectedValue!));
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("Lang", groupSelectedValue!);
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBackgroundColor,
                    padding: EdgeInsets.only(top: 7,bottom: 7,left: 25,right: 25),
                  ),
                  child: Text("Okay"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void groupChanges(String? value) {
    setState(() {
      groupSelectedValue = value;
    });
  }
}
