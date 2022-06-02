import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ListCityPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  TextStyle styles = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  ListCityPage({Key? key}) : super(key: key);

  void cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(pageContext, '/city', arguments: cityData);
  }

  @override
  Widget build(BuildContext context) {
    final continentIndex = ModalRoute.of(context)?.settings.arguments as int;

    return Consumer<AppData>(builder: (ctx, appdata, child) {
      var cities = [];
      for (var country in appdata.data[continentIndex]['countries']) {
        cities.addAll(country['cities']);
      }
      return Scaffold(
          key: _scaffoldkey,
          appBar: CustomAppBar(
              scaffoldkey: _scaffoldkey,
              pageContext: context,
              title:
                  "${appdata.data[continentIndex]['name']} (${cities.length} cidades)",
              showBack: true),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: GridView.count(
              crossAxisCount: 3,
              children: List.generate(cities.length, (index) {
                return CityBox(
                  data: cities[index],
                  onTap: (cityData) {
                    cityBoxAction(context, cityData);
                  },
                );
              })));
    });
  }
}

/*
Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text('Bem vindo(a) ao', style: styles),
      ),
      Image.asset('lib/assets/flutter1_devstravel_logo.png',
          width: 200),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Text('Seu guia de viagem perfeito', style: styles),
      )
    ]))
*/