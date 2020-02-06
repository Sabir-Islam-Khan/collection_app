import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/StoreDetails.dart';

class StoreList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return StoreListState();
      }  
    }
    
    class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}

    class StoreListState extends State<StoreList> {

      

      final db = Firestore.instance;
      String nameId;

      double media;

  Container buildItem(DocumentSnapshot doc) {
    return Container(
      color: Colors.white,
      height: 165.0,
      width: media*1,
      margin: EdgeInsets.only(
        top: 10.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Card(
        elevation: 20.0,
        child: Container(
          color: Color.fromRGBO(40, 50, 65, .9),
          padding: EdgeInsets.only(
            left: 15.0,
            right: 0.0,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: GestureDetector(
                        onTap: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StoreDetails(doc,) ), 
                          );

                          print('${doc.documentID}');
                        },
                        child: Container(
                        width: 250.0,
                        height: 45.0, 
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "${doc.data['name']}",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: "Bebas",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "${doc.data['address']}",
                        style: TextStyle(
                          fontFamily: 'Yanone',
                          fontSize: 25.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellowAccent,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: GestureDetector(
                            onTap: () => launch("tel: ${doc.data['number']}"),
                            child: Image(
                              image: AssetImage('assets/call.png'),
                              height: 45.0,
                              width: 40.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "${doc.data['number']}",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onDoubleTap: () {
                      deleteData(doc);
                    },
                    child: Image(
                      image: AssetImage('assets/cross.png'),
                      height: 35.0,
                      width: 35.0,
                      color: Colors.red[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    media = MediaQuery.of(context).size.width; 

    final db = Firestore.instance;
    return StreamBuilder<QuerySnapshot>(
              stream: db.collection("CRUD").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents
                        .map((doc) => buildItem(doc))
                        .toList(),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
  }
  void deleteData(DocumentSnapshot doc) async {
    await db.collection("CRUD").document(doc.documentID).delete();
    setState(() {
      nameId = null;
    });
  }
}