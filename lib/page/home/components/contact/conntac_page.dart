import 'dart:typed_data';

import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/page/hospital/controllers/hospital_controller.dart';
import 'package:bv_cay_an_qua/page/issue/input_issue_page.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../export.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late MediaQueryData _mediaQueryData;

  late GoogleMapController _controller;

  Set<Marker> markers = Set();
  HospitalController hospitalController = Get.put(HospitalController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _buildMarker().then((v) {}).catchError((e) {
        print(e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    print(
        "hospitalController.loadMoreItems.value.length---${hospitalController.loadMoreItems.value.length}");

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.all(14.0),
      //       child: Image.asset(
      //         AssetsConst.iconBack,
      //         fit: BoxFit.cover,
      //         width: 24,
      //         height: 24,
      //       ),
      //     ),
      //   ),
      //   brightness: Brightness.light,
      //   title: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text('Liên hệ',
      //           style: StyleConst.boldStyle(
      //                   color: ColorConst.red, fontSize: titleSize)
      //               .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
      //       Text('www.benhviencayanqua.vn',
      //           style: StyleConst.mediumStyle(color: ColorConst.primaryColor)),
      //     ],
      //   ),
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   actions: <Widget>[
      //     GestureDetector(
      //       onTap: () {
      //         Get.to(InputIssuePage());
      //         // Routing().navigate2(context, CreatQuestionScreen());
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.all(3),
      //         child: Image.asset(
      //           "assets/images/question.png",
      //         ),
      //       ),
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //       child: Container(
      //         color: ColorConst.primaryColor,
      //         height: 8,
      //       ),
      //       preferredSize: Size.fromHeight(8)),
      // ),
      body: Column(
        children: [
          WidgetAppbar(title: "Liên hệ"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: ColorConst.primaryColor,
                      width: 8,
                    ),
                    bottom: BorderSide(
                      color: ColorConst.primaryColor,
                      width: 8,
                    ),
                  ),
                ),
                child: Container(
                  height: 40,
                  width: _mediaQueryData.size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        ColorConst.primaryColorGradient1,
                        ColorConst.primaryColorGradient2
                      ])),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Trụ sở chính',
                      style: StyleConst.boldStyle(
                          color: Colors.white, fontSize: titleSize),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Bệnh viên cây ăn quả trung tâm',
                  style: StyleConst.mediumStyle(
                      color: ColorConst.primaryColor, fontSize: titleSize),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 10),
                child: Text(
                  'KM1975 QL1A, ấp Đông, xã Long Định, huyện Châu Thành, Tiền Giang',
                  style: StyleConst.mediumStyle(fontSize: miniSize),
                ),
              ),
            ],
          ),
          Expanded(
            child: _buildGoogleMap(),
          ),
          Image.asset(
            AssetsConst.backgroundBottomLogin,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            // height: 130,
          ),
        ],
      ),
    );
  }

  Future _buildMarker() async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: Size(30.0, 30.0));
    final bitmap = await BitmapDescriptor.fromAssetImage(
        imageConfiguration, 'assets/images/app_logo_doctor.png');
    hospitalController.loadMoreItems.value.forEach((hospital) {
      print(hospital.toJson());
      try {
        markers.add(
          Marker(
//          anchor: AnchorPos.align(AnchorAlign.center),
//            icon: bitmap,
              markerId: MarkerId(hospital.id ?? ""),
              position: LatLng(hospital.place!.location!.coordinates![1],
                  hospital.place!.location!.coordinates![0]),
              onTap: () => _touchToMarker(hospital)),
        );
      } catch (error) {
        print("_buildMarker--- $error");
      }
    });

    setState(() {});
  }

  _touchToMarker(HospitalModel hospital) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                hospital.name ?? '',
                style: StyleConst.regularStyle(fontSize: titleSize),
              ),
              content: Text(
                hospital.place?.fullAddress ?? '',
                style: StyleConst.regularStyle(),
              ),
              actions: <Widget>[
                WidgetButton(
                  onTap: () async {
                    Navigator.pop(context);
                    String googleUrl =
                        'https://www.google.com/maps/search/?api=1&query=${hospital.place?.location?.coordinates?[1]},${hospital.place?.location?.coordinates?[0]}';
                    if (await canLaunch(googleUrl)) {
                      await launch(googleUrl);
                    } else {
                      throw 'Could not open the map.';
                    }
                  },
                  text: 'Mở bản đồ',
                  textColor: Colors.white,
                ),
                WidgetButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Đóng',
                  backgroundColor: Colors.white,
                ),
              ],
            ));
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(10.7894763, 106.7009849),
//    zoom: 4.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _moveToHCM();
      },
      markers: markers,
    );
  }

  _moveToHCM() {
    _controller.moveCamera(
      CameraUpdate.newLatLngZoom(
        const LatLng(10.7894763, 106.7009849),
        7.0,
      ),
    );
  }
}
