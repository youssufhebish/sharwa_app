
import 'package:flutter/material.dart';
import 'package:shop/modules/log_in_screen/log_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    BoardingModel(image: 'assets/images/onBoarding.png',
      title: 'Hello title 01',
      body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',),
    BoardingModel(image: 'assets/images/onBoarding.png',
      title: 'Hello title 02',
      body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',),
    BoardingModel(image: 'assets/images/onBoarding.png',
      title: 'Hello title 03',
      body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',),
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
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()),
                        );
                      }, child: Text('SKIP')),
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
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Text(
            model.body,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}