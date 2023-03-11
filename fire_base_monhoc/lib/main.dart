import 'package:fire_base/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ADD(),
    );
  }
}

class ADD extends StatefulWidget {
  @override
  State<ADD> createState() => _ADDState();
}

class _ADDState extends State<ADD> {
  final _id = TextEditingController();
  final _maMonHoc = TextEditingController();

  final _tenMonHoc = TextEditingController();

  final _moTa = TextEditingController();

  var _output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 186, 248, 244),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('ID:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _id,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Mã môn học:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _maMonHoc,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Tên môn học:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _tenMonHoc,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Mô tả:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _moTa,
                      )),
                ],
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  CollectionReference collection =
                      FirebaseFirestore.instance.collection('MonHoc');
                  await collection.add({
                    "maMonHoc": _maMonHoc.text,
                    "tenMonHoc": _tenMonHoc.text,
                    "moTa": _moTa.text
                  });
                },
                child: Text('Tạo'),
              ),
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      collection.doc(_id.text).update({
                        "maMonHoc": _maMonHoc.text,
                        "tenMonHoc": _tenMonHoc.text,
                        "moTa": _moTa.text
                      });
                    },
                    child: Text('Sửa'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      collection.doc(_id.text).delete();
                    },
                    child: Text('Xóa'),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      QuerySnapshot querySnapshot = await collection.get();
                      List<DocumentSnapshot> documents = querySnapshot.docs;
                      setState(() {
                        for (var doc in documents) {
                          _output = _output + doc.data().toString();
                        }
                      });
                    },
                    child: Text('In ra'),
                  ),
                  Text(_output),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
