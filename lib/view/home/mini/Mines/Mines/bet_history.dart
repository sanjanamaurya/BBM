import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiranga/generated/assets.dart';
import 'package:tiranga/main.dart';
import 'package:tiranga/model/user_model.dart';
import 'package:tiranga/res/aap_colors.dart';
import 'package:tiranga/res/api_urls.dart';
import 'package:tiranga/res/components/text_widget.dart';
import 'package:tiranga/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;
import 'package:tiranga/view/home/mini/Mines/Mines/mine_history_model.dart';


class MineGameHistory extends StatefulWidget {
  @override
  State<MineGameHistory> createState() => _MineGameHistoryState();
}


class _MineGameHistoryState extends State<MineGameHistory> {

  @override
  void initState() {
    super.initState();
    MinesBetHistoryApi();
  }

  int limitResult = 0;
  int pageNumber = 1;

  int itemsPerPage = 10;


  @override
  Widget build(BuildContext context) {
    int numberPages = (int.parse(count)/ itemsPerPage).ceil();
    return  Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: height*0.8,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff212226).withOpacity(0.9),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width*0.05,
                      ),
                      Text('GAME HISTORY',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     Spacer(),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.cancel_outlined,color: Colors.white,),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Container(
                    height: height,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width:width*0.25,
                                child: Center(
                                  child: Text('Time',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: width*0.15,
                                child: Center(
                                  child: Text('Bet',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width*0.2,
                                child: Center(
                                  child: Text('Cash out',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width*0.2,
                                child: Text('Multiplier',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          responseStatuscode== 400? notFoundData():
                          MinesDataList.isEmpty? Center(child: CircularProgressIndicator()):
                          Container(
                            height: height*0.55,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: MinesDataList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: height*0.05,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Color(0xff394c54),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width:width*0.25,
                                                child: Center(
                                                  child: Text(MinesDataList[index].datetime.toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: width*0.15,
                                                child: Center(
                                                  child: Text("${MinesDataList[index].amount}.00₹",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: int.parse(MinesDataList[index].winAmount.toString()) >int.parse(MinesDataList[index].amount.toString())
                                                          ? Colors.green
                                                          : Colors.white,

                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width*0.2,
                                                child: Center(
                                                  child: Text("+${MinesDataList[index].winAmount}.00₹",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: int.parse(MinesDataList[index].winAmount.toString()) >int.parse(MinesDataList[index].amount.toString())
                                                          ? Colors.green
                                                          : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width*0.2,
                                                child: Center(
                                                  child: Text("${MinesDataList[index].multipler}x",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: int.parse(MinesDataList[index].winAmount.toString()) >int.parse(MinesDataList[index].amount.toString())
                                                          ? Colors.green
                                                          : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: height*0.01,
                          ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pageNumber > 1
                                ? () {
                              setState(() {
                                pageNumber--;
                                limitResult = limitResult - 10;
                                offsetResult = offsetResult - 10;
                              });
                              MinesBetHistoryApi();
                            }
                                : null,
                            child: Container(
                              height: height * 0.06,
                              width: width * 0.10,
                              decoration: BoxDecoration(
                                color: Color(0xff394c54),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.navigate_before,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          textWidget(
                            text: '$pageNumber/$numberPages',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryTextColor,
                            maxLines: 1,
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: pageNumber < (int.parse(count) / itemsPerPage).ceil()
                                ? () {
                              setState(() {
                                pageNumber++;
                                limitResult = limitResult + 10;
                                offsetResult = offsetResult + 10;
                              });
                              MinesBetHistoryApi();
                            }
                                : null,
                            child: Container(
                              height: height * 0.06,
                              width: width * 0.10,
                              decoration: BoxDecoration(
                                color: Color(0xff394c54),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  int? responseStatuscode;

   String count='0';
  UserViewProvider userProvider = UserViewProvider();
  int offsetResult = 0;
  List<MineHistoryModel> MinesDataList = [];
  Future<void> MinesBetHistoryApi() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.MineBetHistory}userid=$token&offset=$offsetResult&limit=$itemsPerPage"),
    );
    print("${ApiUrl.MineBetHistory}userid=$token&offset=$offsetResult&limit=$itemsPerPage");
    setState(() {
      responseStatuscode = response.statusCode;
    });
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      count = json.decode(response.body)['count'];
      setState(() {
        count;
        MinesDataList = responseData
            .map((item) => MineHistoryModel.fromJson(item))
            .toList();
      });
      print(count);
      print('sxsxs');
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        MinesDataList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class notFoundData extends StatelessWidget {
  const notFoundData({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: height*0.21,),

        const Text("No data (:",style: TextStyle(color: Colors.white),)
      ],
    );
  }

}