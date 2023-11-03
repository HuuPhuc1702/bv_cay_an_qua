import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/config/theme/size-constant.dart';
import 'package:bv_cay_an_qua/config/theme/style-constant.dart';
import 'package:bv_cay_an_qua/page/hospital/controllers/hospital_controller.dart';
import 'package:bv_cay_an_qua/shared/widget/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../export.dart';
import 'doctor_page.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({Key? key}) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  ScrollController scrollController = ScrollController();
  HospitalController hospitalController = Get.put(HospitalController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        hospitalController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HospitalController>(builder: (controller) {
      return ListView.builder(
          itemCount: controller.loadMoreItems.value.length + 1,
          padding: EdgeInsets.zero,
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index == controller.loadMoreItems.value.length) {
              if (controller.loadMoreItems.value.length >=
                      (controller.pagination.value.limit ?? 10) ||
                  controller.loadMoreItems.value.length == 0) {
                return WidgetLoading(
                  notData: controller.lastItem,
                  count: controller.loadMoreItems.value.length,
                );
              } else {
                return SizedBox();
              }
            }
            if (controller.lastItem == false &&
                controller.loadMoreItems.value.length == 0) {
              return WidgetLoading();
            }
            return Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.2))),
              ),
              child: ListTile(
                onTap: () {
                  // Routing().navigate2(context, IntroTeamDetail(hospitalModel: hospitalModel));
                  Get.to(DoctorPage(
                    hospitalModel: controller.loadMoreItems.value[index],
                  ));
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: WidgetImageNetWork(
                    url: controller.loadMoreItems.value[index].logo,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                title: Text(
                  controller.loadMoreItems.value[index].name ??
                      'Tên bệnh viện đang cập nhật',
                  style: StyleConst.mediumStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  controller.loadMoreItems.value[index].place?.fullAddress ??
                      'Địa chỉ đang cập nhật',
                  style: StyleConst.regularStyle(
                      color: ColorConst.primaryColor.withOpacity(.5),
                      fontSize: miniSize),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: GestureDetector(
                          onTap: () async {
                            if (controller.loadMoreItems.value[index].phone !=
                                null) {
                              await canLaunch(
                                      "tel:${controller.loadMoreItems.value[index].phone}")
                                  ? await launch(
                                      "tel:${controller.loadMoreItems.value[index].phone}")
                                  : throw 'Could not launch tel:${controller.loadMoreItems.value[index].phone}';
                              // openWebBrowerhURL(
                              //     "tel:${hospitalModel?.phone?.trim().toString().replaceAll(' ', '')}");
                            }
                          },
                          child: Icon(Icons.phone,
                              color:
                                  controller.loadMoreItems.value[index].phone !=
                                          null
                                      ? ColorConst.primaryColor.withOpacity(.8)
                                      : Colors.grey.withAlpha(100))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: GestureDetector(
                          onTap: (controller.loadMoreItems.value[index].place
                                          ?.location?.coordinates?.length ??
                                      0) >=
                                  2
                              ? () async {
                                  String googleUrl =
                                      'https://www.google.com/maps/search/?api=1&query=${controller.loadMoreItems.value[index].place?.location?.coordinates?[1]},${controller.loadMoreItems.value[index].place?.location?.coordinates?[0]}';
                                  if (await canLaunch(googleUrl)) {
                                    await launch(googleUrl);
                                  } else {
                                    throw 'Could not open the map.';
                                  }
                                  // MapUtils.openMap(
                                  //     hospitalModel.lat, hospitalModel.long);
                                }
                              : null,
                          child: Icon(
                            Icons.pin_drop,
                            color: (controller.loadMoreItems.value[index].place
                                            ?.location?.coordinates?.length ??
                                        0) >=
                                    2
                                ? ColorConst.primaryColor.withOpacity(.8)
                                : Colors.grey.withAlpha(100),
                          )),
                    ),
                    Icon(Icons.chevron_right)
                  ],
                ),

                contentPadding: EdgeInsets.all(20),
                // isThreeLine: true,
              ),
            );
          });
    });
  }
}
