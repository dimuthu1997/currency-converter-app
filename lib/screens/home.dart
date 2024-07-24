import 'package:currency_converter/models/currencies_model.dart';
import 'package:currency_converter/services/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  CurrencyData? currenciesModel;
  bool isLoading = true;
  String? errorMessage;
  bool isDropdownOpen = false;
  List<Widget> listTiles = [];
  Map<String, double> conversionRates = {};

  final CurrencyService _currencyService = CurrencyService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => isLoading = true);
    try {
      final currencyData = await _currencyService.getCurrencyData();
      Logger().d('Currency data fetched successfully: $currencyData');
      setState(() {
        currenciesModel = CurrencyData.fromJson(currencyData);
        conversionRates =
            Map.fromEntries(currenciesModel!.conversionRates!.entries);
        isLoading = false;
        _addListTiles();
      });
    } catch (e) {
      Logger().e('Error fetching currency data: $e');
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _addListTiles() {
    listTiles.clear();
    for (final code in conversionRates.keys) {
      ListTile newListTile = ListTile(
        title: Text(
          code,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = true;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.white,
                child: Text(
                  currenciesModel?.baseCode ?? "",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xff262425),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                code,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide.none,
        ),
        tileColor: const Color(0xff262425),
      );

      setState(() {
        listTiles.add(newListTile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Exchanger'),
          leading: const Icon(Icons.arrow_back),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "INSERT AMOUNT :",
                style: TextStyle(
                  color: Color(0xff4d4d4d),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4.0),
              TextFormField(
                key: formFieldKey,
                controller: amountController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  filled: true,
                  fillColor: const Color(0xff262425),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        currenciesModel?.baseCode ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40.0),
              const Text(
                "CONVERT TO :",
                style: TextStyle(
                  color: Color(0xff4d4d4d),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4.0),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listTiles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listTiles[index],
                        const SizedBox(height: 4.0),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15.0);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _addListTiles();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff34402c),
                    foregroundColor: const Color(0xff547b3a),
                  ),
                  child: const Text(
                    "+ADD CONVERTER",
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
