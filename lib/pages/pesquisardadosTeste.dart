import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/tela_Paciente.dart';


class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String nome = "";

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
      body:  Column(
        children: <Widget>[
          SizedBox(
              height: 5,
            ),
          TextField(
            //controller: _procurarpaciente,
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
                .snapshots()
            : Firestore.instance.collection("pacientes").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
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
                     onTap: ()=> _navegarParaPerfil(context, snapshot.data.documents[index]),
                          
                    );
                    
 
                  },
                );
        },
      
      ),
          )
        ]
    )
    );
  }
   void _navegarParaPerfil(BuildContext context, index) async{
    await Navigator.push(context,
     MaterialPageRoute(builder: (context) => TelaPaciente(index)),
     );
  }
}
