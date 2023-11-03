import 'package:flutter/material.dart';

import '../../export.dart';

class InformationAppPage extends StatelessWidget {
  const InformationAppPage({Key? key}) : super(key: key);

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
              "assets/images/ic_back.png",
              fit: BoxFit.cover,
              width: 24,
              height: 24,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: Text('Về chúng tôi',
            style: StyleConst.boldStyle(fontSize: titleSize)),
        //centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: ColorConst.primaryColor,
              height: 8,
            ),
            preferredSize: Size.fromHeight(8)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 150),
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(20))),
                  Text(
                      // "TẬP ĐOÀN NÔNG NGHIỆP TRI THỨC\n Thành lập từ năm 1993, trải qua 24 năm phát triển, Tập đoàn Lộc Trời luôn gắn bó với người nông dân và đóng góp vào sự phát triển bền vững của nền nông nghiệp Việt Nam. Tập đoàn với 25 chi nhánh trải rộng khắp Việt Nam, một chi nhánh tại Campuchia. Tập đoàn Lộc Trời – tiền thân là Công ty cổ phần bảo vệ thực vật An Giang (AGPPS) là nhà sản xuất, cung ứng sản phẩm và dịch vụ dẫn đầu thị trường Việt Nam trong lĩnh vực nông nghiệp, với chuỗi giá trị bền vững từ nghiên cứu, sản xuất, kinh doanh các sản phẩm hạt giống, thuốc bảo vệ thực vật, các sản phẩm hữu cơ sinh học, lúa gạo, cà phê. \n\n SỨ MỆNH \nHiện thực hóa những ước vọng của nông dân, nâng cao vị thế và chất lượng cuộc sống của người nông dân, góp phần xây dựng những vùng nông thôn đáng sống”. \n\nTẦM NHÌN \nLà Tập đoàn hàng đầu khu vực về dịch vụ nông nghiệp với Chuỗi giá trị nông nghiệp bền vững và các thương hiệu nông sản dẫn đầu. Là người phụng sự được nông dân và người tiêu dùng tin yêu hàng đầu; Tiên phong trong việc ứng dụng các giải pháp khoa học công nghệ tiên tiến hướng tới hiệu quả. Mang lại cuộc sống sung túc cho nhân viên, đem lại lợi nhuận cao cho nhà đầu tư dài hạn.",
                      "Hệ thống Bệnh Viện Cây Ăn Quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam và Tập Đoàn Lộc Trời.",
                      style: StyleConst.regularStyle()),
                  // Visibility(
                  //   visible: !isYes,
                  //   child: RaisedButton(
                  //       onPressed: () {},
                  //       child: Text(Strings.agree.toUpperCase(), style: Theme.of(context).textTheme.button)),
                  // ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   child: Image.asset(
          //     "assets/images/home_bottom.png",
          //     width: MediaQuery.of(context).size.width,
          //     fit: BoxFit.cover,
          //     alignment: Alignment.bottomCenter,
          //     // height: 130,
          //   ),
          // ),
        ],
      ),
    );
  }
}
