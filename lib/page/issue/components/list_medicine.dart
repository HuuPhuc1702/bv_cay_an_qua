import 'package:bv_cay_an_qua/page/controllers/medicine_controller.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_provider.dart';
import 'package:bv_cay_an_qua/shared/helper/print_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../export.dart';
import 'information_medicine.dart';

class ListMedicine extends StatefulWidget {
  const ListMedicine({Key? key}) : super(key: key);

  @override
  _ListMedicineState createState() => _ListMedicineState();
}

class _ListMedicineState extends State<ListMedicine> {
  ScrollController scrollController = ScrollController();
  MedicineController _medicineProvider = Get.put(MedicineController());
  BehaviorSubject<String> _searchChangeBehavior =
      BehaviorSubject<String>.seeded("");

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _medicineProvider.loadMore();
      }
    });

    _searchChangeBehavior
        .debounceTime(Duration(milliseconds: 500))
        .listen((queryString) {
      printLog(queryString);
      if (_medicineProvider.queryInput != null) {
        _medicineProvider.loadAll(
            query: mapData(
                _medicineProvider.queryInput!.toJson(),
                QueryInput(limit: 20, page: 1, search: "$queryString")
                    .toJson()));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchChangeBehavior.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Image.asset(
              AssetsConst.iconBack,
              fit: BoxFit.cover,
              width: 24,
              height: 24,
            ),
          ),
        ),
        brightness: Brightness.light,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Danh sách thuốc",
                style: StyleConst.boldStyle(
                        color: ColorConst.red, fontSize: titleSize)
                    .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
            Text('www.benhviencayanqua.vn',
                style: StyleConst.mediumStyle(color: ColorConst.primaryColor)),
          ],
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: ColorConst.primaryColor,
              height: 8,
            ),
            preferredSize: Size.fromHeight(8)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 2, bottom: 2, right: 5),
                    child: Icon(
                      Icons.search,
                      size: titleSize * 1.8,
                      color: Colors.grey.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: StyleConst.mediumStyle(),
                      cursorColor: ColorConst.primaryColor,
                      onChanged: _searchChangeBehavior.sink.add,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm...",
                        isDense: true,
                        hintStyle: StyleConst.mediumStyle(color: Colors.grey),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 2, bottom: 2, right: 10),
                    child: StreamBuilder<String>(
                      stream: _searchChangeBehavior.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false ||
                            (snapshot.data?.isEmpty ?? true)) return SizedBox();
                        return GestureDetector(
                          onTap: () {
                            _searchChangeBehavior.sink.add('');
                            _searchController.clear();
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: titleSize * 1.5,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: GetBuilder<MedicineController>(builder: (controller) {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.loadMoreItems.value.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.loadMoreItems.value.length) {
                        if (controller.loadMoreItems.value.length >=
                                (controller.pagination.value.limit ?? 30) ||
                            controller.loadMoreItems.value.length == 0) {
                          return WidgetLoading(
                            notData: controller.lastItem,
                            count: controller.loadMoreItems.value.length,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                      if (controller.lastItem == false &&
                          controller.loadMoreItems.value.length == 0) {
                        return WidgetLoading();
                      }
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: .5),
                                top:
                                    BorderSide(color: Colors.grey, width: .5))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "${controller.loadMoreItems.value[index].name}",
                              style: StyleConst.regularStyle(),
                            )),
                            WidgetButton(
                              text: "Chọn",
                              paddingBtnHeight: 8,
                              textColor: Colors.white,
                              onTap: () {
                                Get.to(InformationMedicine(
                                  medicineModel:
                                      controller.loadMoreItems.value[index],
                                ));
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
