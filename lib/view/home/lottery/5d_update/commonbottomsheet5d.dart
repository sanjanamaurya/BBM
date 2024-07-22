// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously
import 'package:provider/provider.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/res/aap_colors.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/res/provider/profile_provider.dart';
import 'package:tiranga/utils/utils.dart';
import 'package:tiranga/view/home/lottery/WinGo/win_go_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlfaBate {
  int Alfaid;
  String title;

  AlfaBate(
    this.Alfaid,
    this.title,
  );
}

class Big {
  String type;
  String amount;
  Big(this.type, this.amount);
}

class CommonBottomSheet5D extends StatefulWidget {
  final int gameid;

  const CommonBottomSheet5D({
    super.key,
    required this.gameid,
  });

  @override
  State<CommonBottomSheet5D> createState() => _CommonBottomSheet5DState();
}

class _CommonBottomSheet5DState extends State<CommonBottomSheet5D> {
  @override
  void initState() {
    amount.text = selectedIndex.toString();

    super.initState();
  }

  int value = 1;
  int value1 = 1;
  int amount1=1;
  int totalBetAmount=0;
  int selectedAmount = 1;
  bool rememberPass = true;

  void increment() {
    setState(() {
      selectedMultiplier = selectedMultiplier + 1;
      totalBetAmount = int.parse(amount.text) * amount1;
      deductAmount();
    });
  }
  void decrement() {
    setState(() {
      if (selectedMultiplier > 1) {
        selectedMultiplier = selectedMultiplier - 1;
        totalBetAmount = int.parse(amount.text) * amount1;
        deductAmount();
      }
    });
  }

  void deductAmount() {
    int amountToDeduct = selectedAmount * selectedMultiplier;

    if (walletApi! >= amountToDeduct) {
      setState(() {
        amount.text = amountToDeduct.toString();
        walletApi = (walletApi! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  void selectam(int selectedIndex) {
      setState(() {
        selectedAmount = selectedIndex;
        value = 1;
        if(selectedAmount>=selectedIndex){
          totalBetAmount = selectedIndex * (amount1);
        }
        totalBetAmount = selectedIndex * (amount1);
      });
      deductAmount();

    setState(() {
      this.selectedIndex = selectedIndex;
    });
    print('Selected Amount: $amount1');
  }


  List<int> multipliers = [1, 5, 10, 20, 50, 100];
  int selectedMultiplier = 1; // Default multipli

  void updateMultiplier(int multiplier) {
    setState(() {
      selectedMultiplier = multiplier;
      if(selectedAmount>=int.parse(amount.text)){
        totalBetAmount = selectedMultiplier * int.parse(amount.text);
      }
      totalBetAmount = selectedMultiplier * int.parse(amount.text);
      deductAmount();
    });
  }



  List<int> list = [
    1,
    10,
    100,
    1000,
  ];
  int? walletApi;
  int? wallbal;

  int selectedIndex = 1;
  int previousIndex = 0;

  TextEditingController amount = TextEditingController();


  List<Winlist> listwe = [
    Winlist(1, "Win Go", "1 Min", 60),
    Winlist(2, "Win Go", "3 Min", 180),
    Winlist(3, "Win Go", "5 Min", 300),
    Winlist(4, "Win Go", "10 Min", 600),
  ];

  List<AlfaBate> alphabetlist = [
    AlfaBate(
      1,
      "A",
    ),
    AlfaBate(
      2,
      "B",
    ),
    AlfaBate(
      3,
      "C",
    ),
    AlfaBate(
      4,
      "D",
    ),
    AlfaBate(
      5,
      "E",
    ),
    AlfaBate(
      6,
      "SUM",
    ),
  ];

  List<int> listt = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<Big> listthree = [
    Big("Big", ""),
    Big("Small", ""),
    Big("Even", ""),
    Big("Odd", ""),
  ];
  List<int> list1 = [9, 9, 9, 9, 9, 9, 9, 9, 9, 9];

  List<Color> color = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  int? showalphabet = 1;
  int? showtype = -1;
  int? fillalphabet = 0;

  String gametitle = 'Wingo';
  String subtitle = '1 Min';

  void updateTextFieldValue() {}

  Set<int> selectedContainer = {};

  @override
  Widget build(BuildContext context) {
    final userData = context.read<ProfileProvider>();
    walletApi = (userData.totalWallet == null
            ? 0
            : double.parse(userData.totalWallet.toString()))
        .toInt();
    wallbal = (userData.totalWallet == null
            ? 0
            : double.parse(userData.totalWallet.toString()))
        .toInt();

    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.whitegradient,
          borderRadius: BorderRadius.circular(27)),
      width: width,
      height: height * 0.79,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  alphabetlist.length,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        showalphabet = alphabetlist[index].Alfaid;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: showalphabet == alphabetlist[index].Alfaid
                              ? AppColors.gradientFirstColor
                              : Color(0xffcfd1de),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      child: textWidget(
                          text: alphabetlist[index].title,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: showalphabet == alphabetlist[index].Alfaid
                              ? AppColors.primaryTextColor
                              : Colors.white),
                    ),
                  ),
                )),
          ),

