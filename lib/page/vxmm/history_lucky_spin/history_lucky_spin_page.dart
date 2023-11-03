import 'dart:async';

import 'package:bv_cay_an_qua/export.dart';
import 'package:bv_cay_an_qua/models/user.dart';
import 'package:bv_cay_an_qua/page/login/controllers/auth_controller.dart';
import 'package:bv_cay_an_qua/repositories/vxmm_repo.dart';
import 'package:bv_cay_an_qua/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/models/history_lucky_spin_model.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:rxdart/rxdart.dart';
import '../component/tab_bar_component.dart';
import 'package:bv_cay_an_qua/models/vxmm/campaign_model.dart';
import 'history_lucky_spin_item.dart';

enum SpinType { scan, referral }

class HistoryLuckySpinPage extends StatefulWidget {
  const HistoryLuckySpinPage({Key? key}) : super(key: key);

  @override
  _HistoryLuckySpinPageState createState() => _HistoryLuckySpinPageState();
}

class _HistoryLuckySpinPageState extends State<HistoryLuckySpinPage>
    with SingleTickerProviderStateMixin {
  // TextEditingController _searchController = new TextEditingController(text: '');
  // bool _refreshing = false;
  // bool _refreshingReferral = false;

  final _searchChangeBehavior = BehaviorSubject<String>.seeded('');
  final _streamDataHistoryLuckySpin =
      BehaviorSubject<List<HistoryLuckySpinModel>>.seeded([]);
  final _streamDataHistoryLuckySpinReferral =
      BehaviorSubject<List<HistoryLuckySpinModel>>.seeded([]);

  int _page = 1;
  int _pageReferral = 1;

  bool _lastItem = false;
  bool _lastItemReferral = false;

  late ScrollController _scrollController;
  late ScrollController _scrollControllerReferral;

  List<HistoryLuckySpinModel> _listDataTemp = [];
  List<HistoryLuckySpinModel> _listDataTempReferral = [];

  late LUser _me = LUser(id: '');
  final _currentTabIs1 = BehaviorSubject<bool>.seeded(true);

  final _campaignList = BehaviorSubject<List<CampaignModel>>.seeded([]);
  final _currentCampaign = BehaviorSubject<String>.seeded("");

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerReferral = ScrollController();

    initGetMe();

    init();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _lastItem == false) {
        _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
        _page += 1;
        await vxmmRepository
            .getAllLuckySpinByFarmer(pageIndex: _page, farmerId: _me.id)
            .then((value) {
          _listDataTemp.addAll(value ?? []);
          if ((value?.length ?? 0) < 10) {
            _lastItem = true;
          }
          _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
        });
      }
    });

    _scrollControllerReferral.addListener(() async {
      if (_scrollControllerReferral.position.pixels ==
              _scrollControllerReferral.position.maxScrollExtent &&
          _lastItemReferral == false) {
        _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
        _pageReferral += 1;
        await vxmmRepository
            .getAllLuckySpinByFarmerReferral(
                pageIndex: _pageReferral, phone: _me.phone ?? '')
            .then((value) {
          _listDataTempReferral.addAll(value ?? []);
          if ((value?.length ?? 0) < 10) {
            _lastItemReferral = true;
          }
          _streamDataHistoryLuckySpinReferral.sink.add(_listDataTempReferral);
        });
      }
    });

    // _searchChangeBehavior
    //     .debounceTime(Duration(milliseconds: 500))
    //     .listen((queryString) async {
    //       if (currentTabIs1.value == true) {
    //               listDataTemp = [];
    //               _page=1;
    //               lastItem=false;
    //               await UserService()
    //                   .getAllLuckySpinByFarmer(
    //                       pageIndex: _page, search: _searchController.text)
    //                   .then((value) {
    //                 listDataTemp = value;
    //                 if(value.length<20){
    //                   lastItem=true;
    //                 }
    //                 streamDataHistoryLuckySpin.sink.add(listDataTemp);
    //               });
    //       } else {
    //               listDataTempReferral = [];
    //               _pageReferral=1;
    //               lastItemReferral=false;
    //               await UserService()
    //                   .getAllLuckySpinByFarmerReferral( search: _searchController.text,
    //                       pageIndex: _pageReferral, phone: me.phone).then((value) {
    //                 listDataTempReferral = value;
    //                 if(value.length<20){
    //                   lastItemReferral=true;
    //                 }
    //                 streamDataHistoryLuckySpinReferral.sink.add(listDataTempReferral);
    //                       });
    //       }
    // });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<CampaignModel> tempCampaignList = [];
      tempCampaignList.add(CampaignModel(
          id: "",
          image: '',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          name: ''));
      tempCampaignList.addAll(await vxmmRepository.getCampaignList() ?? []);
      _campaignList.sink.add(tempCampaignList);
      _currentCampaign.sink.add(tempCampaignList[0].id);

      if (_currentCampaign.value == "") {
        await vxmmRepository
            .getAllLuckySpinByFarmer(farmerId: _me.id)
            .then((value) {
          _listDataTemp.addAll(value ?? []);
          _streamDataHistoryLuckySpin.sink.add(value ?? []);
        });
        await vxmmRepository
            .getAllLuckySpinByFarmerReferral(phone: _me.phone ?? '')
            .then((value) {
          _listDataTempReferral.addAll(value ?? []);
          _streamDataHistoryLuckySpinReferral.sink.add(value ?? []);
        });
      }
    });
  }

  void initGetMe() async {
    print('-----------------------------------------');
    final initMe = await Get.find<AuthController>().userGetMe();
    print('initMe:${initMe.id}');
    print('initMe:${initMe.phone}');
    _me = LUser(phone: initMe.phone, id: initMe.id ?? '');
  }

  init() async {
    _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
    _page += 1;
    await vxmmRepository
        .getAllLuckySpinByFarmer(pageIndex: _page, farmerId: _me.id)
        .then((value) {
      _listDataTemp.addAll(value ?? []);
      if ((value?.length ?? 0) < 10) {
        _lastItem = true;
      }
      _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
    });

    _streamDataHistoryLuckySpin.sink.add(_listDataTemp);
    _pageReferral += 1;
    await vxmmRepository
        .getAllLuckySpinByFarmerReferral(
            pageIndex: _pageReferral, phone: _me.phone ?? '')
        .then((value) {
      _listDataTempReferral.addAll(value ?? []);
      if ((value?.length ?? 0) < 10) {
        _lastItemReferral = true;
      }
      _streamDataHistoryLuckySpinReferral.sink.add(_listDataTempReferral);
    });
  }

  Future<void> _onRefresh({bool loadAll = false}) async {
    String campaignId = _currentCampaign.value;
    if (loadAll) {
      _onRefreshScan(campaignId: campaignId);
      _onRefreshReferral(campaignId: campaignId);
    } else {
      if (_currentTabIs1.value == true) {
        _onRefreshScan(campaignId: campaignId);
      } else {
        _onRefreshReferral(campaignId: campaignId);
      }
    }
  }

  Future<void> _onRefreshScan({String? campaignId}) async {
    _page = 1;
    _lastItem = false;
    _listDataTemp = [];
    await vxmmRepository
        .getAllLuckySpinByFarmer(
            pageIndex: _page, campaignId: campaignId, farmerId: _me.id)
        .then((value) {
      _listDataTemp.addAll(value ?? []);
      _streamDataHistoryLuckySpin.sink.add(value ?? []);
    });
  }

  Future<void> _onRefreshReferral({String? campaignId}) async {
    _pageReferral = 1;
    _lastItemReferral = false;
    _listDataTempReferral = [];
    await vxmmRepository
        .getAllLuckySpinByFarmerReferral(
            phone: _me.phone ?? '',
            pageIndex: _pageReferral,
            campaignId: campaignId)
        .then((value) {
      _listDataTempReferral.addAll(value ?? []);
      _streamDataHistoryLuckySpinReferral.sink.add(value ?? []);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _campaignList.close();
    _currentCampaign.close();
    _currentTabIs1.close();
    _searchChangeBehavior.close();
    _streamDataHistoryLuckySpin.close();
    _streamDataHistoryLuckySpinReferral.close();
  }

  // _searchDoc(String text) async {
  //   if (_currentTabIs1.value == true) {
  //     await UserService().getAllLuckySpinByFarmer(search: text).then((value) {
  //       print(value.length);
  //       _listDataTemp = [];
  //       _listDataTemp.addAll(value);
  //       _streamDataHistoryLuckySpin.sink.add(value);
  //     });
  //   } else {
  //       await UserService().getAllLuckySpinByFarmerReferral(phone: _me.phone, search : text).then((value) {
  //       print(value.length);
  //       _listDataTempReferral = [];
  //       _listDataTempReferral.addAll(value);
  //       _streamDataHistoryLuckySpinReferral.sink.add(value);
  //     });
  //   }
  // }

// 0916968263
// 123123
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Lịch sử trúng thưởng'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(15.0),
            //     child: Container(
            //       padding: EdgeInsets.all(deviceWidth(context) * 0.03),
            //       width: deviceWidth(context) * 0.94,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: AssetImage('assets/images/btn_search.png'))),
            //       height: ScaleUtil.getInstance().setWidth(70),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: TextField(
            //           controller: _searchController,
            //           style: ptTitle(context).copyWith(color: Colors.white),
            //           cursorColor: Colors.white,
            //           onSubmitted: _searchDoc,
            //           onChanged: (value) {
            //             _searchChangeBehavior.sink.add(value);
            //           },
            //           decoration: InputDecoration(
            //             hintText: "Tìm kiếm...",
            //             contentPadding: EdgeInsets.all(10.0),
            //             hintStyle:
            //                 ptTitle(context).copyWith(color: Colors.white70),
            //             border: InputBorder.none,
            //             enabledBorder: InputBorder.none,
            //             disabledBorder: InputBorder.none,
            //             focusedBorder: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // StreamBuilder<List<CampaignModel>>(
            //     stream: _campaignList.stream,
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) return Container();
            //       return StreamBuilder<String>(
            //           stream: _currentCampaign.stream,
            //           builder: (context, snap) {
            //             if (!snap.hasData) {
            //               return SizedBox();
            //             }
            //             return Container(
            //               height: 40,
            //               margin: EdgeInsets.only(bottom: 10),
            //               color: HexColor(appColor),
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: snapshot.data?.length,
            //                   itemBuilder: (context, index) {
            //                     if (index == 0)
            //                       return InkWell(
            //                           onTap: () {
            //                             print('${snapshot.data?[index].name}');
            //                             _currentCampaign.sink.add("");
            //                             _onRefresh(loadAll: true);
            //                           },
            //                           child: Container(
            //                               padding: EdgeInsets.symmetric(horizontal: 10), alignment: Alignment.center, child: Text("Tất cả")));
            //                     return InkWell(
            //                       onTap: () {
            //                         print('${snapshot.data?[index].name}');
            //                         _currentCampaign.sink.add(snapshot.data?[index].id ?? '');
            //                         _onRefresh(loadAll: true);
            //                       },
            //                       child: Container(
            //                           alignment: Alignment.center,
            //                           padding: EdgeInsets.symmetric(horizontal: 10),
            //                           child: Text(
            //                             snapshot.data?[index].name ?? '',
            //                           )),
            //                     );
            //                   }),
            //             );
            //           });
            //     }),

            StreamBuilder<bool>(
                stream: _currentTabIs1.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return SizedBox();
                  return TabBarComponent(
                    currentTabIs1: snapshot.data == true,
                    callBack: (value) {
                      print(value);
                      _currentTabIs1.sink.add(value);
                    },
                  );
                }),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'CHƯƠNG TRÌNH',
                        style: TextStyle(color: ColorConst.primaryColor),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        'PHẦN THƯỞNG',
                        style: TextStyle(color: ColorConst.primaryColor),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'THỜI GIAN',
                          style: TextStyle(color: ColorConst.primaryColor),
                        ),
                      )),
                ],
              ),
            ),
            StreamBuilder<List<HistoryLuckySpinModel>>(
                stream: _streamDataHistoryLuckySpin.stream,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream: _currentTabIs1.stream,
                      builder: (context, snap) {
                        if (!snap.hasData) return SizedBox();
                        if (snap.data == false) {
                          return SizedBox();
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _onRefresh();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: (snapshot.data?.length ?? 0) + 1,
                                  controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    if (!snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child:
                                            Center(child: Text("Đang tải...")),
                                      );
                                    }
                                    if (_lastItem == true &&
                                        snapshot.data!.length == index) {
                                      if (snapshot.data!.length < 10 &&
                                          snapshot.data!.length > 0)
                                        return SizedBox();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                            child: Text('Không có dữ liệu')),
                                      );
                                    }
                                    if (snapshot.data!.length == index &&
                                        _lastItem == false) {
                                      if (snapshot.data!.length < 10)
                                        return SizedBox();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child:
                                            Center(child: Text("Đang tải...")),
                                      );
                                    }
                                    return HistoryLuckySpinItem(
                                      historyLuckySpinModel:
                                          snapshot.data![index],
                                    );
                                  }),
                            ),
                          ),
                        );
                      });
                }),

            StreamBuilder<List<HistoryLuckySpinModel>>(
                stream: _streamDataHistoryLuckySpinReferral.stream,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream: _currentTabIs1.stream,
                      builder: (context, snap) {
                        if (!snap.hasData) return SizedBox();
                        if (snap.data == true) {
                          return SizedBox();
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _onRefresh();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: (snapshot.data?.length ?? 0) + 1,
                                  controller: _scrollControllerReferral,
                                  itemBuilder: (context, index) {
                                    if (!snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child:
                                            Center(child: Text("Đang tải...")),
                                      );
                                    }
                                    if (_lastItem == true &&
                                        snapshot.data!.length == index) {
                                      if (snapshot.data!.length < 10 &&
                                          snapshot.data!.length > 0)
                                        return SizedBox();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                            child: Text('Không có dữ liệu')),
                                      );
                                    }
                                    if (snapshot.data!.length == index &&
                                        _lastItem == false) {
                                      if (snapshot.data!.length < 10)
                                        return SizedBox();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child:
                                            Center(child: Text("Đang tải...")),
                                      );
                                    }
                                    return HistoryLuckySpinItem(
                                      historyLuckySpinModel:
                                          snapshot.data![index],
                                    );
                                  }),
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
