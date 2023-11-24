import 'package:flutter/cupertino.dart';
import 'package:gara/Data/Provider/car_data.dart';

class CarDataProvider with ChangeNotifier {
  CarData? _carData;

  CarData? get carData => _carData;

  void setCarData(CarData carData) {
    _carData = carData;
    print("car data set");
    notifyListeners();
  }
}
