import 'package:coaching/bottom_sheet.dart';
import 'package:coaching/training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingSession {
  final String id;
  final String storeName;
  final String address;
  final String company;
  final String person;
  final DateTime date;
  final List<String> imageUrls;
  final String? status; // Optional status field

  TrainingSession({
    required this.id,
    required this.storeName,
    required this.address,
    required this.company,
    required this.person,
    required this.date,
    required this.imageUrls,
    this.status, // Optional field for status
  });
}

class TrainingSessionList extends StatelessWidget {
  final TrainingController _controller = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HUẤN LUYỆN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Get.bottomSheet(
                DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.6,
                  minChildSize: 0.3,
                  maxChildSize: 1.0,
                  builder: (context, scrollController) {
                    return MyBtmSheet(scrollController: scrollController);
                  },
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isScrollControlled: true,
              );
            },
            color: Colors.black,
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.trainingSessions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: _controller.trainingSessions.length,
          itemBuilder: (context, index) {
            var session = _controller.trainingSessions[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.5, vertical: 4),
              child: Card(
                color: const Color.fromARGB(255, 238, 232, 216),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wrap all elements except the image grid with Padding
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8), // Padding for the non-image content
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${session.id} - ${session.storeName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (session.status !=
                                  null) // Show status only if it is not null
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red, // Badge color
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    session.status!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            session.address,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                session.company,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                session.person,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Ngày giờ',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '${session.date.day}.${session.date.month}.${session.date.year}, ${session.date.hour}:${session.date.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Dynamic Image Display (no padding inheritance here)
                    if (session.imageUrls.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(
                            3), // Independent padding for image grid
                        child: _buildImageGrid(session.imageUrls),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildImageGrid(List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return const SizedBox
          .shrink(); // Don't show anything if there are no images
    }

    if (imageUrls.length == 1) {
      // Case 1: Show 1 image in a full row
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          imageUrls[0],
          fit: BoxFit.cover,
          width: double.infinity,
          height: 160, // Full space for single image
        ),
      );
    } else if (imageUrls.length == 2) {
      // Case 2: 2 images, equally split in the first row with more space between them
      return Row(
        children: imageUrls
            .take(2)
            .map((url) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0), // Increased horizontal padding
                    child: AspectRatio(
                      aspectRatio:
                          1.5, // Slightly reduced aspect ratio for more space
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
    } else if (imageUrls.length == 3) {
      // Case 3: First row 1 image, second row 2 images
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: AspectRatio(
              aspectRatio: 343 / 140, // Full width for the first image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imageUrls[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: imageUrls
                .skip(1)
                .take(2)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio:
                              169.5 / 110, // Split two images in second row
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    } else if (imageUrls.length == 4) {
      // Case 4: Both rows with 2 images
      return Column(
        children: [
          Row(
            children: imageUrls
                .take(2)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 169.5 / 140, // First row, 2 images split
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: imageUrls
                .skip(2)
                .take(2)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio:
                              169.5 / 140, // Second row, 2 images split
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    } else if (imageUrls.length == 5) {
      // Case 5: First row with 2 images, second row with 3 images
      return Column(
        children: [
          Row(
            children: imageUrls
                .take(2)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 169.5 / 140, // First row with 2 images
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: imageUrls
                .skip(2)
                .take(3)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 113 / 100, // Second row with 3 images
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    } else {
      // Case 6: Default to handling more than 5 images with a grid
      return Column(
        children: [
          Row(
            children: imageUrls
                .take(2)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 169.5 / 140, // First row, 2 images
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: imageUrls
                .skip(2)
                .take(3)
                .map((url) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AspectRatio(
                          aspectRatio: 113 / 100, // Second row, 3 images
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }
  }
}
