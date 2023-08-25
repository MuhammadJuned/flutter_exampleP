import 'package:flutter/material.dart';
import 'package:flutter_creddeck/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  late Locale _locale = Locale("en", '');

  @override
  void initState() {
    getLocale();
    super.initState();
  }

  void getLocale() {
    setState(() async {
      var prefs = await SharedPreferences.getInstance();
      var lang = prefs.getString("Lang")!;
      _locale = Locale(lang,'');
    });
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hi', ''),
      ],
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var buttonStyddle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)))),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: null,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .please_select_your_preferred_language,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColorWhite, fontSize: 22),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                /*   return CustomAlertDialog(type: AlertDialogType.success,
                                title: "Beautiful Title",
                                content: "Information related to message subject",
                                label: "Done",
                                icon: Icon(Icons.check_circle,color: Colors.green));*/
                                return ChangeLanguage();
                              });
                          //ChangeLanguage();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.english_hindi,
                          style: TextStyle(color: textColorWhite, fontSize: 18),
                        ),
                        style: buttonStyle(),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: TextStyle(color: textColorWhite, fontSize: 18),
                        ),
                        style: buttonStyle(),
                      ),
                    ],
                  )),
            ),
            Positioned(
                bottom: 25,
                right: 0,
                left: 0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.login_with_merchant,
                        style: TextStyle(color: textColorWhite, fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 8, bottom: 8),
                        side: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
