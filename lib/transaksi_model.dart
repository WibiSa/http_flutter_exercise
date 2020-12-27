// To parse this JSON data, do
//
//     final transaksi = transaksiFromJson(jsonString);

import 'dart:convert';

Transaksi transaksiFromJson(String str) => Transaksi.fromJson(json.decode(str));

String transaksiToJson(Transaksi data) => json.encode(data.toJson());

class Transaksi {
  Transaksi({
    this.id,
    this.namaLapangan,
    this.bokingKode,
    this.total,
    this.quantity,
    this.namaUser,
    this.emailUser,
    this.status,
    this.paymentUrl,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String namaLapangan;
  String bokingKode;
  int total;
  int quantity;
  String namaUser;
  String emailUser;
  String status;
  String paymentUrl;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        namaLapangan: json["nama_lapangan"],
        bokingKode: json["boking_kode"],
        total: json["total"],
        quantity: json["quantity"],
        namaUser: json["nama_user"],
        emailUser: json["email_user"],
        status: json["status"],
        paymentUrl: json["payment_url"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lapangan": namaLapangan,
        "boking_kode": bokingKode,
        "total": total,
        "quantity": quantity,
        "nama_user": namaUser,
        "email_user": emailUser,
        "status": status,
        "payment_url": paymentUrl,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
