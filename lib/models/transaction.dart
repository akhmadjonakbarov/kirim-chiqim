// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  String id;
  String personid;
  double quantity;
  bool kc; // kc = false kirim bo'ladi
  DateTime dateTime;
  Transaction({
    required this.id,
    required this.personid,
    required this.quantity,
    required this.kc,
    required this.dateTime,
  });

  Transaction copyWith({
    String? id,
    String? personid,
    double? quantity,
    bool? kc,
    DateTime? dateTime,
  }) {
    return Transaction(
      id: id ?? this.id,
      personid: personid ?? this.personid,
      quantity: quantity ?? this.quantity,
      kc: kc ?? this.kc,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personid': personid,
      'quantity': quantity,
      'kc': kc,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      personid: map['personid'] as String,
      quantity: map['quantity'] as double,
      kc: map['kc'] as bool,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, personid: $personid, quantity: $quantity, kc: $kc, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personid == personid &&
        other.quantity == quantity &&
        other.kc == kc &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personid.hashCode ^
        quantity.hashCode ^
        kc.hashCode ^
        dateTime.hashCode;
  }
}
