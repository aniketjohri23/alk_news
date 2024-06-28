import 'package:alk/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';


class news extends StatefulWidget{

  const news({super.key});

  @override
  State<news> createState() =>  _newsState();

}

class _newsState extends State<news> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController urlcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("add news",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
       backgroundColor: Colors.pink,
     ),
     body: Container(
       margin: const EdgeInsets.only(left: 20,right: 20,top: 30),

         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const Text("News Title",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
             const SizedBox(height: 10,),
             Container(
               decoration: BoxDecoration(
                   border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: titlecontroller,
                 decoration: const InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 30,),


             const Text("News Description",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
             const SizedBox(height: 10,),
             Container(
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: desccontroller,
                 decoration: const InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 30,),



             const Text("Image URL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
             const SizedBox(height: 10,),
             Container(
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: urlcontroller,
                 decoration: const InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 20,),

             Center(child: ElevatedButton(
                 onPressed: ()async{
                   String ID = randomAlphaNumeric(10);
                   Map<String,dynamic> newsinfoMap={
                     "title":titlecontroller.text,
                     "desc":desccontroller.text,
                     "url":urlcontroller.text,
                   "id":ID,
                   };
                   await DatabaseMethods().addNews(newsinfoMap,ID).then((value) {
                     Fluttertoast.showToast(
                         msg: "News added",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.CENTER,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.red,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                   });
                 },
                 child: const Text("add",style: TextStyle(color: Colors.pink,fontSize: 20,fontWeight: FontWeight.bold),)))

           ],
         ),
     ),
   );

  }
}

