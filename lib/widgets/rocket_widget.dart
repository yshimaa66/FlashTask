import 'package:date_count_down/date_count_down.dart';
import 'package:flash_test/helper/formatDate.dart';
import 'package:flash_test/helper/navigation.dart';
import 'package:flash_test/modules/details/detail_page.dart';
import 'package:flash_test/models/rocket_model.dart';
import 'package:flash_test/utilities/colors.dart';
import 'package:flash_test/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RocketWidget extends StatelessWidget {

  final RocketModel rocketModel;
  final int index;
  final bool isNext;
  final bool isPast;

  const RocketWidget({Key? key,
    required this.rocketModel,required this.index,
    this.isNext = false,this.isPast=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/10),
      child: InkWell(
        onTap: () {
          navigateTo(context, RocketDetailPage(
            rocketModel: rocketModel,
          ),);
        },
        child: Stack(
          children: <Widget>[
                //SizedBox(height: 100),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: rocketModel.id,
                          child: Container(
                              //width: MediaQuery.of(context).size.width/5,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                image: DecorationImage(
                                  image: new AssetImage(rocketImagePath),
                                  fit: BoxFit.fill,
                                ),
                        )),),
                        SizedBox(height: height/40,),
                        Text(
                              rocketModel.name,
                              style: TextStyle(
                                fontSize: 30,
                                color: const Color(0xff47455f),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),

                        Text(
                          'XSpace',
                          style: TextStyle(
                            fontSize: 23,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: height/50,),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                              color: navigationColor,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              formatDate(rocketModel.dateTime.toString()),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xff47455f).withOpacity(.5),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.left,
                              ),
                          ],
                        ),
                        SizedBox(height: height/50,),

                        Visibility(
                          visible: !isNext,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Know more',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 18,
                                  color: secondaryTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: secondaryTextColor,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Visibility(
                //     visible: !isNext,
                //     child: Padding(
                //       padding: EdgeInsets.only(bottom: height/10,top: height/10),
                //       child: Text(
                //         (index+1).toString(),
                //         style: TextStyle(
                //           fontSize: 80,
                //           color: primaryTextColor.withOpacity(0.08),
                //           fontWeight: FontWeight.w900,
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //     ),
                //   ),
                // ),


            Align(
              alignment: Alignment.bottomCenter,
              child: !isPast?Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: primaryTextColor,
                  ),
                padding: const EdgeInsets.all(15.0),
                  child: CountDownText(
                    due: DateTime.fromMillisecondsSinceEpoch(
                        int.parse(rocketModel.dateTime.toString())* 1000),
                    finishedText: "Rocket Launched",
                    showLabel: true,
                    longDateName: false,
                    style: TextStyle(
                      fontSize: 20,
                      color: titleTextColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ):Text(""),),

              ],
            ),


      ),
    );
  }
}
