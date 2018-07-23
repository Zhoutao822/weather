import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import '../entity/weather_now_entity.dart';
import '../entity/air_now_entity.dart';

class CityItem extends StatelessWidget {
  CityItem(
      {Key key, @required this.weatherNowEntity, @required this.airNowEntity})
      : assert(weatherNowEntity != null &&
            airNowEntity != null &&
            weatherNowEntity.isValid &&
            airNowEntity.isValid),
        super(key: key);

  static const double height = 310.0;
  final WeatherNowEntity weatherNowEntity;
  final AirNowEntity airNowEntity;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    var random = new Random();
    String index = (random.nextInt(3) + 1).toString();

    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        height: height,
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // photo and title
              new SizedBox(
                height: 184.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                      child: new Image.asset(
                        "graphics/img" + index + ".jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    new Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: new FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: new Text(
                          weatherNowEntity.location +
                              " " +
                              weatherNowEntity.loc,
                          style: titleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // description and share/explore buttons
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: new DefaultTextStyle(
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              "空气质量：" + airNowEntity.qlty,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black54),
                            ),
                            new Text(
                              "空气指数：" + airNowEntity.aqi,
                              style: descriptionStyle.copyWith(
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Image.asset(
                                      "graphics/cond_icon_heweather/" +
                                          weatherNowEntity.condcode +
                                          ".png"),
                                  new Text(weatherNowEntity.condtxt,
                                      style: descriptionStyle.copyWith(
                                          color: Colors.black54)),
                                ],
                              ),
                              new Text(weatherNowEntity.tmp + "℃",
                                  style: descriptionStyle.copyWith(
                                    color: Colors.black54,
                                    fontSize: 24.0,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
