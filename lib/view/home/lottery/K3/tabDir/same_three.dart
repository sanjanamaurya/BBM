import 'package:flutter/material.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/view/home/lottery/K3/K3Screen.dart';
import 'package:tiranga/view/home/lottery/K3/commonbottomsheetK3.dart';
import 'package:tiranga/view/home/lottery/K3/k3_bottomsheet_test.dart';

class SameThreeTab extends StatefulWidget {
  int tabindex;
  SameThreeTab({super.key, required this.tabindex});

  @override
  State<SameThreeTab> createState() => _SameThreeTabState();
}

class _SameThreeTabState extends State<SameThreeTab> {
  int ?change;
  int ?changesame2;
  int?changesame3;


  PersistentBottomSheetController? _bottomSheetController;
  List<dynamic>samethreeitemone= [
    {"id":"1", "no":"111","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
    {"id":"2", "no":"222","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
    {"id":"3", "no":"333","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
    {"id":"4", "no":"444","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
    {"id":"5", "no":"555","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
    {"id":"6", "no":"666","color":const Color(0xff784a9c),"title":"3 of the same number: odds(25.8)"},
  ];

  List<dynamic>samethreeitemtwo= [
    {"id":"1", "no":"Any 3 of the same number: odds","color":const Color(0xfffb9494),"title":"Any 3 of the same number: odds(25.8)"},

  ];
  void updateTotalAmount() {
    setState(() {
      updateamount = selectedItems.length + selectedItemsss.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              textWidget(
                  text: "3 of the same number:odds(207.36)", fontSize: width * 0.04),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: samethreeitemone.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          if (selectedItems.contains(samethreeitemone[index])) {
                            selectedItems.remove(samethreeitemone[index]);
                          } else {
                            selectedItems.add(samethreeitemone[index]);
                          }
                          amount1 = selectedItems.length;

                          updateTotalAmount();

                          if (selectedItems.isNotEmpty) {
                            showbottomsheet(samethreeitemone[index],selectedItems);
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
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: textWidget(
                            text: samethreeitemone[index]['no'].toString(),
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
                height: height * 0.03,
              ),
              textWidget(
                  text: "Any 3 of the same numbers: odds(34.56)",
                  fontSize: width * 0.04),
              SizedBox(
                height: height * 0.03,
              ),
              ListView.builder(
                  itemCount: samethreeitemtwo.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){

                    setState(() {
                      if (selectedItemsss.contains(samethreeitemtwo[index])) {
                        selectedItemsss.remove(samethreeitemtwo[index]);
                      } else {
                        selectedItemsss.add(samethreeitemtwo[index]);
                      }
                      amount1 = selectedItemsss.length;

                      updateTotalAmount();
                      if (selectedItemsss.isNotEmpty) {
                        showbottomsheet(samethreeitemtwo[index],selectedItemss);
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
                          text:  samethreeitemtwo[index]['no'].toString(),
                          fontSize: width * 0.04,
                          color: Colors.white),
                    ),
                  ),
                );
              })

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
