import 'package:bitcoin_news/Screens/homeScreen.dart';
import 'package:bitcoin_news/Screens/splashScreen.dart';
import 'package:bitcoin_news/Services/news_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsRequest>(
      builder: (_) => NewsRequest(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bitcoin News',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Color(0XFF141E30),
        ),
        routes: {
          '/news': (context) => News(
                title: "Bitcoin News",
              ),
        },
        home:News(
          title: "Bitcoin News",
        ),
      ),
    );
  }
}

