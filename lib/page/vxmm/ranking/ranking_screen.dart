import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/models/vxmm/check_user_in_campaign_response.dart';
import 'package:bv_cay_an_qua/models/vxmm/rank_result.dart';
import 'package:bv_cay_an_qua/models/vxmm/rank_user.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bv_cay_an_qua/page/vxmm/component/tab_bar_component.dart';
import 'package:rxdart/subjects.dart';
import 'ranking_item.dart';
import 'ranking_list.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen(
      {Key? key, required this.campaign, required this.titleHeader})
      : super(key: key);
  final String titleHeader;
  final CampaignModel campaign;
  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool currentTabIs1 = true;
  // TabController _tabController;

  CheckUserInCampaignResponse? responseCheck;
  bool isLockReferral = true;
  final ScrollController _controller = ScrollController();
  final _scanMeRank = BehaviorSubject<RankUser>.seeded(RankUser());
  final _referralMeRank = BehaviorSubject<RankUser>.seeded(RankUser());
  @override
  void initState() {
    super.initState();
    responseCheck = CheckUserInCampaignResponse();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkExistCode(widget.campaign.id);
      _refreshDocument();
    });
  }

  Future _refreshDocument() async {
    RankResult? rank;
    print("Current Tab Log:" + currentTabIs1.toString());

    rank = await vxmmRepository.getRankResultList(widget.campaign.id,
        (currentTabIs1) ? RankType.scan : RankType.referral);
    if (rank?.me != null && rank!.me!.isNotEmpty) {
      RankUser meRank = rank.me!.first;
      if (currentTabIs1) {
        print("rank screen refresh rank of scan...");
        _scanMeRank.sink.add(meRank);
      } else {
        print("rank screen refresh rank of referral...");
        _referralMeRank.sink.add(meRank);
      }
      // _scanMeRank.sink.add(meRank);
      // _referralMeRank.sink.add(meRank);
    }
    return Future;
  }

  checkExistCode(String campaignId) async {
    CheckUserInCampaignResponse? result =
        await vxmmRepository.checkExistCode(campaignId: campaignId);
    if (result != null) {
      setState(() {
        responseCheck = result;
        isLockReferral = false;
        // if (responseCheck?.active == true) {
        //   isLockReferral = false;
        // } else {
        //   isLockReferral = true;
        // }
      });
    }
  }

  void _scroll(value) {
    _controller.jumpTo(_controller.position.pixels + value);
  }

  @override
  void dispose() {
    _scanMeRank.close();
    _referralMeRank.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: widget.titleHeader),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  //HexColor(appColor2).withOpacity(0.2),
                  Colors.white,
                  Colors.white,
                ],
              )),
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: widget.campaign.image != null &&
                              widget.campaign.image != ""
                          ? Image(
                              image: CachedNetworkImageProvider(
                                  widget.campaign.image ?? ''),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/app_logo.png",
                              height: 200,
                            ),
                    ),
                    Visibility(
                      visible: currentTabIs1 == true,
                      child: StreamBuilder<RankUser>(
                          stream: _scanMeRank.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData == false) {
                              return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: RankItem(
                                  isMe: true,
                                  title: "",
                                  price: 0,
                                  index: 0,
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: RankItem(
                                isMe: true,
                                image: snapshot.data?.info?.avatar,
                                title: snapshot.data?.info?.name,
                                price: snapshot.data?.total,
                                index: (snapshot.data?.rank ?? 0),
                              ),
                            );
                          }),
                    ),
                    isLockReferral
                        ? SizedBox()
                        : Visibility(
                            visible: currentTabIs1 == false,
                            child: StreamBuilder<RankUser>(
                                stream: _referralMeRank.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == false) {
                                    return Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        child: RankItem(
                                          isMe: true,
                                          title: "",
                                          price: 0,
                                          index: 0,
                                        ));
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: RankItem(
                                      isMe: true,
                                      image: snapshot.data?.info?.avatar,
                                      title: snapshot.data?.info?.name,
                                      price: snapshot.data?.total,
                                      index: (snapshot.data?.rank ?? 0),
                                    ),
                                  );
                                }),
                          ),
                    TabBarComponent(
                      isLockReferral: isLockReferral,
                      currentTabIs1: currentTabIs1,
                      callBack: (value) {
                        setState(() {
                          _refreshDocument();
                          if (currentTabIs1 != value) {
                            currentTabIs1 = value;
                          }
                        });
                      },
                    ),
                    Visibility(
                      visible: currentTabIs1 == true,
                      child: Container(
                        color: HexColor(appWhite),
                        child: RankingList(
                            campaignId: widget.campaign.id,
                            type: RankType.scan),
                      ),
                    ),
                    Visibility(
                      visible: currentTabIs1 == false,
                      child: isLockReferral == true
                          ? SizedBox(
                              child: Center(
                                child: Text(
                                  "Không thể xem",
                                ),
                              ),
                            )
                          : Container(
                              color: HexColor(appWhite),
                              child: RankingList(
                                campaignId: widget.campaign.id,
                                type: RankType.referral,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  int sensitivity = 8;
                  if (details.delta.dy > sensitivity) {
                    _scroll(-50);
                  } else if (details.delta.dy < -sensitivity) {
                    _scroll(50);
                  }
                },
                child: Image.asset(
                  AssetsConst.backgroundBottomLogin,
                  width: deviceWidth(context),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ));
  }
}
