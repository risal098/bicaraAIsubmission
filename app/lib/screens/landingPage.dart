import 'package:flutter/material.dart';
import 'auth.dart';
class LandingPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LandingPage> {
  int clickCount = 0;
  int contentIndex = 0;
  bool showImage = true;

  List<String> buttonTexts = ['next >', 'next >', "Let's Go" ];
  List<String> texts = ['''Bicara AI is a mobile app to help people prepare their English Proficiency Test by providing an IELTS Speaking Mock Test / Simulation with lengthy feedback in the area of grammar, fluency and others.''', 
  '''With 24/7 Personal IELTS Speaking Coach in your fingertips, Bicara AI can boost your confidence affordably.''', '''  With AI integrations, learning english is not hard anymore'''];
  List<String> img=['lib/assets/app_icon.png',
    'lib/assets/logo_light.png',
     'lib/assets/logo.png',
    'lib/assets/logomark.png'];

  void changeTextAndImage() {
    setState(() {
      if (contentIndex < 2) {
        contentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),backgroundColor: Color.fromARGB(255, 249, 249, 249),elevation: 0,
      ),
      body: Center(
        child: Column(
          
          children: [
          Image.asset('${img[0]}',height: 110,width: 110,),
            Text("Bicara AI"),
            Text(""),
            Text(""),
            Text(""),
            Text(texts[contentIndex], style: TextStyle(fontSize: 24,fontWeight:FontWeight.w300,
            fontStyle: FontStyle.italic ),textAlign: TextAlign.center),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(contentIndex==2){
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
          }else{if (clickCount < 5) {
            changeTextAndImage();
          }}
          
        },
        backgroundColor: Color.fromARGB(255, 95, 141, 233),
        label: Text(buttonTexts[contentIndex]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}