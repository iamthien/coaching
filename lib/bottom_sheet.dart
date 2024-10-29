import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyBtmSheet extends StatefulWidget {
  final ScrollController scrollController;

  const MyBtmSheet({super.key, required this.scrollController});

  @override
  State<MyBtmSheet> createState() => _MyBtmSheetState();
}

class _MyBtmSheetState extends State<MyBtmSheet> {
  TextEditingController dateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String? selectedNPP;
  String? selectedUSM;
  String? selectedCustomer;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Lọc dữ liệu',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.refresh_sharp,
                  size: 25,
                  color: Color.fromARGB(255, 255, 156, 7),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Field
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Tìm kiếm',
                hintText: 'Táo',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),

            // Date Picker
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: // Date Picker TextField
                  TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Thời gian',
                  hintText: 'Chọn ngày',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
            const SizedBox(height: 20),

            // NPP Dropdown
            DropdownButtonFormField<String>(
              value: selectedNPP,
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
                setState(() {
                  selectedNPP = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // USM Dropdown
            DropdownButtonFormField<String>(
              value: selectedUSM,
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
                setState(() {
                  selectedUSM = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // Customer Name Dropdown
            DropdownButtonFormField<String>(
              value: selectedCustomer,
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
                setState(() {
                  selectedCustomer = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add search action here, check validation as needed
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Tìm kiếm',
                    style: TextStyle(color: Colors.white),
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
