import 'package:flutter/material.dart';
import 'package:tyba_front/src/models/user_model.dart';
import 'package:tyba_front/src/providers/auth_provider.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _authProvider = new Auth();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _inputFieldController =
      new TextEditingController(text: "");

  // text field state
  String _email = '';
  String _password = '';
  String _passwordRepeat = '';
  String _nombre = '';
  String _fecha = '';

  bool _loading = false;
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sing up'),
        backgroundColor: Colors.green,
      ),
      body: _crearRegistro(),
    );
  }

  Widget _crearRegistro() {
    //Form(
    //          key: _formKey,
    //          child: Column(
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _alignFieldContainer(_emailField()),
          _alignFieldContainer(_nombreField()),
          _alignFieldContainer(_crearFecha(context)),
          _alignFieldContainer(_passwordField()),
          _alignFieldContainer(_passwordRepeatField()),
          _alignFieldContainer(_signUpButton()),
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "E-mail",
        helperStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: "E-mail",
        icon: Icon(
          Icons.email,
          color: Colors.grey,
        ),
      ),
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (val) {
        setState(() => _email = val);
      },
    );
  }

  Widget _passwordField() {
    //SizedBox(height: 20.0),
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "password",
        helperStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: "password",
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
      validator: (val) => val.length < 6 ? 'entter a valid password' : null,
      onChanged: (val) {
        setState(() => _password = val);
      },
    );
  }

  Widget _passwordRepeatField() {
    //SizedBox(height: 20.0),
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "repeat your password",
        helperStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: "repeat your password",
        icon: Icon(
          Icons.lock_open,
          color: Colors.grey,
        ),
      ),
      validator: (val) =>
          val.length < 6 || val != _password ? 'passwords do not match' : null,
      onChanged: (val) {
        setState(() => _password = val);
      },
    );
  }

  Widget _nombreField() {
    //SizedBox(height: 20.0),
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "nombre",
        helperStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: "nombre",
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
      onChanged: (val) {
        setState(() => _nombre = val);
      },
    );
  }

  Widget _signUpButton() {
    return RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.green,
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // el loading lo use pensando en que me alcanzaba el tiempo para montar un firebase
            setState(() => _loading = true);
            UserModel result = _authProvider.singUpEmail(
                _email, _password, _nombre, 20, _fecha);
            if (result == null) {
              setState(() {
                _loading = false;
                _error = 'Could not sign up';
              });
            } else {
              Navigator.pushReplacementNamed(context, 'user',
                  arguments: result);
            }
          }
        });
  }

  Widget _crearFecha(context) {
    return TextField(
      controller: _inputFieldController,
      enableInteractiveSelection: true,
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: "Fecha de nacimiento",
          helperStyle: TextStyle(fontWeight: FontWeight.bold),
          labelText: "Fecha de nacimiento",
          icon: Icon(Icons.calendar_today, color: Colors.grey),
          suffixIcon: Icon(Icons.calendar_view_day)),

      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
        _inputFieldController.text = _fecha;
      },
    );
  }

  Widget _alignFieldContainer(Widget field) {
    final screen = MediaQuery.of(context).size;
    return Container(
      child: field,
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.08),
    );
  }

  _selectDate(BuildContext context) async {
    print("hasta aqui todo bien");
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2020),
        firstDate: new DateTime(1999),
        lastDate: new DateTime(2020));

    if (picked != null) {
      print(picked);
      setState(() {
        _fecha = picked.toString();
      });
    }
  }
}
