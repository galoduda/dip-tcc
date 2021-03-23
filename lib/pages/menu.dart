import 'package:flutter/material.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/pages/loginScreen.dart';
import 'package:flutter_auths/pages/pesquisardados.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_auths/pages/receberdados.dart';
//import 'package:flutter_auths/pages/pesquisardadosTeste.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
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
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top:20,
                          left: 0
                        ),
                        child: IconButton(
                          icon: Icon(Icons.logout),
                          iconSize: 25,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => signOutUser().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            }),
                          ),
                      ),
                    ),
                    Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/dip.png",
                      width: 280,
                      height: 130,
                      )
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        //padding: EdgeInsets.symmetric(vertical: 0.0),
                        padding: const EdgeInsets.only(
                          top: 15
                        ),
                          child: Text(
                            "Hospital Central",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            Container(
                padding: EdgeInsets.only(top:30),
                child: Text(
                            "Bem vindo(a)!",
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            ),
                          ),
              ),
               SizedBox(
              height: 20,
            ),
                          Container(
                padding: EdgeInsets.only(top:30),
                child: Text(
                            "Escolha uma opção:",                            
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            ),
                          ),
              ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.4,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                      Color(0xFF2962FF),
                      Color(0xFF2196F3),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Receber dados",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: Icon(
                            Icons.phonelink_ring,
                            size: 30,
                            ),
                        ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExibirPacientes(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.4,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                      Color(0xFF2962FF),
                      Color(0xFF2196F3),

                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pesquisar paciente",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Icon(
                            Icons.person_search,
                            size: 34,
                            ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                     context,
                      MaterialPageRoute(
                        builder: (context) => ListaPacientes(),
                        //builder: (context) => CloudFirestoreSearch(),
                      ),
                    );
                  },
                ),
              ),
            ),
             
            ],
          ),
        ),
      ),
    );
  }
}
