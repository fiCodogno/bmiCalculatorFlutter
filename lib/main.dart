import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: const Home(),
    title: "Calculadora de IMC",
    color: Colors.green.shade400
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _message = "Insira os dados!";
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _clearTextFields() {
    setState(() {
      weightController.clear();
      heightController.clear();
      _message = "Insira os dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if(imc < 18.5){
        _message = "IMC: ${imc.toStringAsPrecision(4)} -> Você se encontra abaixo do peso ideal!";
      } else if (imc >= 18.5 && imc < 24.9){
        _message = "IMC: ${imc.toStringAsPrecision(4)} -> Você se encontra no peso ideal!";
      } else if (imc >= 25 && imc < 29.9){
        _message = "IMC: ${imc.toStringAsPrecision(4)} -> Você se encontra em sobrepeso (obesidade de grau I)!";
      } else if (imc >= 30 && imc < 39.9){
        _message = "IMC: ${imc.toStringAsPrecision(4)} -> Você se encontra com obesidade de grau II!";
      } else{
        _message = "IMC: ${imc.toStringAsPrecision(4)} -> Você se encontra com obesidade de grau III!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          backgroundColor: Colors.green.shade400,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: _clearTextFields, icon: const Icon(Icons.refresh)),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green.shade400,
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value == ""){
                      return "Insira seu peso!";
                    }
                  },
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green.shade400),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade400))),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green.shade400, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value == ""){
                      return "Insira sua altura!";
                    }
                  },
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green.shade400),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade400))),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green.shade400, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade400)),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green.shade400, fontSize: 25),
                ),
              ],
            ),
          ),
        ));
  }
}
