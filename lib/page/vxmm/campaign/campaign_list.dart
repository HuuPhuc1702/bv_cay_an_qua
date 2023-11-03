import 'dart:async';

import 'package:bv_cay_an_qua/config/theme/assets-constant.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/utils.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/constants.dart';
import '../../../models/vxmm/campaign_model.dart';
import 'campaign_item.dart';

class CampaignList extends StatefulWidget {
  final String titleHeader;
  final String topicSlugs;

  CampaignList({Key? key, this.titleHeader = '', required this.topicSlugs})
      : super(key: key);

  _CampaignListState createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList>
    with AutomaticKeepAliveClientMixin {
  bool refreshing = false;
  bool isLoading = false;

  late ScrollController _scrollController;
  late TextEditingController _searchController = new TextEditingController();
  late String searchText;
  // List<LPost> _postList;
  List<CampaignModel>? _campaignsList;
  final _searchChangeBehavior = BehaviorSubject<String>.seeded('');

  Stream<String> get _searchChangedEvent =>
      _searchChangeBehavior.stream.debounceTime(Duration(milliseconds: 200));
  late StreamSubscription _searchStreamSub;
  // final _videoBehavior = BehaviorSubject<List<LPost>>.seeded(null);
  final _campaignBehavior = BehaviorSubject<List<CampaignModel>>.seeded([]);

  @override
  void dispose() {
    _searchChangeBehavior.close();
    _campaignBehavior.close();
    _scrollController.dispose();
    _searchStreamSub.cancel();
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print("_onSearchChanged");
  }

  @override
  void initState() {
    _scrollController = ScrollController();

    _searchController.addListener(_onSearchChanged);
    searchText = "";
    //_onRefresh();
    super.initState();

    // Listen search changed
    _searchStreamSub = _searchChangedEvent.listen((kw) {
      _filterDocuments(kw);
    });
    _refreshDocument();
  }

  _filterDocuments(String kw) {
    if (_campaignsList != null) {
      _campaignBehavior.sink.add(_campaignsList ?? []);
    } else if (_campaignsList?.length == 0) _refreshDocument();
  }

  Future _refreshDocument() async {
    List<CampaignModel> campaigns = [];
    campaigns = await vxmmRepository.getCampaignList() ?? [];
    campaigns.sort((a, b) {
      return b.startDate.compareTo(a.startDate);
    });
    _campaignsList = campaigns;
    return Future;
  }

  Future<void> _onRefresh() async {
    setState(() {
      refreshing = true;
    });
    await _refreshDocument();
    setState(() {
      refreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: buildAppBar(context, title: widget.titleHeader),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: StreamBuilder<List<CampaignModel>>(
                            // stream: _videoBehavior.stream,
                            stream: _campaignBehavior.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false)
                                Container(
                                  alignment: Alignment.center,
                                  child: Text('Đang tải ...'),
                                );
                              return RefreshIndicator(
                                backgroundColor: ptPrimaryColor(context),
                                onRefresh: _onRefresh,
                                child: snapshot.data == null ||
                                        snapshot.data?.length == 0
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: snapshot.data == null
                                            ? LinearProgressIndicator(
                                                backgroundColor:
                                                    ptPrimaryColor(context),
                                              )
                                            : Text(
                                                'Không tìm thấy kết quả',
                                              ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(bottom: 80),
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(
                                              bottom: 250, left: 15, right: 15),
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            CampaignModel campaign =
                                                snapshot.data!.elementAt(index);
                                            return CampaignItem(
                                                campaign: campaign);
                                          },
                                        ),
                                      ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  AssetsConst.backgroundBottomLogin,
                  width: deviceWidth(context),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WebViewContainer extends StatefulWidget {
  final url;
  Widget? bottomWid;

  WebViewContainer(this.url, {this.bottomWid});

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();

  _WebViewContainerState(this._url);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          // Expanded(child: WebViewContainer(key: _key, javascriptMode: JavascriptMode.unrestricted, initialUrl: _url)),
          Expanded(child: WebViewContainer(_url)),
          (widget.bottomWid != null)
              ? (widget.bottomWid ?? SizedBox())
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
