import 'package:tyba_front/src/models/user_model.dart';

class Auth {
  List<UserModel> _usuarios = [];

  static final Auth _auth = Auth._();

  factory Auth() {
    return _auth;
  }

  Auth._();

  UserModel signInWithEmailAndPassword(String usuario, String password) {
    //aqui tengo un error de duplicado en complejidad
    var user = _usuarios.where((user) => user.email == usuario).toList();
    if (user.length > 0 && user[0].password == password) {
      return user[0];
    }
    return null;
  }

  UserModel singUpEmail(
      String email, String password, String nombre, int edad, String fecha) {
    try {
      UserModel usuario = new UserModel(email, password, nombre, edad, fecha);
      _usuarios.add(usuario);
      return usuario;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
