import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'get_data.dart';
Color kinactivecolor = Color(0xff12122d);
Color kiconcolor = Color(0xffefeff1);
TextStyle klabelstyle = TextStyle(
  color: kiconcolor,
  fontSize: 30,
);
var latitude;
var longitude;
var weatherData;
var temp;
var cond;
var city;
var humidity;
var wind;
var region;
String weathoricon ='';
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
    latitude = position.latitude;
    longitude = position.longitude;
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
    weathoricon = weatherData['current']['weather_icons'][0];
    weathoricon = weathoricon.toString();

  }
  void initState(){
    super.initState();
    getLocation();
  }

  Widget build(BuildContext context) {
    return Column(
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: kiconcolor,
                      ),
                      labelText: 'Enter City',
                      icon: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
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
                      getLocation();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kinactivecolor,
                    ),
                    height: 50,
                    margin: EdgeInsets.all(10),

                    child: Icon(
                      Icons.location_on,
                      color: kiconcolor,
                    ),
                  ),
                ),
            )
          ],
        ),
        Text('$city, $region',
          style: klabelstyle,
        ),
        SvgPicture.asset('images/clear-day.svg',
        height: 200),
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
    );
  }
}

