import 'package:flutter/material.dart';
import 'package:tyba_front/src/models/restaurante_model.dart';
import 'package:tyba_front/src/providers/api_provider.dart';

class ResultadosPage extends StatelessWidget {
  //const ResultadosPage({Key key}) : super(key: key);
  final bloc = new ApiProvider();

  @override
  Widget build(BuildContext context) {
    String busqueda = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
        ),
        body: _crearResultados(busqueda));
  }

  Widget _crearResultados(String term) {
    print(term);
    return FutureBuilder<List<RestauranteModel>>(
      future: bloc.obtenerRestaurantesFiltered(term),
      //initialData: InitialData,
      builder: (BuildContext context,
          AsyncSnapshot<List<RestauranteModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].nombre),
                subtitle: Text(snapshot.data[index].ciudad),
              );
            },
          );
        }
      },
    );
  }
}
