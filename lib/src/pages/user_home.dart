import 'package:flutter/material.dart';
import 'package:tyba_front/src/models/restaurante_model.dart';
import 'package:tyba_front/src/models/user_model.dart';
import 'package:tyba_front/src/providers/api_provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final bloc = new ApiProvider();

  String _searchTerm = '';
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Bienvenido ${usuario.nombre}'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              })
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _crearPerfil(screen, usuario),
          Container(
            padding: EdgeInsets.only(
                left: screen.width * 0.08,
                right: screen.width * 0.08,
                top: screen.height * 0.05),
            child: _searchField(),
          ),
          _searchButton(screen, usuario),
          //_crearResultados()
        ],
      ),
    );
  }

  Widget _crearPerfil(Size screen, UserModel usuario) {
    return Container(
      padding: EdgeInsets.all(screen.width * 0.1),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.person,
              size: screen.height * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[Text("nombre: "), Text(usuario.nombre)],
                ),
                Row(
                  children: <Widget>[
                    Text("fecha nacimiento: "),
                    Text(usuario.fecha)
                  ],
                )
              ],
            )
          ],
        ),
        _verBusquedas(screen, usuario)
      ]),
    );
  }

  Widget _verBusquedas(Size screen, UserModel usuario) {
    return Container(
      padding: EdgeInsets.only(left: screen.width * 0.18),
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          Navigator.pushNamed(context, 'history', arguments: usuario);
        },
        icon: Icon(
          Icons.history,
          color: Colors.white,
        ),
        label: Text(
          'Ver busquedas',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
      ),
    );
  }

  Widget _searchButton(Size screen, UserModel usuario) {
    return Container(
      padding: EdgeInsets.only(left: screen.width * 0.18),
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          setState(() {
            //bloc.obtenerRestaurantes();
            DateTime now = DateTime.now();

            usuario
                .agregarTransaccion(_searchTerm + ';' + now.toIso8601String());
            Navigator.pushNamed(context, 'resultados', arguments: _searchTerm);
          });
        },
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        label: Text(
          'Buscar',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
      ),
    );
  }

  Widget _searchField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "ciudad",
        helperStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: "ciudad",
        icon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
      ),
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (val) {
        //setState(() => _);
        _searchTerm = val;
      },
    );
  }
}
