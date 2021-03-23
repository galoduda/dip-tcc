import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/Paciente.dart';
import 'package:flutter_auths/pages/tela_Paciente.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExibirPacientes extends StatefulWidget{
  @override
  _ReceberDados createState() => _ReceberDados();
}

class _ReceberDados extends State<ExibirPacientes> {

  //List<Paciente> items;
  var db = Firestore.instance;
  String nome = "";
  String id ="";
  String dispexib='1';
  List<String>  listaDisp=<String>[
    '1',
    '2'
  ];

  
     void selecionaDisp(BuildContext context){
      showDialog(
        context: context, 
        builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width/1.2,
            height:MediaQuery.of(context).size.height/5,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Text("Selecione o dispositivo em uso:"),
                SizedBox(
                        height: 10,
                      ),
                SizedBox(
                        height: 20,
                      ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: DropdownButton(
                    hint: Text("Selecione"),
                    value: dispexib,
                    items: listaDisp.map((dispexib) => DropdownMenuItem(
                      child: Text(
                        dispexib,
                        style: TextStyle(color: Colors.black),
                      ),
                       value: dispexib,
                      )).toList(),
                    onChanged: (novoDisp){
                      dispexib=novoDisp;
                      setState(() {
                        dispexib=novoDisp;
                        Navigator.of(context).pop();
                      });
                    },
                    )

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
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [IconButton(
          icon: Icon(Icons.app_settings_alt_rounded),
          color: Colors.black,
          onPressed: () => selecionaDisp(context)
        ),]
      ),

      body: Column(
        children: <Widget>[
          SizedBox(
              height: 5,
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('pacientes')
                .orderBy('dataexib', descending: true).limit(1)
                .where('exibir', isEqualTo: 'sim')
                .where('dispositivo', isEqualTo: dispexib)
                .snapshots(),
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
                        //print(data.documentID);
                        //print(index);
                      // _navegarParaPerfil(context, items[index]),
                        
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

  void _navegarParaPerfil(BuildContext context, Paciente paciente) async{
    await Navigator.push(context,
     MaterialPageRoute(builder: (context) => TelaPaciente(paciente)),
     );
  }
}
