import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

class CreateTransactionCard extends StatefulWidget {
  final DocumentSnapshot doc;

  CreateTransactionCard(this.doc);

  @override
  State<StatefulWidget> createState() {
    return CreateTransactionCardState();
  }
}

class CreateTransactionCardState extends State<CreateTransactionCard> {
  final db = Firestore.instance;

  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  final givenAmmountController = TextEditingController();
  final takenAmmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double media = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.greenAccent[700],
      height: 225.0,
      width: media * 1,
      margin: EdgeInsets.only(
        top: 10.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Card(
        color: Color.fromRGBO(64, 75, 96, .9),
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                style: new TextStyle(
                  color: Colors.yellowAccent,
                ),
                decoration: InputDecoration(
                  labelText: "Product Ammount",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                controller: givenAmmountController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.yellowAccent,
                ),
                decoration: InputDecoration(
                  labelText: "Payment",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                controller: takenAmmountController,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Container(
                width: double.infinity,
                child: Center(
                  child: NiceButton(
                    onPressed: () {
                        updateGivenData(widget.doc);
                        updateTakenData(widget.doc);

                        givenAmmountController.clear();
                        takenAmmountController.clear();
                    },
                    text: "Make Transaction",
                    background: Colors.blue,
                    radius: 60,
                    gradientColors: [secondColor, firstColor],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void updateGivenData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).updateData(
      {'given': '${givenAmmountController.value.text}'},
      );
  }
    void updateTakenData(DocumentSnapshot doc) async {
    await db.collection('CRUD').document(doc.documentID).updateData(
      {'payment': '${takenAmmountController.value.text}'},
      );
  }
}
