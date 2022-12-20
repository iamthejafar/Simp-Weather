import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'get_data.dart';
import 'package:lottie/lottie.dart';
Color kinactivecolor = Color(0xff12122d);
Color kiconcolor = Color(0xffefeff1);
TextStyle klabelstyle = TextStyle(
  color: kiconcolor,
  fontSize: 30,
);
int flag = 0;
var latitude;
var longitude;
var weatherData;
var weatherData2;
var iconcode;
var temp;
var cond;
var city;
var humidity;
var wind;
var region;
class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  void getLocation() async{
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    if(flag == 0){
      latitude = position.latitude;
      longitude = position.longitude;
    }

    String link = 'http://api.weatherstack.com/current?access_key=f9742dadfca0c028c2db25a288efbd0e&query=$latitude,$longitude';
    GetData getdata = GetData(link);
    weatherData = await getdata.fetchData();
    temp = weatherData['current']['temperature'];
    temp = temp.toInt().toString();
    cond = weatherData['current']['weather_descriptions'][0];
    humidity = weatherData['current']['humidity'];
    wind = weatherData['current']['wind_speed'];
    city = weatherData['location']['name'];
    city = city.toString();
    region = weatherData['location']['region'];
    region = region.toString();

    String link2 ='https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=6d4001bfc3ae16b00b4de3c3fc1ff0d2';
    GetData getdata2 = GetData(link2);
    weatherData2 = await getdata2.fetchData();
// print(weatherData2);
    iconcode = weatherData2['weather'][0]['icon'];
    // print(iconcode);


  }
  void initState(){
    super.initState();
    flag = 0;
    getLocation();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kinactivecolor,
                      ),
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) async{
                          print(value);
                          city = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              child: Icon(Icons.search,),
                              onTap: () async{
                                String link3 = 'http://api.positionstack.com/v1/forward?access_key=fcfb6ca0f890df406794f9a9c948e7d4&%20query=$city';
                                GetData locationdata = GetData(link3);
                                final response = await locationdata.fetchData();
                                setState(() {
                                  flag = 1;
                                  latitude = response['data'][0]['latitude'];
                                  longitude = response['data'][0]['longitude'];
                                  getLocation();
                                });
                                print(response['data'][0]['latitude']);
                                print(response['data'][0]['longitude']);

                              },
                          ),
                          labelStyle: TextStyle(
                            color: kiconcolor,
                          ),
                          labelText: 'Enter City',
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              size: 30,
                              Icons.location_city,
                              color: kiconcolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          flag = 0;
                          getLocation();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kinactivecolor,
                        ),
                        height: 55,
                        margin: EdgeInsets.all(10),

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            size:30,
                            Icons.location_on,
                            color: kiconcolor,
                          ),
                        ),
                      ),
                    ),
                )
              ],
            ),
            Text('$city, $region',
              style: klabelstyle,
            ),
            // Lottie.asset('images/try.json',fit: BoxFit.fill),
            SvgPicture.asset('images/$iconcode.svg',height: 350,),
            // ColorFiltered(
            //   colorFilter: const ColorFilter.mode(
            //     Colors.grey,
            //     BlendMode.saturation,
            //   ),
            //   // child: Image.network('$weathoricon',
            //   // ),
            //   child: Image.asset('images/img1.png',
            //   height: 200
            //     ,),
            // ),
            Text('$cond',style: klabelstyle,),
            SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    // height: 100,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kinactivecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text('TEMPERATURE',
                            style: TextStyle(
                                color: kiconcolor
                            ),
                          ),
                          Text('$temp ° C',style: klabelstyle,)
                        ],
                      )
                  ),
                ),
                Expanded(
                  child:  Container(
                    // height: 100,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kinactivecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text('HUMIDITY',
                            style: TextStyle(
                                color: kiconcolor
                            ),
                          ),
                          Text('$humidity %',style: klabelstyle,)
                        ],
                      )
                  ),
                ),
                Expanded(
                  child:  Container(
                    // height: 100,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kinactivecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text('WIND SPEED',
                            style: TextStyle(
                                color: kiconcolor
                            ),
                          ),
                          Text('$wind Km/h',style: klabelstyle,)
                        ],
                      )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



//
//
// class AssignData extends StatefulWidget {
//
//   late final String link;
//   AssignData(this.link);
//
//   @override
//   State<AssignData> createState() => _AssignDataState();
// }
//
// class _AssignDataState extends State<AssignData> {
//
//
//
//   void assigndata() async{
//     GetData getdata = GetData(link);
//     weatherData = await getdata.fetchData();
//     temp = weatherData['current']['temperature'];
//     temp = temp.toInt().toString();
//     cond = weatherData['current']['weather_descriptions'][0];
//     humidity = weatherData['current']['humidity'];
//     wind = weatherData['current']['wind_speed'];
//     city = weatherData['location']['name'];
//     city = city.toString();
//     region = weatherData['location']['region'];
//     region = region.toString();
//
//     String link2 ='https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=6d4001bfc3ae16b00b4de3c3fc1ff0d2';
//     GetData getdata2 = GetData(link2);
//     weatherData2 = await getdata2.fetchData();
// // print(weatherData2);
//     iconcode = weatherData2['weather'][0]['icon'];
//     print(iconcode);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
//
//
