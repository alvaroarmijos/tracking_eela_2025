

import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarker(){
  return BitmapDescriptor.asset(
    ImageConfiguration(
      size: Size(50, 50)
    ), 
    'assets/icons/custom_location_pin.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final res = await Dio().get(
    'https://www.iconsdb.com/icons/preview/purple/marker-xxl.png',
    options: Options(
      responseType: ResponseType.bytes,
    )
    );

    return BitmapDescriptor.bytes(res.data, width: 50, height: 50);
}