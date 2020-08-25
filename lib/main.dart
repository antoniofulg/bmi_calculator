import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados.";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.amber),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.amber)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.amber)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child:
                        Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25)),
                        color: Colors.amber)
                ),
              ),
              Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25.0)
              )
            ],
          )
        )
      ),
    );
  }
}
