import 'package:flutter/material.dart';

class PaymentOptionTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;
  final String selectedPayment;
  final Function(String) onChanged;

  const PaymentOptionTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.value,
    required this.selectedPayment,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedPayment;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 255, 255, 255)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 0, 26, 255)
                : Colors.grey[300]!,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
              activeColor: const Color.fromARGB(255, 0, 102, 255),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Image.asset(iconPath, height: 30),
          ],
        ),
      ),
    );
  }
}
