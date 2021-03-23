import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/Paciente.dart';
import 'package:flutter_auths/pages/tela_Paciente.dart';

class ListaPacientes extends StatefulWidget{
  @override
  _PesquisarDados createState() => _PesquisarDados();
}

class _PesquisarDados extends State<ListaPacientes> {

  List<Paciente> items;
  var db = Firestore.instance;
  TextEditingController _procurarpaciente = TextEditingController();
  StreamSubscription<QuerySnapshot> pacienteInscricao;
  String nome = "";

  @override
  void initState(){
    super.initState();

      items = List();
      pacienteInscricao?.cancel();

  pacienteInscricao =
  db.collection("pacientes").snapshots().listen((snapshot) { 
    final List<Paciente> pacientes = snapshot.documents.map(
      (documentSnapshot)=> Paciente.fromMap(
        documentSnapshot.data, documentSnapshot.documentID),
    ).toList();

    setState(() {
      this.items = pacientes;
    });
  });
  }

  @override
  void dispose(){
    pacienteInscricao?.cancel();
    super.dispose();
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
          onPressed: () => Navigator.pop(context, false),
        ),
      ),

      body: Column(
        children: <Widget>[
          SizedBox(
              height: 5,
            ),
          TextField(
            controller: _procurarpaciente,
            decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Pesquisar paciente",prefixIcon: Icon(Icons.search)
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getListaPacientes(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                              Icon(Icons.error_outline),
                              Text("Usuário não encontrado")                                                
                      ],
                    ),
                  );
                  default:
                    List<DocumentSnapshot> documentos =
                      snapshot.data.documents;
                    return ListView.builder(
                      itemCount: documentos.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(items[index].nome,
                            style: TextStyle(fontSize: 16)),
                          subtitle: Text('Quarto: ${items[index].quarto}',
                            style: TextStyle(fontSize: 16)),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(items[index].foto),
                          ),
                                onTap: ()=> _navegarParaPerfil(context, items[index]),
                        );
                      }
                      );
                }
              }
            ),
            )
        ],
        ),
    );
  }

  Stream<QuerySnapshot> getListaPacientes(){
    return Firestore.instance.collection('pacientes').snapshots();
  }

  //void _deletaPaciente(BuildContext context,
  //DocumentSnapshot doc, int position) async{
  //  db.collection("pacientes").document(doc.documentID).delete();
  //
  //  setState(() {
  //    items.removeAt(position);
  //  });
  //}
  void _navegarParaPerfil(BuildContext context, Paciente paciente) async{
    await Navigator.push(context,
     MaterialPageRoute(builder: (context) => TelaPaciente(paciente)),
     );
  }
}
