import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  double dersHarfKredi = 4;
  int dersKredi = 1;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;
  @override
  void initState() {
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ortalama Hesapla'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
      ),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Statik Form tutan container
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'Ders Adı',
                        hintText: 'Ders adını girin',
                        hintStyle: TextStyle(fontSize: 18),
                        labelStyle:
                            TextStyle(fontSize: 22, color: Colors.purple),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else
                        return 'Ders adı boş bırakılamaz';
                    },
                    onSaved: (kaydedilenDeger) {
                      dersAdi = kaydedilenDeger;
                      setState(() {
                        tumDersler.add(Ders(dersAdi, dersHarfKredi, dersKredi));
                        ortalama = 0;
                        ortalamaHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: dersKredileriItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: dersHarfKrediItems(),
                            value: dersHarfKredi,
                            onChanged: (secilenHarfKredi) {
                              setState(() {
                                dersHarfKredi = secilenHarfKredi;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Colors.blue,
            height: 70,
            child: Center(
                child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: tumDersler.length == 0
                        ? 'Lütfen ders ekleyin'
                        : 'Ortalama : ',
                    style: TextStyle(fontSize: 30, color: Colors.black)),
                TextSpan(
                    text: tumDersler.length == 0
                        ? ''
                        : '${ortalama.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold)),
              ]),
            )),
          ),
          //Dinamik form tutan container
          Expanded(
            child: Container(
              color: Colors.white10,
              child: ListView.builder(
                itemBuilder: _listeElemanlariOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      var a = DropdownMenuItem<int>(
        value: i,
        child: Text(
          '$i Kredi',
          style: TextStyle(fontSize: 20),
        ),
      );
      krediler.add(a);
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfKrediItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(
      DropdownMenuItem(
          child: Text('AA', style: TextStyle(fontSize: 20)), value: 4),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('BA', style: TextStyle(fontSize: 20)), value: 3.5),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('BB', style: TextStyle(fontSize: 20)), value: 3),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('CB', style: TextStyle(fontSize: 20)), value: 2.5),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('CC', style: TextStyle(fontSize: 20)), value: 2),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('DC', style: TextStyle(fontSize: 20)), value: 1.5),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('DD', style: TextStyle(fontSize: 20)), value: 1),
    );
    harfler.add(
      DropdownMenuItem(
          child: Text('FF', style: TextStyle(fontSize: 20)), value: 0),
    );

    return harfler;
  }

  Widget _listeElemanlariOlustur(BuildContext context, int index) {
    sayac++;
    debugPrint(sayac.toString());
    return Dismissible(
      background: Container(
        margin: EdgeInsets.only(top: 4, bottom: 4, left: 4),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Card(
        elevation: 6,
        margin: EdgeInsets.only(top: 4, bottom: 4, right: 10),
        child: ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text(
            tumDersler[index].ad,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          subtitle: Text(
            tumDersler[index].kredi.toString() +
                ' Kredi Not değeri ' +
                tumDersler[index].harfDegeri.toString(),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oankiDers in tumDersler) {
      var krediDegeri = oankiDers.kredi;
      var harfDegeri = oankiDers.harfDegeri;
      toplamNot = toplamNot + (harfDegeri * krediDegeri);
      toplamKredi += krediDegeri;
    }
    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Ders(this.ad, this.harfDegeri, this.kredi);
}
