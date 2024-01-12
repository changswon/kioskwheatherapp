import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class WindyMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String htmlContent = '''
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
            }
        </style>
    </head>
    <body>
        <div id="windy"></div>
        <script>
            const options = {
                key: 'jixEuptEnnkEQf4FBY0igRHkFKJBglfa',
                verbose: true,
                lat: 50.4,
                lon: 14.3,
                zoom: 5,
            };

            windyInit(options, windyAPI => {
                const { map } = windyAPI;
                L.popup()
                    .setLatLng([50.4, 14.3])
                    .setContent('Hello World')
                    .openOn(map);
            });
        </script>
    </body>
</html>
''';
    String encodedHtml = Uri.dataFromString(htmlContent, mimeType: 'text/html', encoding: Encoding.getByName('UTF-8')).toString();

    return WebView(
      initialUrl: 'data:text/html;charset=utf-8,$encodedHtml', // URL을 data URL로 설정
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
