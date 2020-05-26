import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ncfr/Database.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ncfr/Profil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Column(
                      children: [
                        Text(
                          "NCFR",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontFamily: "Fredoka",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Nice Friday Points",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Fredoka",
                              color: Colors.white),
                        )
                      ],
                    ),
                    Shimmer(
                      period: Duration(seconds: 5),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [
                            0.45,
                            0.5,
                            0.55
                          ],
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0)
                          ]),
                      child: Column(
                        children: [
                          Text(
                            "NCFR",
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Fredoka",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Nice Friday Points",
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                        left: 60, right: 60, top: 30, bottom: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Masukkan email...",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          prefixStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: 200,
                    height: 43,
                    child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () async {
                          DocumentSnapshot snapshot =
                              await Database.checkData(_email);
                          try {
                            if (snapshot.data["Email"] ==
                                _email.toLowerCase()) {
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: "Selamat anda berhasil login",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.1),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profil(snapshot.data["Nama"],snapshot.data["Email"],snapshot.data["Alamat"],snapshot.data["Poin"])
                                        ));
                              });
                            }
                          } catch (e) {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: "Maaf email yang anda masukkan salah",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.1),
                                  textColor: Colors.red,
                                  fontSize: 16.0);
                            });
                          }
                        },
                        child: Text(
                          "Cek Poin",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Fredoka'),
                        )),
                  )
                ],
              ),
            )));
  }
}
