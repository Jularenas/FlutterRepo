class UserModel {
  String _email;
  String _password;
  String _nombre;
  int _edad;
  String _fechaNacimiento;
  List<String> _transacciones;

  UserModel(
      String email, String password, String nombre, int edad, String fecha) {
    _email = email;
    _password = password;
    _nombre = nombre;
    _edad = edad;
    _fechaNacimiento = fecha;
    _transacciones = [];
  }

  String get email {
    return _email;
  }

  String get nombre {
    return _nombre;
  }

  String get password {
    return _password;
  }

  int get edad {
    return _edad;
  }

  String get fecha {
    return _fechaNacimiento;
  }

  List<String> get transaccciones {
    return _transacciones;
  }

  void agregarTransaccion(String transaccion) {
    _transacciones.add(transaccion);
  }
}
