import 'dart:convert';

import 'package:covid_19_api/Model/WorldStatesModel.dart';
import 'package:covid_19_api/Services/Utilies/app_url.dart';
import 'package:covid_19_api/Services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class WorldStatessScreen extends StatefulWidget {
  const WorldStatessScreen({super.key});

  @override
  State<WorldStatessScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WorldStatessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 7), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    //StatesServices services = StatesServices();
    return Scaffold(
      // backgroundColor: Colors.black.withOpacity(0.01),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Covid 19",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Column(

            children: [

              FutureBuilder(
                  future: StatesServices().futureWorldStatesModel(),
                  builder: (context, snapshot) {
                    print(" rrrrrrrrrrrrrrr${snapshot.data}");
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitRotatingCircle(
                            color: Colors.orange,
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PieChart(
                            colorList: colorList,
                             ringStrokeWidth: 25,

                            centerText: "Covid",
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            chartRadius:
                                MediaQuery.of(context).size.width *0.3,
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recover": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString())
                            },
                            chartType: ChartType.ring,
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: Duration(
                              milliseconds: 1280,
                            ),
                          ),
                          SizedBox(
                              //  height: MediaQuery.of(context).size.height * 0.01,
                              ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
                            child: Card(

                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: "Total",
                                      vlue: snapshot.data!.cases!.toString()),
                                  ReusableRow(
                                      title: "Test",
                                      vlue: snapshot.data!.tests!.toString()),
                                  ReusableRow(
                                      title: "Deaths",
                                      vlue: snapshot.data!.deaths!.toString()),
                                  ReusableRow(
                                      title: "Recovered",
                                      vlue:
                                          snapshot.data!.recovered!.toString()),
                                  ReusableRow(
                                      title: "Active",
                                      vlue: snapshot.data!.active!.toString()),
                                  ReusableRow(
                                      title: "Critical",
                                      vlue:
                                          snapshot.data!.critical!.toString()),
                                  ReusableRow(
                                      title: "Today Deaths",
                                      vlue: snapshot.data!.todayDeaths!
                                          .toString()),
                                  ReusableRow(
                                      title: "Today Recovered",
                                      vlue: snapshot.data!.todayRecovered!
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(

                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              width: double.infinity,
                              height: 50,

                              decoration: BoxDecoration(

                                  color: Color(
                                0xff1aa260,
                              ),
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: Text("Track Countires",textAlign: TextAlign.center,style: TextStyle(fontSize: 22),),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          )),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, vlue;

  ReusableRow({super.key, required this.title, required this.vlue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(vlue,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
         // Divider(),
         // Divider(),
        ],
      ),
    );
  }
}
