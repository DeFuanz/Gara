class Vehicle {
  late String? vehicleName;
  late int? avgMiles;
  late int? fillUps;
  late int? totalMiles;

  String? get getVehicle {
    return vehicleName;
  }

  set setVehicleName(String? name) {
    vehicleName = name;
  }

  int? get getAvgMiles {
    return avgMiles;
  }

  set setAvgMiles(int? miles) {
    avgMiles = miles;
  }

  int? get getFillUps {
    return fillUps;
  }

  set setFillUps(int? fills) {
    fillUps = fills;
  }

  int? get getTotalMiles {
    return totalMiles;
  }

  set setTotalMiles(int? miles) {
    totalMiles = miles;
  }
}
