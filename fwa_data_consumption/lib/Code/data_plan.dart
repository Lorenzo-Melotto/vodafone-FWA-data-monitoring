class DataPlan {
  late double totData;
  late double consumedData;
  late double remData;
  late double dataPerDay;
  late double dataConsumedPerDay;
  late int daysLeft;
  late String startDate;
  late String endDate;
  late String dataConsumptionTrend;

  DataPlan(this.totData, this.consumedData, this.remData, this.startDate,
      this.endDate) {
    Map<String, String> monthsMap = {
      "gennaio": "01",
      "febbraio": "02",
      "marzo": "03",
      "aprile": "04",
      "maggio": "05",
      "giugno": "06",
      "luglio": "07",
      "agosto": "08",
      "settembre": "09",
      "ottobre": "10",
      "novembre": "11",
      "dicembre": "12",
    };

    // splitting dates by spaces
    List<String> startDateComps = startDate.split(" ");
    List<String> endDateComps = endDate.split(" ");

    // formatting dates to parse them into DateTime
    String formattedStartDate =
        "${startDateComps.elementAt(2)}-${monthsMap[startDateComps.elementAt(1)]}-${startDateComps.elementAt(0)}";
    String formattedEndDate =
        "${endDateComps.elementAt(2)}-${monthsMap[endDateComps.elementAt(1)]}-${endDateComps.elementAt(0)}";

    // parse string dates in DateTime
    DateTime startDt = DateTime.parse(formattedStartDate);
    DateTime endDt = DateTime.parse(formattedEndDate);
    DateTime today = DateTime.now();

    // obtain days passed since latest renewal and the total days between last and next renewal
    int daysPassed = today.difference(startDt).inDays + 1;
    int totDays = endDt.difference(startDt).inDays + 1;

    daysLeft = -today.difference(endDt).inDays; // days left untill next renewal
    dataPerDay = totData / totDays; // GBs available for each day
    dataConsumedPerDay = consumedData / daysPassed; // average data consumption

    // very rough estimation of the data consumption trend
    if (dataConsumedPerDay <= dataPerDay / 4) {
      dataConsumptionTrend = "Basso";
    } else if (dataConsumedPerDay > dataPerDay / 4 &&
        dataConsumedPerDay <= dataPerDay * (2 / 4)) {
      dataConsumptionTrend = "Medio";
    } else if (dataConsumedPerDay > dataPerDay * (2 / 4) &&
        dataConsumedPerDay <= dataPerDay * (3 / 4)) {
      dataConsumptionTrend = "Elevato";
    } else if (dataConsumedPerDay > dataPerDay * (3 / 4) &&
        dataConsumedPerDay <= dataPerDay) {
      dataConsumptionTrend = "Al limite";
    } else {
      dataConsumptionTrend = "Limite superato";
    }
  }
}
