const String tableEntradas = 'Entradas';

class EntradasFields {
  static const List<String> values = [id, origin, value, dateTime, isFixed];

  static const String id = '_id';
  static const String origin = 'origin';
  static const String value = 'value';
  static const String dateTime = 'dateTime';
  static const String isFixed = 'isFixed';
}

class Entrada {
  int? id;
  String origin;
  double value;
  final DateTime dateTime;
  final bool isFixed;

  Entrada({
    this.id,
    required this.origin,
    required this.value,
    required this.dateTime,
    required this.isFixed,
  });

  Map<String, Object?> toJson() => {
        EntradasFields.id: id,
        EntradasFields.origin: origin,
        EntradasFields.value: value,
        EntradasFields.dateTime: dateTime.millisecondsSinceEpoch,
        EntradasFields.isFixed: isFixed ? 1 : 0
      };

  Entrada copy({
    int? id,
    String? origin,
    double? value,
    DateTime? dateTime,
    bool? isFixed,
  }) =>
      Entrada(
        id: id ?? this.id,
        origin: origin ?? this.origin,
        value: value ?? this.value,
        dateTime: dateTime ?? this.dateTime,
        isFixed: isFixed ?? this.isFixed,
      );

  static Entrada fromJson(Map<String, Object?> json) => Entrada(
        id: json[EntradasFields.id] as int?,
        origin: json[EntradasFields.origin] as String,
        value: json[EntradasFields.value] as double,
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            json[EntradasFields.dateTime] as int),
        isFixed: json[EntradasFields.isFixed] == 1,
      );
}
