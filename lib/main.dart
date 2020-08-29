import 'package:flutter/material.dart';
import 'package:tyba_front/src/pages/home_page.dart';
import 'package:tyba_front/src/pages/registro_page.dart';
import 'package:tyba_front/src/pages/resultados_page.dart';
import 'package:tyba_front/src/pages/user_history_page.dart';
import 'package:tyba_front/src/pages/user_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      //initialRoute: 'home',
      home: HomePage(),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'registro': (BuildContext context) => RegistroPage(),
        'user': (BuildContext context) => UserHomePage(),
        'history': (BuildContext context) => HistoryPage(),
        'resultados': (BuildContext context) => ResultadosPage(),
      },
      onGenerateRoute: (settings) {
        print("No route asigned, going to alertPage");

        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      },
    );
  }
}
