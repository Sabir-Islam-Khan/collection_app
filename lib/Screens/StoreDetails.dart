import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/createTransactionCard.dart';
import '../widgets/transactionList.dart';

class StoreDetails extends StatefulWidget {
  final DocumentSnapshot doc;
  final db = Firestore.instance;
  StoreDetails(this.doc);

  @override
  State<StatefulWidget> createState() {
    return StoreDetailsState();
  }
}

class StoreDetailsState extends State<StoreDetails> {

  int givenAmmount;
  int takenAmount;

  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(240, 242, 240, 1),
            Color.fromRGBO(0, 12, 64, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, ),  
                child: Text(
              "${widget.doc.data['name']}",
              style: TextStyle(
                fontFamily: 'bebas', 
                fontSize: 50.0,
                color: Colors.deepOrangeAccent,
                ),
            ),
              ),
            ),
            CreateTransactionCard(widget.doc),
            TransactionList(widget.doc),
          ],
        ),
      ),
    );
  }
}
