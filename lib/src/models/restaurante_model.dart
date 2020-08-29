class RestauranteModel {
  String _nombre;

  String _ciudad;

  RestauranteModel(String nombre, String ciudad) {
    _nombre = nombre;
    _ciudad = ciudad;
  }

  String get nombre {
    return _nombre;
  }

  String get ciudad {
    return _ciudad;
  }
}
