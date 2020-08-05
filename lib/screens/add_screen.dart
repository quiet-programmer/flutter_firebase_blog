import 'dart:io';

import 'package:firebase_blog_app/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String authorName, title, desc;
  File selectedImage;
  final picker = ImagePicker();
  bool isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    setState(() {
      isLoading = true;
    });
    if (selectedImage != null) {
      //uploading to the firebase storage
      StorageReference firebaseStorageReg = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final StorageUploadTask task = firebaseStorageReg.putFile(selectedImage);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is the download url $downloadUrl");
      Navigator.of(context).pop();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase Blog"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {
              uploadBlog();
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () => getImage(),
                      child: selectedImage != null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: FileImage(selectedImage),
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Author Name",
                      ),
                      onChanged: (val) {
                        authorName = val;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Title",
                      ),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                      onChanged: (val) {
                        desc = val;
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
