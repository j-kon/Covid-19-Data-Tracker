import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/screens/home_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/default_country_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cases_progress_bars.dart';
import 'new_case_boxes.dart';

// ignore: must_be_immutable
class CountryCardDetails extends StatefulWidget {
  Color color;
  int totalCases;
  final countryName, countryCode, flagPath, isIncreasing;
  Map<String, dynamic> todayJson, yestJson;

  CountryCardDetails(
      {this.color,
      this.todayJson,
      this.yestJson,
      this.totalCases,
      this.countryName,
      this.countryCode,
      this.flagPath,
      this.isIncreasing});

  @override
  _CountryCardDetailsState createState() => _CountryCardDetailsState();
}

class _CountryCardDetailsState extends State<CountryCardDetails>
    with TickerProviderStateMixin {
  AnimationController _controller1, _controller2;
  Duration textScaleDuration;
  final formatter = new NumberFormat("#,###");
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    textScaleDuration = Duration(milliseconds: 200);
    _controller1 = AnimationController(
        vsync: this,
        duration: textScaleDuration,
        lowerBound: 0.7,
        upperBound: 1);
    _controller2 = AnimationController(
        vsync: this,
        duration: textScaleDuration,
        lowerBound: 0.7,
        upperBound: 1);
    _controller1.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //Total Case Bars
        CaseBars(
          color: widget.color,
          totalActive: widget.todayJson['total_active'],
          totalDeaths: widget.todayJson['total_death'],
          totalCases: widget.todayJson['total_cases'],
          totalRecovered: widget.todayJson['total_recovered'],
        ),

        Expanded(child: SizedBox(height: 35)),

        //Set as default button
        defaultCountry.countryName != widget.countryName
            ? InkWell(
                onTap: () async {
                  defaultCountry.countryName = widget.countryName;
                  defaultCountry.countryCode = widget.countryCode;
                  defaultCountry.color = widget.color.value;
                  defaultCountry.flagPath = widget.flagPath;
                  defaultCountry.totalCases = 200;
                  defaultCountry.isIncreasing = 200 > 100;
                  var jsonMap = defaultCountry.toJson();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("defaultCountry", json.encode(jsonMap));
                  Navigator.of(context).pop();
                  Flushbar(
                    messageText: AutoSizeText(
                      "${widget.countryName} set as default country",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 17,
                          color: Colors.white),
                      maxFontSize: 17,
                    ),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    flushbarStyle: FlushbarStyle.FLOATING,
                    icon: Icon(
                      Icons.info_outline,
                      size: 28.0,
                      color: widget.color,
                    ),
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                    shouldIconPulse: false,
                    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                    duration: Duration(seconds: 3),
                    leftBarIndicatorColor: widget.color,
                  )..show(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "Set as default",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxFontSize: 20,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
