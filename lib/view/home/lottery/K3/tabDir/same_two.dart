import 'package:flutter/material.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/view/home/lottery/K3/K3Screen.dart';
import 'package:tiranga/view/home/lottery/K3/commonbottomsheetK3.dart';
import 'package:tiranga/view/home/lottery/K3/k3_bottomsheet_test.dart';

class SameTwoTab extends StatefulWidget {
  int tabindex;
  SameTwoTab({super.key, required this.tabindex});

  @override
  State<SameTwoTab> createState() => _SameTwoTabState();
}

class _SameTwoTabState extends State<SameTwoTab> {
  int ?change;
  int ?changesame2;
  int?changesame3;


  PersistentBottomSheetController? _bottomSheetController;


  List<dynamic>sametwoitemone= [
    {"id":"1", "no":11,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"2", "no":22,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"3", "no":33,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"4", "no":44,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"5", "no":55,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"6", "no":66,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
  ];

  List<dynamic>sametwoitemtwo= [
    {"id":"1", "no":11,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"2", "no":22,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"3", "no":33,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"4", "no":44,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"5", "no":55,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"6", "no":66,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
  ];
  List<dynamic>sametwoitemthree= [
    {"id":"1", "no":1,"title":" ","color":const Color(0xff3d7456)},
    {"id":"2", "no":2,"title":" ","color":const Color(0xff3d7456)},
    {"id":"3", "no":3,"title":" ","color":const Color(0xff3d7456)},
    {"id":"4", "no":4,"title":" ","color":const Color(0xff3d7456)},
    {"id":"5", "no":5,"title":" ","color":const Color(0xff3d7456)},
    {"id":"6", "no":6,"title":" ","color":const Color(0xff3d7456)},
  ];

  void updateTotalAmount() {
    setState(() {
      updateamount = selectedItems.length;
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
          text: "2 matching numbers: odds(13.83)",
          fontSize: width * 0.04,
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sametwoitemone.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {

                  setState(() {
                    if (selectedItems.contains(sametwoitemone[index])) {
                      selectedItems.remove(sametwoitemone[index]);
                    } else {
                      selectedItems.add(sametwoitemone[index]);
                    }
                    amount1 = selectedItems.length;
                    updateTotalAmount();

                    if (selectedItems.isNotEmpty) {
                      showbottomsheet(sametwoitemone[index],selectedItems);
                    } else {
                      _closeBottomSheet();
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Container(
                      height: 36,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: change==index?const Color(0xff784a9c):const Color(0xffdaacfe),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: textWidget(
                        text: sametwoitemone[index]['no'].toString(),
                        fontSize: width * 0.04,
                        color: Colors.white,
                      ),
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
          text: "A pair of unique numbers: odds(69.12)",
          fontSize: width * 0.04,
        ),
        SizedBox(
          height: height * 0.03,
        ),
        SizedBox(
          height: 50, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sametwoitemtwo.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {

                  setState(() {
                    selectedItems.removeWhere((element) => element["id"].toString()==sametwoitemtwo[index]["id"].toString());
                    selectedItems.add(sametwoitemtwo[index]);
                    amount1 = selectedItems.length;

                    updateTotalAmount();

                    if (selectedItems.isNotEmpty) {
                      showbottomsheet(sametwoitemtwo[index],selectedItems);
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
                      color: changesame2==index?Colors.red:const Color(0xfffb9494),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget(
                      text: sametwoitemtwo[index]["no"].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sametwoitemthree.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {

                  setState(() {
                    selectedItems.removeWhere((element) => element["id"].toString()==sametwoitemthree[index]["id"].toString());
                    selectedItems.add(sametwoitemthree[index]);
                    changesame3=index;
                    amount1 = selectedItems.length;

                    updateTotalAmount();

                    if (selectedItems.isNotEmpty) {
                      showbottomsheet(sametwoitemthree[index],selectedItems);
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
                      color: changesame3==index?Colors.green.shade900:const Color(0xff3d7456),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: textWidget(
                      text: sametwoitemthree[index]["no"].toString(),
                      fontSize: width * 0.04,
                      color: Colors.white,
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
