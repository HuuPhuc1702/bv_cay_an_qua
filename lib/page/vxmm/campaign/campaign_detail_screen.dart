import 'dart:ui';

import 'package:bv_cay_an_qua/config/theme/color-constant.dart';
import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/helper/getHtml.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'dart:convert';

class CampaignDetailScreen extends StatefulWidget {
  final String campaignId;
  final String titleHeader;
  CampaignDetailScreen({required this.campaignId, required this.titleHeader});

  @override
  State<StatefulWidget> createState() => CampaignDetailScreenState();
}

class CampaignDetailScreenState extends State<CampaignDetailScreen> {
  static final double minFont = 18.0;
  static final double maxFont = 40.0;

  ScrollController? scrollController;
  CampaignModel? itemCampaign;
  double? fontSlider = 25;
  String? html;
  bool loading = false;
  bool pop = false;

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController?.addListener(() => setState(() {}));
    print("widget.postId----${widget.campaignId}");
    if (widget.campaignId != null) {
      _loadPostDetail();
    } else {}
  }

  _loadPostDetail() async {
    CampaignModel? campaign =
        await vxmmRepository.getCampaignDetail(widget.campaignId);
    setState(() {
      itemCampaign = campaign;
      html = itemCampaign?.content;
      //   html = html ??
      //       """
      // <figure class="media"><oembed url="https://www.youtube.com/watch?v=q4ccbja1OYw"></oembed></figure><figure class="image"><img src="https://i.imgur.com/hsK1CRz.png"></figure><figure class="image"><img src="https://i.imgur.com/DMjir8O.png"></figure><p>&nbsp;</p>
      // """;
      html = HtmlUtil.position(html ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: widget.titleHeader),
      body: html != null
          ? Stack(fit: StackFit.loose, children: <Widget>[
              SingleChildScrollView(
                child: Html(
                  data: '''<html><body>${html.toString()}</body></html>''',
                  // style: {
                  //   "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                  //   "figure": Style(margin: EdgeInsets.fromLTRB(0, 0, 0, 15), padding: EdgeInsets.zero),
                  // },
                ),
              ),
            ])
          : Container(
              child: LinearProgressIndicator(
                backgroundColor: ptPrimaryColor(context),
              ),
            ),
    );
  }
}
