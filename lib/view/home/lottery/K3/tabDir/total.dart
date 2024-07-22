import 'package:flutter/material.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/view/home/lottery/K3/K3Screen.dart';
import 'package:tiranga/view/home/lottery/K3/k3_bottomsheet_test.dart';

class TotalTab extends StatefulWidget {
  int tabindex;
  TotalTab({super.key, required this.tabindex});

  @override
  State<TotalTab> createState() => _TotalTabState();
}

class _TotalTabState extends State<TotalTab> {

  PersistentBottomSheetController? _bottomSheetController;


  List<dynamic> totalitems = [
    {"id":"1","centerno":Assets.imagesRedPlainK3,"no":"3","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"2","centerno":Assets.imagesGreenPlainK3,"no":"4","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"3","centerno":Assets.imagesRedPlainK3,"no":"5","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"4","centerno":Assets.imagesGreenPlainK3,"no":"6","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"5","centerno":Assets.imagesRedPlainK3,"no":"7","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"6","centerno":Assets.imagesGreenPlainK3,"no":"8","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"7","centerno":Assets.imagesRedPlainK3,"no":"9","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"8","centerno":Assets.imagesGreenPlainK3,"no":"10","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"9","centerno":Assets.imagesRedPlainK3,"no":"11","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"10","centerno":Assets.imagesGreenPlainK3,"no":"12","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"11","centerno":Assets.imagesRedPlainK3,"no":"13","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"12","centerno":Assets.imagesGreenPlainK3,"no":"14","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"13","centerno":Assets.imagesRedPlainK3,"no":"15","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"14","centerno":Assets.imagesGreenPlainK3,"no":"16","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"15","centerno":Assets.imagesRedPlainK3,"no":"17","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"16","centerno":Assets.imagesGreenPlainK3,"no":"18","subtitle":"207.36X","color":Colors.green,"title":"Total"},

  ];
  List<dynamic> sizeTypeList = [
    {"id":"1","no":"Big", "centerno":"1.98", "color":Colors.orange,"title":"Total"},
    {"id":"2","no":"Small", "centerno":"1.98", "color":Colors.blue,"title":"Total"},
    {"id":"3","no":"Even", "centerno":"1.98", "color":Colors.green,"title":"Total"},
    {"id":"4","no":"Odd", "centerno":"1.98", "color":Colors.red,"title":"Total"},

  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,

          ),
          shrinkWrap: true,
          itemCount: totalitems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                setState(() {
                  if (selectedItems.contains(totalitems[index])) {
                    selectedItems.remove(totalitems[index]);
                  } else {
                    selectedItems.add(totalitems[index]);
                  }

                  updateamount = selectedItems.length;
                  amount1 = selectedItems.length;

                  if (selectedItems.isNotEmpty) {
                    showbottomsheet(totalitems[index],selectedItems);
                  } else {
                    _closeBottomSheet();
                  }
                });

              },
              child: Column(
                children: [
                  Container(
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(totalitems[index]['centerno'].toString())
                        )),
                    child: Center(
                      child: textWidget(
                          text: totalitems[index]['no'],
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: totalitems[index]['color']),
                    ),
                  ),
                  textWidget(
                      text: totalitems[index]['subtitle'],
                      fontSize: width * 0.034,
                      color: Colors.grey)
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          height: height*0.06,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizeTypeList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {

                  setState(() {
                    if (selectedItems.contains(sizeTypeList[index])) {
                      selectedItems.remove(sizeTypeList[index]);
                    } else {
                      if (sizeTypeList[index]['no'] == "Big" && selectedItems.any((item) => item['no'] == "Small")) {
                        selectedItems.removeWhere((item) => item['no'] == "Small");
                        print("hdtjudrkj");
                      } else if (sizeTypeList[index]['no'] == "Small" && selectedItems.any((item) => item['no'] == "Big")) {
                        selectedItems.removeWhere((item) => item['no'] == "Big");
                        print("jtfjrj");
                      } else if (sizeTypeList[index]['no'] == "Even" && selectedItems.any((item) => item['no'] == "Odd")) {
                        selectedItems.removeWhere((item) => item['no'] == "Odd");
                        print("hndftdjd");
                      } else if (sizeTypeList[index]['no'] == "Odd" && selectedItems.any((item) => item['no'] == "Even")) {
                        selectedItems.removeWhere((item) => item['no'] == "Even");
                        print("kdtyd");
                      }
                      selectedItems.add(sizeTypeList[index]);
                    }

                    updateamount = selectedItems.length;
                    amount1 = selectedItems.length;

                    if (selectedItems.isNotEmpty) {
                      showbottomsheet(sizeTypeList[index],selectedItems);
                    } else {
                      _closeBottomSheet();
                    }
                  });


                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 40,
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sizeTypeList[index]['color'],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                          text: sizeTypeList[index]['no'],
                          fontSize: width * 0.04,
                          color: Colors.white,
                        ),
                        textWidget(
                          text: sizeTypeList[index]['centerno'],
                          fontSize: width * 0.04,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
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
