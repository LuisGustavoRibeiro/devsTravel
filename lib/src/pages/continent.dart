import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ContinentPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  TextStyle styles = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  void seeCityAction(context, continentIndex) {
    Navigator.pushNamed(context, '/listcity', arguments: continentIndex);
  }

  void cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(pageContext, '/city', arguments: cityData);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
          key: _scaffoldkey,
          appBar: CustomAppBar(
              scaffoldkey: _scaffoldkey,
              pageContext: context,
              title: 'Escolha um continente'),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: ListView.builder(
              itemCount: appdata.data.length,
              itemBuilder: (context, index) {
                // return Text('CONTINENTE: ${appdata.data[index]['name']}') ;
                var cities = [];
                for (var country in appdata.data[index]['countries']) {
                  cities.addAll(country['cities']);
                }
                return Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                                "${appdata.data[index]['name']} (${cities.length})",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Helvetica Neue')),
                          ),
                          FlatButton(
                            child: const Text(
                              'Ver cidades',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica Neue',
                                  color: Colors.grey),
                            ),
                            onPressed: () {
                              seeCityAction(context, index);
                            },
                          ),
                        ]),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cities.length,
                          itemBuilder: (cityContext, cityIndex) {
                            return CityBox(
                                data: cities[cityIndex],
                                onTap: (cityData) {
                                  cityBoxAction(context, cityData);
                                });
                          }),
                    )
                  ],
                );
              })),
    );
  }
}