// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/model/bettingHistory_Model.dart';
import 'package:tiranga/model/user_model.dart';
import 'package:tiranga/res/aap_colors.dart';
import 'package:tiranga/res/api_urls.dart';
import 'package:tiranga/res/components/app_bar.dart';
import 'package:tiranga/res/components/app_btn.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/res/helper/api_helper.dart';
import 'package:tiranga/res/provider/user_view_provider.dart';
import 'package:tiranga/res/provider/wallet_provider.dart';
import 'package:tiranga/view/auth/constant_wallet.dart';
import 'package:tiranga/view/home/lottery/5d_update/5d_screen_update.dart';
import 'package:tiranga/view/home/lottery/K3/dummygridK3.dart';
import 'package:tiranga/view/home/lottery/K3/slotmachine_new.dart';
import 'package:tiranga/view/home/lottery/K3/tabDir/different.dart';
import 'package:tiranga/view/home/lottery/K3/tabDir/same_three.dart';
import 'package:tiranga/view/home/lottery/K3/tabDir/same_two.dart';
import 'package:tiranga/view/home/lottery/K3/tabDir/total.dart';
import 'package:tiranga/view/home/lottery/K3/triangle_painter_page.dart';
import 'package:provider/provider.dart';
import 'package:tiranga/view/home/lottery/trx/imageToat_trx.dart';

class Big {
  String type;
  String amount;
  final Color color;
  Big(this.type, this.amount, this.color);
}

class Digitselect {
  String digit;
  String setdigit;
  Digitselect(this.digit, this.setdigit);
}
List<dynamic> selectedItems = [];
List<dynamic> selectedItemss = [];
List<dynamic> selectedItemsss = [];

int updateamount = 0;
int amount1=1;
int gameid = 1;



class ScreenK3 extends StatefulWidget {
  const ScreenK3({super.key});

  @override
  _ScreenK3State createState() => _ScreenK3State();
}

class _ScreenK3State extends State<ScreenK3> with SingleTickerProviderStateMixin {
  late int selectedCatIndex;
  TabController? tabController;


