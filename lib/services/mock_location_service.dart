import 'dart:math';

class MockLocationService {
  final double roomCenterLat;
  final double roomCenterLon;
  final double allowedRadiusMeters;
  final Random _rng = Random();

  MockLocationService({
    required this.roomCenterLat,
    required this.roomCenterLon,
    required this.allowedRadiusMeters,
  });

  Future<({double distanceMeters, double accuracyMeters, bool isMockProvider})> getReading() async {
    final distance = _rng.nextDouble() * 60; // 0..60m
    final accuracy = 5 + _rng.nextDouble() * 20; // 5..25m
    final isMock = _rng.nextDouble() < 0.05; // 5%
    await Future.delayed(const Duration(milliseconds: 120));
    return (distanceMeters: distance, accuracyMeters: accuracy, isMockProvider: isMock);
  }

  bool isInside(double distanceMeters) => distanceMeters <= allowedRadiusMeters;
}
