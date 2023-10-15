import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
class Login extends StatefulWidget{
  Login({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login>{
  Future<List<String>> letsLogin(String email,String password) async{
var url = Uri.https('server-lab.risalahqz.repl.co',
                    'logins');
var response = await http.post(url, body: jsonEncode({'email': email,
                                           'password': password}));

return [response.statusCode.toString(),response.body];
}


Future<List<String>> letsRegister(String email,String fName,String lName,String password) async{
var url = Uri.https('server-lab.risalahqz.repl.co',
                    'registers');
var response = await http.post(url, body: jsonEncode({'email': email,
                                                      'firstName':fName,
                                                      'lastName':lName,
                                           'password': password}));

return [response.statusCode.toString(),response.body];
}
List<String> formCondition=["","your email is not a valid email format"
,"email is mandatory!"
,"email already registered","email or password is not correct"];
List<String> passwordCondition=["","email or password is not correct"];
int loginIndexResponse=0;
int regIndexResponse=0;
String authDecision="login";
bool PWobscureText = true;
int botImgIndex=0;
List<String> botImage=["lib/assets/seek.png","lib/assets/secret.png","lib/assets/semiSeek.png"];
bool emailValid(String email){
  return  RegExp(r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`
{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""").hasMatch(email);
}
TextEditingController loginEmailController = TextEditingController();
TextEditingController loginPasswordController = TextEditingController();


TextEditingController regEmailController = TextEditingController();
TextEditingController regFNameController = TextEditingController();
TextEditingController regLNameController = TextEditingController();
TextEditingController regPasswordController = TextEditingController();
 @override
  Widget build(BuildContext context){
    
    if(authDecision=="login"){
      return Scaffold(
      appBar: AppBar(
        title: Text(''),automaticallyImplyLeading: false,backgroundColor: Color.fromARGB(255, 249, 249, 249),elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('${botImage[botImgIndex]}',height: 110,width: 110,),
              Text(""),
              Text("LOGIN",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 87, 92, 255))),
              Text("${formCondition[loginIndexResponse]}",style: TextStyle(color: Color.fromARGB(255, 248, 70, 70)),),
              // Email Input
              TextFormField(
                controller: loginEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),onTap: () {
                setState(() {
                  botImgIndex=0;
                });
              },
              ),

              SizedBox(height: 20),

              // Password Input
              TextFormField(
                 controller: loginPasswordController,
                obscureText: PWobscureText, 
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
          icon: Icon(PWobscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              PWobscureText = !PWobscureText;
              if(PWobscureText) {
              botImgIndex=1;}else{botImgIndex=2;}
            });
          },
        ),
                ),onTap: () {
                setState(() {
                  if(botImgIndex!=2 && PWobscureText){
                  botImgIndex=1;}
                });
              },
              ),

              SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                //  login logic disini
                onPressed: () async {
                  String email = loginEmailController.text;
                  String password = loginPasswordController.text;
                  if(email.length==0){
                    setState(() {
                      loginIndexResponse=2;
                    });
                  }else if(!emailValid(email)){
                      setState(() {
                      loginIndexResponse=1;
                    });
                  }else{
                   List<String> response =await letsLogin(email, password);
                    String statusResponse =response[0];
                    String bodyResponse =response[1];
                    if(statusResponse=="200" && bodyResponse=="ok"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                    }else{
                      setState(() {
                        loginIndexResponse=4;
                      });
                    }
                  }
                  
                },
                child: Text('Login'),
              ),

              SizedBox(height: 20),

              // Sign Up Text
              GestureDetector(
                onTap: () {
                   setState(() {
                    regIndexResponse=0;
                    botImgIndex=0;
          authDecision="register";
        });
                  
                },
                child: Text(
                  'Sign up for an account',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

      /*
    return Scaffold(appBar: AppBar(
        title: Text(''),backgroundColor: Color.fromARGB(255, 249, 249, 249),elevation: 0,
      ),body: Center(
        child: Column(children: [
          Text("login")
        ],
        )
        ),
        floatingActionButton: FloatingActionButton(onPressed:(){setState(() {
          authDecision="register";
        });}),
        );*/
        else{
      return Scaffold(
      appBar: AppBar(
        title: Text(''),automaticallyImplyLeading: false,backgroundColor: Color.fromARGB(255, 249, 249, 249),elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset('${botImage[botImgIndex]}',height: 110,width: 110,),
              Text(""),
              Text("REGISTER",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 87, 92, 255))),
              Text("${formCondition[regIndexResponse]}",style: TextStyle(color: Color.fromARGB(255, 248, 70, 70)),),
              // Email Input
              TextFormField(
                controller: regEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),onTap: () {
                setState(() {
                  botImgIndex=0;
                });
              },
              ),

              SizedBox(height: 20),
              // Email Input
              TextFormField(
                controller: regFNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your First Name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),onTap: () {
                setState(() {
                  botImgIndex=0;
                });}
              ),

              SizedBox(height: 20),
              // Email Input
              TextFormField(
                controller: regLNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your Last Name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),onTap: () {
                setState(() {
                  botImgIndex=0;
                });}
              ),

              SizedBox(height: 20),

              // Password Input
              TextFormField(
                controller: regPasswordController,
                obscureText: PWobscureText, // Hide password
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
          icon: Icon(PWobscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              PWobscureText = !PWobscureText;
              if(PWobscureText) {
              botImgIndex=1;}else{botImgIndex=2;}
            });
          },
        ),
                ),onTap: () {
                setState(() {
                  if(botImgIndex!=2 && PWobscureText){
                  botImgIndex=1;}
                });
              },
              ),

              SizedBox(height: 20),

              // registr Button
              ElevatedButton(
                onPressed: () async{
                  //register logic here
                  String email = regEmailController.text;
                  String fName = regFNameController.text;
                  String lName = regLNameController.text;
                  String password = regPasswordController.text;
                  if(email.length==0){
                    setState(() {
                      regIndexResponse=2;
                    });
                  }else if(!emailValid(email)){
                      setState(() {
                      regIndexResponse=1;
                    });
                  }else{
                   List<String> response =await letsRegister(email,fName,lName, password);
                    String statusResponse =response[0];
                    String bodyResponse =response[1];
                    if(statusResponse=="200" && bodyResponse=="ok"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                    }else{
                      setState(() {
                        regIndexResponse=3;
                      });
                    }
                  }
                },
                child: Text('Register'),
              ),

              SizedBox(height: 20),

              // Sign Up Text
              GestureDetector(
                onTap: () {
                   setState(() {
                    loginIndexResponse=0;
                    botImgIndex=0;
          authDecision="login";
        });
                  
                },
                child: Text(
                  'Already have an account?,Login',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
}
