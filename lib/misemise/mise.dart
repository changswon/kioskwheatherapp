import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiseWidget extends StatelessWidget {
  final dynamic parseAirPollution;
  final String dust1;
  final String dust2;
  final Widget airState;

  MiseWidget({
    this.parseAirPollution,
    required this.dust1,
    required this.dust2,
    required this.airState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 10.0), // 미세먼지 위 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '미세먼지',
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 17.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$dust1㎍/㎥ | 존나좋음',
                        style: GoogleFonts.lato(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0), // 미세먼지 위 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '초미세먼지',
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 17.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$dust2㎍/㎥ | 매우좋음',
                        style: GoogleFonts.lato(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0), // 미세먼지 위 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '대기질지수',
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: airState!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
