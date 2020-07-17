import 'package:completeloginproject/screens/starting.dart';
import 'package:flutter/material.dart';
import '../model/onboardata.dart';

class OnBoardScreen extends StatefulWidget {
  static const String id = 'onBoardid';

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentPage = 0;
  List<SliderData> slides = new List<SliderData>();

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    slides = getSliderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (val) {
          setState(() {
            currentPage = val;
          });
        },
        itemCount: slides.length,
        itemBuilder: (context, index) {
          return SlideTiles(
            imagepath: slides[index].getImagePath(),
            title: slides[index].getTitle(),
            desc: slides[index].getDesc(),
          );
        },
      ),
      bottomSheet: currentPage != slides.length - 1
          ? Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for(int i=0; i<slides.length; i++) currentPage==i?pageIndexIndicator(true):pageIndexIndicator(false),
                  ],
                ),
              ),
            )
          : Container(
          alignment: Alignment.center,
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffd4140f),
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, StartingPage.id);
            },
            child: Text(
              'Let\'s Go',
              style:
              TextStyle(fontWeight: FontWeight.w400, color: Colors.white,fontSize: 18.0,fontFamily: 'Ubuntu'),
            ),
          ),
      ),
    );
  }
}

class SlideTiles extends StatelessWidget {
  String imagepath;
  String title;
  String desc;

  SlideTiles({this.imagepath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagepath,
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Ubuntu',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              desc,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Ubuntu',
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
