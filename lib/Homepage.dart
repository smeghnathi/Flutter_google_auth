import 'package:flutter/material.dart';
import 'package:flutter_car_app/main.dart';
import 'package:flutter_car_app/sign_in.dart';


class Homepage extends StatefulWidget {
  static String user;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  void signOut() {
    signOutGoogle();
    //Homepage.user = null;
    Navigator.pop(context);
  }

  authCheck() {
    if(Homepage.user == null){
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to home!'),
        ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Welcome, ${Homepage.user}'),
                ),
              SizedBox(height: 30.0),
              MaterialButton(
                child: Text('Sign out'),
                color: Colors.blueGrey,
                onPressed: signOut,
                textColor: Colors.red,
                highlightColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

}


