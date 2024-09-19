import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebook/data/favitemList.dart';

import 'package:notebook/utils/DataViewCart.dart';

import '../bloc/ecom_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double allDiscountMrpWithCheckbox = 0.0;
  double allMrpWithCheckbox = 0.0;

  List containCheckBoxList = [];
  int count = 0;
  List<dynamic> checkboxListData = [];
  var delivery_charges = 0.0;
  var plateform_charges = 0.0;
  var grand_total = 0.0;
  // List<bool> isValueChecked = [true];
  // List newFavList = [];

  // updateList(context) async {
  //   await BlocListener<EcomBloc, EcomState>(listener: (context, state) {
  //     // newFavList = state.favItemList.toSet().toList();
  //     newFavList.add(favItemList.toSet());

  //     log("this is data list ");
  //   });
  //   log("this is data list  $newFavList");
  // }

  @override
  Widget build(BuildContext context) {
    // BlocListener<EcomBloc, EcomState>(listener: (context, state) {

    // log("this newFavList= $newFavList");
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1A95BE),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Cart',
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<EcomBloc, EcomState>(
        builder: (context, state) {
          var newFavList = state.favItemList.toSet().toList();
          if (count == 0) {
            containCheckBoxList = List.from(newFavList);

            checkboxListData = state.favItemList.fold([0.0, 0.0], (sub, item) {
              sub[0] += item['Mrp'];
              sub[1] += item['discountMrp'];
              return sub;
            });
            delivery_charges =
                containCheckBoxList.isEmpty || checkboxListData[1] >= 167.95
                    ? 0
                    : 29.00;
            plateform_charges = containCheckBoxList.isEmpty ? 0 : 4.00;
            grand_total = containCheckBoxList.isEmpty
                ? 0
                : checkboxListData[1] + delivery_charges + plateform_charges;

            count = 1;
          }

          // double data= newFavList.where((element) => containCheckBoxList.contains(element)) ?10.0:20.0;

          // var isAllDiscountMrpWithCheckbox = newFavList.where((element) {
          //   if (containCheckBoxList.contains(element)) {
          //     element['descountMrp'];
          //     // allDiscountMrpWithCheckbox =
          //     //     element['discountMrp'] + allDiscountMrpWithCheckbox;
          //     // log("this is element in containList $element");
          //     return true;
          //   } else {
          //     // allDiscountMrpWithCheckbox =
          //     //     allDiscountMrpWithCheckbox - element['discountMrp'];
          //     return false;
          //   }
          // }).toList();
          // print("${isAllDiscountMrpWithCheckbox}------------");
          return state.favItemList.isEmpty
              ? Center(
                  child: Text("No Item In cart ! Go Shoppings"),
                )
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: containCheckBoxList.length ==
                                        newFavList.length
                                    ? true
                                    : false,
                                onChanged: (newValue) {
                                  log("Checkbox change");
                                }),
                            Text(containCheckBoxList.length.toString()),
                            Text(
                                "/${newFavList.length.toString()} items selected "),
                            Text(
                              '(Rs grand_total )',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),

                        BlocBuilder<EcomBloc, EcomState>(
                          builder: (context, state) {
                            var newFavList = state.favItemList.toSet().toList();

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: newFavList.length,
                              itemBuilder: ((context, index) {
                                final String title = newFavList[index]['title'];
                                final double mrp = newFavList[index]['Mrp'];
                                final double discountMrp =
                                    (newFavList[index]['discountMrp']);
                                int percentOff =
                                    (((mrp - discountMrp) * 100) / mrp).toInt();
                                var produtCountInList = state.favItemList
                                    .where(
                                      (element) => element == newFavList[index],
                                    )
                                    .length;

                                delivery_charges =
                                    containCheckBoxList.isEmpty ||
                                            checkboxListData[1] >= 167.95
                                        ? 0
                                        : 29.00;
                                plateform_charges =
                                    containCheckBoxList.isEmpty ? 0 : 4.00;
                                grand_total = containCheckBoxList.isEmpty
                                    ? 0
                                    : checkboxListData[1] +
                                        delivery_charges +
                                        plateform_charges;

                                // List<double> checkboxListData =

                                // var fillterFavItmeListForCheckboxList = state
                                //     .favItemList
                                //     .where((element) =>
                                //         element != newFavList[index])
                                //     .toList();
                                // List checkboxListData = state.favItemList
                                //     .fold([0.0, 0.0], (sum, item) {
                                //   sum[0] += item['Mrp'];
                                //   sum[1] += item['discountMrp'];
                                //   return sum;
                                // });
                                // checkboxListData =
                                //     updateItemPriceData(context);

                                // List<double> checkboxListData =
                                //     favItemList.fold([0.0, 0.0], (sub, item) {
                                //   sub[0] += item['Mrp'];
                                //   sub[1] += item['discountMrp'];
                                //   return sub;
                                // });
                                // log(checkboxListData.toString());

                                // double delivery_charges =
                                //     containCheckBoxList.isEmpty ||
                                //             checkboxListData[1] >= 167.95
                                //         ? 0
                                //         : 29.00;
                                // double plateform_charges =
                                //     containCheckBoxList.isEmpty ? 0 : 4.00;

                                // double grand_total = checkboxListData[1] +
                                //     delivery_charges +
                                //     plateform_charges;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0,
                                                top: 20,
                                                bottom: 10,
                                                left: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: CachedNetworkImage(
                                                    imageUrl: newFavList[index]
                                                        ['image'],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image:
                                                                  imageProvider,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .blue
                                                                          .shade100,
                                                                      BlendMode
                                                                          .colorBurn)),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Center(
                                                            child: Icon(
                                                                Icons.error)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    child: Column(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          title,
                                                          // overflow: TextOverflow.ellipsis,

                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Rs $mrp  ',
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              'Rs ${discountMrp} ',
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color(
                                                                      0xff1A95BE),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              '(${percentOff}% off)',
                                                              style: TextStyle(
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: SizedBox()),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                minimumSize: Size(
                                                                    double
                                                                        .infinity,
                                                                    33),
                                                                maximumSize: Size(
                                                                    double
                                                                        .infinity,
                                                                    35),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff1A95BE),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            11))),
                                                            onPressed: () {},
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      var data =
                                                                          newFavList[
                                                                              index];

                                                                      removeProductDataInCart(
                                                                          context,
                                                                          data);
                                                                      if (produtCountInList ==
                                                                          1) {
                                                                        containCheckBoxList
                                                                            .remove(newFavList[index]);
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        checkboxListData = updateItemPriceData(
                                                                            context,
                                                                            containCheckBoxList);
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    produtCountInList
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      var data =
                                                                          newFavList[
                                                                              index];
                                                                      addProductDataInCart(
                                                                          context,
                                                                          data);

                                                                      setState(
                                                                          () {
                                                                        checkboxListData = updateItemPriceData(
                                                                            context,
                                                                            containCheckBoxList);
                                                                      });
                                                                      // log("--------------------------------");
                                                                    },
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
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
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -10,
                                          child: Checkbox(
                                              value: containCheckBoxList
                                                  .contains(newFavList[index]),
                                              onChanged: (newValue) {
                                                if (newValue == true) {
                                                  containCheckBoxList
                                                      .add(newFavList[index]);
                                                  checkboxListData =
                                                      updateItemPriceData(
                                                          context,
                                                          containCheckBoxList);

                                                  setState(() {});
                                                } else {
                                                  containCheckBoxList.remove(
                                                      newFavList[index]);
                                                  checkboxListData =
                                                      updateItemPriceData(
                                                          context,
                                                          containCheckBoxList);

                                                  setState(() {});
                                                }

                                                //                    bool isSelectedIdx = selctedIndex == index;

                                                // log("this is isSelectedIdx = $isSelectedIdx selectedindx=$selctedIndex index= $index");
                                                grand_total =
                                                    containCheckBoxList.isEmpty
                                                        ? 0
                                                        : checkboxListData[1] +
                                                            delivery_charges +
                                                            plateform_charges;
                                                setState(() {});

                                                ;
                                              }),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  containCheckBoxList.remove(
                                                      newFavList[index]);
                                                  var data = newFavList[index];
                                                  removeCartDataWithDuplicatsValue(
                                                      context, data);
                                                  setState(() {
                                                    checkboxListData =
                                                        updateItemPriceData(
                                                            context,
                                                            containCheckBoxList);
                                                  });
                                                },
                                                icon: Icon(Icons.close))),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                        // Container(
                        //   decoration: BoxDecoration(color: Colors.blue.shade100),
                        //   height: 100,
                        //   child: ListTile(
                        //     leading: Icon(Icons.confirmation_number_outlined),
                        //     title: Text("Add a coupon Code"),
                        //     trailing: Icon(Icons.arrow_forward_ios),
                        //   ),
                        // )
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                minVerticalPadding: 0.0,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 8, right: 0),
                                tileColor: Color.fromARGB(255, 219, 246, 255),
                                leading: Icon(
                                    Icons.confirmation_number_outlined,
                                    color: Color(0xff1A95BE)),
                                title: Text(
                                  "Add a coupon Code",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "You don't have coupon code 😂")));
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 219, 246, 255),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Icon(
                                        Icons.error,
                                        color: Color(0xff1A95BE),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: "Add",
                                            // style: DefaultTextStyle.of(context).style,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: " ₹ 167.95 ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red),
                                              ),
                                              TextSpan(
                                                  text:
                                                      "of eligible items to your order to qualify for FREE Delivery.")
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 219, 246, 255),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: Icon(
                                          Icons.touch_app,
                                          color: Color(0xff1A95BE),
                                        ),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                              text:
                                                  "Tip your delivery partner\n",
                                              // style: DefaultTextStyle.of(context).style,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Your Kindness means a lot! Thank your delivery partner them with a tip. 100%of the tip will go to your delivery partner.\n",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              116,
                                                              116,
                                                              116)),
                                                ),
                                                TextSpan(
                                                    text: " \n",
                                                    style:
                                                        TextStyle(fontSize: 8)),
                                                TextSpan(
                                                  text: " 🍪 10  ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white),
                                                ),
                                                TextSpan(
                                                  text: "   ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 219, 246, 255),
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              219, 246, 255)),
                                                ),
                                                TextSpan(
                                                  text: " ☕ 20  ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white),
                                                ),
                                                TextSpan(
                                                  text: "   ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 219, 246, 255),
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              219, 246, 255)),
                                                ),
                                                TextSpan(
                                                  text: " 🍿 30  ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white),
                                                ),
                                                TextSpan(
                                                  text: "   ",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 219, 246, 255),
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              219, 246, 255)),
                                                ),
                                                TextSpan(
                                                  text: " 🍫 50  .",
                                                  // style: DefaultTextStyle.of(context).style,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 219, 246, 255),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 15, left: 15),
                                  child: BlocBuilder<EcomBloc, EcomState>(
                                    builder: (context, state) {
                                      // double delivery_charge= state.favItemList.isEmpty?0:29.00;
                                      double total_saving =
                                          checkboxListData[0] -
                                              checkboxListData[1];

                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Item Total",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Rs ${checkboxListData[0].toStringAsFixed(1)}',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 8,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    ' ${checkboxListData[1].toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff1A95BE),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Delivery Charges",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                checkboxListData[1] > 167.95
                                                    ? 'FREE'
                                                    : 'Rs. $delivery_charges',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff1A95BE),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Plateform Fee",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                'Rs. $plateform_charges',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff1A95BE),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "total saving",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                'Rs. ${total_saving.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.5,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Grand total",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Rs. ${grand_total.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff1A95BE),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 219, 246, 255),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        child: Icon(
                                          Icons.replay,
                                          size: 20,
                                          color: Color(0xff1A95BE),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Refund & Cancellation policy",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "We want to ensure your satisfaction with every purchase from Your Notebook. Please check our return policy document for detailed information on our policies. Please note that orders cannot be cancelled once packed for delivery, but you can cancel your order at the time of delivery, but you can cancel your order at the time of delivery. Please note that we only accept returns for unused products.",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                );
        },
      ),
    );
  }

