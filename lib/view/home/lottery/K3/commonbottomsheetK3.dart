// // ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mmmlottery/main.dart';
// import 'package:mmmlottery/res/helper/api_helper.dart';
// import 'package:mmmlottery/res/provider/profile_provider.dart';
// import 'package:mmmlottery/res/provider/wallet_provider.dart';
// import 'package:mmmlottery/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:mmmlottery/view/home/lottery/K3/K3Screen.dart';
//
// class CommonBottomSheetK3 extends StatefulWidget {
//   final GlobalKey<ScaffoldState>? scaffoldKey;
//   final List<Color>? colors;
//   final String colorName;
//   final String predictionType;
//   final int gameid;
//   final List<dynamic> selectedItems;
//   final int tabno;
//   const CommonBottomSheetK3({
//     super.key,
//     this.colors,
//     required this.colorName,
//     required this.predictionType,
//     required this.gameid,
//     this.scaffoldKey,
//     required this.selectedItems,
//     required this.tabno,
//   });
//
//   @override
//   State<CommonBottomSheetK3> createState() => _CommonBottomSheetK3State();
// }
//
// class _CommonBottomSheetK3State extends State<CommonBottomSheetK3> {
//   @override
//   void initState() {
//     walletfetch();
//     amount.text = selectedMultiplier.toString();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   int value = 1;
//   int selectedAmount = 1;
//   int selectedIndex = 1;
//
//   void increment() {
//     setState(() {
//       selectedMultiplier = selectedMultiplier + 1;
//       updateamount = int.parse(amount.text) * amount1;
//       deductAmount();
//     });
//   }
//   void decrement() {
//     setState(() {
//       if (selectedMultiplier > 1) {
//         selectedMultiplier = selectedMultiplier - 1;
//         updateamount = int.parse(amount.text) * amount1;
//         deductAmount();
//       }
//     });
//   }
//
//   void deductAmount() {
//     int amountToDeduct = selectedAmount * selectedMultiplier;
//
//     if (walletApi! >= amountToDeduct) {
//       setState(() {
//         amount.text = amountToDeduct.toString();
//         walletApi = (walletApi! - amountToDeduct).toInt();
//       });
//     } else {
//       Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
//     }
//   }
//
//   void selectam(int selectedIndex) {
//     setState(() {
//       selectedAmount = selectedIndex;
//       value = 1;
//       if(selectedAmount>=selectedIndex){
//         updateamount = selectedIndex * (amount1);
//       }
//       updateamount = selectedIndex * (amount1);
//     });
//     deductAmount();
//
//     setState(() {
//       this.selectedIndex = selectedIndex;
//     });
//     print('Selected Amount: $amount1');
//   }
//
//
//   List<int> multipliers = [1, 5, 10, 20, 50, 100];
//   int selectedMultiplier = 1;
//
//   void updateMultiplier(int multiplier) {
//     setState(() {
//       selectedMultiplier = multiplier;
//       deductAmount();
//
//     });
//   }
//   List<int> list = [
//     1,
//     10,
//     100,
//     1000,
//   ];
//   int? walletApi;
//   int? wallbal;
//
//
//
//   TextEditingController amount = TextEditingController();
//
//
//   String gametitle = 'K3 Lotre';
//   String subtitle = '1 Min';
//
//   @override
//   Widget build(BuildContext context) {
//     final userData = context.watch<ProfileProvider>();
//
//     walletApi = (userData.totalWallet == null
//             ? 0
//             : double.parse(userData.totalWallet.toString()))
//         .toInt();
//     wallbal = (userData.totalWallet == null
//             ? 0
//             : double.parse(userData.totalWallet.toString()))
//         .toInt();
//
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xffffffff),
//               borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.4),
//                 spreadRadius: 5,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           height: height / 1.4,
//           width: width,
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             // selectedItems.isNotEmpty? Row(
//                             //   children: [
//                             //     for(var data in selectedItems)
//                             //       Text(data["no"].toString())
//                             //   ],
//                             // ):Container(),
//                             // selectedItemss.isNotEmpty?  Row(
//                             //   children: [
//                             //     for(var dataa in selectedItemss)
//                             //       Text(dataa["no"].toString())
//                             //   ],
//                             // ):Container(),
//                             widget.tabno == 1
//                                 ? Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ListView.builder(
//                                         itemCount: 1,
//                                         shrinkWrap: true,
//                                         physics: const NeverScrollableScrollPhysics(),
//                                         itemBuilder: (BuildContext context , int index){
//                                           return  Padding(
//                                             padding:const EdgeInsets.only(left: 10, top: 3),
//                                             child: Text(
//                                                 selectedItems[index]['title'].toString()
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 20)),
//                                           );
//                                         }),
//
//                                     selectedItems.isNotEmpty?
//                                     Container(
//                                         height: selectedItems.length>=5? height * 0.19:height*0.05,
//                                         child: GridView.builder(
//                                           itemCount: selectedItems.where((element) => element["no"].toString().length == 2).length,
//                                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             mainAxisSpacing: 5,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             final items = selectedItems.where((element) => element["no"].toString().length == 2).toList();
//                                             final singleNo = selectedItems.where((element) => element["no"].toString().length == 1).map((e) => e["no"].toString()).toList();
//                                             final backgroundColor = widget.colors == null ? Colors.white : widget.colors!.first;
//
//                                             return Padding(
//                                               padding: const EdgeInsets.all(4.0),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         padding:
//                                                             const EdgeInsets.all(8),
//                                                         decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius.circular(3),
//                                                           color: backgroundColor,
//                                                         ),
//                                                         child: Text(
//                                                           items[index]["no"]
//                                                               .toString(),
//                                                           style: const TextStyle(
//                                                               color: Colors.white,
//                                                               fontSize: 12),
//                                                         ),
//                                                       ),
//                                                       singleNo.isNotEmpty
//                                                           ? Container(
//                                                               height:
//                                                                   height * 0.033,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             3),
//                                                                 color: const Color(
//                                                                     0xff3d7456),
//                                                               ),
//                                                               child: Center(
//                                                                 child: Text(
//                                                                   singleNo
//                                                                       .join(","),
//                                                                   style: const TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize: 12),
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           : const SizedBox(),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         )):Container()
//                                   ],
//                                 )
//                                 : ListView(
//                                     shrinkWrap: true,
//                                     children: [
//                                       selectedItems.isNotEmpty
//                                           ? Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ListView.builder(
//                                                     itemCount: 1,
//                                                     shrinkWrap: true,
//                                                     physics: const NeverScrollableScrollPhysics(),
//                                                     itemBuilder: (BuildContext context , int index){
//                                                       return  Padding(
//                                                         padding:const EdgeInsets.only(left: 10, top: 3),
//                                                         child: Text(
//                                                             selectedItems[index]['title'].toString()
//                                                                 .toString(),
//                                                             style: const TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16)),
//                                                       );
//                                                 }),
//
//                                                 Container(
//                                                   height: selectedItems.length >6?height*0.18:height * 0.055,
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.all(8.0),
//                                                     child: GridView.builder(
//                                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                                         crossAxisCount: 6,
//                                                         mainAxisSpacing: 3,
//                                                         childAspectRatio: 1.9,
//                                                       ),
//                                                       itemCount: selectedItems.length,
//                                                       itemBuilder: (context, index) {
//                                                         var data = selectedItems[index];
//                                                         return InkWell(
//
//                                                           child: Center(
//                                                             child: Container(
//                                                               width: width * 0.10,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color:
//                                                                     data['color'],
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10),
//                                                               ),
//                                                               child: Center(
//                                                                 child: Text(
//                                                                   data["no"]
//                                                                       .toString(),
//                                                                   style: const TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           17),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           : Container(),
//                                       selectedItemsss.isNotEmpty
//                                           ?Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           ListView.builder(
//                                               itemCount: 1,
//                                               shrinkWrap: true,
//                                               physics: const NeverScrollableScrollPhysics(),
//                                               itemBuilder: (BuildContext context , int index){
//                                                 return  Padding(
//                                                   padding:const EdgeInsets.only(left: 10, top: 3),
//                                                   child: Text(
//                                                       selectedItemsss[index]['title'].toString()
//                                                           .toString(),
//                                                       style: const TextStyle(
//                                                           color: Colors.black,
//                                                           fontSize: 16)),
//                                                 );
//                                               }),
//
//                                           SizedBox(
//                                             height: height * 0.064,
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: ListView.builder(
//                                                 itemCount: selectedItemsss.length,
//                                                 shrinkWrap: true,
//                                                 physics: const NeverScrollableScrollPhysics(),
//                                                 itemBuilder: (context, index) {
//                                                   var data = selectedItemsss[index];
//                                                   return Center(
//                                                     child: Container(
//                                                       width: width*0.871,
//                                                       height: height*0.045,
//                                                       decoration:
//                                                       BoxDecoration(
//                                                         color:
//                                                         data['color'],
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .circular(
//                                                             10),
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           data["no"]
//                                                               .toString(),
//                                                           style: const TextStyle(
//                                                               color: Colors
//                                                                   .white,
//                                                               fontSize:
//                                                               17),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                           : Container(),
//                                       selectedItemss.isNotEmpty
//                                           ? Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ListView.builder(
//                                                     itemCount: 1,
//                                                     shrinkWrap: true,
//                                                     physics: const NeverScrollableScrollPhysics(),
//                                                     itemBuilder: (BuildContext context , int index){
//                                                       return    Padding(padding:
//                                                         const EdgeInsets.only(left: 10, top: 3),
//                                                         child: Text(
//                                                             selectedItemss[index]['title']
//                                                                 .toString(),
//                                                             style: const TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16)),
//                                                       );
//                                                     }),
//                                                 Container(
//                                                   height: height * 0.055,
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.all(8.0),
//                                                     child: GridView.builder(
//                                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                                         crossAxisCount: 6,
//                                                         mainAxisSpacing: 3,
//                                                         childAspectRatio: 1.9,
//                                                       ),
//                                                       itemCount: selectedItemss.length,
//                                                       itemBuilder: (context, index) {
//                                                         var data = selectedItemss[index];
//                                                         return Center(
//                                                           child: Container(
//                                                             width: width * 0.10,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               color:
//                                                                   data['color'],
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10),
//                                                             ),
//                                                             child: Center(
//                                                               child: Text(
//                                                                 data["no"]
//                                                                     .toString(),
//                                                                 style: const TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontSize:
//                                                                         17),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           : Container(),
//                                     ],
//                                   ),
//
//                             // "$itemss",
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(5),
//                         width: width,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Balance",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.black),
//                             ),
//                             SizedBox(
//                               width: 200,
//                               height: 30,
//                               child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   shrinkWrap: true,
//                                   itemCount: list.length,
//                                   itemBuilder: (BuildContext, int index) {
//                                     return InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             selectedIndex = list[index];
//                                           });
//                                           selectam(selectedIndex);
//                                         },
//                                         child: Container(
//                                             margin:
//                                                 const EdgeInsets.only(right: 5),
//                                             padding: const EdgeInsets.all(5),
//                                             decoration: BoxDecoration(
//                                                 color: selectedIndex ==
//                                                         list[index]
//                                                     ? widget.colors!.first
//                                                     : const Color(0xffe1e1e1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(5)),
//                                             // color:selectedIndex==list[index]?widget.colors!.first:Colors.white,
//                                             child: Text(
//                                               list[index].toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black),
//                                             )));
//                                   }),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(5),
//                         width: width,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Quantity",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 18),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//
//                                     InkWell(
//                                       onTap: decrement,
//                                       child: Container(
//                                         width: 35,
//                                         alignment: Alignment.center,
//                                         margin: const EdgeInsets.only(right: 5),
//                                         padding: const EdgeInsets.all(5),
//                                         color: widget.colors!.first,
//                                         child: const Text("--",
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white)),
//                                       ),
//                                     ),
//                                     Container(
//                                         height: 35,
//                                         alignment: Alignment.center,
//                                         padding: const EdgeInsets.all(4),
//                                         margin: const EdgeInsets.all(5),
//                                         width: 90,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(14),
//                                           border: Border.all(
//                                               width: 1,
//                                               color: Colors.grey.shade500),
//                                         ),
//                                         child: TextField(
//                                           controller: amount,
//                                           // readOnly: true,
//                                           keyboardType: TextInputType.number,
//                                           textAlign: TextAlign.center,
//                                           decoration: const InputDecoration(
//                                               border: InputBorder.none),
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         )),
//                                     InkWell(
//                                       onTap: increment,
//                                       child: Container(
//                                         width: 35,
//                                         alignment: Alignment.center,
//                                         margin: const EdgeInsets.only(left: 5),
//                                         padding: const EdgeInsets.all(5),
//                                         color: widget.colors!.first,
//                                         child: const Text("+",
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white)),
//                                       ),
//                                     ),
//                                   ]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 40,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: multipliers.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedMultiplier = multipliers[index];
//                           });
//                           updateMultiplier(selectedMultiplier);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               selectedMultiplier == multipliers[index]
//                                   ? widget.colors!.first
//                                   : const Color(0xffe1e1e1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         child: Text(
//                           'X${multipliers[index]}',
//                           style: const TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Icon(
//                     Icons.check_circle,
//                     color: widget.colors!.first,
//                   ),
//                   const Text(
//                     " I agree",
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     "(Pre sale rule)",
//                     style: TextStyle(
//                       color: widget.colors!.first,
//                     ),
//                   )
//                 ],
//               ),
//               const Spacer(),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                       setState(() {
//                         selectedItems.clear();
//                         selectedItemss.clear();
//                         selectedItemsss.clear();
//                       });
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       color: Colors.white,
//                       width: width / 3,
//                       height: 45,
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(color: Colors.grey, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       // Betprovider.Colorbet(context, amount.text,
//                       //     widget.predictionType, widget.gameid);
//                     },
//                     child: Center(
//                       child: Container(
//                         alignment: Alignment.center,
//                         color: widget.colors!.first,
//                         width: width / 1.5,
//                         height: 45,
//                         child: Text(
//                           "Total amount $updateamount.00",
//                           // "Total amount ${amount.text}",
//                           style: const TextStyle(
//                               fontSize: 20, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   BaseApiHelper baseApiHelper = BaseApiHelper();
//
//   Future<void> walletfetch() async {
//     try {
//       if (kDebugMode) {
//         print("qwerfghj");
//       }
//       final walletData = await baseApiHelper.fetchWalletData();
//       if (kDebugMode) {
//         print(walletData);
//         print("wallet_data");
//       }
//       Provider.of<WalletProvider>(context, listen: false)
//           .setWalletList(walletData!);
//     } catch (error) {
//       // Handle error here
//       if (kDebugMode) {
//         print("hiiii $error");
//       }
//     }
//   }
// }