  @override
  void initState() {
    startCountdown();
    walletfetch();
    partelyRecord(1);
    GamehistoryTRX(1);
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection(){
    setState(() {
      _currentTabIndex = tabController!.index;
      if (kDebugMode) {
        print("_currentTabIndex");
        print(_currentTabIndex);
      }

    });
  }

  int _currentTabIndex = 0;
  int countdownSeconds = 60;
  int gameseconds = 60;
  int selectedContainerIndex = -1;
  int? responseStatuscode;
  int? showalphabet = 0;
  String gametitle = 'K3 Lotre';
  String subtitle = '1 Min';
  Timer? countdownTimer;

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int minutes = now.minute;
    int minsec = minutes * 60;
    int initialSeconds = 60;
    if (gameseconds == 60) {
      initialSeconds = gameseconds - now.second;
    } else if (gameseconds == 180) {
      for (var i = 0; i < 20; i++) {
        if (minsec >= 180) {
          minsec = minsec - 180;
        } else {
          initialSeconds = gameseconds - minsec - now.second;
        }
        if (kDebugMode) {
          print(initialSeconds);
        }
      }
    } else if (gameseconds == 300) {
      for (var i = 0; i < 12; i++) {
        if (minsec >= 300) {
          minsec = minsec - 300;
        } else {
          initialSeconds = gameseconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    } else if (gameseconds == 600) {
      for (var i = 0; i < 6; i++) {
        if (minsec >= 600) {
          minsec = minsec - 600;
        } else {
          initialSeconds = gameseconds -
              minsec -
              now.second; // Calculate initial remaining seconds
        }
      }
    }
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameconcept(countdownSeconds);
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 5) {
      } else if (countdownSeconds == 0) {
        countdownSeconds = gameseconds;
        walletfetch();
        partelyRecord(1);
        GamehistoryTRX(1);
        BettingHistory();
        gameWinPopup();
        // onStart();
        _handleSlotMachineTap();
      } else if (countdownSeconds == 59) {
        // onButtonTap();
      }
      countdownSeconds = (countdownSeconds - 1);
    });
  }

  @override
  void dispose() {
    countdownSeconds.toString();
    tabController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  List<Winlist> list = [
    Winlist(1, "K3 Lotre", "1 Min", 60),
    Winlist(2, "K3 Lotre", "3 Min", 180),
    Winlist(3, "K3 Lotre", "5 Min", 300),
    Winlist(4, "K3 Lotre", "10 Min", 600),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
            title: textWidget(text: 'tiranga', fontSize: 22, color: Colors.white),
            leading: const AppBackBtn(),
            gradient: AppColors.primaryAppBarGrey),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [

              Container(
                height: height / 2.8,
                decoration: const BoxDecoration(
                    gradient: AppColors.primaryAppBarGrey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),

              Column(
                children: [
                  const SizedBox(height: 20),
                  const ConstantWallet(),
                  Container(
                    height: height * 0.18,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      gradient: AppColors.whitegradient,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(list.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCatIndex = index;
                              subtitle = list[index].subtitle;
                              gameseconds = list[index].time;
                              gameid = list[index].gameid;
                            });
                            countdownTimer!.cancel();
                            startCountdown();
                            offsetResult = 0;
                            partelyRecord(list[index].gameid);
                            GamehistoryTRX(list[index].gameid);
                          },
                          child: Container(
                            height: height * 0.28,
                            width: width * 0.23,
                            decoration: BoxDecoration(
                              gradient: selectedCatIndex == index
                                  ? AppColors.goldenGradientDir
                                  : const LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                selectedCatIndex == index
                                    ? Image.asset(Assets.imagesRedWatch,
                                        height: 70)
                                    : Image.asset(Assets.iconsTime, height: 70),
                                textWidget(
                                    text: list[index].title,
                                    color: selectedCatIndex == index
                                        ? AppColors.primaryTextColor
                                        : Colors.black,
                                    fontSize: 14),
                                textWidget(
                                    text: list[index].subtitle,
                                    color: selectedCatIndex == index
                                        ? AppColors.primaryTextColor
                                        : Colors.black,
                                    fontSize: 14),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          gradient: AppColors.whitegradient,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Period',
                                        style: TextStyle(
                                            color:
                                                AppColors.secondaryTextColor),
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowtoplayScreen()));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            height: 28,
                                            width: width * 0.35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: AppColors
                                                        .greenContainer)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Assets.iconsHowtoplay,
                                                  height: 18,
                                                  color:
                                                      AppColors.greenContainer,
                                                ),
                                                const Text(
                                                  ' How to Play',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .greenContainer,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    period.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkcolor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Time Remaining',
                                    style: TextStyle(
                                        color: AppColors.darkcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  buildTime1(countdownSeconds),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                              width: width*0.78,
                              child: SlotMachineView()
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          create == false
                              ? Column(
                                  children: [
                                    DefaultTabController(
                                      length: 4,
                                      child: TabBar(
                                        indicator: const BoxDecoration(
                                            color: AppColors.containerBgColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))),
                                        controller: tabController,
                                        tabs: [
                                          Tab(
                                            child: textWidget(
                                                text: "Total",
                                                textAlign: TextAlign.center,
                                                fontSize: width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Tab(
                                            child: textWidget(
                                                text: "2 same",
                                                textAlign: TextAlign.center,
                                                fontSize: width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Tab(
                                            child: textWidget(
                                                text: "3 same",
                                                textAlign: TextAlign.center,
                                                fontSize: width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Tab(
                                            child: textWidget(
                                                text: "Different",
                                                textAlign: TextAlign.center,
                                                fontSize: width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColors.darkcolor,
                                    ),
                                    SizedBox(
                                      height: height * 0.58,
                                      child: TabBarView(
                                        physics: const BouncingScrollPhysics(),
                                        controller: tabController,
                                        children: [
                                          TotalTab(tabindex:_currentTabIndex),
                                          SameTwoTab(tabindex:_currentTabIndex),
                                          SameThreeTab(tabindex:_currentTabIndex),
                                          DifferentTab(tabindex:_currentTabIndex)
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    const DummygridK3(),
                                    Container(
                                      height: height*0.60,
                                      color: Colors.black26,
                                      child: buildTime5sec(countdownSeconds),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                  const SizedBox(height: 15),
                  result5d()
                ],
              ),
            ],
          ),
        ));
  }

  int pageNumber = 1;
  int selectedTabIndex = 0;
  Widget result5d() {
    setState(() {});

    return _listdataResult != []
        ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabContainer(
              'Game History',
              0,
              width,
              Colors.red,
            ),
            buildTabContainer('Chart', 1, width, Colors.red),
            buildTabContainer('My History', 2, width, Colors.red),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        selectedTabIndex == 0
            ? Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                  gradient: AppColors.secondaryappbar,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.25,
                    child: textWidget(
                        text: 'Period',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.17,
                    child: textWidget(
                        text: 'Sum',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.21,
                    child: textWidget(
                        text: 'Results',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.94,
              decoration: const BoxDecoration(
                  color: AppColors.primaryTextColor),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listdataResult.length,
                itemBuilder: (context, index) {
                  if (_listdataResult[index].number == '0') {
                  } else if (_listdataResult[index].number == '5') {
                  } else {}

                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: height * 0.09,
                            alignment: Alignment.center,
                            width: width * 0.3,
                            child: textWidget(
                              text: _listdataResult[index].period,
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            height: height * 0.09,
                            alignment: Alignment.center,
                            width: width * 0.10,
                            child: textWidget(
                              text: "9",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            height: height * 0.09,
                            alignment: Alignment.center,
                            width: width * 0.13,
                            child: textWidget(
                              text: "Small",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            height: height * 0.09,
                            alignment: Alignment.center,
                            width: width * 0.12,
                            child: textWidget(
                              text: "Odd",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.28,
                            child: ListView.builder(
                                itemCount: 1,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, int index) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Image.asset(
                                        Assets.icons1,
                                        height: height * 0.03,
                                      ),
                                      Image.asset(
                                        Assets.icons2,
                                        height: height * 0.03,
                                      ),
                                      Image.asset(
                                        Assets.icons3,
                                        height: height * 0.03,
                                      ),
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                      Container(
                          width: width,
                          color: AppColors.darkcolor,
                          height: 0.5),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: limitResult == 0
                      ? () {}
                      : () {
                    setState(() {
                      pageNumber--;
                      limitResult = limitResult - 10;
                      offsetResult = offsetResult - 10;
                    });
                    GamehistoryTRX(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.navigate_before,
                        color: AppColors.primaryTextColor),
                  ),
                ),
                const SizedBox(width: 16),
                textWidget(
                  text: '$pageNumber',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkcolor,
                  maxLines: 1,
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      limitResult = limitResult + 10;
                      offsetResult = offsetResult + 10;
                      pageNumber++;
                    });
                    GamehistoryTRX(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.navigate_next,
                        color: AppColors.primaryTextColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10)
          ],
        )
            : selectedTabIndex == 1
            ? chartScreen()
            : responseStatuscode == 400 ? const Notfounddata()
            : items.isEmpty ? const Center(child: CircularProgressIndicator())
            : Container(
          width: width,
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 15),
          margin: const EdgeInsets.only(
              left: 10, right: 10),
          decoration:  const BoxDecoration(


              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10))),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHistoryDetails()));
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.25,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(15),
                        border: Border.all(
                            color: AppColors
                                .gradientFirstColor)),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Detail',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                            height: height * 0.04,
                            width: width * 0.09,
                            child: const Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10),
                physics:
                const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  List<Color> colors;

                  if (items[index].number == 0) {
                    colors = [
                      const Color(0xFFfd565c),
                      AppColors.primaryTextColor,
                    ];
                  } else if (items[index].number == 5) {
                    colors = [
                      const Color(0xFF40ad72),
                      AppColors.primaryTextColor,
                    ];
                  } else if (items[index].number ==
                      10) {
                    colors = [
                      const Color(0xFF40ad72),
                      const Color(0xFF40ad72),
                    ];
                  } else if (items[index].number ==
                      20) {
                    colors = [
                      AppColors.primaryTextColor,
                      AppColors.primaryTextColor,
                    ];
                  } else if (items[index].number ==
                      30) {
                    colors = [
                      const Color(0xFFfd565c),
                      const Color(0xFFfd565c),
                    ];
                  } else if (items[index].number ==
                      40) {
                    colors = [
                      AppColors.goldencolor,
                      AppColors.goldencolor,
                    ];
                  } else if (items[index].number ==
                      50) {
                    colors = [
                      const Color(0xff6eb4ff),
                      const Color(0xff6eb4ff)
                    ];
                  } else {
                    int number = int.parse(
                        items[index].number.toString());
                    colors = number.isOdd
                        ? [
                      const Color(0xFF40ad72),
                      const Color(0xFF40ad72),
                    ]
                        : [
                      const Color(0xFFfd565c),
                      const Color(0xFFfd565c),
                    ];
                  }

                  return ExpansionTile(
                    leading: Container(
                        height: height * 0.06,
                        width: width * 0.12,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(
                                10),

                            gradient: LinearGradient(
                                stops: const [0.5, 0.5],
                                colors: colors,
                                begin:
                                Alignment.topLeft,
                                end: Alignment
                                    .bottomRight)),
                        child: Center(
                          child: Text(
                            items[index].number == 40
                                ? 'Big'
                                : items[index].number ==
                                50
                                ? 'Small'
                                : items[index]
                                .number ==
                                10
                                ? 'G'
                                : items[index]
                                .number ==
                                20
                                ? 'W'
                                : items[index].number ==
                                30
                                ? 'O'
                                : items[index]
                                .number
                                .toString(),
                            style: TextStyle(
                                fontSize: items[index]
                                    .number ==
                                    40
                                    ? 10
                                    : items[index]
                                    .number ==
                                    50
                                    ? 10
                                    : 20,
                                fontWeight:
                                FontWeight.w800,
                                color: Colors.black),
                          ),
                        )),
                    title: Text(
                      items[index].gamesno.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                        items[index]
                            .createdAt
                            .toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height * 0.042,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  10),
                              border: Border.all(
                                  color: items[index]
                                      .status ==
                                      0
                                      ? AppColors
                                      .primaryTextColor
                                      : items[index]
                                      .status ==
                                      2
                                      ? Colors.red
                                      : Colors
                                      .green)),
                          child: Center(
                            child: Text(
                              items[index].status == 2
                                  ? 'Failed'
                                  : items[index]
                                  .status ==
                                  0
                                  ? 'Pending'
                                  : 'Succeed',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w700,
                                  color: items[index]
                                      .status ==
                                      0
                                      ? Colors.white
                                      : items[index]
                                      .status ==
                                      2
                                      ? Colors.red
                                      : Colors
                                      .green),
                            ),
                          ),
                        ),
                        Text(
                          items[index].status == 0
                              ? '--'
                              : items[index].status == 2
                          // ? '- ₹${items[index].amount.toStringAsFixed(2)}'
                              ? '- ₹0'
                          // : '+ ₹${items[index].winAmount.toStringAsFixed(2)}',
                              : '+ ₹0',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                              FontWeight.w700,
                              color: items[index]
                                  .status ==
                                  0
                                  ? Colors.white
                                  : items[index]
                                  .status ==
                                  2
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Align(
                                alignment:
                                Alignment.topLeft,
                                child: Text(
                                  'Details',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .w900,
                                      color:
                                      Colors.white),
                                )),
                            const SizedBox(height: 8.0),
                            Container(
                              height: height * 0.08,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(10),
                                  color: Colors.black.withOpacity(0.05)),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    const Text(
                                      'order number',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight
                                              .w700,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                        height: 4.0),
                                    Text(
                                      items[index]
                                          .orderId
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight
                                              .w700,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            historyDetails(
                                'Period',
                                items[index]
                                    .gamesno
                                    .toString(),
                                Colors.black),
                            historyDetails(
                                'Purchase amount',
                                items[index]
                                    .amount
                                    .toString(),
                                Colors.black),
                            historyDetails(
                                'Amount after tax',
                                items[index]
                                    .tradeAmount
                                    .toString(),
                                Colors.black),
                            historyDetails(
                                'Tax',
                                items[index]
                                    .commission
                                    .toString(),
                                Colors.black),
                            historyWinDetails(
                                'Result',
                                items[index].winNumber == null
                                    ? '--'
                                    : '${items[index].winNumber}, ',
                                items[index].winNumber ==
                                    5
                                    ? 'Green White,'
                                    : items[index]
                                    .winNumber ==
                                    0
                                    ? 'orange white,'
                                    : items[index]
                                    .winNumber ==
                                    null
                                    ? ''
                                    : items[index]
                                    .winNumber
                                    .isOdd
                                    ? 'green,'
                                    : 'orange,',
                                items[index].winNumber ==
                                    null
                                    ? ''
                                    : items[index]
                                    .winNumber <
                                    5
                                    ? 'small'
                                    : 'Big',
                                Colors.white,
                                items[index].winNumber ==
                                    null
                                    ? Colors.orange
                                    : items[index]
                                    .winNumber
                                    .isOdd
                                    ? Colors.green
                                    : Colors.orange,
                                items[index].winNumber ==
                                    null
                                    ? Colors.orange
                                    : items[index]
                                    .winNumber <
                                    5
                                    ? Colors.yellow
                                    : Colors.blue),
                            historyDetails(
                                'Select',
                                items[index].number ==
                                    50
                                    ? 'small'
                                    : items[index]
                                    .number ==
                                    40
                                    ? 'big'
                                    : items[index]
                                    .number ==
                                    10
                                    ? 'Green'
                                    : items[index].number ==
                                    20
                                    ? 'White'
                                    : items[index].number ==
                                    30
                                    ? 'Orange'
                                    : items[index].number.toString(),
                                Colors.black),
                            historyDetails(
                                'Status',
                                items[index].status == 0
                                    ? 'Unpaid'
                                    : items[index]
                                    .status ==
                                    2
                                    ? 'Failed'
                                    : 'Succeed',
                                items[index].status == 0
                                    ? Colors.white
                                    : items[index]
                                    .status ==
                                    2
                                    ? Colors.red
                                    : Colors.green),
                            historyDetails(
                                'Win/Loss',
                                items[index].status == 0
                                    ? '--'
                                    : '₹0',
                                items[index].status == 0
                                    ? Colors.white
                                    : items[index]
                                    .status ==
                                    2
                                    ? Colors.red
                                    : Colors.green),
                            historyDetails(
                                'Order time',
                                items[index]
                                    .createdAt
                                    .toString(),
                                Colors.black),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              responseStatuscode == 400
                  ? Container()
                  : Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: limitResult == 0
                        ? () {}
                        : () {
                      setState(() {
                        pageNumber--;
                        limitResult =
                            limitResult -
                                10;
                        offsetResult =
                            offsetResult -
                                10;
                      });
                      setState(() {});
                      BettingHistory();
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.10,
                      decoration: BoxDecoration(
                        gradient: AppColors
                            .goldenGradientDir,
                        borderRadius:
                        BorderRadius.circular(
                            10),
                      ),
                      child: const Icon(
                        Icons.navigate_before,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  textWidget(
                    text: '$pageNumber/${items.length}',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors
                        .primaryTextColor,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        limitResult =
                            limitResult + 10;
                        offsetResult =
                            offsetResult + 10;
                        pageNumber++;
                      });
                      setState(() {});
                      BettingHistory();
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.10,
                      decoration: BoxDecoration(
                        gradient: AppColors
                            .goldenGradientDir,
                        borderRadius:
                        BorderRadius.circular(
                            10),
                      ),
                      child: const Icon(
                          Icons.navigate_next,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    )
        : Container();
  }

  ///chart page
  Widget chartScreen() {
    setState(() {});
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
              gradient: AppColors.secondaryappbar,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.25,
                child: textWidget(
                    text: 'Period',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.21,
                child: textWidget(
                    text: 'Results',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
              Container(
                alignment: Alignment.center,
                width: width * 0.23,
                child: textWidget(
                    text: 'Number',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryTextColor),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            _listdataResult.length,
                (index) {
              return Container(
                height: 30,
                width: width * 0.97,
                decoration: BoxDecoration(gradient: AppColors.whitegradient),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textWidget(
                        text: _listdataResult[index].period,
                        color: Colors.black),
                    SizedBox(width: width * 0.05),
                    SizedBox(
                      width: width * 0.29,
                      child: ListView.builder(
                          itemCount: 1,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  Assets.icons1,
                                  height: height * 0.03,
                                ),
                                Image.asset(
                                  Assets.icons2,
                                  height: height * 0.03,
                                ),
                                Image.asset(
                                  Assets.icons3,
                                  height: height * 0.03,
                                ),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      width: width * 0.28,
                      child: ListView.builder(
                          itemCount: 1,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Center(
                              child: textWidget(
                                  text: "2 same number", color: Colors.black),
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult = limitResult - 10;
                  offsetResult = offsetResult - 10;
                });
                GamehistoryTRX(gameid);
                setState(() {});
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.1,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkcolor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult = offsetResult + 10;
                  pageNumber++;
                });
                GamehistoryTRX(gameid);
                setState(() {});
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.1,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_next,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///condition for obscure text
  String obscureCenterDigits(String input) {
    if (input.length < 4) {
      return input; // If the input is shorter than 4 characters, return the original string
    }

    // Get the length of the input string
    int length = input.length;

    // Calculate the start index for obscuring
    int startIndex = (length ~/ 2) - 1;

    // Calculate the end index for obscuring
    int endIndex = (length ~/ 2) + 1;

    // Create a List of characters from the input string
    List<String> chars = input.split('');

    // Replace characters in the specified range with asterisks
    for (int i = startIndex; i <= endIndex; i++) {
      chars[i] = '*';
    }

    // Join the List of characters back into a single string
    return chars.join('');
  }

  Widget buildTabContainer(String label, int index, double width, Color selectedTextColor) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
        BettingHistory();
      },
      child: Container(
        height: 40,
        width: width / 3.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selectedTabIndex == index
                ? Colors.red.withOpacity(0.9)
                : Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width / 24,
            fontWeight:
            selectedTabIndex == index ? FontWeight.bold : FontWeight.w500,
            color: selectedTabIndex == index
                ? AppColors.primaryTextColor
                : Colors.black,
          ),
        ),
      ),
    );
  }

  gameconcept(int countdownSeconds) {
    if (countdownSeconds == 6) {
      setState(() {
        create = true;
      });
      if (kDebugMode) {
        print('5 sec left');
      }
    } else if (countdownSeconds == 0) {
      setState(() {
        create = false;
      });
      if (kDebugMode) {
        print('0 sec left');
      }
    } else {}
  }

  late SlotMachineImageController _numberController;
  bool _isSlotMachineRunning = false;

  void _handleSlotMachineTap() {
    if (!_isSlotMachineRunning) {
      const input = '646';
      // '${GameResults}23';
      if (input.length == 3 && input.runes.every((r) => r >= 49 && r <= 54)) {
        final selectedNumbers = input.runes.map((r) => r - 48).toList();
        setState(() {
          _isSlotMachineRunning = true;
          _numberController.start(hitRollItemIndexes: selectedNumbers);
          for (int i = 0; i < 3; i++) {
            Future.delayed(Duration(seconds: 1 + i), () {
              _numberController.stop(reelIndex: i, resultIndex: selectedNumbers[i]);
              if (i == 2) {
                setState(() {
                  _isSlotMachineRunning = false;
                });
              }
            });
          }
        });
      } else {
        _showInvalidNumberDialog();
      }
    }
  }

  void _showInvalidNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invalid Number"),
          content: const Text("Please enter a number between 111 and 666."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  final Map<int, String> digitToImageMap = {
    1: Assets.slotMachineNum1,
    2: Assets.slotMachineNum2,
    3: Assets.slotMachineNum3,
    4: Assets.slotMachineNum4,
    5: Assets.slotMachineNum5,
    6: Assets.slotMachineNum6,
  };

  Widget SlotMachineView() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -8,
          top: 47.0,
          child: Container(
            height: 30,
            width: 15,
            decoration: const BoxDecoration(
                color: AppColors.greenContainer,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
          ),
        ),
        Positioned(
          left: -8,
          top: 47.0,
          child: Container(
            height: 30,
            width: 15,
            decoration: const BoxDecoration(
                color: AppColors.greenContainer,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.darkcolor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 10, color: AppColors.greenContainer)
          ),
          child: Center(
            child: SlotMachineNumber(
              rollItems: List.generate(
                6,
                    (index) => RollItemNumber(
                  index: index + 1, // Adjust index to start from 1
                ),
              ),

              onCreated: (controller) {
                _numberController = controller;
              },
              onFinished: (resultIndexes) {
                if (kDebugMode) {
                  print('Result: $resultIndexes');
                }
              },
              digitToImageMap: digitToImageMap,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            height: 150,
            width: 300,
            color: Colors.transparent,
          ),
        ),
        Positioned(
          right: 0,
          top: 86.0, // 50% of 64.0 height (to center vertically)
          child: Transform.translate(
            offset: const Offset(
                0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size: const Size(
                  30.53, 16.0), // Width and height of the triangle
              painter: TrianglePainter(),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 86.0, // 50% of 64.0 height (to center vertically)
          child: Transform.translate(
            offset: const Offset(
                0, -32.0), // Translate by -50% of 64.0 height
            child: CustomPaint(
              size:  const Size(
                  30.53, 16.0),
              painter: TrianglePainter2(),
            ),
          ),
        ),

      ],
    );
  }


  /// how to play ke pass wala api
  bool create = false;
  int period = 0;

  final List<pertrecord> _listdata = [];

  partelyRecord(int gameid) async {
    if (kDebugMode) {
      print("f6td");
    }
    final response = await http.get(
        Uri.parse("${ApiUrl.colorresultTRX}limit=1&offset=0&gameid=$gameid"));
    if (kDebugMode) {
      print(jsonDecode(response.body));
      print("vygciydt");
      print("${ApiUrl.colorresultTRX}limit=1&offset=1&gameid=$gameid");
    }
    if (response.statusCode == 200) {
      _listdata.clear();
      final jsonData = json.decode(response.body)['data'];
      // setState(() {
      //   period = int.parse(jsonData[0]['gamesno'].toString()) + 1;
      // });
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        var hashh = jsonData[i]['hash'];

        _listdata.add(pertrecord(period, number, hashh));
      }
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  int limitResult = 10;
  int offsetResult = 0;

  gameWinPopup() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final response = await http.get(
        Uri.parse('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid'));

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid');
      print('nbnbnbnbn');
    }
    if (data["status"] == "200") {
      var totalamount = data["totalamount"];
      var win = data["win"];
      var gamesno = data["gamesno"];
      var gameid = data["gameid"];
      if (kDebugMode) {
        print('rrrrrrrr');
      }
      // showPopup(context,totalamount,win,gamesno,gameid);
      // Future.delayed(const Duration(seconds: 5), () {
      //   Navigator.of(context).pop();
      // });
      ImageToastTRX.show(
        text: gamesno,
        subtext: totalamount,
        subtext1: win,
        subtext2: gameid,
        context: context,
      );
    } else {
      setState(() {
        // loadingGreen = false;
      });
      // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  UserViewProvider userProvider = UserViewProvider();

  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult'),
    );
    if (kDebugMode) {
      print(
          '${ApiUrl.betHistory}$token&game_id=$gameid&limit=10&offset=$offsetResult');
      print('betHistory+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData
            .map((item) => BettingHistoryModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  ///tokentrx api (how to work jaha hai )
  final List<GameHistoryModel> _listdataResult = [];
  GamehistoryTRX(int gameid) async {
    final response = await http.get(Uri.parse(
      "${ApiUrl.colorresultTRX}limit=$limitResult&gameid=$gameid&offset=$offsetResult",
    ));
    if (kDebugMode) {
      print('pankaj');
      print(
          "${ApiUrl.colorresultTRX}limit=$limitResult&gameid=$gameid&offset=$offsetResult");
      print(jsonDecode(response.body));
    }

    if (response.statusCode == 200) {
      _listdataResult.clear();
      if (kDebugMode) {
        print('hhhghgjt');
      }
      final jsonData = json.decode(response.body)['data'];
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        var hash = jsonData[i]['hash'];
        var datetime = jsonData[i]['datetime'];
        var block = jsonData[i]['block'];
        if (kDebugMode) {
          print(period);
        }
        _listdataResult.add(GameHistoryModel(
            period: period.toString(),
            number: number.toString(),
            hash: hash,
            datetime: datetime,
            block: block));
      }
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
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
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

}

Widget buildTime1(int time) {
  Duration myDuration = Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = strDigits(myDuration.inMinutes.remainder(11));
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: minutes[0].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: minutes[1].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: ':', header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}

Widget buildTimeCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkcolor,
                fontSize: 15),
          ),
        ),
      ],
    );

Widget buildTime5sec(int time) {
  Duration myDuration = Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 15,
    ),
    buildTimeCard5sec(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}

Widget buildTimeCard5sec({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              gradient: AppColors.goldenGradientDir,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.primaryTextColor,
                fontSize: 100),
          ),
        )
      ],
    );

class TimeDigit extends StatelessWidget {
  final int value;
  const TimeDigit({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Winlist {
  int gameid;
  String title;
  String subtitle;
  int time;

  Winlist(this.gameid, this.title, this.subtitle, this.time);
}

class BetNumbers {
  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone, this.colortwo, this.number);
}

class Tokennumber {
  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  Tokennumber(this.photo, this.colorone, this.colortwo, this.number);
}

///howtoplay ke pass wala
class pertrecord {
  final String period;
  final String number;
  final String hashh;
  // final String datetime;
  // final String block;
  // final Color color;
  pertrecord(
    this.period,
    this.number,
    this.hashh,
    // this.datetime,
    // this.block
  );
}



///gamehistory model
class GameHistoryModel {
  final String period;
  final String number;
  final String hash;
  final String datetime;
  final String block;

  GameHistoryModel({
    required this.period,
    required this.number,
    required this.hash,
    required this.datetime,
    required this.block,
  });
}

class TotalWidget {
  String image;
  String title;
  String Subtitle;
  final Color color;
  TotalWidget(this.image, this.title, this.Subtitle, this.color);
}

List<Widget> generateNumberWidgets(int parse) {
  return List.generate(10, (index) {
    List<Color> colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ];

    if (index == parse) {
      if (parse == 0) {
        colors = [
          const Color(0xFFfd565c),
          const Color(0xFFb659fe),
        ];
      } else if (parse == 5) {
        colors = [
          const Color(0xFF40ad72),
          const Color(0xFFb659fe),
        ];
      } else {
        colors = parse % 2 == 0
            ? [
                const Color(0xFFfd565c),
                const Color(0xFFfd565c),
              ]
            : [
                const Color(0xFF40ad72),
                const Color(0xFF40ad72),
              ];
      }
    }

    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
        gradient: LinearGradient(
            colors: colors,
            stops: const [
              0.5,
              0.5,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.mirror),
      ),
      child: textWidget(
        text: '$index',
        fontWeight: FontWeight.w600,
        color: index == parse ? AppColors.primaryTextColor : Colors.black,
      ),
    );
  });
}


