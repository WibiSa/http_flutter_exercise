import 'package:flutter/material.dart';
import 'package:http_flutter_exercise/transaksi_model.dart';
import 'package:http/http.dart' as http;

//Mencoba API Bola route checkout untuk transaksi melalui midtrans.
class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  //inisialisasi object Transaksi.
  Transaksi _transaksi;

  bool _loading = false;

  //variabel-variabel dummy untuk mengisi data object Transaksi.
  final String nama = 'anas';
  final String email = 'anas@anas.com';
  final String namaLap = 'city futsal';
  final String bokingKode = 'fb221220202';
  final String total = '20000';
  final String quantity = '1';
  final String status = 'boking';

  //Fungsi untuk post data transaksi ke API bola dengan mengembalikan data Transaksinya.
  Future<Transaksi> checkout(String nama, String email, String namaLap,
      String bokingKode, String total, String quantity, String status) async {
    setState(() {
      _loading = true;
    });

    final String apiUrl =
        'https://thawing-taiga-77412.herokuapp.com/public/api/checkout';

    final response = await http.post(apiUrl, body: {
      "nama_lapangan": namaLap,
      "boking_kode": bokingKode,
      "total": total,
      "quantity": quantity,
      "nama_user": nama,
      "email_user": email,
      "status": status
    });

    if (response.statusCode == 201) {
      //jika berhasil
      final String responseString = response.body;
      setState(() {
        _loading = false;
      });
      return transaksiFromJson(responseString);
    } else {
      //jika gagal
      setState(() {
        _loading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Data yang akan di kirim ke API fbola/api/checkout'),
            SizedBox(height: 16),
            Text(nama),
            Text(email),
            Text(namaLap),
            Text(quantity),
            Text(total),
            Text(status),
            Text(bokingKode),
            SizedBox(height: 32),
            _loading
                ? CircularProgressIndicator()
                : _transaksi == null
                    ? Container()
                    : Text(
                        'Data yang telah dibuat pada: ${_transaksi.paymentUrl}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //implementasi fungsi checkout dan menyimpan nilai kembalian fungsi tersebut.
          final Transaksi transaksi = await checkout(
              nama, email, namaLap, bokingKode, total, quantity, status);
          setState(() {
            _transaksi = transaksi;
          });
        },
        child: Icon(Icons.cloud_download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
