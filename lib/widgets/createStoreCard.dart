import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nice_button/nice_button.dart';

class CreateStoreCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return CreateStoreCardState();
      }
    
    
    }
    
    class CreateStoreCardState extends State<CreateStoreCard> {
  @override
  Widget build(BuildContext context) {

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final numberController = TextEditingController();

  String nameId;

  final db = Firestore.instance;

  double media = MediaQuery.of(context).size.width;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

   void createData() async {
    DocumentReference nameRef = await db.collection('CRUD').add({
      'name': '${nameController.value.text}',
      'number': '${numberController.value.text}',
      'address': '${addressController.value.text}',
      'given': null,
      'payment': null,
    });

    setState(() {
      nameId = nameRef.documentID;
    });
  }
    
    return Container(
              color: Colors.white,
              height: 280.0,
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
                          labelText: "Store Name",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        controller: nameController,
                      ),
                      TextField(

                        style: TextStyle(
                          color: Colors.yellowAccent,
                        ),
                        decoration: InputDecoration(
                          labelText: "Address",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        controller: addressController,
                      ),
                      TextField(

                        style: TextStyle(
                          color: Colors.yellowAccent,
                        ),
                        decoration: InputDecoration(
                          labelText: "Mobile number",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                      ),
                      Container(
                        width: double.infinity,
                        child: Center(

                          child: NiceButton(

                            onPressed: (){
                              
                              createData();
                              nameController.clear();
                              numberController.clear();
                              addressController.clear();
                            },
                            text: "Create Store" ,
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
  
}