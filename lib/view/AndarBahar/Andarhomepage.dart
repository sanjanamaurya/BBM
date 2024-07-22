import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/model/last_fifteen.dart';
import 'package:tiranga/res/aap_colors.dart';
import 'package:tiranga/res/api_urls.dart';
import 'package:tiranga/res/provider/common_api.dart';
import 'package:tiranga/utils/utils.dart';
import 'package:tiranga/view/AndarBahar/AndarBaharassets.dart';
import 'package:tiranga/view/AndarBahar/AndarbaharLoading.dart';
import 'package:tiranga/view/AndarBahar/constant/coins_sign_new.dart';
import 'package:tiranga/view/AndarBahar/constant/game_history.dart';
import 'package:tiranga/view/AndarBahar/constant/hide_coins.dart';
import 'package:tiranga/view/home/dragon_tiger_new/coin/set_coin.dart';
import 'package:tiranga/view/home/dragon_tiger_new/widgets/dragonTost.dart';
import 'package:tiranga/view/home/dragon_tiger_new/widgets/dragon_tiger_Assets.dart';
import 'package:tiranga/view/home/dragon_tiger_new/widgets/fade_animation.dart';
import 'package:tiranga/view/home/dragon_tiger_new/widgets/glory_border.dart';
import 'package:tiranga/view/home/lottery/WinGo/imagetoastWINGO.dart';
import 'package:tiranga/view/home/mini/Aviator/widget/imagetoast.dart';
import 'package:http/http.dart' as http;

class AandarBaharHome extends StatefulWidget {
  final String gameId;
  const AandarBaharHome({super.key, required this.gameId});

  @override
  State<AandarBaharHome> createState() => _AandarBaharHomeState();
}

class _AandarBaharHomeState extends State<AandarBaharHome>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    startCountdown();
    fetchData();
    super.initState();
  }
