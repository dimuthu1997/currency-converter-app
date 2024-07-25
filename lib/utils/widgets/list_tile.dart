import 'package:currency_converter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/utils/widgets/dropdown.dart';

class ConverterTile extends StatelessWidget {
  final ConverterTileModel model;
  final Map<String, double> conversionRates;
  final Function(String) onDelete;
  final Function(String, String) onDropdownChanged;

  const ConverterTile({
    required this.model,
    required this.conversionRates,
    required this.onDelete,
    required this.onDropdownChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(model.id),
      title: Text(
        model.result,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 20,
            ),
            onPressed: () => onDelete(model.id),
          ),
          DropdownRow(
            value: model.dropdownValue,
            currencies: conversionRates,
            onChanged: (String? newValue) {
              onDropdownChanged(model.id, newValue!);
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide.none,
      ),
      tileColor: const Color(0xff262425),
    );
  }
}
