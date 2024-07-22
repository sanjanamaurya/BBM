// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/helper/api_helper.dart';
import 'package:tiranga/res/provider/profile_provider.dart';
import 'package:tiranga/res/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:tiranga/utils/utils.dart';
import 'package:tiranga/view/home/lottery/K3/K3Screen.dart';




class CommonTest extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<Color>? colors;
  final String colorName;
  final String predictionType;
  final int gameid;
  final List<dynamic> selectedItems;
  final int tabno;
  const CommonTest({
    super.key,
    this.colors,
    required this.colorName,
    required this.predictionType,
    required this.gameid,
    this.scaffoldKey,
    required this.selectedItems,
    required this.tabno,
  });

  @override
  State<CommonTest> createState() => _CommonTestState();
}

class _CommonTestState extends State<CommonTest> {
  @override
  void initState() {
    walletfetch();
    amount.text = selectedIndex.toString();
    // TODO: implement initState
    super.initState();
  }



  int selectedIndex = 1;
  int selectedIndextwo = 1;
  int? walletApi;
  int? wallbal;
  int value = 1;
  // int updateamount = 0;


  List<int> list = [1, 10, 100, 1000];
  //
  // void increment() {
  //   setState(() {
  //     int currentValue = int.parse(amount.text);
  //     amount.text = (currentValue + 1).toString();
  //     updateamount = selectedIndex * int.parse(amount.text);
  //   });
  // }
  //
  // void decrement() {
  //   setState(() {
  //     int currentValue = int.parse(amount.text);
  //     if (currentValue > 1) {
  //       amount.text = (currentValue - 1).toString();
  //       updateamount = selectedIndex * int.parse(amount.text);
  //     }
  //   });
  // }

  void increment() {
    setState(() {
      amount.text = (updateamount + 1).toString();
      updateamount = int.parse(amount.text);
    });
  }

  void decrement() {
    setState(() {
      amount.text = (updateamount - 1).toString();
      updateamount = int.parse(amount.text);
    });
  }
  void selectam(int selectedIndex) {
    setState(() {
      updateamount = selectedIndex * amount1;
      value = 1;
      this.selectedIndex = selectedIndex;
    });
    deductAmount();
    print('Selected Amount: $amount1');
  }

