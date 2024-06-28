import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addNews(Map<String,dynamic> NewsInfo,String id) async{
      return await FirebaseFirestore.instance
  .collection("News")
  .doc(id)
  .set(NewsInfo);

  }

  Future<Stream<QuerySnapshot>> getNews()async{
    return await FirebaseFirestore.instance.collection("News").snapshots();

  }

}