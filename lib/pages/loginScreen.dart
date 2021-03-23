//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/pages/resetpassword.page.dart';
//import 'package:flutter_auths/pages/signupScreen.dart';
//import 'package:flutter_auths/pages/tasks.dart';
import 'package:flutter_auths/pages/menu.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void login() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signin(email, password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                //builder: (context) => TasksPage(uid: value.uid),
                builder: (context) => Menu(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF2962FF)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90)
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/dip.png",
                      width: 320,
                      height: 180,
                      )
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        //padding: EdgeInsets.symmetric(vertical: 0.0),
                        padding: const EdgeInsets.only(
                          top: 30
                        ),
                          child: Text(
                            "Hospital Central",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:35),
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Esse campo é necessário"),
                          EmailValidator(errorText: "Email inválido"),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Senha"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "A senha é necessária"),
                            MinLengthValidator(6,
                                errorText: "A senha está muito curta"),
                          ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      RaisedButton(
                        // passing an additional context parameter to show dialog boxs
                        onPressed: login,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          "Login",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             // MaterialButton(
            //  padding: EdgeInsets.zero,
            //    onPressed: () => googleSignIn().whenComplete(() async {
            //      FirebaseUser user = await FirebaseAuth.instance.currentUser();
            //
            //      Navigator.of(context).pushReplacement(MaterialPageRoute(
            //          builder: (context) => TasksPage(uid: user.uid)));
            //    }),
            //    child: Image(
            //      image: AssetImage('assets/signin.png'),
            //      width: 200.0,
            //    ),
             // ),
              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  // send to login screen
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                },
                child: Text(
                  "Esqueci minha senha",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
