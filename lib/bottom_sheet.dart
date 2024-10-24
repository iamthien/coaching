import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBtmSheet extends StatefulWidget {
  final ScrollController scrollController;

  const MyBtmSheet({super.key, required this.scrollController});

  @override
  State<MyBtmSheet> createState() => _MyBtmSheetState();
}

class _MyBtmSheetState extends State<MyBtmSheet> {
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.month}.${pickedDate.day}.${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController, // Use scrollController for scrolling
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 60,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Space text and icon apart
                children: [
                  Text(
                    'Lọc dữ liệu',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.refresh_sharp,
                    size: 25,
                    color: Color.fromARGB(255, 255, 156, 7),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm',
                hintText: 'Táo',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),

            // Date Picker
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Thời gian',
                  hintText: 'Chọn ngày',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(height: 20),

            // NPP Dropdown
            DropdownButtonFormField<String>(
              value: '200000092 - Kiều My',
              decoration: const InputDecoration(
                labelText: 'NPP',
                border: OutlineInputBorder(),
              ),
              items: ['200000092 - Kiều My', 'Other NPP'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle change here
              },
            ),
            const SizedBox(height: 20),

            // USM Dropdown
            DropdownButtonFormField<String>(
              value: 'Đào Duy Từ',
              decoration: const InputDecoration(
                labelText: 'USM',
                border: OutlineInputBorder(),
              ),
              items: ['Đào Duy Từ', 'Other USM'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle change here
              },
            ),
            const SizedBox(height: 20),

            // Customer Name Dropdown
            DropdownButtonFormField<String>(
              value: 'Chị Phượng',
              decoration: const InputDecoration(
                labelText: 'Tên khách hàng',
                border: OutlineInputBorder(),
              ),
              items: ['Chị Phượng', 'Other Customer'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle change here
              },
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 'Đóng' Button with border
                OutlinedButton(
                  onPressed: () {
                    Get.back(); // Close the bottom sheet
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0), // Button padding
                    side: const BorderSide(color: Colors.grey), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0)), // Text color
                  ),
                ),

                // 'Tìm kiếm' Button with filled background
                ElevatedButton(
                  onPressed: () {
                    // Add search action here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0), // Button padding
                    backgroundColor: Colors.green, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Tìm kiếm',
                    style: TextStyle(color: Colors.white), // Set text color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
