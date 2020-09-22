import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Text(
                "Error. Did you add your GoogleService-Info.plist file?",
                textDirection: TextDirection.ltr);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
          return const Text("Loading", textDirection: TextDirection.ltr);
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('mycollection').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading. Do your Firestore rules still allow access?');

            return ListView.builder(
                itemExtent: 80,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => ListTile(
                        title: Row(
                      children: [
                        Expanded(
                          child: Text(
                              snapshot.data.documents[index].data().toString()),
                        )
                      ],
                    )));
          }),
    );
  }
}
