import 'package:flutter/material.dart';

class CustemDropdown extends StatelessWidget {
  const CustemDropdown({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 60,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton<int>(
          value: value,
          onChanged: (int? newValue) {
            if (newValue != null) {
              // Only update the state if the value is different
              if (newValue != value) {
                onChanged(newValue);
              }
            }
          },
          items: [
            DropdownMenuItem<int>(
              value: 0,
              child: Text(
                'LKR',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 76, 76, 76),
                ),
              ),
            ),
            DropdownMenuItem<int>(
              value: 1,
              child: Text(
                'USD',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 76, 76, 76),
                ),
              ),
            ),
          ],
          style: const TextStyle(
            color: Colors.black,
          ),
          underline: SizedBox.shrink(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        ),
      ),
    );
  }
}
