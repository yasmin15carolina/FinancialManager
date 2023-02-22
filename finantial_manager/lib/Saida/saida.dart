const String tableSaidas = 'Saidas';

class SaidasFields {
  static const List<String> values = [id, reason, value, dateTime, isFixed];

  static const String id = '_id';
  static const String reason = 'reason';
  static const String value = 'value';
  static const String dateTime = 'dateTime';
  static const String isFixed = 'isFixed';
}

class Saida {
  int? id;
  String reason;
  double value;
  DateTime dateTime;
  final bool isFixed;

  Saida({
    this.id,
    required this.reason,
    required this.value,
    required this.dateTime,
    required this.isFixed,
  });

  Map<String, Object?> toJson() => {
        SaidasFields.id: id,
        SaidasFields.reason: reason,
        SaidasFields.value: value,
        SaidasFields.dateTime: dateTime.millisecondsSinceEpoch,
        SaidasFields.isFixed: isFixed ? 1 : 0
      };

  Saida copy({
    int? id,
    String? reason,
    double? value,
    DateTime? dateTime,
    bool? isFixed,
  }) =>
      Saida(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        value: value ?? this.value,
        dateTime: dateTime ?? this.dateTime,
        isFixed: isFixed ?? this.isFixed,
      );

  static Saida fromJson(Map<String, Object?> json) => Saida(
        id: json[SaidasFields.id] as int?,
        reason: json[SaidasFields.reason] as String,
        value: json[SaidasFields.value] as double,
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            json[SaidasFields.dateTime] as int),
        isFixed: json[SaidasFields.isFixed] == 1,
      );
}
