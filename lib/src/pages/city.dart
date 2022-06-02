import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customdrawer.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPage createState() => _CityPage();
}

class _CityPage extends State<CityPage> {
  bool heart = false;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  TextStyle styles = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.black,
  );

  TextStyle stylesnamecityTextStyle = const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.black,
  );

  TextStyle stylesscorecityTextStyle = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.blue,
  );

  TextStyle stylesdescriptoncityTextStyle = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.grey,
  );

  TextStyle stylesprincipalpointturistcsTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.grey,
  );

  TextStyle stylesnameplaceTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.black,
  );

  TextStyle stylespointturistcs2TextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    var cityData = ModalRoute.of(context)?.settings.arguments as Map;

    void backButtonAction(pageContext) {
      Navigator.pop(pageContext);
    }

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final double footerBarHeight = MediaQuery.of(context).padding.bottom;

    var stars = [];

    var starRate = double.parse(cityData['review']).floor();

    for (var i = 0; i < 5; i++) {
      if (i < starRate) {
        stars.add(true);
      } else {
        stars.add(false);
      }
    }

    return Consumer<AppData>(builder: (ctx, appdata, child) {
      heart = appdata.hasFavorite(cityData['name']);
      return Scaffold(
        key: _scaffoldkey,
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Image.network(
                cityData['places'][0]['img'],
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 220),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    cityData['name'],
                                    style: stylesnamecityTextStyle,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color:
                                          stars[0] ? Colors.blue : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color:
                                          stars[1] ? Colors.blue : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color:
                                          stars[2] ? Colors.blue : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color:
                                          stars[3] ? Colors.blue : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color:
                                          stars[4] ? Colors.blue : Colors.grey,
                                      size: 16,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        cityData['review'],
                                        style: stylesscorecityTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: Icon(
                                  heart
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    heart = appdata.favorite(cityData['name']);
                                  });
                                },
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 0,
                          left: 15,
                          bottom: 10,
                          right: 15,
                        ),
                        child: Text(
                          cityData['description'],
                          style: stylesdescriptoncityTextStyle,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 15,
                        ),
                        child: Text(
                          'PRINCIPAIS PONTOS TURÍSTICOS',
                          style: stylesprincipalpointturistcsTextStyle,
                        ),
                      ),
                      GridView.count(
                        padding: EdgeInsets.only(
                            bottom:
                                footerBarHeight), // o GriView tem um padding por padrão, essa opção é para tirar o padding
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 10 / 11,
                        children: List.generate(
                          cityData['places'].length,
                          (index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          cityData['places'][index]['img'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      cityData['places'][index]['name'],
                                      style: stylesnameplaceTextStyle,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'Ponto Turístico',
                                      style: stylespointturistcs2TextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: statusBarHeight),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  backButtonAction(context);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

/*
  Container(
    height: 250,
    decoration: BoxDecoration(color: Colors.red),
  ),
*/

/*
Column(
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
])
*/