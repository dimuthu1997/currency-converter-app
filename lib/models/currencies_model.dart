class CurrencyData {
  final String? success;
  final String? documentation;
  final String? termsOfUse;
  final int? timeLastUpdateUnix;
  final String? timeLastUpdateUtc;
  final int? timeNextUpdateUnix;
  final String? timeNextUpdateUtc;
  final String? baseCode;
  final Map<String, double>? conversionRates;

  CurrencyData({
    this.success,
    this.documentation,
    this.termsOfUse,
    this.timeLastUpdateUnix,
    this.timeLastUpdateUtc,
    this.timeNextUpdateUnix,
    this.timeNextUpdateUtc,
    this.baseCode,
    this.conversionRates,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      success: json['success'],
      documentation: json['documentation'],
      termsOfUse: json['terms_of_use'],
      timeLastUpdateUnix: json['time_last_update_unix'],
      timeLastUpdateUtc: json['time_last_update_utc'],
      timeNextUpdateUnix: json['time_next_update_unix'],
      timeNextUpdateUtc: json['time_next_update_utc'],
      baseCode: json['base_code'],
      conversionRates: (json['conversion_rates'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toDouble()),
      ),
    );
  }
}