//Navigator.push(context, MaterialPageRoute(builder: (context)=>AandarBaharHome(gameId: '',)
  var _cartQuantityItems = 0;
  bool fristCome = false;
  final pattiCon = FlipCardController();

  int countdownSeconds = 30;
  Timer? countdownTimer;
  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 30 - now.second;
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 29) {
        // wallet = int.parse(context.read<MyModel>().wallet);
        // context.read<MyModel>().getprofile();
        _handleFlipCards(countdownSeconds);
        singleCard();
        // fetchData();
        if (fristCome == false) {
        } else {
          ImageToast.show(
              imagePath: AppAssets.dragontigerStartbetting,
              heights: 80,
              context: context);
        }
      } else if (countdownSeconds == 27) {
        _isFrontTwo = true;
        generateRandomCoin();
        _addCoins(randomCoin);
      } else if (countdownSeconds == 25) {
        _isFrontTwo = true;
      } else if (countdownSeconds == 20) {
      } else if (countdownSeconds == 13) {
        if (fristCome == false) {
        } else {
          ImageToast.show(
              imagePath: AppAssets.dragontigerStopbetting,
              heights: 80,
              context: context);
        }
        hidebutton = true;
      } else if (countdownSeconds == 10) {
        if (fristCome == false) {
        } else {
          if (andarCount == 0 && baharCount == 0) {
          } else {
            bettingApi();
          }
        }
      } else if (countdownSeconds == 6) {
        lastresultview();
        // walletview();
        // wallet = int.parse(context.read<MyModel>().wallet);
        // context.read<MyModel>().getprofile();
      } else if (countdownSeconds == 1) {
        _handleFlipCards(countdownSeconds);
        fetchData();
        _isFrontTwo = false;
        gameWinPopup();
        hidebutton = false;
        fristCome = true;
        countandcoinclear();
        stringList.clear();
      }
      countdownSeconds = (countdownSeconds - 1) % 30;
    });
  }

  void countandcoinclear() {
    setState(() {
      andarCoins.clear();
      andarCount = 0;

      baharCoins.clear();
      baharCount = 0;

      coins1.clear();
      coins2.clear();
    });
  }

  void _handleFlipCards(int newCountdownSeconds) {
    pattiCon.flipcard();

    countdownSeconds = newCountdownSeconds;
  }

  bool hidebutton = false;
  int? wallet = 0;
  int randomCoin = 0;
  int randomPeople = 0;
  void generateRandomCoin() {
    setState(() {
      randomCoin = Random().nextInt(90) + 10;
      randomPeople = Random().nextInt(989) + 10;
    });
  }

  void deductAmount(int amountToDeduct) {
    if (wallet! >= amountToDeduct) {
      setState(() {
        wallet = (wallet! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  int selectedCart = 1;
  GlobalKey<CartIconKey> andar = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> bahar = GlobalKey<CartIconKey>();
  late Function(GlobalKey<CartIconKey>) runAddToCartAnimation;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //  Audio.audioPlayer.dispose();
    countdownTimer?.cancel();
    super.dispose();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   // wallet = int.parse(context.read<MyModel>().wallet);
  }

  @override
  Widget build(BuildContext context) {
    return fristCome == false
        ? AndarbaharLoading(time: int.parse(countdownSeconds.toString()))
        : AddToCartAnimation(
            cartKey: selectedCart == 1 ? andar : bahar,
            height: 15,
            width: 15,
            opacity: 0.85,
            dragAnimation: const DragToCartAnimationOptions(
              rotation: false,
            ),
            jumpAnimation: const JumpAnimationOptions(),
            createAddToCartAnimation: (runAddToCartAnimation) {
              this.runAddToCartAnimation = runAddToCartAnimation;
            },
            child: Scaffold(
              body: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AndarAssets.andarbaharIvAndharBaharBg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.4),
                      child: Container(
                        height: height * 0.8,
                        width: width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AndarAssets.andarbaharIvAndarBaharTable),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            /// Middle
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.10),
                              child: Container(
                                height: height * 0.3,
                                width: width * 0.97,
                                // decoration: const BoxDecoration(
                                //   image: DecorationImage(
                                //     image: AssetImage(
                                //         AndarAssets.andarbaharIvChipsBg),
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:40),
                                      child: Container(
                                        height: height,
                                        width: width,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.textColor3,width: 2)
                                        ),
                                      ),
                                    ),
                                    ///yaha fek raha hai chips
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: height*0.05),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: height * 0.05,
                                                width: width * 0.3,
                                                decoration:
                                                const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        AndarAssets
                                                            .andarbaharTopPopAndhar),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedCart = 1;
                                                  });
                                                },
                                                child: Container(
                                                  key: andar,
                                                  height: height * 0.18,
                                                  width: width * 0.48,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color: selectedCart ==
                                                          1
                                                          ?AppColors.textColor3
                                                          : Colors
                                                          .transparent,
                                                    ),
                                                    color: selectedCart ==
                                                        1
                                                        ? Colors.blue
                                                        .withOpacity(
                                                        0.5)
                                                        : null,
                                                  ),
                                                  child: Stack(
                                                    clipBehavior:
                                                    Clip.none,
                                                    children: [
                                                      Positioned(
                                                        left: -115,
                                                        top: 50,
                                                        child: Stack(
                                                          children:
                                                          coins1,
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          for (var data
                                                          in andarCoins)
                                                            data,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top:height*0.11),
                                          child: Container(
                                            height: height * 0.3,
                                            width: 2,
                                            decoration:
                                            BoxDecoration(
                                                border: Border.all(color:AppColors.textColor3)
                                              // image: DecorationImage(
                                              //   image: AssetImage(
                                              //       AndarAssets
                                              //           .andarbaharLine),
                                              //   fit: BoxFit.fill,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: height*0.05),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: height * 0.05,
                                                width: width * 0.3,
                                                decoration:
                                                const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        AndarAssets
                                                            .andarbaharTopPopUpBahar),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                // color: Colors.red,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedCart = 2;
                                                  });
                                                },
                                                child: Container(
                                                  key: bahar,
                                                  height: height * 0.18,
                                                  width: width * 0.48,
                                                  decoration:
                                                  BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color: selectedCart ==
                                                          2
                                                          ?AppColors.textColor3
                                                          : Colors
                                                          .transparent,
                                                    ),
                                                    color: selectedCart ==
                                                        2
                                                        ? Colors.blue
                                                        .withOpacity(
                                                        0.5)
                                                        : null,
                                                  ),
                                                  child: Stack(
                                                    clipBehavior:
                                                    Clip.none,
                                                    children: [
                                                      Positioned(
                                                          left: -110,
                                                          top: 50,
                                                          child: Stack(
                                                            children:
                                                            coins2,
                                                          )),
                                                      Stack(
                                                        children: [
                                                          for (var data
                                                          in baharCoins)
                                                            data,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height*0.11),
                                      child: Container(
                                        height: 2,
                                        width: width,
                                        color:AppColors.textColor3,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.07,
                                          left: width * 0.42),
                                      child: _isFrontTwo
                                          ? AnimatedGradientBorder(
                                          borderSize: 3,
                                          gradientColors: const [
                                            Color(0xfffaee72),
                                            Colors.transparent,
                                            Color(0xfffaee72),
                                          ],
                                          borderRadius:
                                          const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          child: Image.network(
                                              singleImage.toString(),
                                              height: height / 8))
                                          : FadeInUpBig(
                                          child: Image.asset(
                                              AppAssets.imageFireCard,
                                              height: height / 13)),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(height: height*0.1,),


                            /// bottom
                            Container(
                              height: height * 0.1,
                              width: width * 12,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      AndarAssets.andarbaharIcDtBottomStrip),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.03,top: height*0.03),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.09,
                                          top: height * 0.02),
                                      child: Container(
                                        height: height * 0.03,
                                        width: width * 0.15,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AndarAssets
                                                .andarbaharPlayerWallet),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          wallet.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.22,
                                          top: height * 0.02),
                                      child: Container(
                                        height: height * 0.03,
                                        width: width * 0.12,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AndarAssets
                                                .andarbaharAddIconNew),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.32),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: GameHistoryPage(
                                                      gameId: widget.gameId),
                                                  type: PageTransitionType
                                                      .topToBottom,
                                                  duration: const Duration(
                                                      milliseconds: 500)));
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.345,
                                      ),
                                      child: SizedBox(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: list.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (context, int index) {
                                            final GlobalKey<CartIconKey>
                                                itemKey =
                                                GlobalKey<CartIconKey>();
                                            return hidebutton == true
                                                ? hidecoins(list[index])
                                                :
                                            InkWell(
                                                    onTap: () async {
                                                      wallet == null
                                                          ? Utils.flushBarErrorMessage(
                                                              'Please Recharge',
                                                              context,
                                                              Colors.white)
                                                          : wallet! <
                                                                  list[index]
                                                              ? Utils.flushBarErrorMessage(
                                                                  'Low Balance',
                                                                  context,
                                                                  Colors
                                                                      .white)
                                                              : Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1500),
                                                                  () {
                                                                  if (selectedCart ==
                                                                      1) {
                                                                    andarCoins.add(Positioned(
                                                                        left: Randomno(
                                                                            1,
                                                                            150),
                                                                        top: Randomno(
                                                                            1,
                                                                            50),
                                                                        child:
                                                                            CoindesignNew(list[index])));
                                                                  } else if (selectedCart ==
                                                                      2) {
                                                                    baharCoins.add(Positioned(
                                                                        left: Randomno(
                                                                            1,
                                                                            150),
                                                                        top: Randomno(
                                                                            1,
                                                                            50),
                                                                        child:
                                                                            CoindesignNew(list[index])));
                                                                  }
                                                                  setState(
                                                                      () {
                                                                    if (selectedCart ==
                                                                        1) {
                                                                      andarCount =
                                                                          andarCount +
                                                                              list[index];
                                                                    } else {
                                                                      baharCount =
                                                                          baharCount +
                                                                              list[index];
                                                                    }
                                                                  });
                                                                });
                                                      wallet! < list[index]
                                                          ? ''
                                                          : listClick(
                                                              itemKey);

                                                      deductAmount(
                                                        list[index],
                                                      );
                                                    },
                                                    child: Container(
                                                        key: itemKey,
                                                        child: CoindesignNew(
                                                            list[index])),
                                                  );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height*0.015),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: const AssetImage(
                                            AndarAssets.andarbaharIcons),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: NetworkImage(context
                                              .watch<MyModel>()
                                              .image
                                              .toString()),
                                          backgroundColor: Colors.white,
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
                    /// Top
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 7, left: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: height * 0.04,
                              width: width * 0.06,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AndarAssets.andarbaharBack),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 7, left: 10),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         child: GameRulesPage(gameId:widget.gameId),
                              //         type: PageTransitionType.topToBottom,
                              //         duration: const Duration(milliseconds: 500))
                              // );
                            },
                            child: Container(
                              height: height * 0.04,
                              width: width * 0.065,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      AndarAssets.andarbaharIcJackpotInfo),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              height: height * 0.05,
                              width: height * 0.05,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        Assets.imagesBethistory),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            const Text(
                              'History',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.8,bottom: height*0.055),
                      child: Center(
                        child: Container(
                          height: height*0.1,
                          width: width*0.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(AppAssets.watch)),
                          ),
                          child: Center(
                              child: Text(
                                countdownSeconds.toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w900),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height*0.41),
                      child: Container(
                        height: height / 10,
                        width: width / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AppAssets.buttonsRuppePannel),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: height / 80,
                                    backgroundImage: const AssetImage(
                                        AndarAssets.andarbaharA),
                                  ),
                                  CircleAvatar(
                                    radius: height / 80,
                                    backgroundImage: const AssetImage(
                                        AndarAssets.andarbaharB),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    andarCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    baharCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height*0.82),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AndarAssets
                                      .andarbaharIcOnlineUser),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              randomPeople.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height*0.5),
                      child: Center(
                        child: Container(
                          height: height * 0.22,
                          width: width,
                          decoration: BoxDecoration(
                            color: AppColors.textColor3.withOpacity(0.4)
                            // image: DecorationImage(
                            //   image: AssetImage(Assets
                            //       .andarbaharIvAndharBaharCarddrawnDown),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:width*0.05,top: height*0.03),
                                    child: Container(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AndarAssets
                                              .andarbaharTopPopAndhar),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      // color: Colors.red,
                                    ),
                                  ),
                                  FadeInRightBig(
                                    child: SizedBox(
                                      height: height * 0.07,
                                      width: width * 0.2,
                                      child: Stack(
                                        children: List.generate(
                                            stringList.length, (index) {
                                          double left = 00.0 +
                                              (index *
                                                  8.0);
                                          final animation = CurvedAnimation(
                                            curve: Interval(
                                              index / stringList.length,
                                              1.0,
                                              curve: Curves
                                                  .easeInOut,
                                            ),
                                            parent:
                                            const AlwaysStoppedAnimation(
                                                1),
                                          );

                                          return AnimatedPositioned(
                                            duration: const Duration(
                                                milliseconds:
                                                500),
                                            curve: Curves
                                                .easeInOut,
                                            // top: top,
                                            left: left,
                                            child: AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds:
                                                  500), // Animation duration
                                              curve: Curves
                                                  .easeInOut, // Animation curve for opacity
                                              opacity:
                                              1.0, // Initially set to 1
                                              child: FadeTransition(
                                                opacity:
                                                animation, // Use the CurvedAnimation
                                                child: Row(
                                                  children: [
                                                    if (index.isEven)
                                                      AnimatedGradientBorder(
                                                          borderSize:
                                                          (stringList.length -
                                                              1) ==
                                                              index
                                                              ? 2
                                                              : 0,
                                                          gradientColors: const [
                                                            Color(
                                                                0xfffaee72),
                                                            Colors
                                                                .transparent,
                                                            Color(
                                                                0xfffaee72),
                                                          ],
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                            Radius.circular(
                                                                5),
                                                          ),
                                                          child:
                                                          Image.network(
                                                            stringList[
                                                            index], // Use the image URL at the current index
                                                            width:
                                                            25.0, // Fixed width
                                                            height:
                                                            35.0, // Fixed height
                                                            fit:
                                                            BoxFit.fill,
                                                          ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:width*0.05,top: height*0.03),
                                    child: Container(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AndarAssets
                                              .andarbaharTopPopUpBahar),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      // color: Colors.red,
                                    ),
                                  ),
                                  FadeInRightBig(
                                    child: SizedBox(
                                      height: height * 0.07,
                                      width: width * 0.2,
                                      child: Stack(
                                        children: List.generate(
                                            stringList.length, (index) {
                                          double left = 00.0 +
                                              (index *
                                                  8.0); // Adjusted left position for overlap

                                          // Create a CurvedAnimation with an Interval to stagger the animations
                                          final animation = CurvedAnimation(
                                            curve: Interval(
                                              index / stringList.length,
                                              1.0,
                                              curve: Curves
                                                  .easeInOut, // Apply curve inside Interval
                                            ),
                                            parent:
                                            const AlwaysStoppedAnimation(
                                                1), // Animation controller
                                          );

                                          return AnimatedPositioned(
                                            duration: const Duration(
                                                milliseconds:
                                                500), // Animation duration
                                            curve: Curves
                                                .easeInOut, // Animation curve for position
                                            // top: top,
                                            left: left,
                                            child: AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds:
                                                  500), // Animation duration
                                              curve: Curves
                                                  .easeInOut, // Animation curve for opacity
                                              opacity:
                                              1.0, // Initially set to 1
                                              child: FadeTransition(
                                                opacity:
                                                animation, // Use the CurvedAnimation
                                                child: Row(
                                                  children: [
                                                    if (index.isOdd)
                                                      AnimatedGradientBorder(
                                                          borderSize:
                                                          (stringList.length -
                                                              1) ==
                                                              index
                                                              ? 2
                                                              : 0,
                                                          gradientColors: const [
                                                            Color(
                                                                0xfffaee72),
                                                            Colors
                                                                .transparent,
                                                            Color(
                                                                0xfffaee72),
                                                          ],
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                            Radius.circular(
                                                                5),
                                                          ),
                                                          child:
                                                          Image.network(
                                                            stringList[
                                                            index], // Use the image URL at the current index
                                                            width:
                                                            25.0, // Fixed width
                                                            height:
                                                            35.0, // Fixed height
                                                            fit:
                                                            BoxFit.fill,
                                                          ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height*0.01),
                                child: Container(
                                  height: height * 0.05,
                                  width: width * 0.98,
                                  decoration: BoxDecoration(
                                    color: AppColors.TextBlack.withOpacity(0.4)
                                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                    // image: DecorationImage(
                                    //   image: AssetImage(
                                    //       AndarAssets.andarbaharGamebuttonbg),
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width*0.4,
                                      ),
                                      SizedBox(
                                        height: height / 25,
                                        width: width / 2.5,
                                        child: ListView.builder(
                                          itemCount: items.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: CircleAvatar(
                                                radius: height / 55,
                                                backgroundImage: AssetImage(
                                                    items[index].number == '2'
                                                        ? AndarAssets
                                                        .andarbaharB
                                                        : AndarAssets
                                                        .andarbaharA),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Image.asset(
                                          AppAssets.buttonsIcArrowZigzag,
                                          height: height / 19),
                                    ],
                                  ),
                                  // color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height*0.05),
                      child: Center(child: Image.asset(Assets.imagesGirlCharSeven,width: width*0.25,height: height*0.15,)),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  List<int> list = [1, 5, 10, 50, 100, 500, 1000];
  int andarCount = 0;
  int baharCount = 0;
  bool _isFrontTwo = false;

  List<Widget> andarCoins = [];
  List<Widget> baharCoins = [];

  Randomno(int min, int max) {
    Random random = Random();
    return double.parse((min + random.nextInt(max - min + 1)).toString());
  }

  void listClick(GlobalKey<CartIconKey> itemKey) async {
    await runAddToCartAnimation(itemKey);
    if (selectedCart == 1 && andar.currentState != null) {
      andar.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Dragon');
    } else if (selectedCart == 2 && bahar.currentState != null) {
      bahar.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tie');
    }
  }

  List<Widget> coins1 = [];
  List<Widget> coins2 = [];
  void _addCoins(int count) {
    for (int i = 0; i < count; i++) {
      Timer(Duration(milliseconds: i * 200), () {
        setState(() {
          coins1.add(
            const _AnimatedCoin(
              type: 0,
            ),
          );

          coins2.add(
            const _AnimatedCoin(
              type: 1,
            ),
          );
        });
      });
    }
  }

  List<LastFifteen> items = [];

  Future<void> fetchData() async {
    var gameids = widget.gameId;
    final response =
        await http.get(Uri.parse("${ApiUrl.result}$gameids&limit=15"));
    print("${ApiUrl.result}$gameids&limit=15");
    print('qqqqqq');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      print(responseData);
      print('eeeeeeee');
      setState(() {
        items = responseData.map((item) => LastFifteen.fromJson(item)).toList();
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

  // *beting API*  //
  bettingApi() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final betList = [
      {'number': '1', 'amount': andarCount.toString()},
      {'number': '2', 'amount': baharCount.toString()},
    ];

    final response = await http.post(
      Uri.parse(ApiUrl.betPlaced),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userid": userid,
        "game_id": widget.gameId,
        "json": betList,
      }),
    );

    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      ImageToast.show(
          imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
      countandcoinclear();
    } else {
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  var WinResult;
  var gamesNo;
  List<String> stringList = [];
  lastresultview() async {
    var gameids = widget.gameId;

    try {
      final url = Uri.parse('${ApiUrl.result}$gameids&limit=1');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"][0];
        setState(() {
          WinResult = responseData["number"];
          gamesNo = int.parse(responseData["gamesno"].toString()) + 1;
          final List<dynamic> cardImage = json.decode(responseData["json"]);
          stringList =
              cardImage.map((dynamic item) => item.toString()).toList();
        });

        WinResult == '1'
            ? TextToast.show(context: context, message: 'Andar Win')
            : TextToast.show(context: context, message: 'Bahar Win');
        print('Successfully fetched contact data');
        print(gamesNo);
        print('gjjjjjjjjjjj');
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data. $e");
    }
  }

  var singleImage;
//singleCard
  Future<void> singleCard() async {
    var gameids = widget.gameId;
    try {
      final url = Uri.parse('${ApiUrl.result}$gameids&limit=1');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"][0];
        setState(() {
          singleImage = responseData["random_card"];
        });
        print(singleImage);
        print('rrrrrrffffff');
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data. $e");
    }
  }

// game win popup
  gameWinPopup() async {
    print(widget.gameId);
    print(gamesNo.toString());
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(ApiUrl.winAmount),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userid": userid.toString(),
        "game_id": widget.gameId.toString(),
        "game_no": gamesNo.toString()
      }),
    );

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print('nbnbnbnbn');
      print(data);
      print('data');
    }
    if (data["status"] == 200) {
      var win = data["win"].toString();
      var result = data["result"].toString();
      var gsm = data["gamesno"].toString();
      print('vbbbbbbbbbb');
      win == '0'
          ? ImageToastWingo.showloss(
              subtext: result, subtext1: gsm, subtext2: win, context: context)
          : ImageToastWingo.showwin(
              subtext: result,
              subtext1: gsm,
              subtext2: win,
              context: context,
            );
    } else {
      setState(() {
        // loadingGreen = false;
      });
      // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }
}

class _AnimatedCoin extends StatefulWidget {
  final int type;

  const _AnimatedCoin({required this.type});
  @override
  _AnimatedCoinState createState() => _AnimatedCoinState();
}

class _AnimatedCoinState extends State<_AnimatedCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = widget.type == 1
        ? Tween<Offset>(
            begin: const Offset(10, 50),
            end: _randomOffset(100, 150),
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
          )
        : Tween<Offset>(
            begin: const Offset(10, 50),
            end: _randomOffset(100, 150),
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
          );

    _controller.forward();
  }

  doublepj(double start, double end) {
    Random random = Random();

    return start + random.nextDouble() * (end - start);
  }

  Offset _randomOffset(double start, double end) {
    double randomPositionX = doublepj(50, 200);
    double randomPositionY = doublepj(50, 100);
    return Offset(randomPositionX, randomPositionY);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: const CoinSpringAnimation(),
        );
      },
    );
  }
}
