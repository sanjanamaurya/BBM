import 'package:flutter/material.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/view/home/lottery/K3/K3Screen.dart';
import 'package:tiranga/view/home/lottery/K3/k3_bottomsheet_test.dart';

class DifferentTab extends StatefulWidget {
  int tabindex;
   DifferentTab({super.key, required this.tabindex});

  @override
  State<DifferentTab> createState() => _DifferentTabState();
}

class _DifferentTabState extends State<DifferentTab> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  PersistentBottomSheetController? _bottomSheetController;


  ///different
  List<dynamic>differentitemone= [
    {"id":"1", "no":1,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
    {"id":"2", "no":2,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
    {"id":"3", "no":3,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
    {"id":"4", "no":4,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
    {"id":"5", "no":5,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
    {"id":"6", "no":6,"color": const Color(0xff784a9c),"title":"3 different number:odds(207.36)"},
  ];
  List<dynamic>differentitemtwo= [
    {"id":"1", "no":1,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
    {"id":"2", "no":2,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
    {"id":"3", "no":3,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
    {"id":"4", "no":4,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
    {"id":"5", "no":5,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
    {"id":"6", "no":6,"color": const Color(0xff784a9c),"title":"2 different number:odds(34.36)"},
  ];
  List<dynamic>differentitemthree= [
    {"id":"1", "no":"3 continuous numbers","color":const Color(0xfffb9494),"title":"3 continuous number:odds(34.36)"},

  ];

  void updateTotalAmount() {
    setState(() {
      updateamount = selectedItems.length + selectedItemss.length + selectedItemsss.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "3 different number: odds (207.36)", fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),

        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: differentitemone.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  setState(() {
                    if (selectedItems.contains(differentitemone[index])) {
                      selectedItems.remove(differentitemone[index]);

                    } else {
                      selectedItems.add(differentitemone[index]);

                    }
                    // updateamount = selectedItems.length;
                    amount1 = selectedItems.length;
                    updateTotalAmount();

                    if (selectedItems.isNotEmpty) {
                      showbottomsheet(differentitemone[index],selectedItems);
                    } else {
                      _closeBottomSheet();
                    }

                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 40,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff784a9c),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: textWidget(
                        text: differentitemone[index]['no'].toString(),
                        fontSize: width * 0.04,
                        color: Colors.white
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "3 continuous numbers: odds (34.56)", fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){

                setState(() {
                  if (selectedItemsss.contains(differentitemthree[index])) {
                    selectedItemsss.remove(differentitemthree[index]);

                  } else {
                    selectedItemsss.add(differentitemthree[index]);

                  }
                  amount1 = selectedItemsss.length;
                  updateTotalAmount();

                  if (selectedItemsss.isNotEmpty) {
                    showbottomsheet(differentitemthree[index],selectedItemsss);
                  } else {
                    _closeBottomSheet();
                  }

                });
              },
              child: Container(
                height: height * 0.05,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xfffb9494)),
                child: Center(
                  child: textWidget(
                      text: differentitemthree[index]['no'], fontSize: width * 0.04),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: height * 0.03,
        ),
        textWidget(
            text: "2 different numbers: odds (34.56)", fontSize: width * 0.04),
        SizedBox(
          height: height * 0.03,
        ),
        SizedBox(
          height: 50,  // You can adjust the height according to your need
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: differentitemtwo.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {


                  setState(() {
                    if (selectedItemss.contains(differentitemtwo[index])) {
                      selectedItemss.remove(differentitemtwo[index]);
                    } else {
                      selectedItemss.add(differentitemtwo[index]);
                    }
                    amount1 = selectedItemss.length;
                    updateTotalAmount();
                    if (selectedItemss.isNotEmpty) {
                      showbottomsheet(differentitemtwo[index],selectedItemss);
                    } else {
                      _closeBottomSheet();
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 40,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff784a9c),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: textWidget(
                        text: differentitemtwo[index]['no'].toString(),
                        fontSize: width * 0.04,
                        color: Colors.white
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  void showbottomsheet (Map<String, dynamic> item,selectedItems){
    if (_bottomSheetController == null) {
      _bottomSheetController = Scaffold.of(context).showBottomSheet((context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CommonTest(
                colors:  [
                  item['color'],
                  item['color']
                ],
                colorName: item['title'],
                predictionType: "10",
                gameid: gameid,
                selectedItems: selectedItems,
                // selectedItemsText: selectedItemsText,
                // selectedItemsSingle: selectedItemsSingle,
                // item['no'] is String ? selectedItemsss : item['no'] is int ? selectedItemss : selectedItems,
                tabno:widget.tabindex
            );
          },
        );
      });

      _bottomSheetController!.closed.then((value) {
        _bottomSheetController = null;
      });
    } else {
      _bottomSheetController!.setState!(() {});
    }
  }


  void _closeBottomSheet() {
    if (_bottomSheetController != null) {
      Navigator.pop(context);
      _bottomSheetController = null;
    }
  }
}
