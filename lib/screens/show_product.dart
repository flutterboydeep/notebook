import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebook/bloc/ecom_bloc.dart';
import 'package:notebook/data/favitemList.dart';
import 'package:notebook/utils/DataViewCart.dart';
import 'package:notebook/utils/bottom_card.dart';

import '../data/shope_by_category.dart';

class ShowProduct extends StatefulWidget {
  final List productData;
  const ShowProduct({super.key, required this.productData});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  double allDiscountMrp = 0.0;
  double allMrp = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff1A95BE),
        ),
        title: const Center(
            child: Text(
          'Your notebook',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff1A95BE),
            fontWeight: FontWeight.w500,
          ),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      color: Color(0xff1A95BE),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Choose your location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff1A95BE),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.tune_outlined),
                        onPressed: () {},
                      ),
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                      labelText: 'Search for notebook,pencil,gift,calculator',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xff1A95BE),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xff1A95BE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7),
                    itemCount: widget.productData.length,
                    itemBuilder: (context, index) {
                      double mrp = widget.productData[index]['Mrp'];
                      double discountMrp =
                          (widget.productData[index]['discountMrp']);

                      int percentOff =
                          (((mrp - discountMrp) * 100) / mrp).toInt();

                      bool isInStock = widget.productData[index]['isInStock'];

                      // log(discountMrp.runtimeType.toString());
                      // if (favItemList.isNotEmpty) {
                      //   for (int i = 0; i < favItemList.length; i++) {
                      //     allDiscountMrp +=
                      //         favItemList[i]['discountMrp'].toDouble;
                      //   }
                      // }

                      // allDiscountMrp = favItemList.where((element) => element==widget.productData[index]) + allDiscountMrp;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                height: 150,
                                color: Color.fromARGB(255, 204, 204, 204),
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: widget.productData[index]['image'],
                                  imageBuilder: (context, imageProvider) =>
                                      InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: imageProvider,
                                            colorFilter: ColorFilter.mode(
                                                Colors.blue.shade100,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                            // child: Image(
                            //     image: NetworkImage(
                            //         shopeByCategory[index]['image'])),

                            Text(
                              widget.productData[index]['title'].toString(),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Rs $mrp  ',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 8,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rs $discountMrp ',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff1A95BE),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '(${percentOff}% off)',
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            BlocBuilder<EcomBloc, EcomState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 33),
                                      maximumSize: Size(double.infinity, 35),
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: isInStock
                                          ? Color(0xff1A95BE)
                                          : Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11))),
                                  onPressed: () {
                                    if (state.favItemList
                                        .contains(widget.productData[index])) {
                                    } else {
                                      if (isInStock) {
                                        var data = widget.productData[index];

                                        addProductDataInCart(context, data);
                                        // or
                                        // double totalProdutAllMrp =
                                        //     state.favItemList.fold(
                                        //         0,
                                        //         (sum, item) =>
                                        //             sum + item['Mrp']);

                                        // log("This is totalProduct Mrp $totalProdutAllMrp");
                                        // log("this is product mrp ${allMrp}");
                                        // log("this is first product mrp ${data['Mrp']}");
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Sorry! currently this item is not available")));
                                      }
                                    }
                                  },
                                  // child: favItemList[index]['id'],
                                  // child: favItemList[index]['id'] ==
                                  //             widget.productData[index]["id"] &&
                                  //         favItemList.isNotEmpty
                                  child: state.favItemList
                                          .contains(widget.productData[index])
                                      ? Align(
                                          alignment: Alignment.topCenter,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  var data =
                                                      widget.productData[index];
                                                  removeProductDataInCart(
                                                      context, data);
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              BlocBuilder<EcomBloc, EcomState>(
                                                builder: (context, state) {
                                                  int productCountInList =
                                                      state.favItemList
                                                          .where(
                                                            (element) =>
                                                                element ==
                                                                widget.productData[
                                                                    index],
                                                          )
                                                          .length;
                                                  return Text(
                                                    productCountInList
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  );
                                                },
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  var data =
                                                      widget.productData[index];
                                                  addProductDataInCart(
                                                      context, data);

                                                  // allDiscountMrp =
                                                  //     allDiscountMrp +
                                                  //         widget.productData[
                                                  //                 index]
                                                  //             ['discountMrp'];

                                                  // allMrp = allMrp +
                                                  //     widget.productData[index]
                                                  //         ['Mrp'];
                                                  // // final data =
                                                  // //     widget.productData[index]
                                                  // //             ['discountMrp'] +
                                                  // //         allDiscountMrp;
                                                  // favItemList.add(widget
                                                  //     .productData[index]);

                                                  // BlocProvider.of<
                                                  //         EcomBloc>(context)
                                                  //     .add(FavItemEvent(
                                                  //         totalItems:
                                                  //             favItemList
                                                  //                 .length,
                                                  //         mrp: allMrp,
                                                  //         discountPrice:
                                                  //             allDiscountMrp,
                                                  //         favItemList:
                                                  //             favItemList));

                                                  // setState(() {});
                                                  // log("your add item is ${widget.productData[index]['discountMrp']}");
                                                  // log("add item suceesfully ${allDiscountMrp.toString()}");
                                                  // favItemList.add(value)
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                // child: Text(
                                                //   "+",
                                                //   style: TextStyle(
                                                //       fontSize: 18,
                                                //       color: Colors.white),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          isInStock
                                              ? "Add to Cart"
                                              : "Out of Stock",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<EcomBloc, EcomState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: state.favItemList.isNotEmpty ? 40 : 0,
                    );
                  },
                ),
              ],
            ),
          ),
          bottomCardView(context,
              MRP: allMrp.toStringAsFixed(1),
              discountMrp: allDiscountMrp.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
