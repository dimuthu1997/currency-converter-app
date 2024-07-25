import 'package:flutter/material.dart';

class DropdownRow extends StatelessWidget {
  final String value;
  final Map currencies;
  final void Function(String?) onChanged;

  const DropdownRow({
    super.key,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(15),
            menuMaxHeight: 500.0,
            value: value,
            dropdownColor: const Color(0xff262425),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: Color(0xff4d4d4d),
            ),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            isExpanded: true,
            onChanged: onChanged,
            items: currencies.keys
                .toSet()
                .toList()
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  '$value - ${currencies[value]}',
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
