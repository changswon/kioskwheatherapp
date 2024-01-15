import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WindyMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: htmlContent,
          mimeType: 'text/html',
          encoding: 'UTF-8',
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            // 웹 페이지 내에서 JavaScript 실행을 허용합니다.
            javaScriptEnabled: true,
            transparentBackground: true,
          ),
        ),
      ),
    );
  }
}

const String htmlContent = '''
<html>
<head>
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
    />
    <script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>
    <script src="https://api.windy.com/assets/map-forecast/libBoot.js"></script>
    <style>
        #windy {
            width: 100%;
            height: 300px;
            border-radius: 16px; /* 모서리를 라운드 처리 */
        }
    </style>
</head>
<body>
    <div id="windy"></div>
    <script>
        const options = {
            key: 'jixEuptEnnkEQf4FBY0igRHkFKJBglfa',
            verbose: true,
            lat: 35.3130416,
            lon: 128.9607861,
            zoom: 5,
        };

        windyInit(options, windyAPI => {
            const { map } = windyAPI;
            // L.popup()
            //     .setLatLng([35.3130416, 128.9607861])
            //     .setContent('Ulsan')
            //     .openOn(map);
        });
    </script>
</body>
</html>
''';

void main() {
  runApp(WindyMapView());
}
