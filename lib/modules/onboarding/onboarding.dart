
import 'package:flutter/material.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/modules/log_in_screen/log_screen.dart';
import 'package:shop/shared/components/push_replacement.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}



class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/images/avoid-scam.png',
      title: LocaleKeys.onBoardingtitle01.tr(),
      body: LocaleKeys.onBoardingmessage01.tr(),),
    BoardingModel(image: 'assets/images/be-in-control.png',
      title: LocaleKeys.onBoardingtitle02.tr(),
      body: LocaleKeys.onBoardingmessage02.tr(),),
    BoardingModel(image: 'assets/images/top-rated.png',
      title: LocaleKeys.onBoardingtitle03.tr(),
      body: LocaleKeys.onBoardingmessage03.tr(),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      onBoardingScreenItem(context, boarding[index], index),
                  itemCount: 3,
                  physics: BouncingScrollPhysics(),
                  controller: boardingController,
                )),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    onDotClicked: (index) {
                      boardingController.animateToPage(
                        index,
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.linearToEaseOut,
                      );
                    },
                    controller: boardingController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Theme
                            .of(context)
                            .primaryColor,
                        dotColor: Theme
                            .of(context)
                            .primaryColor),
                  ),
                  Spacer(),
                  TextButton(onPressed: () {
                    CacheHelper.saveData(key: 'onBoarding', value: true);
                   navigatorPR(context: context, page: LogInScreen());
                      }, child: Text(LocaleKeys.skipbutton.tr())),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingScreenItem(context, model, int i) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Text(
            model.body,
            style: TextStyle(fontSize: 14.0),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}