class SliderData{
  String imagePath;
  String title;
  String desc;
  SliderData({this.imagePath,this.title,this.desc});
  void setData(String img, String til, String des){
    imagePath = img;
    title = til;
    desc = des;
  }
  String getImagePath(){
    return imagePath;
  }
  String getTitle(){
    return title;
  }
  String getDesc(){
    return desc;
  }
}
List<SliderData> getSliderData(){
  List<SliderData> slides = new List<SliderData>();
  SliderData slide1 = new SliderData();
  slide1.setData('images/firebase.png','Firebase Support','Provides Firebase Email Login Support');
  slides.add(slide1);
  SliderData slide2 = new SliderData();
  slide2.setData('images/facebook.png','Facebook Authorization','Provides Facebook authorization');
  slides.add(slide2);
  SliderData slide3 = new SliderData();
  slide3.setData('images/google.png','Gmail Authorization','Provides Gmail authorization');
  slides.add(slide3);
  return slides;
}