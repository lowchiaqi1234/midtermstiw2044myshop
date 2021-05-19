import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/newproduct.dart';
import 'package:http/http.dart' as http;

void main() => runApp(ProductPage());

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double screenHeight, screenWidth;
  String _title = "Loading...";
  List _productList;
  @override
  void initState() {
    super.initState();
    _loadproduct();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('PRODUCT'),
        ),
        body: Center(
          child: Container(
              child: Column(
            children: [
              _productList == null
                  ? Flexible(child: Center(child: Text(_title)))
                  : Flexible(
                      child: Center(
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.9,
                              children:
                                  List.generate(_productList.length, (index) {
                                return Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                        child: SingleChildScrollView(
                                            child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenHeight / 6.5,
                                          width: screenWidth / 1.2,
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://lowtancqx.com/s270910/myshop/images/${_productList[index]['prid']}.png",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  new Transform.scale(
                                                      scale: 0.5,
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(
                                                        Icons.broken_image,
                                                        size: screenWidth / 3,
                                                      )),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                   "Product Name:",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Text( _productList[index]["prname"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .teal[900])),
                                              ),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                   "Product Type:",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Text( _productList[index]["prtype"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .teal[900])),
                                              ),
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                   "Price (RM):",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Text( _productList[index]["prprice"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .teal[900])),
                                              ),
                                            ]),
                  
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                   "Quantity:",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Text( _productList[index]["prqty"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .teal[900])),
                                              ),
                                            ])
                                      ],
                                    ))));
                              }))))
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _onAdd,
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }

  void _onAdd() {
    Navigator.push(
        context, MaterialPageRoute(builder: (contemt) => Newproduct()));
  }

  void _loadproduct() {
    http.post(
        Uri.parse("https://lowtancqx.com/s270910/myshop/php/loadproduct.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _title = "Sorry no product available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        setState(() {
          print(_productList);
        });
      }
    });
  }
}
