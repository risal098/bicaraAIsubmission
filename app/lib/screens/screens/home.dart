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
      appBar: AppBar(title: Text("done"),
    ),
    
    );
  }
}