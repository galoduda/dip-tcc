import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auths/pages/Paciente.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaPaciente extends StatefulWidget {
  final Paciente paciente;
  TelaPaciente(this.paciente);

  @override
  _TelaPacienteState createState() => _TelaPacienteState();
}

class _TelaPacienteState extends State<TelaPaciente> {

  final db =Firestore.instance;
 
   
  
  String now = DateFormat('dd-MM-yyyy  –  kk:mm').format(DateTime.now());



  String _nomePaciente;
  String _quartoPaciente;
  String _fotoPaciente;
  String _id;
  String _diag;
  String _nasc;
  String _nomemae;
  String _alergia;
  String _obs;
  String _dataobs;
  //var _dataexib;
  String _exibir;

  @override
    void initState(){
      super.initState();
      _nomePaciente = widget.paciente.nome;
      _quartoPaciente = widget.paciente.quarto;
      _fotoPaciente = widget.paciente.foto;
      _id = widget.paciente.id;
      _diag = widget.paciente.diag;
      _nasc = widget.paciente.nasc;
      _nomemae = widget.paciente.nomemae;
      _alergia = widget.paciente.alergia;
      _obs = widget.paciente.obs;
      _dataobs = widget.paciente.dataobs;
      //_dataexib = widget.paciente.dataexib;
      _exibir = widget.paciente.exibir;
    }

    

   void insereObs(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          TextEditingController _observ = TextEditingController();
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width/1.2,
            height:MediaQuery.of(context).size.height/4,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Text("Insira a observação:"),
                SizedBox(
                        height: 10,
                      ),
                TextField(
                  controller: _observ,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, 
                        )
                    ),
                  ),
                ),
                SizedBox(
                        height: 20,
                      ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Material(
                    elevation: 5.0,
                    borderRadius:BorderRadius.circular(25),
                    color: Colors.blueAccent[700],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(10,15,10,15),
                      child: Text(
                        "Enviar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        onPressed: (){
                           db.collection("pacientes").document(_id).updateData({
                             "obs": _observ.text,
                             "dataobs": now
                           });    //ALTERAR PARA SOMENTE ESSE, OU INCLUIR TODOS
                           Navigator.of(context).pop();
                           setState(() {
                              _obs =_observ.text;
                              _dataobs =now;
                           });
                        },
                    ),
                  ),

                )

            ],),
            ),
        );
        }
      );
    }

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
          onPressed: (){
            //Navigator.pop(context, false);
            db.collection("pacientes").document(_id).updateData({
                             "exibir": "nao"
                           });    //ALTERAR PARA SOMENTE ESSE, OU INCLUIR TODOS
                           Navigator.of(context).pop();
                           setState(() {
                              _exibir ="nao";
                           });
            
            
            },
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
                        child: new Container(
                              width: 190.0,
                              height: 190.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                        "$_fotoPaciente")
                                    )
                                ),
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _nomePaciente,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Quarto: $_quartoPaciente",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nascimento: $_nasc",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nome da mãe: $_nomemae",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Código: $_id",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Alergia: $_alergia",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Diagnóstico: $_diag",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                       SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start ,
                    children: <Widget>[
                      Flexible(
                        child: 
                          Text(
                        "Última observação: $_dataobs  $_obs",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 15,
                          //decoration: TextDecoration.underline
                        ),
                        textAlign: TextAlign.center,
                            ),
                      ),
                          ],
                        ),
                      ),

                      Container(
              height: 40,
              width: MediaQuery.of(context).size.width/2.5,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Nova Observação",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () {
                    insereObs(context);
                        //builder: (context) => CloudFirestoreSearch(),
                      
                  },
                ),
              ),
            ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

 
}