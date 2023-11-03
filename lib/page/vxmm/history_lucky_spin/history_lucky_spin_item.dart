import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/models/history_lucky_spin_model.dart';
import 'package:intl/intl.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';

class HistoryLuckySpinItem extends StatelessWidget {
  const HistoryLuckySpinItem({Key? key, required this.historyLuckySpinModel})
      : super(key: key);
  final HistoryLuckySpinModel historyLuckySpinModel;
  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: Localizations.localeOf(context).toString(),
    );
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        // margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    historyLuckySpinModel.campaignId?.name ?? "",
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    historyLuckySpinModel.prizeName ?? "",
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${DateFormat('dd/MM/yyyy').format(DateTime.parse(historyLuckySpinModel.createdAt ?? ''))}",
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 5),
                //   child: Row(
                //     children: [

                //       Text(
                //         "Ngày quét: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(historyLuckySpinModel.createdAt ?? ''))}",
                //       ),
                //     ],
                //   ),
                // ),
                // historyLuckySpinModel.farmerId != null
                //     ? historyLuckySpinModel.farmerId is ReferIdMap
                //         ? Padding(
                //             padding: const EdgeInsets.only(bottom: 5),
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.person_outline,
                //                   color: HexColor(appText2),
                //                   size: 16,
                //                 ),
                //                 const SizedBox(width: 10),
                //                 Text(
                //                   "Người quét: ${(historyLuckySpinModel.farmerId as ReferIdMap).phone ?? ''}",
                //                 )
                //               ],
                //             ),
                //           )
                //         : const SizedBox()
                //     : const SizedBox(),
                //     historyLuckySpinModel.refPrize != null
                //         ? Visibility(
                //             visible: historyLuckySpinModel.refPrize?.active ?? false,
                //             child: Row(
                //               children: [
                //                 Icon(
                //                   Icons.card_giftcard,
                //                   color: HexColor(appColor),
                //                   size: 16,
                //                 ),
                //                 SizedBox(width: 10),
                //                 if (historyLuckySpinModel.refPrize?.type == "TOPUP")
                //                   Text(
                //                     "Phần thưởng: ${formatter.format(historyLuckySpinModel.refPrize?.topupAmount ?? 0)}",
                //                   )
                //                 else if (historyLuckySpinModel.refPrize?.type == "COMMISSION")
                //                   Text(
                //                     "Phần thưởng: ${formatter.format(historyLuckySpinModel.refPrize?.commissionAmount ?? 0)}",
                //                   )
                //                 else
                //                   SizedBox()
                //               ],
                //             ),
                //           )
                //         : const SizedBox(),
                //     Container(margin: EdgeInsets.only(top: 10, bottom: 10), height: 1, color: Colors.grey),
                //     historyLuckySpinModel.value != null
                //         ? Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "+${NumberFormat('##,000 ').format(historyLuckySpinModel.value)} điểm",
                //               )
                //             ],
                //           )
                //         : SizedBox()
              ],
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ));
  }
}
