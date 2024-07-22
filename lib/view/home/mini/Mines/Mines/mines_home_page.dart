import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiranga/view/home/mini/Mines/Mines/mines_drawer.dart';
import 'package:provider/provider.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/model/user_model.dart';
import 'package:tiranga/res/aap_colors.dart';
import 'package:tiranga/res/api_urls.dart';
import 'package:tiranga/res/components/app_btn.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/res/provider/profile_provider.dart';
import 'package:tiranga/res/provider/user_view_provider.dart';
import 'package:http/http.dart'as http;

class MinesHomePage extends StatefulWidget {
  const MinesHomePage({super.key});

  @override
  State<MinesHomePage> createState() => _MinesHomePageState();
}

class _MinesHomePageState extends State<MinesHomePage> {
  TextEditingController amount = TextEditingController();
  int selectedIndex = 10;
  var initValue = 0;
  void incrementCounter() {
    setState(() {
      selectedIndex += initValue;
      amount.text = selectedIndex.toString();
    });
  }

  void decrementCounter() {
    setState(() {
      if (selectedIndex >= initValue) {
        selectedIndex -= initValue;
        amount.text = selectedIndex.toString();
      }
    });
  }

  void dispose() {
    amount.dispose();
    super.dispose();
  }

  List<int> list = [
    10,
    20,
    50,
    100,
    200,
    500,
    1000,
    5000,
  ];
  int dropdownMines = 3;
  bool cashOut =false;
  String displayedValue = '1.10';
  void _onChanged(int? newValue) {
    setState(() {
      dropdownMines = newValue!;
      _refreshGame();
      if (dropdownMines == 1) {
        displayedValue = "1.01";
      } else if (dropdownMines == 2) {
        displayedValue = "1.05";
      } else if (dropdownMines == 3) {
        displayedValue = "1.10";
      } else if (dropdownMines == 4) {
        displayedValue = "1.15";
      } else if (dropdownMines == 5) {
        displayedValue = "1.20";
      } else if (dropdownMines == 6) {
        displayedValue = "1.25";
      } else if (dropdownMines == 7) {
        displayedValue = "1.30";
      } else if (dropdownMines == 8) {
        displayedValue = "1.40";
      } else if (dropdownMines == 9) {
        displayedValue = "1.45";
      } else if (dropdownMines == 10) {
        displayedValue = "1.55";
      } else if (dropdownMines == 11) {
        displayedValue = "1.60";
      } else if (dropdownMines == 12) {
        displayedValue = "1.65";
      } else if (dropdownMines == 13) {
        displayedValue = "1.70";
      } else if (dropdownMines == 14) {
        displayedValue = "1.75";
      } else if (dropdownMines == 15) {
        displayedValue = "1.80";
      } else if (dropdownMines == 16) {
        displayedValue = "1.85";
      } else if (dropdownMines == 17) {
        displayedValue = "1.90";
      } else if (dropdownMines == 18) {
        displayedValue = "1.95";
      } else if (dropdownMines == 19) {
        displayedValue = "2.00";
      } else {
        displayedValue = "2.10";
      }
    });
    print(displayedValue);
    print("displayedValue");
  }
  int rows = 5;
  int columns = 5;

  List<List<bool>> grid = [];
  List<bool> selectedCells = [];
  bool isTapped = false;
  bool gameLost = false;
  double amountVale= 0.0;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = List.generate(rows, (_) => List.filled(columns, false));
    selectedCells = List.filled(rows * columns, false);

