import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fwa_data_consumption/Code/data_plan.dart';

class DataPlanWidget extends StatefulWidget {
  final DataPlan? dp;
  final AsyncCallback? refresh;
  const DataPlanWidget({super.key, this.dp, this.refresh});

  @override
  State<DataPlanWidget> createState() => _DataPlanWidgetState();
}

class _DataPlanWidgetState extends State<DataPlanWidget> {
  final double dataFontSize = 35;
  final double defaultFontSize = 23;
  DataPlan? dp;

  @override
  void initState() {
    setState(() {
      dp = widget.dp;
    });
    super.initState();
  }

  Color getColor(String s) {
    switch (s) {
      case "Basso":
        return Colors.green;
      case "Medio":
        return Colors.yellow[700]!;
      case "Elevato":
        return Colors.yellow[900]!;
      case "Al limite":
        return Colors.red;
      case "Limite superato":
        return Colors.red[900]!;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refresh!,
      child: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dati totali",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("${dp!.totData.toStringAsFixed(2)}GB",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dati consumati",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("${dp!.consumedData.toStringAsFixed(2)}GB",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dati rimanenti",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("${dp!.remData.toStringAsFixed(2)}GB",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Consumo medio giornaliero",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("~${dp!.dataConsumedPerDay.toStringAsFixed(2)}GB",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dati disponibili al giorno",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("${dp!.dataPerDay.toStringAsFixed(2)}GB",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Andamento del consumo",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text(dp!.dataConsumptionTrend,
                    style: TextStyle(
                        fontSize: dataFontSize,
                        color: getColor(dp!.dataConsumptionTrend))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Data inizio conteggio",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text(dp!.startDate, style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Data prossimo rinnovo",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text(dp!.endDate, style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Giorni al prossimo rinnovo",
                    style: TextStyle(fontSize: defaultFontSize)),
                Text("${dp!.daysLeft}",
                    style: TextStyle(fontSize: dataFontSize)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
