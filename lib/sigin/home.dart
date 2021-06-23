import 'package:flutter/material.dart';
import 'package:flutter_sqlite/ui/edit.dart';
import 'package:flutter_sqlite/sigin/entryform.dart';
import 'package:flutter_sqlite/models/contact.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//untuk memanggil fungsi yg terdapat di daftar pustaka sqflite
import 'dart:async';
//pendukung program asinkron

class HomeSigin extends StatefulWidget {
  @override
  HomeSiginState createState() => HomeSiginState();
}

class HomeSiginState extends State<HomeSigin> {
  final String url = "http://10.10.22.89/api/inputs";
  Future getInput() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://10.10.22.89/api/inputs/" + dataId;
    var response = await http.delete(Uri.parse(url));

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sigin Account'),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sigin()));
          }),
      body: FutureBuilder(
          future: getInput(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Card(
                            elevation: 8,
                            child: ListTile(
                              title: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditData(
                                                            input:
                                                                snapshot.data[
                                                                        'data']
                                                                    [index])));
                                          },
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              // yang ini diemin ya ini untuk hapus datanya
                                              // jadi index yang di ambil itu dari ID datanya misalkan ID 1 berarti data ke 1 yang di hapus
                                              deleteData(snapshot.data['data']
                                                          [index]['id']
                                                      .toString())
                                                  .then((value) {
                                                setState(() {});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Data sudah dihapus")));
                                              });
                                            }),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                             Text("Nama Pesanan : " +
                                                snapshot.data['data'][index]
                                                    ['nama_pesanan']),
                                            Text("Keterangan :" +
                                                snapshot.data['data'][index]
                                                    ['keterangan']),
                                            Text("Harga :" +
                                                snapshot.data['data'][index]
                                                    ['harga']),
                                            Text("Jumlah :" +
                                                snapshot.data['data'][index]
                                                    ['jumlah']),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )));
                  });
            } else {
              return Text("Error");
            }
          }),
    );
  }
}
