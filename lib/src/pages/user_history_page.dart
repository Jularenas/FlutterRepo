import 'package:flutter/material.dart';
import 'package:tyba_front/src/models/user_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("History page"),
      ),
      body: ListView.builder(
        itemCount: usuario.transaccciones.length,
        itemBuilder: (BuildContext context, int index) {
          List<String> busquedas = usuario.transaccciones[index].split(";");
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Busqueda: ${busquedas[0]}'),
                Text('fecha: ${busquedas[1]}')
              ],
            ),
          );
        },
      ),
    );
  }
}
