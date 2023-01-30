class Vehicle {
  final String? vehicleName;
  final int? avgMiles;
  final int? fillUps;
  final int? totalMiles;
  final String? color;
  final String? vehicleType;
  final String? vehicleImage;

  Vehicle(
      {required this.vehicleName,
      required this.avgMiles,
      required this.fillUps,
      required this.totalMiles,
      required this.color,
      required this.vehicleType,
      required this.vehicleImage});

  factory Vehicle.fromRTDB(Map<String, dynamic> data) {
    return Vehicle(
        vehicleName: data['Name'],
        avgMiles: data['AvgMiles'],
        fillUps: data['FillUps'],
        totalMiles: data['Miles'],
        color: data['Color'],
        vehicleType: data['Type'],
        vehicleImage: data['Image']);
  }
}
