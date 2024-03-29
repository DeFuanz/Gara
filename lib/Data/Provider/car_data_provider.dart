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

  void setCarMake(String carMake) {
    _carData!.selectedCarMake = carMake;
    notifyListeners();
  }

  void setCarModel(String carModel) {
    _carData!.selectedCarModel = carModel;
    notifyListeners();
  }
}
