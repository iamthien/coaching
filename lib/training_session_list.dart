import 'package:coaching/training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              // Handle filter action
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
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
              child: Card(
                color: const Color.fromARGB(255, 238, 232, 216),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Padding only for text
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${session.id} - ${session.storeName}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                          const SizedBox(
                              height: 2), // 2px padding before the images
                        ],
                      ),
                    ),
                    // Dynamic Image Display - 3px padding applied here
                    if (session.imageUrls.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(
                            3.0), // 3px padding around the grid
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
    if (imageUrls.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imageUrls[0],
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
      );
    } else if (imageUrls.length == 2) {
      return Row(
        children: imageUrls
            .map((url) => Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(2.0), // 2px padding between images
                    child: AspectRatio(
                      aspectRatio: 1, // Square images
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
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
      return Row(
        children: imageUrls
            .map((url) => Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(2.0), // 2px padding between images
                    child: AspectRatio(
                      aspectRatio: 1, // Square images
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
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
    } else if (imageUrls.length == 4) {
      return Column(
        children: [
          Row(
            children:
                imageUrls.take(2).map((url) => _buildGridImage(url)).toList(),
          ),
          Row(
            children: imageUrls
                .skip(2)
                .take(2)
                .map((url) => _buildGridImage(url))
                .toList(),
          ),
        ],
      );
    } else if (imageUrls.length == 5) {
      return Column(
        children: [
          Row(
            children:
                imageUrls.take(2).map((url) => _buildGridImage(url)).toList(),
          ),
          Row(
            children: imageUrls
                .skip(2)
                .take(3)
                .map((url) => _buildGridImage(url))
                .toList(),
          ),
        ],
      );
    } else if (imageUrls.length == 6) {
      return Column(
        children: [
          Row(
            children:
                imageUrls.take(3).map((url) => _buildGridImage(url)).toList(),
          ),
          Row(
            children: imageUrls
                .skip(3)
                .take(3)
                .map((url) => _buildGridImage(url))
                .toList(),
          ),
        ],
      );
    }

    return SizedBox.shrink(); // Fallback for 0 images or any other case
  }

  Widget _buildGridImage(String url) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0), // 2px padding between images
        child: AspectRatio(
          aspectRatio: 1, // Square images
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
