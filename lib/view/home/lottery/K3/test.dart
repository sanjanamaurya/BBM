// import 'package:flutter/material.dart';
//
// class AmountManager extends StatefulWidget {
//   final String colorName;
//   final List<Map<String, dynamic>> selectedItems;
//   final List<Map<String, dynamic>> selectedItemsss;
//   final List<Map<String, dynamic>> selectedItemss;
//
//   AmountManager({
//     required this.colorName,
//     required this.selectedItems,
//     required this.selectedItemsss,
//     required this.selectedItemss,
//   });
//
//   @override
//   _AmountManagerState createState() => _AmountManagerState();
// }
//
// class _AmountManagerState extends State<AmountManager> {
//   int value = 1;
//   int selectedAmount = 1;
//   int selectedMultiplier = 1;
//   int? walletApi;
//   int? wallbal;
//   TextEditingController amountController = TextEditingController();
//   Map<String, dynamic>? selectedIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize with the first item from selectedItems if available
//     if (widget.selectedItems.isNotEmpty) {
//       setState(() {
//         selectedIndex = widget.selectedItems[0];
//         updateAmount();
//       });
//     }
//   }
//
//   void increment() {
//     setState(() {
//       selectedMultiplier += 1;
//       updateAmount();
//     });
//   }
//
//   void decrement() {
//     setState(() {
//       if (selectedMultiplier > 0) {
//         selectedMultiplier -= 1;
//         updateAmount();
//       }
//     });
//   }
//
//   void selectAmount(int amount) {
//     setState(() {
//       selectedAmount = amount;
//       value = 1;
//       updateAmount();
//     });
//   }
//
//   void updateAmount() {
//     if (selectedIndex != null) {
//       amountController.text = (selectedIndex!['no'] * selectedMultiplier * selectedAmount).toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Amount Manager'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.colorName,
//               style: const TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             Text(
//               'Multiplier: $selectedMultiplier',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: decrement,
//                   child: Text('-'),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: increment,
//                   child: Text('+'),
//                 ),
//               ],
//             ),
//             DropdownButton<int>(
//               value: selectedAmount,
//               items: [1, 10, 50, 100, 500].map((int value) {
//                 return DropdownMenuItem<int>(
//                   value: value,
//                   child: Text(value.toString()),
//                 );
//               }).toList(),
//               onChanged: (int? newValue) {
//                 if (newValue != null) {
//                   selectAmount(newValue);
//                 }
//               },
//             ),
//             Text(
//               'Wallet Balance: ${wallbal ?? 'N/A'}',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               'Updated Wallet: ${walletApi ?? 'N/A'}',
//               style: TextStyle(fontSize: 20),
//             ),
//             TextField(
//               controller: amountController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Total Amount',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             if (widget.selectedItems.isNotEmpty)
//               buildGridView(widget.selectedItems, height, width),
//             if (widget.selectedItemsss.isNotEmpty)
//               buildListView(widget.selectedItemsss, height, width),
//             if (widget.selectedItemss.isNotEmpty)
//               buildGridView(widget.selectedItemss, height, width),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildGridView(List<Map<String, dynamic>> selectedItems, double height, double width) {
//     return Container(
//       height: selectedItems.length > 6 ? height * 0.18 : height * 0.055,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 6,
//             mainAxisSpacing: 3,
//             childAspectRatio: 1.9,
//           ),
//           itemCount: selectedItems.length,
//           itemBuilder: (context, index) {
//             var data = selectedItems[index];
//             return InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = selectedItems[index];
//                   updateAmount();
//                 });
//               },
//               child: Center(
//                 child: Container(
//                   width: width * 0.10,
//                   decoration: BoxDecoration(
//                     color: data['color'],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(
//                       data["no"].toString(),
//                       style: const TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildListView(List<Map<String, dynamic>> selectedItems, double height, double width) {
//     return Container(
//       height: height * 0.064,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: selectedItems.length,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             var data = selectedItems[index];
//             return InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = selectedItems[index];
//                   updateAmount();
//                 });
//               },
//               child: Center(
//                 child: Container(
//                   width: width * 0.871,
//                   height: height * 0.045,
//                   decoration: BoxDecoration(
//                     color: data['color'],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(
//                       data["no"].toString(),
//                       style: const TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
