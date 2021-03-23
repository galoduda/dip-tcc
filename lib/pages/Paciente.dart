class Paciente{
  String _id;
  String _nome;
  String _quarto;
  String _foto;
  String _diag;
  String _nasc;
  String _nomemae;
  String _alergia;
  String _obs;
  String _dataobs;
  String _exibir;
  String _dispositivo;
  var _dataexib;

  Paciente(this._id, this._nome, this._quarto, this._foto, this._diag, this._nomemae, this._alergia, this._obs, this._dataobs, this._exibir,this._nasc,this._dataexib);

  Paciente.map(dynamic obj){
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._quarto = obj['quarto'];
    this._foto = obj['foto'];
    this._diag = obj['diag'];
    this._nasc = obj['nasc'];
    this._nomemae = obj['nomemae'];
    this._alergia = obj['alergia'];
    this._obs= obj['obs'];
    this._dataobs= obj['dataobs'];
    this._exibir= obj['exibir'];
    this._dispositivo= obj['dispositivo'];
    this._dataexib= obj['dataexib'];
  }

  String get id => _id;
  String get nome => _nome;
  String get quarto => _quarto;
  String get foto => _foto;
  String get diag => _diag;
  String get nasc => _nasc;
  String get nomemae => _nomemae;
  String get alergia => _alergia;
  String get obs => _obs;
  String get dataobs => _dataobs;
  String get exibir => _exibir;
  String get dispositivo => _dispositivo;
  String get dataexib => _dataexib;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if (_id != null){
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['quarto']= _quarto;
    map['foto'] = _foto;
    map['diag'] = _diag;
    map['nasc'] = _nasc;
    map['nomemae'] = _nomemae;
    map['alergia'] = _alergia;
    map['obs'] = _obs;
    map['dataobs'] = _dataobs;
    map['exibir'] = _exibir;
    map['dispositivo'] = _dispositivo;
    map['dataexib'] = _dataexib;

    return map;
  }
    
  Paciente.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    this._nome = map['nome'];
    this._quarto = map['quarto']; 
    this._foto = map['foto'];
    this._diag = map['diag'];
    this._nasc = map['nasc'];
    this._nomemae = map['nomemae'];
    this._alergia = map['alergia'];
    this._obs = map['obs'];
    this._dataobs = map['dataobs'];
    this._exibir = map['exibir'];
    this._dispositivo = map['dispositivo'];
    this._dataexib = map['dataexib'];

  } 
}