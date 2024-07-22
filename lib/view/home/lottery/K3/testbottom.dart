import 'package:flutter/material.dart';
import 'package:tiranga/res/components/text_widget.dart';

class MyHomePage extends StatefulWidget {
  final int tabindex;
  MyHomePage({super.key, required this.tabindex});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PersistentBottomSheetController? _bottomSheetController;


  List<Map<String, dynamic>> bigList = [
    {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
  ];

  List<Map<String, dynamic>> smallList = [
    {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
  ];

  List<Map<String, dynamic>> evenList = [
    {"id": "1", "no": "3 continuous numbers", "color": const Color(0xfffb9494), "title": "3 continuous number: odds (34.36)"},
  ];

  late List<List<Map<String, dynamic>>> allLists;
  List<Map<String, dynamic>> selectedItems = [];
  List<int> multiplierList = [1, 10, 100, 1000];
  int selectedIndex = 0;
  int updateAmount = 0;
  int value = 1;

  @override
  void initState() {
    super.initState();
    allLists = [bigList, smallList, evenList];
  }

  void handleSelection(Map<String, dynamic> selectedItem) {
    setState(() {
      if (selectedItems.contains(selectedItem)) {
        selectedItems.remove(selectedItem);
      } else {
        selectedItems.add(selectedItem);
      }
      updateAmount = selectedItems.length * value;
    });
  }

  void selectam(int selectedIndex) {
    setState(() {
      this.selectedIndex = selectedIndex;
      value = multiplierList[selectedIndex];
      updateAmount = selectedItems.length * value;
    });
    deductAmount();
    print('Selected Amount: $updateAmount');
  }

  void deductAmount() {
    print('Deducted Amount: $updateAmount');
  }

  void showPersistentBottomSheet(BuildContext context) {
    if (_bottomSheetController != null) {
      _bottomSheetController!.close();
    }

    _bottomSheetController = Scaffold.of(context).showBottomSheet(
          (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Number of Selections: ${selectedItems.length}'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Update Amount: $updateAmount'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(multiplierList.length, (index) {
                  return ElevatedButton(
                    onPressed: () => selectam(index),
                    child: Text(multiplierList[index].toString()),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }


  // void showBottomSheet(BuildContext context, Map<String, dynamic> item) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Number of Selections: ${selectedItems.length}'),
  //             SizedBox(height: 16),
  //             Text('Update Amount: $updateAmount'),
  //             SizedBox(height: 16),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: List.generate(multiplierList.length, (index) {
  //                 return ElevatedButton(
  //                   onPressed: () {
  //                     selectam(index);
  //                     Navigator.pop(context); // Close the bottom sheet after selection
  //                   },
  //                   child: Text(multiplierList[index].toString()),
  //                 );
  //               }),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Items'),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              textWidget(text: "3 different number: odds (207.36)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[0].take(6).toList();

                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 40,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xff784a9c),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: textWidget(
                                  text: item['no'].toString(),
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              textWidget(text: "3 continuous numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[2].take(1).toList();
                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xfffb9494),
                                ),
                                child: Center(
                                  child: textWidget(
                                    text: item['no'].toString(),
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              textWidget(text: "2 different numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[1].take(6).toList();
                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 40,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xff784a9c),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: textWidget(
                                  text: item['no'].toString(),
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
