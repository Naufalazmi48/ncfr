import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ncfr/Database.dart';
import 'package:circle_wave_progress/circle_wave_progress.dart';

class Profil extends StatefulWidget {
  final String email;
  final String alamat;
  final String nama;
  final int poin;

  Profil(this.nama, this.email, this.alamat, this.poin);
  _ProfilState createState() =>
      _ProfilState(this.nama, this.email, this.alamat, this.poin);
}

class _ProfilState extends State<Profil> with TickerProviderStateMixin {
  String userName, userAddress, userEmail;
  int poin;
  _ProfilState(this.userName, this.userEmail, this.userAddress, this.poin);
  double percent = 0, sizewidth = 0, sizeheight = 0, opacity = 0;
  Duration animationDuration = Duration(seconds: 3);

  var defaultcolor = Colors.white;
  var textcolor = Colors.white;

  @override
  void initState() {
    super.initState();
    if (poin == 0) {
      percent = 0.0;
      defaultcolor = Colors.white;
    } else if (poin == 1) {
      percent = 20;
      defaultcolor = Colors.red;
    } else if (poin == 2) {
      percent = 40;
      defaultcolor = Colors.orange;
    } else if (poin == 3) {
      percent = 60;
      defaultcolor = Colors.yellow;
    } else if (poin == 4) {
      percent = 80;
      defaultcolor = Colors.green;
    } else if (poin == 5) {
      percent = 100;
      defaultcolor = Colors.green;
    } else {
      Database.resetPoin(userEmail);
      poin = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1), () {
      setState(() {
        sizewidth = 350;
        sizeheight = 150;
      });
    });
    return Scaffold(
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color(0xff000322)),
        child: Column(
          children: [
            Stack(children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 60),
                child: CircleWaveProgress(
                  size: 170,
                  borderWidth: 5.0,
                  backgroundColor: Colors.white10,
                  borderColor: Color(0xff16FCFF),
                  waveColor: defaultcolor,
                  progress: percent,
                ),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 110),
                  child: Text(
                    poin.toString() + "\npoint",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
            ]),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                AnimatedContainer(
                  onEnd: () {
                    setState(() {
                      opacity = 1;
                    });
                  },
                  duration: animationDuration,
                  width: sizewidth,
                  height: sizeheight,
                  decoration: new BoxDecoration(
                      border: Border.all(color: Color(0xff16FCFF), width: 2),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        text(
                            Icon(
                              Icons.people_outline,
                              color: Color(0xff16FCFF),
                            ),
                            userName),
                        SizedBox(
                          height: 10,
                        ),
                        text(
                            Icon(
                              Icons.explore,
                              color: Color(0xff16FCFF),
                            ),
                            userAddress),
                        SizedBox(
                          height: 10,
                        ),
                        text(
                            Icon(
                              Icons.email,
                              color: Color(0xff16FCFF),
                            ),
                            userEmail),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget text(Icon icon, String text) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: TextStyle(
              color: textcolor.withOpacity(opacity),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
