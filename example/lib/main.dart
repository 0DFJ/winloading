import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winloading/winloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ColoredBox(
            color: Colors.black38,
            child: const WinLoading(),
          ),
          const SizedBox.square(dimension: 10,),
          const ColoredBox(
            color: Colors.black38,
            child: WinLoading(cubic: const Cubic(.07, .59, .59, .8),),
          ),
          const SizedBox.square(dimension: 10,),
          const ColoredBox(
            color: Colors.black38,
            child: WinLoading(cubic: const Cubic(.17,.59,.59,.8),),
          ),
          const SizedBox.square(dimension: 10,),
          const ColoredBox(
            color: Colors.black38,
            child: WinLoading(cubic: const Cubic(.22,.42,.64,.79),),
          ),
          const SizedBox.square(dimension: 10,),
          const ColoredBox(
            color: Colors.black38,
            child: WinLoading(cubic: const Cubic(.22,.42,.44,.71),),
          ),
          const SizedBox.square(dimension: 10,),
          const ColoredBox(
            color: Colors.black38,
            child: WinLoading(cubic: const Cubic(.15,.6,.64,.79),),
          ),
          const SizedBox.square(dimension: 10,),
        ],
      ),
    );
  }
}
