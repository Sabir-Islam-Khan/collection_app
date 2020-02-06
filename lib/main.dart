import 'dart:ui';
import "package:flutter/material.dart";


import './widgets/createStoreCard.dart';
import './widgets/StoreList.dart';

main() {
  runApp(CollectionApp());
}

class CollectionApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionAppState();
  }
}

class CollectionAppState extends State<CollectionApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(15, 26, 64,1),
        appBar: AppBar(
          title: Text("Collection App"),
          backgroundColor: Color.fromRGBO(58, 66, 86, .8),
        ),
        body: ListView(
          children: <Widget>[
            
            CreateStoreCard(),
            StoreList(),
          ],
        ),
      ),
    );
  }

  


}
