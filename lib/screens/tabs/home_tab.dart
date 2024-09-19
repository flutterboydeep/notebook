import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:notebook/data/bener_list.dart';
import 'package:notebook/data/productDetailsMap.dart';
import 'package:notebook/data/shope_by_category.dart';
import 'package:notebook/screens/show_product.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CarouselSliderController carouselController = CarouselSliderController();
  PersistentBottomSheetController? _bottomSheetController;
  int bannerCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                Container(
                  height: 150,
                  width: double.infinity,
                  // color: Colors.blueAccent,
                  child: CarouselSlider(
                    carouselController: carouselController,
                    items: bannerList.map((image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.blue.shade100,
                                        BlendMode.colorBurn)),
                              ),
                            );
                          },
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          bannerCurrentIndex = index;
                        });
                      },
                    ),
                  ),
                  // child: Center(
                  //   child: Text(
                  //     'Product Banner',
                  //     style: TextStyle(color: Colors.white, fontSize: 24),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 15,
                  width: double.infinity,
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: bannerList.length,
                        itemBuilder: (context, index) {
                          // if(index==bannerCurrentIndex){

                          // }
                          // var selectedIndex=carouselController.
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: AnimatedContainer(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: bannerCurrentIndex == index
                                      ? Color(0xff1A95BE)
                                      : Color.fromARGB(255, 181, 181, 181)),
                              duration: Duration(milliseconds: 500),
                              height: 15,
                              width: bannerCurrentIndex == index ? 30 : 10,
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Shope by Category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: shopeByCategory.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 134, 187, 227),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 40, top: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: shopeByCategory[index]['image'],
                                  imageBuilder: (context, imageProvider) =>
                                      InkWell(
                                    onTap: () {
                                      var productName =
                                          shopeByCategory[index]['title'];
                                      List productList =
                                          productDetailsMap[productName];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ShowProduct(
                                                  productData: productList)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
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
                            Positioned(
                              bottom: 20,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  shopeByCategory[index]['title'].toString(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  shopeByCategory[index]['discount'].toString(),
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 20,
                                color: Color(0xff1A95BE),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
