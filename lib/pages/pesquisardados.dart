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

  //List<Paciente> items;
  var db = Firestore.instance;
  TextEditingController _procurarpaciente = TextEditingController();
  String nome = "";
  String id ="";
  



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
          color: Colors.black,
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
            onChanged: (val) {
              setState(() {
                nome = val;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
            stream: (nome != "" && nome != null)
            ? Firestore.instance
                .collection('pacientes')
                .where("indexList", arrayContains: nome)
                .orderBy('dataexib', descending: true)
                .snapshots()
            : Firestore.instance.collection("pacientes").orderBy('dataexib', descending: true).snapshots(),
        builder: (context, snapshot) {
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
                   // List<DocumentSnapshot> documentos =
                     // snapshot.data.documents;
                    return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.documents[index];
                    return ListTile(
                      title: Text(
                        data['nome'],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                      ),),
                      subtitle:Text(
                        "Quarto: ${data['quarto']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                      ),),
                      leading:CircleAvatar(
                            backgroundImage: NetworkImage(data['foto']),
                          ),
                     onTap: (){
                      //print(data.data);
                      //print(data.documentID);
              
                      var selecionado = new Paciente(data.documentID,data.data['nome'],data.data['quarto'],data.data['foto'],data.data['diag'],data.data['nomemae'],data.data['alergia'],data.data['obs'],data.data['dataobs'],data.data['exibir'],data.data['nasc'],data.data['dataexib']);
                      
                      _navegarParaPerfil(context, selecionado);
                       }
                          
                    );
                    
 
                  },
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

  void _navegarParaPerfil(BuildContext context, Paciente paciente) async{
    await Navigator.push(context,
     MaterialPageRoute(builder: (context) => TelaPaciente(paciente)),
     );
  }
}
