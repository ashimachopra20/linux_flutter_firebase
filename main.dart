
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

void main() {
WidgetsFlutterBinding.ensureInitialized();
Firebase.initializeApp(); 
   runApp(MyApp()); 
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 String x;
    String data; 
  myweb(x) async{
    
      var url="http://192.168.1.13/cgi-bin/lc.py?x=${x}";
    print(url);
      var r=await http.get(url);
setState(() {
   data=r.body;
});
        print(data);

      }
myget() async{
  var fsconnect= FirebaseFirestore.instance;
  var g = await fsconnect.collection("linuxcmd").get();

  var i;
  setState(() {
    for(i in g.docs){
     String a= i.data();
  print(a);
 }
  });
  
}

//var fsconnect= FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold( appBar: AppBar(title:Center(child: Text('EXECUTE')),backgroundColor: Colors.red,),
     body:Column(
       children: <Widget>[
         


 TextField(
                    onChanged: (value) {
                    x = value;
                    },
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter the command",
                        prefixIcon: Icon(Icons.arrow_right)),
                  ),
        RaisedButton(padding: EdgeInsets.all(10),child: Text('Click to Send'),onPressed: () async {
 await myweb(x);
 print(data);
      var fsconnect= FirebaseFirestore.instance;
//print("absd");
 fsconnect.collection("linuxcmd").add({
   "output":data,
      
     });}
        ),
        RaisedButton(child: Text('Click to Get'),onPressed:myget ),
                 Text("$data"),
     ],
     ),
      
     ),
      debugShowCheckedModeBanner: false,
    );
  }
}