  void deductAmount() {
    if (wallbal! >= updateamount * value) {
      walletApi = wallbal;
    }
    int amountToDeduct = updateamount * value;
    if (walletApi! >= amountToDeduct) {
      setState(() {
        amount.text = (updateamount * value).toString();
        walletApi = (walletApi! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }



   // void addon (){
   //  updateamount = (updateAmountOne ?? 0)  +(updateAmountTwo ?? 0) + (updateAmountThree ?? 0) + (updateAmountFour ?? 0);
   //  print(updateamount);
   //  print("updateamount");
   // }
///
//   int updateamount = 0; // Variable to hold the updated amount
//   int select = 0; // Variable to hold the updated amount
//   int value = 1; // Initial value
//   int amount1 = 100; // Example value for amount1
//   List<int> selectedIds = []; // List to hold selected item IDs
//
//   @override
//   void initState() {
//     super.initState();
//     amount.text = amount1.toString(); // Initialize amount text field
//   }
//
//   void increment() {
//     setState(() {
//       int currentValue = int.parse(amount.text);
//       amount.text = (currentValue + 1).toString();
//       updateAmount();
//     });
//   }
//
//   void decrement() {
//     setState(() {
//       int currentValue = int.parse(amount.text);
//       if (currentValue > 1) {
//         amount.text = (currentValue - 1).toString();
//         updateAmount();
//       }
//     });
//   }
//
//   void updateAmount() {
//     setState(() {
//       updateamount = selectedIds.fold(0, (sum, id) => sum + id * int.parse(amount.text));
//     });
//   }
//
//   void selectam(int selectedIndex) {
//     setState(() {
//       if (selectedIds.contains(selectedIndex)) {
//         selectedIds.remove(selectedIndex);
//       } else {
//         selectedIds.add(selectedIndex);
//       }
//
//       updateamount = selectedIds.fold(0, (sum, id) => sum + id * int.parse(amount.text));
//     });
//
//     deductAmount();
//   }
//
//

  String gametitle = 'K3 Lotre';
  String subtitle = '1 Min';

  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<ProfileProvider>();

    walletApi = (userData.totalWallet == null
        ? 0
        : double.parse(userData.totalWallet.toString()))
        .toInt();
    wallbal = (userData.totalWallet == null
        ? 0
        : double.parse(userData.totalWallet.toString()))
        .toInt();


    return SingleChildScrollView(
      child: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
           color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height:height*0.55,
          width: width,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // selectedItems.isNotEmpty? Row(
                            //   children: [
                            //     for(var data in selectedItems)
                            //       Text(data["no"].toString())
                            //   ],
                            // ):Container(),
                            // selectedItemss.isNotEmpty?  Row(
                            //   children: [
                            //     for(var dataa in selectedItemss)
                            //       Text(dataa["no"].toString())
                            //   ],
                            // ):Container(),
                            widget.tabno == 1
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context , int index){
                                      return  Padding(
                                        padding:const EdgeInsets.only(left: 10, top: 3),
                                        child: Text(
                                            selectedItems[index]['title'].toString()
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17)),
                                      );
                                    }),

                                selectedItems.isNotEmpty?
                                Container(
                                    height: selectedItems.length>=5? height * 0.13:height*0.05,
                                    child: GridView.builder(
                                      itemCount: selectedItems.where((element) => element["no"].toString().length == 2).length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 3,
                                        childAspectRatio: 1.9,
                                      ),
                                      itemBuilder: (context, index) {
                                        final items = selectedItems.where((element) => element["no"].toString().length == 2).toList();
                                        final singleNo = selectedItems.where((element) => element["no"].toString().length == 1).map((e) => e["no"].toString()).toList();
                                        final backgroundColor = widget.colors == null ? Colors.white : widget.colors!.first;



                                        return  Row(
                                          children: [
                                            Container(
                                              height: height * 0.033,
                                              width: width*0.09,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: backgroundColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  items[index]["no"]
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            singleNo.isNotEmpty
                                                ? Container(
                                              height: height * 0.033,
                                              width: width*0.14,
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    3),
                                                color: const Color(
                                                    0xff3d7456),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  singleNo
                                                      .join(","),
                                                  style: const TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                                : const SizedBox(),
                                          ],
                                        );
                                      },
                                    )):Container()
                              ],
                            )
                                : ListView(
                              shrinkWrap: true,
                              children: [
                                selectedItems.isNotEmpty
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        itemCount: 1,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context , int index){
                                          return  Padding(
                                            padding:const EdgeInsets.only(left: 10, top: 3),
                                            child: Text(
                                                selectedItems[index]['title'].toString()
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                          );
                                        }),

                                    SizedBox(
                                      height: selectedItems.length >6?height*0.18:height * 0.055,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            mainAxisSpacing: 3,
                                            childAspectRatio: 1.9,
                                          ),
                                          itemCount: selectedItems.length,
                                          itemBuilder: (context, index) {
                                            var data = selectedItems[index];
                                            return InkWell(

                                              child: Center(
                                                child: Container(
                                                  width: width * 0.10,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    data['color'],
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data["no"]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Container(),
                                selectedItemsss.isNotEmpty
                                    ?Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        itemCount: 1,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context , int index){
                                          return  Padding(
                                            padding:const EdgeInsets.only(left: 10, top: 3),
                                            child: Text(
                                                selectedItemsss[index]['title'].toString()
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                          );
                                        }),

                                    SizedBox(
                                      height: height * 0.064,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          itemCount: selectedItemsss.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var data = selectedItemsss[index];
                                            return Center(
                                              child: Container(
                                                width: width*0.871,
                                                height: height*0.045,
                                                decoration:
                                                BoxDecoration(
                                                  color:
                                                  data['color'],
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data["no"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        17),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Container(),
                                selectedItemss.isNotEmpty
                                    ? Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        itemCount: 1,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context , int index){
                                          return    Padding(padding:
                                          const EdgeInsets.only(left: 10, top: 3),
                                            child: Text(
                                                selectedItemss[index]['title']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                          );
                                        }),
                                    SizedBox(
                                      height: height * 0.055,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            mainAxisSpacing: 3,
                                            childAspectRatio: 1.9,
                                          ),
                                          itemCount: selectedItemss.length,
                                          itemBuilder: (context, index) {
                                            var data = selectedItemss[index];
                                            return Center(
                                              child: Container(
                                                width: width * 0.10,
                                                decoration:
                                                BoxDecoration(
                                                  color:
                                                  data['color'],
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data["no"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize:
                                                        17),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Container(),
                              ],
                            ),

                            // "$itemss",
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(5),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Balance",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: 200,
                              height: 30,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  itemBuilder: (BuildContext, int index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = list[index];
                                          });
                                          selectam(selectedIndex);
                                          print("guyfruy6rdfu");
                                          print(selectedIndex);
                                        },
                                        child: Container(
                                            margin:
                                            const EdgeInsets.only(right: 5),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: selectedIndex ==
                                                    list[index]
                                                    ? widget.colors!.first
                                                    : const Color(0xffe1e1e1),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            // color:selectedIndex==list[index]?widget.colors!.first:Colors.white,
                                            child: Text(
                                              list[index].toString(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            )));
                                  }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [

                                    InkWell(
                                      onTap: decrement,
                                      child: Container(
                                        width: 35,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.all(5),
                                        color: widget.colors!.first,
                                        child: const Text("--",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.all(5),
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade500),
                                        ),
                                        child: TextField(
                                          controller: amount,
                                          // readOnly: true,

                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        )),
                                    InkWell(
                                      onTap: increment,
                                      child: Container(
                                        width: 35,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.all(5),
                                        color: widget.colors!.first,
                                        child: const Text("+",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),

              // SizedBox(
              //   height: 40,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: multipliers.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: ElevatedButton(
              //           onPressed: () {
              //
              //           },
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor:
              //             selectedMultiplier == multipliers[index]
              //                 ? widget.colors!.first
              //                 : const Color(0xffe1e1e1),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //           ),
              //           child: Text(
              //             'X${multipliers[index]}',
              //             style: const TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: widget.colors!.first,
                  ),
                  const Text(
                    " I agree",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "(Pre sale rule)",
                    style: TextStyle(
                      color: widget.colors!.first,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        selectedItems.clear();
                        selectedItemss.clear();
                        selectedItemsss.clear();

                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: width / 3,
                      height: 45,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Betprovider.Colorbet(context, amount.text,
                      //     widget.predictionType, widget.gameid);
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: widget.colors!.first,
                        width: width / 1.5,
                        height: 45,
                        child: Text(
                          "Total amount $updateamount",
                          // "Total amount ${amount.text}",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false)
          .setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }
}
