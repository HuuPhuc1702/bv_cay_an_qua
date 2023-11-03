import 'package:bv_cay_an_qua/shared/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:bv_cay_an_qua/constants/constants.dart';
import 'package:intl/intl.dart';

class RankItem extends StatelessWidget {
  const RankItem(
      {Key? key, this.image, this.title, this.price, this.isMe, this.index})
      : super(key: key);
  final String? image;
  final String? title;
  final num? price;
  final int? index;
  final bool? isMe;
  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.decimalPattern();

    String rank_round = "";
    if (isMe == true) {
      rank_round = "assets/images/rank_me_round.png";
    } else {
      if (index == 1)
        rank_round = "assets/images/rank_gold_round.png";
      else if (index == 2)
        rank_round = "assets/images/rank_silver_round.png";
      else if (index == 3)
        rank_round = "assets/images/rank_bronze_round.png";
      else
        rank_round = "assets/images/rank_other_round.png";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 15, right: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(1, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: (isMe == true)
                          ? Image.asset("assets/images/rank_me_rectangle.png")
                          : (index == 1)
                              ? Image.asset(
                                  "assets/images/rank_gold_rectangle.png")
                              : (index == 2)
                                  ? Image.asset(
                                      "assets/images/rank_silver_rectangle.png")
                                  : (index == 3)
                                      ? Image.asset(
                                          "assets/images/rank_bronze_rectangle.png")
                                      : Image.asset(
                                          "assets/images/rank_other_rectangle.png")),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? "",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          price != null ? formatter.format(price) : '',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(rank_round),
                backgroundColor: Colors.white,
                foregroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: (image != null && image != "null" && image != '')
                      ? Image.network(
                          image ?? '',
                          height: 55,
                          width: 55,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/app_logo.png",
                          height: 55,
                          width: 55,
                        ),
                ),
              ),
            ),
          ),
          index != null
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(90),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: HexColor(appWhite),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              rank_round,
                              height: 40,
                              width: 40,
                            ),
                            Text(
                              ((isMe ?? false) ? index : (index ?? 0 + 1))
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
