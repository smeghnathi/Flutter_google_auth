import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_app/Homepage.dart';
import 'package:flutter_car_app/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void check() async{
    await Firebase.initializeApp();
    final User user = FirebaseAuth.instance.currentUser;
    if(user.displayName != null){
      print('------${user.displayName}-------');
      Homepage.user = user.displayName;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) { return Homepage();}
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20.0,),
            MaterialButton(
              onPressed: (){
                signInWithGoogle().then((result) {
                  if(result != null){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {return Homepage();}
                    ));
                  }
                });
              },
              color: Colors.amber,
              textColor: Colors.black,
              child: Text('Sign in with Google', style: TextStyle(

              ),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
