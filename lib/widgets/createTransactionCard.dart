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
  int rslt = 0;
  @override
  Widget build(BuildContext context) {
    double media = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.greenAccent[700],
            height: 260.0,
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
                    TextField(
                      style: TextStyle(
                        color: Colors.yellowAccent,
                      ),
                      decoration: InputDecoration(
                        labelText: "Additional Note",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: NiceButton(
                          onPressed: () {
                            if (givenAmmountController.value.text != null &&
                                takenAmmountController.value.text != null) {
                              createData();
                            }
                            int purchase =
                                int.parse(givenAmmountController.value.text);
                            int payment =
                                int.parse(takenAmmountController.value.text);
                            int due = purchase - payment;
                            givenAmmountController.clear();
                            takenAmmountController.clear();
                            setState(() {
                              rslt = rslt + due;
                              print(rslt);
                            });
                            updateData(widget.doc, rslt);
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
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 20.0,
              child: Container(
                color: Colors.blueGrey,
                height: 50.0,
                width: media * 1,
                child: Center(
                  child: Text(
                'Due : $rslt ৳',
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontFamily: 'Yanone',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void createData() async {
    
    int purchase = int.parse(givenAmmountController.value.text);
    int payment = int.parse(takenAmmountController.value.text);
    int due = purchase - payment; 

    DocumentReference nameRef =
        await db.collection('${widget.doc.data['name']}').add({
      'purchase': '${givenAmmountController.value.text}',
      'payment': '${takenAmmountController.value.text}',
      'due': '$due',
    });

    setState(() {});
  }
  void updateData(DocumentSnapshot doc, int due) async {
    await db.collection('CRUD').document(doc.documentID).updateData(
      {'due': '$due'}
      );
  }
}