    // Place mines randomly
    final random = Random();
    int minesPlaced = 0;
    while (minesPlaced < dropdownMines) {
      final index = random.nextInt(rows * columns);
      if (!grid[index ~/ columns][index % columns]) {
        grid[index ~/ columns][index % columns] = true;
        minesPlaced++;
      }
    }
  }

  void _refreshGame() {
    setState(() {
      _initializeGrid();
      amountVale= 0.0;
      selectedLength=0;
      isTapped = false;
      gameLost = false;
    });
  }

  void _toggleTappedCell(int index) {
    setState(() {
      if (grid[index ~/ columns][index % columns]) {
        gameLost = true;
        print('game Lost');
        cashOut=false;
         amountVale= 0.0;

        mineCashOut(amountVale.toStringAsFixed(2),displayedValue,'2');

        print(amountVale);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context)
            {
              return  AlertDialog(
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                content: SizedBox(
                  height: height * 0.55,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: width,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.imagesHowtoplayheader),
                                fit: BoxFit.fill)),
                        child: Center(
                            child: textWidget(
                                text: 'You Lose',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primaryTextColor)),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: rows * columns,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                        ),
                        itemBuilder: (context, index) {
                          final row = index ~/ columns;
                          final col = index % columns;
                          return GestureDetector(
                            onTap: () {
                              if (!gameLost) {
                                setState(() {
                                  isTapped = true;
                                  _toggleTappedCell(index);
                                  selectedLength = selectedCells.where((cell) => cell).length;
                                  amountVale = selectedIndex + (selectedLength * double.parse(displayedValue));
                                  print("Selected length: $selectedLength");
                                  print("Amount: $amountVale");

                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                image:  DecorationImage(image: AssetImage(
                                    selectedCells[index]
                                        ? Assets.iconsVault
                                        : isTapped && grid[row][col] && gameLost
                                        ?Assets.imagesMinesBomb
                                        :Assets.imagesMinesGrid
                                ),fit: BoxFit.fill),

                              ),

                            ),
                          );
                        },
                      ),
                      Container(
                        height: height * 0.085,
                        decoration: const BoxDecoration(
                          color: AppColors.scaffolddark,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                          child: AppBtn(
                              title: 'Close',
                              fontSize: 15,
                              onTap: () {
                                _refreshGame();
                                Navigator.pop(context);

                              },
                              hideBorder: true,
                              gradient: AppColors.buttonGradient2),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });

      } else {
        selectedCells[index] = !selectedCells[index];
        print('game go On');
      }
    });
  }
  int selectedLength=0;
  @override
  Widget build(BuildContext context) {
    double progressValue = selectedLength / (25-dropdownMines);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:  BoxDecoration(gradient: AppColors.minesBgColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.03,
                    right: width * 0.03),
                child: Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppColors.minesContainer,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppBackBtn(),
                      const Text(
                        '        MINES',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      Container(
                        child: Row(
                          children: [
                             Text(
                              context.read<ProfileProvider>().mainWallet.toStringAsFixed(2)+' INR',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const MinesDrawer();
                                    },
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: const Offset(0,
                                              3), // Adjust the shadow's position here
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)),
                                  child: const Icon(Icons.menu,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SizedBox(
                  height: height * 0.62,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * 0.04,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              gradient: AppColors.minesContainer,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: const Color(0xFF015759),
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(width: 1, color: Colors.black),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Center(
                                      child: DropdownButton<int>(
                                        menuMaxHeight: height * 0.5,
                                        borderRadius: BorderRadius.circular(10),
                                        value: dropdownMines,
                                        onChanged: _onChanged,
                                        isExpanded: true,
                                        iconSize: 24, // Size of the dropdown arrow
                                        iconEnabledColor: Colors
                                            .white, // Color of the dropdown arrow
                                        dropdownColor: const Color(
                                            0xFF015759), // Background color of the dropdown menu
                                        alignment: Alignment.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .white, // This is for the dropdown button text
                                        ),
                                        items: List.generate(20, (index) {
                                          int value = index + 1;
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Center(
                                              child: Text(
                                                'Mines:  $value',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .white, // This is for the dropdown items text
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2.0),
                                  child: Container(
                                      width: width * 0.3,
                                      decoration: BoxDecoration(
                                        color:  cashOut==true?Colors.green:const Color(0xffffc107),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Next:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black, // This is for the dropdown button text
                                              ),
                                            ),
                                            Text(
                                              displayedValue.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black, // This is for the dropdown button text
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          if(cashOut==true)
                            Container(
                              height: height * 0.04,
                              width: width,
                              color: Colors.transparent,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: LinearProgressIndicator(
                          value: progressValue, // Progress based on the count value
                          backgroundColor: const Color(0xff013599),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      SizedBox(
                          height: height * 0.55,
                          child:   Stack(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: rows * columns,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                ),
                                itemBuilder: (context, index) {
                                  final row = index ~/ columns;
                                  final col = index % columns;
                                  return GestureDetector(
                                    onTap: () {
                                      if (!gameLost) {
                                        setState(() {
                                          isTapped = true;
                                          _toggleTappedCell(index);
                                           selectedLength = selectedCells.where((cell) => cell).length;
                                           amountVale = selectedIndex + (selectedLength * double.parse(displayedValue));
                                          print("Selected length: $selectedLength");
                                          print("Amount: $amountVale");

                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        image:  DecorationImage(image: AssetImage(
                                            selectedCells[index]
                                               ? Assets.iconsVault
                                                : isTapped && grid[row][col] && gameLost
                                                ?Assets.imagesMinesBomb
                                                :Assets.imagesMinesGrid
                                        ),fit: BoxFit.fill),

                                      ),

                                    ),
                                  );
                                },
                              ),
                              if(cashOut==false)
                              Container(
                                height: height * 0.55,
                                width: width,
                                color: Colors.transparent,
                              )
                            ],
                          ),
                )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  height: height * 0.23,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppColors.minesContainer),
                  // Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        height: height * 0.08,
                        child: Stack(
                          children: [
                            Container(
                              width: width * 0.8,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF0267a5),
                                  // Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        '                 Bet',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: height * 0.04,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(4),
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        Colors.grey.withOpacity(0.3),
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                color: const Color(0xFF015759),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    width: 1, color: Colors.black),
                                              ),
                                              child: Text(
                                                '$selectedIndex ₹',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              )),
                                        ],
                                      ),
                                      const SizedBox()
                                    ],
                                  ),
                                  InkWell(
                                    onTap: decrementCounter,
                                    child: Container(
                                        margin: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: const Offset(0,
                                                    3), // Adjust the shadow's position here
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.black)),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: Colors.white,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => betPopUp());
                                    },
                                    child: Container(
                                        margin: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: const Offset(0,
                                                    3), // Adjust the shadow's position here
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.black)),
                                        child: Image.asset(
                                          Assets.iconsStack,
                                          height: 20,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      incrementCounter();
                                    },
                                    child: Container(
                                        margin: EdgeInsets.zero,
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: const Offset(0,
                                                    3), // Adjust the shadow's position here
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.black)),
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            if(cashOut==true)
                            Container(
                              width: width * 0.8,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  // Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(35)),

                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      cashOut==false?
                      InkWell(
                        onTap:(){
                          setState(() {
                            cashOut=true;
                          });
                          _refreshGame();

                          mineBets(selectedIndex.toString());
                        },
                        child: Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              gradient: AppColors.ssbutton,
                              // Colors.greenAccent,
                              borderRadius: BorderRadius.circular(35)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.play_arrow_outlined,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Play',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):
                      InkWell(
                        onTap:(){
                          setState(() {
                            cashOut=false;
                          });
                          mineCashOut(amountVale.toStringAsFixed(2),displayedValue,'1');

                        },
                        child: Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              gradient: AppColors.containerYellowGradient,
                              // Colors.greenAccent,
                              borderRadius: BorderRadius.circular(35)),
                          child:   Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.pause,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Cash Out:${amountVale.toStringAsFixed(2)} INR',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget betPopUp() {
    return Dialog(
      child: Container(
        height: 270,
        width: 300,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF117ea7),
              Color(0xFF19a99f),
              Color(0xFF117ea7),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Bet',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
                height: 240,
                width: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF117ea7),
                      Color(0xFF19a99f),
                      Color(0xFF117ea7),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 15, // Spacing between rows
                            childAspectRatio: 3.5),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            initValue = list[index];
                            selectedIndex = initValue;
                            amount.text = initValue.toString();
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedIndex == list[index]
                                    ? const Color(0xFF017c80)
                                    : const Color(0xFF006366),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(list[index].toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ))),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();
  mineBets(String amount,) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.MineBet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":token,
        "game_id":"12",
        "amount":amount
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      context.read<ProfileProvider>().fetchProfileData();
      print( context.read<ProfileProvider>().mainWallet);

      Fluttertoast.showToast(msg: responseData['message']);

      print( 'a rhaaaaa haiii'); 
    } else {
      //setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }

  mineCashOut(String cashOut,String multiplier,String status) async {
    UserModel user = await userProvider.getUser();
    print(status);
    print('qscsea');
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.MineCashOut),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":token,
        "win_amount":cashOut,
        "multipler":multiplier,
        "status":status
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");

      context.read<ProfileProvider>().fetchProfileData();
      print( context.read<ProfileProvider>().mainWallet);
      Fluttertoast.showToast(msg: responseData['message']);
      if(status=='1')
      _refreshGame();

    } else {
      //setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }
}
