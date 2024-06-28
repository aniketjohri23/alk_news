

import 'package:alk/addNews.dart';
import 'package:alk/service/Database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  Stream<QuerySnapshot>? newsStream;

  getontheload()async{
    newsStream = await DatabaseMethods().getNews() ;
    setState(() {

    });
  }

  @override
  void initState(){
    getontheload();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Widget allNews() {
      return StreamBuilder<QuerySnapshot>(
        stream: newsStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return NewsItem(ds: ds);
            },
          );
        },
      );
    }




    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.pink,

        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Alkraj ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
            Text("News",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow),),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
        child: Column(
          children: [
            Expanded(child: allNews()),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const news()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewsItem extends StatelessWidget {
  final DocumentSnapshot ds;

  const NewsItem({super.key, required this.ds});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: ds["url"],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                ds["title"],
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                ds["desc"],
                style: const TextStyle(color: Colors.black38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}