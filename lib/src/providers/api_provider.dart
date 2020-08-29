import 'package:tyba_front/src/models/restaurante_model.dart';
import 'dart:async';

class ApiProvider {
  //zomato api
  final api_key = '7351532d0ff44437c116b246f9cd7159';

  final rests = [
    new RestauranteModel("Livornos", "Cali"),
    new RestauranteModel("Juanitos", "Bogota"),
    new RestauranteModel("Perez", "Cali"),
    new RestauranteModel("Lasagna", "Tunja"),
    new RestauranteModel("Livornos", "Cali"),
    new RestauranteModel("Juanitos", "Bogota"),
    new RestauranteModel("Perez", "Cali"),
    new RestauranteModel("Lasagna", "Tunja"),
    new RestauranteModel("Livornos", "Cali"),
    new RestauranteModel("Juanitos", "Bogota"),
    new RestauranteModel("Perez", "Cali"),
    new RestauranteModel("Lasagna", "Tunja"),
  ];

  static final ApiProvider _singleton = new ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal() {
    //get scans
  }

  Future<List<RestauranteModel>> obtenerRestaurantes() {
    return new Future.delayed(const Duration(seconds: 1), () => rests);
  }

  Future<List<RestauranteModel>> obtenerRestaurantesFiltered(String term) {
    return new Future.delayed(const Duration(seconds: 2),
        () => rests.where((rest) => rest.ciudad.startsWith(term)).toList());
  }
}
