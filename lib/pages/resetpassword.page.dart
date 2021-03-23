import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        title: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 60, maxWidth: 200),
            child: Text(
              'Hospital Central'
            ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/resetpassword.png"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Por favor, entre o contato com o setor de T.I. para pedir uma nova senha:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Container(
                        child: Icon(Icons.email,color: Colors.black,size: 24,                     
                        ),
                      ),
                      Text(
                        "ti@teste.com.br",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline
                        ),
                        textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Container(
                        child: Icon(Icons.phone, color: Colors.black,size: 20,                     
                        ),
                      ),
                      Text(
                        "(XX) XXXX-XXXX",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline
                        ),
                        textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
