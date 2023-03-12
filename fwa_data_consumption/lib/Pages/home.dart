import 'package:flutter/material.dart';
import 'package:fwa_data_consumption/Code/Widgets/data_plan_widget.dart';
import 'package:fwa_data_consumption/Code/get_rem_data.dart';
import 'package:fwa_data_consumption/Code/data_plan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showData = false;
  DataPlan? dp;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await refresh();
    });
    super.initState();
  }

  Future refresh() async {
    DataPlan? res = await getUserDataPlan();
    if (res != null) {
      setState(() {
        dp = res;
        showData = true;
      });
    } else {
      setState(() {
        showData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var noData = RefreshIndicator(
      onRefresh: refresh,
      child: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 39, 8, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Assicurati di essere collegato al WiFi della Vodafone Station FWA",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  children: const [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 200,
                      color: Colors.grey,
                    ),
                    Text("VF_IT_FWA",
                        style: TextStyle(color: Colors.grey, fontSize: 26)),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo dati FWA"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: showData
          ? DataPlanWidget(
              dp: dp,
              refresh: refresh,
            )
          : noData,
    );
  }
}
