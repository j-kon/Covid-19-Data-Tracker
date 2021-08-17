import '../../widgets/stats_widgets/country_stat_widget.dart';
import 'package:flutter/material.dart';

class CountryStatScreen extends StatefulWidget {
  final color,
      countryName,
      countryCode,
      flagPath,
      isIncreasing,
      totalCases,
      totalRecovered,
      totalDeath;

  const CountryStatScreen({
    Key key,
    this.color,
    this.countryName,
    this.countryCode,
    this.flagPath,
    this.isIncreasing,
    this.totalCases,
    this.totalRecovered,
    this.totalDeath,
  }) : super(key: key);

  @override
  _CountryStatScreenState createState() => _CountryStatScreenState();
}

class _CountryStatScreenState extends State<CountryStatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CountryStatWidget(
          color: widget.color,
          onBackArrow: () {
            Navigator.of(context).pop();
          },
          countryCode: widget.countryCode,
          countryName: widget.countryName,
          totalCases: widget.totalCases,
          totalRecovered: widget.totalRecovered,
          totalDeath: widget.totalDeath,
          flagPath: widget.flagPath,
          isIncreasing: widget.isIncreasing,
        ),
      ),
    );
  }
}
