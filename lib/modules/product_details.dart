import 'package:flutter/material.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetails extends StatelessWidget {
  PageController productController = PageController();

  final List<dynamic> images;
  final String title;
  final String description;
  final dynamic price;
  final dynamic oldPrice;

  ProductDetails(
      this.images, this.title, this.description, this.price, this.oldPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: PageView.builder(
                      itemBuilder: (context, index) => Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                      itemCount: images.length,
                      physics: BouncingScrollPhysics(),
                      controller: productController,
                    ),
                  ),
                  Positioned(
                    child: SmoothPageIndicator(
                      onDotClicked: (index) {
                        productController.animateToPage(
                          index,
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.linearToEaseOut,
                        );
                      },
                      controller: productController,
                      count: images.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Theme.of(context).primaryColor),
                    ),
                    bottom: 20.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 45.0,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    '${price.round()} ${LocaleKeys.le.tr()}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    '${oldPrice.round()} ${LocaleKeys.le.tr()}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            Padding (
              padding: const EdgeInsets.all(3.0),
              child: Text(
                LocaleKeys.description.tr().toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: double.infinity,
                height: 125,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
