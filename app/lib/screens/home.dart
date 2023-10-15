import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  Home ({super.key});
  @override
  _Home  createState() => _Home ();
}

class _Home extends State<Home>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
        title: Text(''),backgroundColor: Color.fromARGB(255, 249, 249, 249),elevation: 0,
      ),
      body: Center(
        child: Column(children:[
          Image.asset("lib/assets/seek.png",height: 110,width: 110,),
              Text(""),
          
          Text("thankyou",style:TextStyle(fontStyle:FontStyle.italic,fontSize:80))]
    )));
  }
}
