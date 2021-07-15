import 'dart:ui';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os seus dados.";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    _updateInfoText("Informe os seus dados.");
  }

  void _updateInfoText(String newText){
    setState(() {
      _infoText = newText;
    });
  }

  void _calculateIMC(){
    double weigth = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;
    double imc = weigth/(height * height);
    String result = "";
    if(imc < 18.5){
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Abaixo do Peso).";
    } else if(imc <= 24.9){
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Peso Normal).";
    } else if(imc <= 29.9){
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Sobrepeso).";
    } else if(imc <= 34.9){
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Obesidade Grau I).";
    } else if(imc <= 39.9){
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Obesidade Grau II).";
    } else{
      result = "Seu IMC é de ${imc.toStringAsPrecision(5)} (Obesidade Grau III ou Mórbida).";
    }
    _updateInfoText(result);
  }

  bool _isNumber(String value){
    final number = num.tryParse(value);
    if(number == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade600,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh)
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person, size: 120, color: Colors.deepPurple.shade600,),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.deepPurple.shade600, fontSize: 15)
                  ),
                  style: TextStyle(color: Colors.blueGrey.shade600),
                  textAlign: TextAlign.center,
                  controller: weightController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "O peso deve ser informado!";
                    }
                    if(!_isNumber(value)){
                      return "O peso deve ser um número!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.deepPurple.shade600, fontSize: 15)
                  ),
                  style: TextStyle(color: Colors.blueGrey.shade600),
                  textAlign: TextAlign.center,
                  controller: heightController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "A altura deve ser informada!";
                    }
                    if(!_isNumber(value)){
                      return "A altura deve ser um número!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 30),
                child: Container(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculateIMC();
                      }
                    },
                    child: Text("Calcular"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple.shade600
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 30),
                child: Text(_infoText, style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 15),)
              )
            ],
          ),
        )
      )
    );
  }
}