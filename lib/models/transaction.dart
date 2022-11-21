// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  String id;
  String personId;
  num quantity;
  int isEntry; // kc = false kirim bo'ladi
  DateTime dateTime;
  Transaction({
    required this.id,
    required this.personId,
    required this.quantity,
    this.isEntry = 0,
    required this.dateTime,
  });

  Transaction copyWith({
    String? id,
    String? personId,
    num? quantity,
    int? isEntry,
    DateTime? dateTime,
  }) {
    return Transaction(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      quantity: quantity ?? this.quantity,
      isEntry: isEntry ?? this.isEntry,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personId': personId,
      'quantity': quantity,
      'isEntry': isEntry,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      personId: map['personId'] as String,
      quantity: map['quantity'] as num,
      isEntry: map['isEntry'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, personId: $personId, quantity: $quantity, isEntry: $isEntry, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personId == personId &&
        other.quantity == quantity &&
        other.isEntry == isEntry &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personId.hashCode ^
        quantity.hashCode ^
        isEntry.hashCode ^
        dateTime.hashCode;
  }
}
