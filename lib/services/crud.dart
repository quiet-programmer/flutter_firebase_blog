import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    Firestore.instance.collection("blog").add(blogData).catchError((e) {
      print(e);
    });
  }

  getAllData() async {
    return await Firestore.instance.collection("blog").getDocuments();
  }
}
