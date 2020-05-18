import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'GetMyWeather.dart';

class GeolocationExample extends StatefulWidget {
  @override
  GeolocationExampleState createState() => new GeolocationExampleState();
}

class GeolocationExampleState extends State {
  Geolocator _geolocator;
  Position _position;

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print('status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationAlways)
        .then((status) {
      print('always status: $status');
    });
    _geolocator.checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationWhenInUse)
      ..then((status) {
        print('whenInUse status: $status');
      });
  }

  @override
  void initState() {
    super.initState();

    _geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    checkPermission();
    updateLocation();

    StreamSubscription positionStream = _geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        _position = position;
      });
    });

    positionStream.cancel();
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));

      setState(() {
        _position = newPosition;
        print(_position);
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз погоды'),
      ),
      body: Column(
        children: <Widget>[
          Text(
              'Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
              ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}'),
          updateTempWidget()
        ],
      ),
    );
  }

  Future<Map> getWeather() async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/forecast?lat=${_position.latitude}&lon=${_position.longitude}&appid=68f24487c6f82b895f80e20bf01da73b&units=metric';
    //'http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=${util.appId}&units=metric';
    print(apiUrl);
    var dio = Dio();
    Response response = await dio.get(apiUrl);
    print(response.data);
    //print(response.statusCode);

    var spisok = response.data.map((f) => GetMyWeather.fromJson(f)).toList();
    print(spisok);
    return spisok;
    //var data = await http.get(apiUrl);

    // var jsonData = convert.jsonDecode(data.body);
    //print(jsonData);
    //return jsonData.map((json) => GetMyWeather.fromJson(json)).toList();
  }

  Widget updateTempWidget() {
    return FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            //Map content = snapshot.data;
            print('Билдим! ${snapshot.data.toString()}');
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data[index].cod,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  //subtitle: Text(GetMyWeather.cod.toString()),
                );
              },
            );
          } else {
            return Center(
              child: Text('нету данных'),
            );
          }
        });
  }
}
