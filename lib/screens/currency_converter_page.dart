import 'package:currency_converter/utils/utils.dart';
import 'package:currency_converter/utils/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/models/currencies_model.dart';
import 'package:currency_converter/services/services/currency_service.dart';
import 'package:currency_converter/utils/widgets/dropdown.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey<FormFieldState>();
  final CurrencyService _currencyService = CurrencyService();
  final List<ConverterTileModel> _listTiles = [];
  final Map<String, double> _conversionRates = {};
  String dropdownValue1 = 'USD';
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  CurrencyData? _currenciesModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _loadSavedCurrencies();
  }

  Future<void> _fetchData() async {
    try {
      final currencyData = await _currencyService.getCurrencyData();
      Logger().d('Currency data fetched successfully: $currencyData');
      setState(() {
        _currenciesModel = CurrencyData.fromJson(currencyData);
        _conversionRates.addAll(_currenciesModel!.conversionRates!);
        if (_listTiles.isEmpty) {
          _addConverter();
        }
      });
    } catch (e) {
      Logger().e('Error fetching currency data: $e');
      setState(() {});
    }
  }

  Future<void> _loadSavedCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTiles = prefs.getStringList('converterTiles') ?? [];
    setState(() {
      _listTiles.addAll(savedTiles.map((tile) =>
          ConverterTileModel.fromJson(Map<String, dynamic>.from(tile as Map))));
    });
  }

  Future<void> _saveCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final tilesJson = _listTiles.map((tile) => tile.toJson()).toList();
    await prefs.setStringList('converterTiles', tilesJson.cast<String>());
  }

  void _addConverter() {
    setState(() {
      _listTiles.add(
          ConverterTileModel(id: UniqueKey().toString(), dropdownValue: 'IDR'));
      _saveCurrencies();
    });
  }

  void _deleteConverter(String id) {
    setState(() {
      _listTiles.removeWhere((tile) => tile.id == id);
      _saveCurrencies();
    });
  }

  void _convertCurrency(ConverterTileModel model) {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    double rate = _conversionRates[model.dropdownValue] ?? 0.0;
    setState(() {
      model.result = (amount * rate).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Advanced Exchanger'),
          leading: const Icon(Icons.arrow_back),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
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
                key: _formFieldKey,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  for (var tile in _listTiles) {
                    _convertCurrency(tile);
                  }
                },
                cursorColor: Colors.white,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: '00.00',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 23.0),
                    child: DropdownRow(
                      value: dropdownValue1,
                      currencies: _conversionRates,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                          for (var tile in _listTiles) {
                            _convertCurrency(tile);
                          }
                          _saveCurrencies();
                        });
                      },
                    ),
                  ),
                ),
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
                  itemCount: _listTiles.length,
                  itemBuilder: (context, index) => ConverterTile(
                    model: _listTiles[index],
                    conversionRates: _conversionRates,
                    onDelete: _deleteConverter,
                    onDropdownChanged: (id, newValue) {
                      _listTiles[index].dropdownValue = newValue;
                      _convertCurrency(_listTiles[index]);
                      _saveCurrencies();
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15.0),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: _addConverter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff34402c),
                    foregroundColor: const Color(0xff547b3a),
                  ),
                  child: const Text("+ADD CONVERTER"),
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
