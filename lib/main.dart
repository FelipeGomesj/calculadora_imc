import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controle de textos
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //Chave global
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = 'Informe seus dados.';

  //Função para dar refresh na página
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    //setState informa que houve uma modificação  aqui e o que está dentro irá assumir depois que atualizarmos no botão de refresh
    setState(() {
      _infoText = 'Informe seus dados';
      //reseta a mensagem de erro quando damos o refresh
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      //Criando variável weight(peso) e transformando o que foi digitado no weightCon... em um double, ou seja em um float
      double weight = double.parse(weightController.text);
      //O 100 no final é para dar o número certo, já que solicitamos em (cm) pro usuário
      double height = double.parse(heightController.text) / 100;
      //formula do imc Peso, dividido pelo quadrado da altura
      double imc = weight / (height * height);
      print(imc);
      //O imc.toStringAsPrecision(4) Significa que só queremos 4 digitos aparecendo na tela
      if (imc < 18.6) {
        _infoText =
            'Abaixo do peso ideal. IMC:  (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal. IMC: (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            'Levemente acima do peso. IMC: (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade de 1°Grau. IMC: (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade de 2°Grau. IMC: (${imc.toStringAsPrecision(4)})';
      } else if (imc > 40) {
        _infoText = 'Obesidade 3°Grau. IMC: (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar é a barra em  cima =  https://api.flutter.dev/flutter/material/AppBar-class.html
      appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          //Cor de fundo da barra AppBar
          backgroundColor: Colors.green,
          //ações na barra chamando um <Widget>
          actions: <Widget>[
            //Ação que queremos: Botão em forma de ícone
            IconButton(
              //Ícone: Icon(Icons.refresh) ou seja botão para dar o refresh
              icon: Icon(Icons.refresh),
              //pressionar  e uma função anônma
              onPressed: _resetFields,
            )
          ]),
      backgroundColor: Colors.white,
      //SingleChildScrollView é para que nosso app possa rolar para cima e para baixo caso o teclado intefira em algo
      body: SingleChildScrollView(
        //Espaçamentos para separar o layout das bordas, ou seja, para não ficar colado nas bordas do celular (esquerda, topo, direita, baixo)
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                //validator valida o campo preenchido
                validator: (value) {
                  //Se o campo do peso estiver vazio, faça
                  if (value.isEmpty) {
                    return 'Insira seu Peso!';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                //validator valida o campo preenchido
                validator: (value) {
                  //Se o campo da altura estiver vazio, faça
                  if (value.isEmpty) {
                    return 'Insira sua altura';
                  }
                },
              ),

              //Padding é o espaçamento
              Padding(
                //Espaçamento do botão Raised com a linha topo e baixo(10,10)
                padding: EdgeInsets.only(top: 10, bottom: 10.0),
                child: Container(
                    height: 50,
                    //Botão verde calcular
                    child: RaisedButton(
                        onPressed: () {
                          //Se o _formkey, estiver com o status validado, isto é, preenchido calcule
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text('Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        color: Colors.green)),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
