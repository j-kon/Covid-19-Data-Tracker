class SummaryEachCountry {
  final String state;
  final String code;
  final String flagPath;
  final int todayCases;
  final int confirmedCases;
  final int death;
  final int critical;
  final int casesOnAdmission;
  final int totalDeaths;
  final int discharged;
  final bool isIncreasing;
  final int testsConducted;

  SummaryEachCountry(
      {this.state,
      this.code,
      this.flagPath,
      this.todayCases,
      this.confirmedCases,
      this.casesOnAdmission,
      this.death,
      this.totalDeaths,
      this.discharged,
      this.isIncreasing,
      this.critical,
      this.testsConducted});

  SummaryEachCountry formMap(Map<String, dynamic> data) {
    String state = data["state"];
    Map<String, dynamic> countryInfo = data["countryInfo"];
    // String code=countryInfo["iso2"];
    return SummaryEachCountry(
      state: state,
      // code : code,
      // flagPath: 'assets/flags/'+code.toLowerCase()+'.png',
      // todayCases: data["todayCases"],
      confirmedCases: data['confirmedCases'],
      casesOnAdmission: data["casesOnAdmission"],
      death: data['todayDeaths'],
      totalDeaths: data['death'],
      discharged: data['discharged'],
      // critical: data["critical"],
      // testsConducted: data["tests"],
      // isIncreasing: data["todayCases"]>0? true : false
    );
  }
}
