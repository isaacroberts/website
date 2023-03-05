import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'text_theme.dart';
import 'device.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'feature_shower.dart';

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}

List<_PieData> pieData = [
  _PieData('Apple', 432),
  _PieData('Cherry', 239),
  _PieData('Crow', 475),
  _PieData('Blueberry', 205),
  _PieData('Tart', 028),
];

List<Color> palette = [
  Color(0xff562aa2),
  Color(0xff2a86a2),
  Color(0xff7d4e7e),
  Color(0xff23a991),
  Color(0xffcc0500),
  Color(0xff776d55),
  Color(0xff48844b),
  Color(0xff446288),
  Color(0xffa08f2c),
  Color(0xff943875),
  Color(0xff2ba174),
];

class DataVis extends StatefulWidget {
  final bool textLeft;
  const DataVis(this.textLeft, {Key? key}) : super(key: key);

  @override
  State<DataVis> createState() => _DataVisState();
}

class _DataVisState extends State<DataVis> with FeatureShower {
  _DataVisState();

  List<_PieData> _data = pieData;
  bool _hasChecked = false;
  bool _gotData = false;

  void longPrint(String x) {
    const int l = 100;
    for (int i = 0; i < x.length; i += l) {
      int e = i + l;
      if (e > x.length) e = x.length;
      log(x.substring(i, e));
    }
    // return x
    //     .toString()
    //     .replaceAllMapped(RegExp(r".{30}"), (match) => "${match.group(0)}\n");
  }

  void getDataIfNotChecked() async {
    if (!_hasChecked) {
      _hasChecked = true;
      await _getData();
      if (_data.isEmpty) {
        log('filling');
        // _hasChecked = false;
        setState(() {
          _data = pieData;
        });
      } else {
        setState(() {
          _gotData = true;
        });
      }
    }
  }

  Future<http.Response> _getResp(
      String function, Map<String, String> args) async {
    String domain = 'alphavantage.co';
    String token = 'YMB67WYG870H5FZ0';
    args['apikey'] = token;
    args['function'] = function;
    Uri uri = Uri.https(domain, '/query', args);
    if (kDebugMode) {
      print('uri: $uri');
    }
    return http.post(uri);
  }

  Future<void> _getData() async {
    // String token = 'cfcp101r01qs3nqkt650cfcp101r01qs3nqkt65g';

    List<String> symbols = [
      // 'BMWYY',
      // 'BYDDF',
      'F',
      'GM',
      // 'MBGYY',
      'RACE',
      'STLA',
      'TM',
      'TSLA',
      // 'VWAGY'
    ];

    setState(() {
      _data = [];
    });
    return;
    for (String symbol in symbols) {
      try {
        var response = await _getResp('OVERVIEW', {'symbol': symbol});
        // log('response: $response');
        if (response.statusCode != 200) {
          continue;
        } else {
          // log('response = ${response.body}');
          // log(response.statusCode.toString());
          longPrint(response.body);

          var jsond = json.decode(response.body);

          log(jsond);
          // String name = jsond['name'];
          // log(jsond['metric'].toString());
          // log("mcap: ${jsond['metric']['marketCapitalization']}");
          num mcap = jsond['MarketCapitalization'];

          String cur = jsond['Currency'];
          log('currency = $cur');
          if (cur != 'USD') {
            response = await _getResp('CURRENCY_EXCHANGE_RATE',
                {'from_currency': cur, 'to_currency': 'USD'});

            if (response.statusCode != 200) {
              continue;
            }
            var jsond = json.decode(response.body);

            num rate =
                jsond['Realtime Currency Exchange Rate']['5. Exchange Rate'];

            mcap /= rate;
          }

          var pd = (_PieData(symbol, mcap.toInt()));

          setState(() {
            _data.add(pd);
          });
        }
      } catch (e, stacktrace) {
        if (kDebugMode) {
          print('==========================');
          print(e.toString());
          print(stacktrace);
        }
        // log(stacktrace.toString());
        // Completer.completeException(exception, stackTrace);
      }
    }

    log('Amt collected: ${_data.length}');
  }

  @override
  String title() => 'Data analytics';
  @override
  String subtitle() => 'Keep up with what\'s happening on the web.';
  @override
  String body() => """
Machine learning through Keras or APIs can make your app more intelligent.""";
  @override
  String bgImage() => 'images/data_an.jpg';

  Widget visWrap(Widget child) {
    return VisibilityDetector(
        key: const Key('sf_chart_vis'),
        onVisibilityChanged: (visibilityInfo) {
          // log(visibilityInfo.visibleFraction.toString());
          if (visibilityInfo.visibleFraction > .8) {
            getDataIfNotChecked();
          }
        },
        child: child);
  }

  @override
  Widget displayContent(BuildContext context) {
    return visWrap(SfCircularChart(
        palette: palette,
        title: ChartTitle(text: 'Market Share', textStyle: fonts.titleSmall),
        legend: Legend(isVisible: true, textStyle: fonts.labelMedium),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
              // animationDelay: 2,
              explodeGesture: ActivationMode.singleTap,
              selectionBehavior: SelectionBehavior(
                selectedBorderColor: Colors.white,
              ),
              explode: false,
              explodeIndex: 0,
              dataSource: _data,
              startAngle: -90,
              endAngle: 270,
              sortingOrder: SortingOrder.descending,
              sortFieldValueMapper: (_PieData data, _) =>
                  data.yData.toInt().toString().padLeft(10, '0'),
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return doBuild(context, widget.textLeft);
  }
}
