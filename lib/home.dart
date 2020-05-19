import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _ctrlPreference = TextEditingController();
  String _info = "Nada salvo";

  _save() async {
    String _inputData = _ctrlPreference.text;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("nome", _inputData);
  }

  _load() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _info = preferences.getString("nome") ?? "Preferência não encontrada";
    });
  }

  _delete() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("nome");
    setState(() {
      _info = "Preferência deletada";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Preferências de usuário"),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Text(_info, style: TextStyle(fontSize: 26)),
              TextField(
                controller: _ctrlPreference,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Digite algo"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Text("Salvar"),
                      onPressed: _save),
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Text("Carregar"),
                      onPressed: _load),
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Text("Apagar"),
                      onPressed: _delete),
                ],
              ),
            ],
          ),
        ));
  }
}
