import 'package:flutter/material.dart';
import 'package:tyba_front/src/models/user_model.dart';
import 'package:tyba_front/src/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authProvider = new Auth();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String _email = '';
  String _password = '';

  bool _loading = false;
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _crearLogin(context), backgroundColor: Colors.green);
  }

  Widget _crearLogin(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.account_balance_wallet,
            size: screen.height * 0.3,
            color: Colors.orange,
          ),
          _loginContainer(screen)
        ],
      ),
    );
  }

  Widget _loginContainer(Size screenSize) {
    final screenratioWidth = 0.03;
    final screenratioHeight = 0.01;
    final loginPaddingRatio = 0.1;

    return Container(
      //height: screenSize.height * 0.6,
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * loginPaddingRatio,
          vertical: screenSize.height * screenratioHeight),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * screenratioWidth,
                vertical: screenSize.height * screenratioHeight),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * screenratioWidth,
                        vertical: screenSize.height * screenratioHeight),
                    child: _emailField(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * screenratioWidth,
                        vertical: screenSize.height * screenratioHeight),
                    child: _passwordField(),
                  ),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: screenSize.width * screenratioWidth,
                        right: screenSize.width * screenratioWidth,
                        top: screenSize.height * screenratioHeight),
                    child: _loginButton(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * screenratioWidth),
                    child: _signUpButton(),
                  ),
                ],
              ),
            ),
          )),
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

  Widget _loginButton() {
    return RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.green,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // el loafing lo use pensando en que me alcanzaba el tiempo para montar un firebase
            setState(() => _loading = true);
            UserModel result =
                _authProvider.signInWithEmailAndPassword(_email, _password);
            if (result == null) {
              setState(() {
                _loading = false;
                _error = 'Could not sign in with those credentials';
              });
            } else {
              Navigator.pushReplacementNamed(context, 'user',
                  arguments: result);
            }
          }
        });
  }

  Widget _signUpButton() {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, 'registro');
        },
        child: Text(
          'Sign up',
          style: TextStyle(color: Colors.grey),
        ));
  }
}