          SizedBox(
            height: height * 0.01,
          ),
          Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    listthree.length,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          showtype = index;
                          selectedContainer.clear();
                        });
                        if (kDebugMode) {
                          print(showtype);
                          print("showtype");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: showtype == index
                                  ? color[index]
                                  : Color(0xffd1d1d6),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(
                                  text: listthree[index].type,
                                  fontSize: width * 0.04,
                                  color: Colors.white),
                              textWidget(
                                  text: listthree[index].amount,
                                  fontSize: width * 0.04,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              showalphabet == 6
                  ? Container()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 15.0,
                      ),
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected = selectedContainer.contains(index);

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (selectedContainer.contains(index)) {
                                    selectedContainer.remove(index);
                                  } else {
                                    selectedContainer.add(index);
                                    showtype = -1;
                                  }
                                 // selectam(selectedIndex);

                                  print(selectedIndex);
                                  print('wwwww');
                                });
                                if (kDebugMode) {
                                  print(isSelected);
                                  print("isSelected");
                                }

                                totalBetAmount = selectedContainer.length;
                                amount1 = selectedContainer.length;
                                print('Selected Indices: $selectedContainer');
                                print('Index: $index, isSelected: $isSelected');
                              },
                              child: Container(
                                height: height * 0.05,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.gradientFirstColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : Colors.black.withOpacity(0.4)),
                                ),
                                child: textWidget(
                                  text: listt[index].toString(),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.4)
                                ),
                              ),
                            ),
                            textWidget(
                                text: list1[index].toString(),
                                fontSize: width * 0.034,
                                color:Colors.black.withOpacity(0.4)
                                ),
                          ],
                        );
                      },
                    ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  height: 30,
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext, int index) {

                          return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = list[index];
                                  selectam(selectedIndex);
                                });

                              },
                              child: Container(
                                  width: width*0.2,
                                  decoration: BoxDecoration(
                                      color:
                                      selectedIndex == list[index]
                                          ? AppColors
                                          .gradientFirstColor
                                          : Color(0xffe1e1e1),
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  margin:
                                  const EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                      list[index].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: selectedIndex ==
                                              list[index]
                                              ? Colors.white
                                              : AppColors
                                              .gradientFirstColor),
                                    ),
                                  )));
                        }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 18, 5),
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Quantity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Row(
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
                          decoration: BoxDecoration(
                              color: AppColors.gradientFirstColor,
                              borderRadius:
                              BorderRadius.circular(26)),
                          child: const Text("—",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white)),
                        ),
                      ),
                      Container(
                          height: 35,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryTextColor,
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
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )),
                      InkWell(
                        onTap: increment,
                        child: Container(
                          width: 35,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColors.gradientFirstColor,
                              borderRadius:
                              BorderRadius.circular(26)),
                          child: const Text("+",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white)),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 18,0),
            height: 35,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: multipliers.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedMultiplier = multipliers[index];
                        });
                        updateMultiplier(selectedMultiplier);
                      },
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color:  selectedMultiplier == multipliers[index]
                              ? AppColors
                              .gradientFirstColor
                              : Color(0xffe1e1e1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                              'X${multipliers[index]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: selectedMultiplier == multipliers[index]
                                      ? Colors.white
                                      : AppColors
                                      .gradientFirstColor)
                          ),
                        ),

                      ),
                    )

                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    rememberPass = !rememberPass;
                  });
                },
                child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: rememberPass
                        ? BoxDecoration(
                            color: AppColors.gradientFirstColor,
                            border:
                                Border.all(color: AppColors.secondaryTextColor),
                            borderRadius: BorderRadiusDirectional.circular(50),
                          )
                        : BoxDecoration(
                            border:
                                Border.all(color: AppColors.secondaryTextColor),
                            borderRadius: BorderRadiusDirectional.circular(50),
                          ),
                    child: rememberPass
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null),
              ),
              const Text(" I agree",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.red)),
              const SizedBox(
                width: 15,
              ),
              const Text("《Pre-sale rules》",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradientFirstColor))
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    print('yyyybbbbbbbbbbb');
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  width: width / 3,
                  height: 45,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Colorbet( amount.text,
                  //     widget.predictionType, widget.gameid.toString());
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration:  BoxDecoration(
                        color: Colors.red),
                    width: width / 1.5,
                    height: 45,
                    child: Text(
                     // "Total amount ${amount.text}.00",
                      "Total amount $totalBetAmount.00",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
