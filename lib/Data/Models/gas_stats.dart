class GasStat {
  final num? cost;
  final num? milesSinceLastFill;
  final num? gallonsFilled;

  GasStat(
      {required this.cost,
      required this.milesSinceLastFill,
      required this.gallonsFilled});

  factory GasStat.fromRTDB(Map<String, dynamic> data) {
    return GasStat(
        cost: data['Cost'] as num?,
        milesSinceLastFill: data['MilesSinceLastFill'] as num?,
        gallonsFilled: data['GallonsFilled'] as num?);
  }
}
