import 'dart:async';
import 'package:bv_cay_an_qua/models/vxmm/rank_result.dart';
import 'package:bv_cay_an_qua/models/vxmm/rank_user.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'ranking_item.dart';

enum RankType { scan, referral }

class RankingList extends StatefulWidget {
  final String campaignId;
  final RankType? type;
  RankingList({Key? key, required this.campaignId, this.type})
      : super(key: key);

  _RankingListState createState() => _RankingListState();
}

class _RankingListState extends State<RankingList>
    with AutomaticKeepAliveClientMixin {
  bool refreshing = false;

  ScrollController? _scrollController;
  RankResult? rankResult;
  final _rankUserBehavior = BehaviorSubject<List<RankUser>>.seeded([]);
  final _scanMeRank = BehaviorSubject<RankUser>.seeded(RankUser());
  final _referralMeRank = BehaviorSubject<RankUser>.seeded(RankUser());
  // ignore: unused_field
  int _page = 1;
  bool lastItem = false;
  List<RankUser> listRankUserTemp = [];

  @override
  void dispose() {
    _scanMeRank.close();
    _referralMeRank.close();
    _rankUserBehavior.close();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _refreshDocument();
    });
  }

  Future _refreshDocument() async {
    _page = 1;
    listRankUserTemp = [];
    lastItem = false;
    RankResult? rank;
    rank =
        await vxmmRepository.getRankResultList(widget.campaignId, widget.type!);
    rankResult = rank;
    listRankUserTemp.addAll(rankResult?.top10 ?? []);
    _rankUserBehavior.sink.add(rankResult?.top10 ?? []);
    if (rank?.me != null && rank!.me!.isNotEmpty) {
      RankUser meRank = rank.me!.first;
      if (widget.type == RankType.scan) {
        print("rank list refresh rank of scan...");
        _scanMeRank.sink.add(meRank);
      } else {
        print("rank list refresh rank of referral...");
        _referralMeRank.sink.add(meRank);
      }
    }
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
    return Container(
      child: StreamBuilder<List<RankUser>>(
          stream: _rankUserBehavior.stream,
          builder: (context, snapshot) {
            return RefreshIndicator(
                backgroundColor: ptPrimaryColor(context),
                onRefresh: _onRefresh,
                child: Column(
                  children: [
                    ...[
                      for (int index = 0;
                          index <
                              (!snapshot.hasData
                                  ? 0
                                  : (snapshot.data?.length ?? 0));
                          index++) ...[
                        if (!snapshot.hasData)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(child: Text("Đang tải...")),
                          )
                        else if (lastItem == true &&
                            (snapshot.data?.length ?? 0) == index) ...[
                          ((snapshot.data?.length ?? 0) < 10 &&
                                  (snapshot.data?.length ?? 0) > 0)
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child:
                                      Center(child: Text('Không có dữ liệu')),
                                )
                        ] else if ((snapshot.data?.length ?? 0) == index &&
                            lastItem == false) ...[
                          ((snapshot.data?.length ?? 0) < 10)
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(child: Text("Đang tải...")),
                                )
                        ] else
                          RankItem(
                            image: snapshot.data?.elementAt(index).info?.avatar,
                            title: snapshot.data?.elementAt(index).info?.name,
                            price: snapshot.data?.elementAt(index).total,
                            isMe: false,
                            index: (index) + 1,
                          )
                      ],
                      SizedBox(height: 100)
                    ]
                  ],
                ));
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
