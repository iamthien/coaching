class TrainingSession {
  final String id;
  final String storeName;
  final String address;
  final String company;
  final String person;
  final DateTime date;
  final List<String> imageUrls;

  TrainingSession({
    required this.id,
    required this.storeName,
    required this.address,
    required this.company,
    required this.person,
    required this.date,
    required this.imageUrls,
  });
}