//   unCheckBoxPriceDecrement(context, listItem) {

//  var copyList = List.from(favItemList);
//     var fillterCheckBoxList = copyList
//         .where(
//           (element) => containCheckBoxList.contains(element),
//         )
//         .toList();

//     var copyList = List.from(favItemList);

//     copyList.removeWhere((element) => element == listItem);
//     log("this is uncheckboxpriceDecrement $copyList");

//     // favItemList.removeWhere((element) => element == favListDataItem);
//     List<double> total = copyList.fold([0.0, 0.0], (sub, item) {
//       sub[0] += item['Mrp'];
//       sub[1] += item['discountMrp'];
//       log("uncheckboxpriceDecrement == sub0= ${sub[0]}, this sub1 ${sub[1]}");
//       return sub;
//     });
//     return total;
//   }

  updateItemPriceData(context, List containCheckBoxItemList) {
    var copyList = List.from(favItemList);
    var fillterCheckBoxList = copyList
        .where(
          (element) => containCheckBoxList.contains(element),
        )
        .toList();

    // copyList.removeWhere((element) => element != listItem);

    // favItemList.removeWhere((element) => element == favListDataItem);

    List<double> total = fillterCheckBoxList.fold([0.0, 0.0], (sub, item) {
      sub[0] += item['Mrp'];
      sub[1] += item['discountMrp'];

      return sub;
    });
    return total;
  }
}
//lkggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggj
