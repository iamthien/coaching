import 'package:get/get.dart';
import 'training_session.dart';

class TrainingController extends GetxController {
  var trainingSessions =
      <TrainingSession>[].obs; // Reactive list of training sessions

  @override
  void onInit() {
    super.onInit();
    fetchTrainingSessions();
  }

  void fetchTrainingSessions() {
    var sessionData = [
      TrainingSession(
        id: '0000241016',
        storeName: 'Hiếu Thịnh',
        address: '23, Hớn Quản, Thị Trấn Tân Khai, Huyện Hớn Quản',
        company: 'Cty Thái Dương',
        person: 'Đào Duy Từ',
        date: DateTime(2023, 10, 5, 14, 0),
        imageUrls: [
          'assets/images/image1.png',
          'assets/images/image2.png'
        ], // Example with multiple images
      ),
      TrainingSession(
        id: '0000241017',
        storeName: 'Phương Nam',
        address: '12, Lê Lợi, Thị Trấn Bến Cát, Huyện Bến Cát',
        company: 'Cty Nam Phương',
        person: 'Nguyễn Văn A',
        date: DateTime(2023, 10, 7, 10, 0),
        imageUrls: [
          'assets/images/image3.jpg',
        ], // Only one image for this session
      ),
      TrainingSession(
        id: '0000241016',
        storeName: 'Hiếu Thịnh',
        address: '23, Hớn Quản, Thị Trấn Tân Khai, Huyện Hớn Quản',
        company: 'Cty Thái Dương',
        person: 'Đào Duy Từ',
        date: DateTime(2023, 10, 5, 14, 0),
        imageUrls: [
          'assets/images/image1.png',
          'assets/images/image2.png',
          'assets/images/image3.jpg',
          'assets/images/image4.jpg',
          'assets/images/image5.jpg'
        ], // Example with multiple images
      ),
      // Add more training sessions as needed...
    ];

    // Use assignAll to update the observable list
    trainingSessions.assignAll(sessionData);
  }
}
