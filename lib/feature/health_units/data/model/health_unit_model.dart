class HealthUnitModel {
  final int id;
  final String name;
  final String area;
  final String address;
  final List<String> services;
  final String phone;
  final String hours;
  final String days;
  final String distance;
  final String illustration;
  final bool free;
  final int staff;
  final double rating;
  final String description;
  final List<String> vaccinations;
  final List<String> facilities;

  HealthUnitModel({
    required this.id,
    required this.name,
    required this.area,
    required this.address,
    required this.services,
    required this.phone,
    required this.hours,
    required this.days,
    required this.distance,
    required this.illustration,
    required this.free,
    required this.staff,
    required this.rating,
    required this.description,
    required this.vaccinations,
    required this.facilities,
  });
}

class VaccinationItem {
  final String age;
  final List<String> vaccines;

  VaccinationItem({
    required this.age,
    required this.vaccines,
  });
}
