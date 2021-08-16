import 'dart:convert';
import 'package:dsc_shop/model/items.dart';
import 'package:dsc_shop/model/products.dart';
import 'package:dsc_shop/screens/Product_details.dart';
import 'package:dsc_shop/tools/Theme.dart';
import 'package:dsc_shop/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Prodaucts>> getData() async {
    String url = "http://fakestoreapi.com/products/";
    var jsonData = await http.get(Uri.parse(url));
    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Prodaucts> allUsers = [];

      for (var j in data) {
        Prodaucts prodaucts = Prodaucts.fromJason(j);
        allUsers.add(prodaucts);
      }
      return allUsers;
    } else {
      throw Exception("error");
    }
  }

  Future<List<Prodaucts>> users;
  @override
  void initState() {
    super.initState();
    users = getData();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChenger basket = Provider.of<ThemeChenger>(context);
    return Scaffold(
      body: FutureBuilder<List<Prodaucts>>(
        future: users,
        builder: (ctx, snapShout) {
          if (snapShout.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapShout.data.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          id: snapShout.data[i].id,
                          title: snapShout.data[i].title,
                          category: snapShout.data[i].category,
                          description: snapShout.data[i].description,
                          imageUrl: snapShout.data[i].imageUrl,
                          price: snapShout.data[i].price,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shadowColor: Tools.mainColor,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(snapShout.data[i].imageUrl),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              snapShout.data[i].title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ج.م ${snapShout.data[i].price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Tools.mainColor,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Tools.mainColor,
                                    ),
                                    onPressed: () {
                                      basket.addCountFav();
                                      ItemModel itemModel = new ItemModel(
                                        id: snapShout.data[i].id,
                                        category: snapShout.data[i].category,
                                        imageUrl: snapShout.data[i].imageUrl,
                                        description:
                                            snapShout.data[i].description,
                                        price: snapShout.data[i].price,
                                        title: snapShout.data[i].title,
                                      );
                                      basket.addItemsFav(itemModel);
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Tools.mainColor,
            ),
          );
        },
      ),
    );
  }
}
