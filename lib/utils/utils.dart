class ConverterTileModel {
  String id;
  String dropdownValue;
  String result;

  ConverterTileModel(
      {required this.id, required this.dropdownValue, this.result = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'dropdownValue': dropdownValue,
        'result': result,
      };

  static ConverterTileModel fromJson(Map<String, dynamic> json) {
    return ConverterTileModel(
      id: json['id'],
      dropdownValue: json['dropdownValue'],
      result: json['result'],
    );
  }
}
