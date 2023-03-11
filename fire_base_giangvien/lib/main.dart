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
  // const ADD({Key? key}) : super(key: key);
  final _id = TextEditingController();
  final _HoTen = TextEditingController();

  final _MaGiangVien = TextEditingController();

  final _SoDienThoai = TextEditingController();

  final _DiaChi = TextEditingController();
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
                    child: Text('Mã giảng viên:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _MaGiangVien,
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
                    child: Text('Họ tên:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _HoTen,
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
                    child: Text('Địa chỉ:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _DiaChi,
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
                    child: Text('SDT:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _SoDienThoai,
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
                      FirebaseFirestore.instance.collection('GiangVien');
                  await collection.add({
                    "MaGiangVien": _MaGiangVien.text,
                    "HoTen": _HoTen.text,
                    "DiaChi": _DiaChi.text,
                    "SoDienThoai": _SoDienThoai.text
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
                          FirebaseFirestore.instance.collection('GiangVien');
                      collection.doc(_id.text).update({
                        "MaGiangVien": _MaGiangVien.text,
                        "HoTen": _HoTen.text,
                        "DiaChi": _DiaChi.text,
                        "SoDienThoai": _SoDienThoai.text
                      });
                    },
                    child: Text('Sửa'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('GiangVien');
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
                          FirebaseFirestore.instance.collection('GiangVien');
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
