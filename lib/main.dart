/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dolater/models/user_model.dart';
import 'package:dolater/utils/initial_screen_notifier.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dolater/utils/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//code to force screen in vertical mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_){
//code to hide the notification bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
//code to get the theme from the prefs
      SharedPreferences.getInstance().then((prefs) {
        int themeNumber = prefs.getInt('Theme') == null ? 1 : prefs.getInt(
            'Theme');
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(themeNumber),
            child: MyApp(),
          ),
        );
      });
    });
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return new GestureDetector(
//code to manually hide the notification bar when the screen is touched
      onTap: () => SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
      child: ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          title: 'Dolater',
          debugShowCheckedModeBanner: false,
          home: InitialScreen(),
          theme: themeNotifier.getTheme(),
        ),
      ),
    );
  }
}