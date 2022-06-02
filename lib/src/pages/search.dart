import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  var list = [];
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  void doSearch(pageContext, text) async {
    var pageContext2 = pageContext;
    List newList = Provider.of<AppData>(pageContext2, listen: false)
        .searchCity(text);
    setState(() {
      list = newList;
    });
  }

/*
  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');
*/

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldkey,
        appBar: CustomAppBar(
            scaffoldkey: _scaffoldkey,
            pageContext: context,
            title: 'Busque uma cidade',
            hideSearch: true, ),
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Digite o nome de uma cidade',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search, size: 32),
                ),
                onChanged: (text) {
                  doSearch(context, text);
                },
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                /*shrinkWrap: true,*/
                /* physics: NeverScrollableScrollPhysics(),*/
                children: List.generate(list.length, (index) {
                  return CityBox(
                    data: list[index],
                    onTap: (cityData) {
                      var cityData2 = cityData;
                      Navigator.pushNamed(context, '/city',
                          arguments: cityData2);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}