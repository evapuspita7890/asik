import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sqlite/ui/home.dart';
import 'package:http/http.dart' as http;

class EditData extends StatelessWidget {
  final Map input;
  EditData({@required this.input});
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  //membuat method POST untuk Upload data ke API
  Future updateKonten() async {
    // karena ingin mengedit data maka menggunakan method PUT maka perlu tambahan body karena di body API kita akan menambahkan data object yang sudah ditulis harus sama dengan yang ada di API
    // dan tambahan pada url yaitu upload ["id"] fungsinya untuk mengetahui id data ke berapa yang diedit pada API
    final response = await http.put(
        Uri.parse("http://10.10.22.89/api/inputs/" + input['id'].toString()),
        body: {
          "nama_pesanan": namaController.text,
          "keterangan": keteranganController.text,
          "harga": hargaController.text,
          "jumlah": jumlahController.text,
        });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.arrow_back),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: namaController..text = input['nama_pesanan'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Nama Sepatu",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: keteranganController..text = input['keterangan'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Warna",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: hargaController..text = input['harga'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Ukuran",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: jumlahController..text = input['jumlah'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Jumlah",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Update',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            updateKonten().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Batal',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
