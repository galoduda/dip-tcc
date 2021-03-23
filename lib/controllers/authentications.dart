import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

showErrDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Erro!"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

Future<FirebaseUser> signin(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: email);
    FirebaseUser user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, 'Email inválido');
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, 'Senha incorreta');
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, 'Usuário não encontrado');
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, 'Usuário desabilitado');
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, 'Muitas requisições realizadas');
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, 'Operação não permitida');
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  await auth.signOut();
  return Future.value(true);
}
