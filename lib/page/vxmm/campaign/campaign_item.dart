import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:bv_cay_an_qua/shared/widget/default_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../models/vxmm/campaign_model.dart';
import '../input_phone_number_introduction/input_phone_number_introduction_screen.dart';
import '../ranking/ranking_screen.dart';
import 'campaign_detail_screen.dart';

class CampaignItem extends StatefulWidget {
  const CampaignItem({Key? key, required this.campaign}) : super(key: key);
  final CampaignModel campaign;
  @override
  State<CampaignItem> createState() => _CampaignItemState();
}

class _CampaignItemState extends State<CampaignItem> {
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    isShow = false;
  }

  Widget itemRender({required CampaignModel campaign}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isShow = !isShow;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: ColorConst.borderInputColor)),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child: buildCampaignThumbnail(context)),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      campaign.name,
                      style: StyleConst.mediumStyle(fontSize: titleSize),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        buildCampaignMenu(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemRender(campaign: widget.campaign);
  }

  Padding buildCampaignDate(BuildContext context) {
    String dateText =
        "Từ ${DateFormat('dd/MM/yyyy').format(widget.campaign.startDate.toLocal())}";

    if (widget.campaign.endDate != null) {
      dateText +=
          " đến ${DateFormat('dd/MM/yyyy').format((widget.campaign.endDate ?? DateTime.now()).toLocal())}";
    }
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          dateText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }

  AnimatedContainer buildCampaignMenu(BuildContext context) {
    return AnimatedContainer(
        padding: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(color: HexColor(appWhite)),
        duration: Duration(milliseconds: 250),
        height: isShow == false ? 0 : 180,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              optionItem(
                  context: context,
                  title: "Nội dung chương trình",
                  function: () {
                    Get.to(CampaignDetailScreen(
                        campaignId: widget.campaign.id,
                        titleHeader: 'Nội dung chương trình'));
                  }),
              optionItem(
                  context: context,
                  title: "Nhập số điện thoại giới thiệu",
                  function: () {
                    Get.to(InputPhoneNumberIntroductionScreen(
                      campaign: widget.campaign,
                      titleHeader: "Nhập số điện thoại giới thiệu",
                    ));
                  }),
              optionItem(
                  context: context,
                  title: "Bảng xếp hạng",
                  function: () {
                    Get.to(RankingScreen(
                        campaign: widget.campaign,
                        titleHeader: "Bảng xếp hạng"));
                  })
            ],
          ),
        ));
  }

  Widget buildCampaignThumbnail(BuildContext context) {
    if (widget.campaign.icon != null && widget.campaign.icon != "") {
      return Image(
        image: CachedNetworkImageProvider(widget.campaign.icon ?? ''),
        width: 60,
        height: 60,
        fit: BoxFit.fitHeight,
      );
    } else if (widget.campaign.image != null && widget.campaign.image != "") {
      return Image(
        image: CachedNetworkImageProvider(widget.campaign.image ?? ''),
        width: 60,
        height: 60,
        fit: BoxFit.fitHeight,
      );
    } else {
      return DefaultImage();
    }
  }

  optionItem(
      {required BuildContext context,
      required String title,
      required Function() function}) {
    return GestureDetector(
      onTap: () {
        function.call();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: ColorConst.borderInputColor)),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                title,
                style: StyleConst.mediumStyle(fontSize: titleSize),
              ),
            )
          ],
        ),
      ),
    );
  }
}
