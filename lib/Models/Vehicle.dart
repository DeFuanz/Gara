class Vehicle {
  late String? vehicleName;
  late int? avgMiles;
  late int? fillUps;
  late int? totalMiles;
  late String? color;
  late String? vehicleType;
  late String? vehicleImage;

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

  String? get getColor {
    return color;
  }

  set setColor(String colour) {
    color = colour;
  }

  String? get getType {
    return vehicleType;
  }

  set setType(String? type) {
    vehicleType = type;
  }

  String? get getImage {
    return vehicleImage;
  }

  set setImage(String? image) {
    vehicleImage = image;
  }
}
