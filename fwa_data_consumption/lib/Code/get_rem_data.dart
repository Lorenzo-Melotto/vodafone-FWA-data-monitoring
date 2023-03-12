import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fwa_data_consumption/Code/data_plan.dart';

Future<DataPlan?> getUserDataPlan() async {
  http.Response? resp;
  try {
    resp = await http.get(Uri.parse("http://contatori.vodafone.it/continua"));
  } on SocketException {
    return Future.value(null);
  } on Error {
    return Future.value(null);
  }

  if (resp.statusCode == 200) {
    if (resp.body.contains("Pagina non disponibile in Wi-Fi")) {
      // user is not connected to the correct WiFi network
      return Future.value(null);
    } else {
      // ok!
      String htmlPage = resp.body;

      // tot data
      RegExp rexTotData = RegExp(r'threshold="\d*"');
      Iterable<RegExpMatch> totDataMatches = rexTotData.allMatches(htmlPage);
      String totData = totDataMatches.elementAt(0).group(0)!;

      // used data and remaining data
      RegExp rexUsedData = RegExp(r'countervalue="\d*\.\d*"');
      RegExp rexRemData = RegExp(r'remaining="\d*\.\d*"');
      Iterable<RegExpMatch> usedDataMatches = rexUsedData.allMatches(htmlPage);
      Iterable<RegExpMatch> remDataMatches = rexRemData.allMatches(htmlPage);

      String usedData = usedDataMatches.elementAt(0).group(0)!;
      String remData = remDataMatches.elementAt(0).group(0)!;

      // start date and end date
      RegExp rexStartDate = RegExp(r'datestart="[\w,\s]*"');
      RegExp rexEndDate = RegExp(r'dateend="[\w,\s]*"');
      Iterable<RegExpMatch> startDateMatches =
          rexStartDate.allMatches(htmlPage);
      Iterable<RegExpMatch> endDateMatches = rexEndDate.allMatches(htmlPage);

      String startDate = startDateMatches.elementAt(0).group(0)!;
      String endDate = endDateMatches.elementAt(0).group(0)!;

      String totDataFormatted,
          usedDataFormatted,
          remDataFormatted,
          startDateFormatted,
          endDateFormatted;

      // remove unwanted substrings
      totDataFormatted = formatData(totData, "threshold=\"");
      usedDataFormatted = formatData(usedData, "countervalue=\"");
      remDataFormatted = formatData(remData, "remaining=\"");
      startDateFormatted = formatData(startDate, "datestart=\"");
      endDateFormatted = formatData(endDate, "dateend=\"");

      // MB to GB conversion
      double totDataGB = double.parse(totDataFormatted) / 1000;
      double usedDataGB = double.parse(usedDataFormatted) / 1000;
      double remDataGB = double.parse(remDataFormatted) / 1000;

      return Future.value(DataPlan(totDataGB, usedDataGB, remDataGB,
          startDateFormatted, endDateFormatted));
    }
  }

  return Future.value(null);
}

String formatData(String src, String replace) {
  src = src.replaceAll(replace, "");
  src = src.replaceAll("\"", "");
  return src;
}
