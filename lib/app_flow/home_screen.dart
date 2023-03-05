import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.file(
                    File(image!.path),
                    height: 200,
                  )
                : const SizedBox(),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("Send Image"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                final storageRef = storage.ref();
                final mountainsRef = storageRef.child("images/first.png");
                String data = await mountainsRef.getDownloadURL();
                debugPrint("data ----------------------------->> $data");
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("Get Image"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("get Data"),
            ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  uploadImage() async {
    try {
      File file = File(image!.path);
      storage.ref().child("images/first.png").putFile(file);
      // final storageRef = storage.ref();
      // final mountainsRef = storageRef.child("first.png");
      // await mountainsRef.putFile(file);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getData() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({
          'full_name': "Nikunj Katrodiya", // John Doe
          'company': "Valam", // Stokes and Sons
          'age': 24 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
