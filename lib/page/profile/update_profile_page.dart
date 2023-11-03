import 'package:bv_cay_an_qua/shared/widget/widget-combobox.dart';

import '../components/image_picker.dart';
import '../login/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../export.dart';

// ignore: must_be_immutable
class UpdateProfilePage extends StatefulWidget {
  bool firstPage;

  UpdateProfilePage({Key? key, this.firstPage = false}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  bool isUpdateInfo = false;
  bool turnOffValidate = true;
  final _formKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  SizedBox sizeBox() {
    return SizedBox(
      height: 16.0,
    );
  }

  @override
  void initState() {
    // avatar = me.avatar ?? 'https://via.placeholder.com/150';
    authController.getProvince();
    isUpdateInfo = widget.firstPage;
    nameController =
        TextEditingController(text: authController.userCurrent.name ?? '');
    phoneController =
        TextEditingController(text: authController.userCurrent.phone ?? '');
    addressController = TextEditingController(
        text: authController.userCurrent.place?.fullAddress ?? '');

    if (authController.userCurrent.place?.provinceId != null) {
      authController.getProvince(
          provinceId: authController.userCurrent.place?.provinceId);
    }
    if (authController.userCurrent.place?.districtId != null) {
      authController.getDistrict(
          authController.userCurrent.place?.provinceId ?? "",
          districtId: authController.userCurrent.place?.districtId);
    }
    if (authController.userCurrent.place?.wardId != null) {
      authController.getWard(authController.userCurrent.place?.districtId ?? "",
          wardId: authController.userCurrent.place?.wardId);
    }
    areaController =
        TextEditingController(text: '${authController.userCurrent.area ?? ""}');
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.firstPage == true) {
        showExist(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          title: Text('Thông tin cá nhân',
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
        body: Form(
          key: _formKey,
          child: GetBuilder<AuthController>(
            builder: (controller) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ImagePickerWidget(
                        context: context,
                        isEdit: isUpdateInfo,
                        positionUser: appConfig.appType == AppType.DOCTOR
                            ? 'doctor'
                            : 'client',
                        circle: true,
                        size: isUpdateInfo ? 70 : 100.0,
                        quality: 100,
                        resourceUrl: authController.userCurrent.avatar ?? "",
                        onFileChanged: (fileUri, fileType) {
                          setState(() {
                            authController.userCurrent.avatar = fileUri;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: isUpdateInfo ? 20 : 50,
                    ),
                    isUpdateInfo ? _buildUpdateInfo() : _buildViewInfo()
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
          height: 60.0,
          decoration: BoxDecoration(
              color: isUpdateInfo
                  ? ColorConst.primaryColor
                  : ColorConst.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: WidgetButton(
            textColor: ColorConst.white,
            text: isUpdateInfo
                ? "Cập nhật thông tin".toUpperCase()
                : "Chỉnh sửa thông tin".toUpperCase(),
            onTap: isUpdateInfo ? _handleUpdate : _handleEdit, // button pressed
          ),
        ),
      ),
    );
  }

  _buildViewInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/icons/icon_person.png",
                  fit: BoxFit.fitHeight, height: 25, width: 25),
              SizedBox(width: 30),
              Expanded(
                  child: Text(
                authController.userCurrent.name ?? "",
                style: StyleConst.regularStyle(fontSize: titleSize),
              ))
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Image.asset("assets/icons/icon_phone.png",
                  fit: BoxFit.fitHeight, height: 25, width: 25),
              SizedBox(width: 30),
              Expanded(
                  child: Text(
                authController.userCurrent.phone ?? "",
                style: StyleConst.regularStyle(fontSize: titleSize),
              ))
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Image.asset("assets/icons/icon_address.png",
                  fit: BoxFit.fitHeight, height: 25, width: 25),
              SizedBox(width: 30),
              Expanded(
                  child: Text(
                authController.userCurrent.place?.fullAddress ?? "",
                style: StyleConst.regularStyle(fontSize: titleSize),
              ))
            ],
          ),
          SizedBox(height: 30),
          appConfig.appType == AppType.DOCTOR
              ? SizedBox()
              : Row(
                  children: [
                    Image.asset("assets/icons/icon_area_ha.png",
                        fit: BoxFit.fitHeight, height: 25, width: 25),
                    SizedBox(width: 30),
                    Expanded(
                        child: Text(
                      authController.userCurrent.area.toString() + " ha",
                      style: StyleConst.regularStyle(fontSize: titleSize),
                    ))
                  ],
                )
        ],
      ),
    );
  }

  _buildUpdateInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Họ và tên",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetTextField(
            controller: nameController,
            hintText: 'Nhập họ và tên',
            turnOffValidate: turnOffValidate,
            radius: 6,
          ),

          // Text(
          //   "Họ và tên",
          //   style:
          //   StyleConst.mediumStyle(color: ColorConst.primaryColor),
          // ),
          // TextFormField(
          //   //enabled: isUpdateInfo,
          //   controller: nameController,
          //   maxLines: 1,
          //   style: StyleConst.mediumStyle(
          //       fontSize: defaultSize, color: Colors.black.withOpacity(0.8)),
          //   maxLength: 30,
          //   autocorrect: false,
          //   // inputFormatters: [BlacklistingTextInputFormatter(RegExp(r"\s\s"))],
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     // prefixIcon: Padding(
          //     //   padding: EdgeInsets.only(right: 20.0),
          //     //   child: Icon(
          //     //     Icons.person,
          //     //     color: ColorConst.grey,
          //     //     size: 30.0,
          //     //   ),
          //     // ),
          //     counterText: '',
          //     hintText: 'Họ và tên',
          //     isDense: true,
          //     hintStyle: StyleConst.mediumStyle(fontSize: defaultSize)
          //         .copyWith(color: ColorConst.grey),
          //     fillColor: ColorConst.primaryColor,
          //     border: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     disabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //   ),
          //   validator: (text) {
          //     return (text != null && (text.isEmpty || text.trim() == ''))
          //         ? 'Vui lòng nhập họ tên'
          //         : null;
          //
          //     // final alphanumeric = RegExp(r'^[a-zA-Z0-9" "]+$');
          //     // alphanumeric.hasMatch(text);
          //     // if (text.isEmpty) {
          //     //   return 'Vui lòng nh��p họ tên';
          //     // } else if (alphanumeric.hasMatch(text)) {
          //     //   return null;
          //     // } else {
          //     //   return 'Tên chỉ gồm chữ và số';
          //     // }
          //   },
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Số điện thoại",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetTextField(
            controller: phoneController,
            hintText: 'Nhập số điện thoại',
            turnOffValidate: turnOffValidate,
            enabled: false,
            radius: 6,
            keyboardType: TextInputType.phone,
          ),

          // sizeBox(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //         padding: EdgeInsets.only(bottom: 5),
          //         child: Text(
          //           "Số điện thoại",
          //           style:
          //               StyleConst.mediumStyle(color: ColorConst.primaryColor),
          //         )),
          //   ],
          // ),
          // TextFormField(
          //   controller: phoneController,
          //   enabled: false,
          //   maxLines: 1,
          //   style: StyleConst.mediumStyle(
          //       fontSize: defaultSize, color: Colors.black.withOpacity(0.8)),
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     // prefixIcon: Padding(
          //     //   padding: EdgeInsets.only(right: 20.0),
          //     //   child: Icon(
          //     //     Icons.phone,
          //     //     color: ColorConst.grey,
          //     //     size: 30.0,
          //     //   ),
          //     // ),
          //     hintText: 'Số điện thoại',
          //     isDense: true,
          //
          //     hintStyle: StyleConst.mediumStyle(fontSize: defaultSize)
          //         .copyWith(color: ColorConst.grey),
          //     fillColor: ColorConst.primaryColor,
          //     border: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     disabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Địa chỉ",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetTextField(
            controller: addressController,
            hintText: 'Nhập số nhà',
            turnOffValidate: turnOffValidate,
            radius: 6,
          ),

          // TextFormField(
          //   //enabled: isUpdateInfo,
          //   controller: addressController,
          //   maxLines: 1,
          //   style: StyleConst.mediumStyle(
          //       fontSize: defaultSize, color: Colors.black.withOpacity(0.8)),
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     // prefixIcon: Padding(
          //     //   padding: EdgeInsets.only(right: 20.0),
          //     //   child: Icon(
          //     //     Icons.pin_drop,
          //     //     color: ColorConst.grey,
          //     //     size: 30.0,
          //     //   ),
          //     // ),
          //     hintText: 'Nhập số nhà',
          //     isDense: true,
          //
          //     hintStyle: StyleConst.mediumStyle(fontSize: defaultSize)
          //         .copyWith(color: ColorConst.grey),
          //     fillColor: ColorConst.primaryColor,
          //     border: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     disabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.grey)),
          //   ),
          //   validator: (text) {
          //     return (text != null && (text.isEmpty || text.trim() == ''))
          //         ? 'Vui lòng nhập địa chỉ'
          //         : null;
          //   },
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Tỉnh/thành phố",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetComboBox(
            listData: authController.listDataProvince,
            itemSelected: authController.provinceModel,
            hintText: "Chọn tỉnh/thành phố",
            turnOffValidate: turnOffValidate,
            onSelected: (newValue) {
              authController.getDistrict(newValue.id);
              authController.districtModel = null;
              authController.wardModel = null;
              setState(() {
                authController.provinceModel = newValue;
              });
            },
          ),

          // customDropdown(
          //   data: authController.provinceModel,
          //   listData: authController.listDataProvince,
          //   hintTex: "Chọn tỉnh/thành phố",
          //   onChange: (newValue) {
          //     if (newValue != null) {
          //       authController.getDistrict(newValue.id);
          //       authController.districtModel = null;
          //       authController.wardModel = null;
          //     }
          //     setState(() {
          //       authController.provinceModel = newValue!;
          //     });
          //   },
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Quận/huyện",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetComboBox(
            listData: authController.listDataDistrict,
            itemSelected: authController.districtModel,
            hintText: "Chọn quận/huyện",
            turnOffValidate: turnOffValidate,
            onSelected: (newValue) {
              authController.getWard(newValue.id);
              authController.wardModel = null;
              setState(() {
                authController.districtModel = newValue;
              });
            },
          ),

          // customDropdown(
          //   data: authController.districtModel,
          //   listData: authController.listDataDistrict,
          //   hintTex: "Chọn quận/huyện",
          //   onChange: (newValue) {
          //     if (newValue != null) {
          //       authController.getWard(newValue.id);
          //       authController.wardModel = null;
          //     }
          //     setState(() {
          //       authController.districtModel = newValue!;
          //     });
          //   },
          // ),

          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 5),
            child: Text(
              "Phường/xã",
              style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
            ),
          ),
          WidgetComboBox(
            listData: authController.listDataWard,
            itemSelected: authController.wardModel,
            hintText: "Chọn phường/xã",
            turnOffValidate: turnOffValidate,
            onSelected: (newValue) {
              setState(() {
                authController.wardModel = newValue;
              });
            },
          ),
          // customDropdown(
          //   data: authController.wardModel,
          //   listData: authController.listDataWard,
          //   hintTex: "Chọn phường/xã",
          //   onChange: (newValue) {
          //     setState(() {
          //       authController.wardModel = newValue!;
          //     });
          //   },
          // ),
          sizeBox(),
          sizeBox(),
          appConfig.appType == AppType.DOCTOR
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Diện tích canh tác",
                    style:
                        StyleConst.mediumStyle(color: ColorConst.primaryColor),
                  )),
          appConfig.appType == AppType.DOCTOR
              ? SizedBox()
              : WidgetTextField(
                  suffix: 'ha',
                  controller: areaController,
                  hintText: 'Diện tích canh tác',
                  turnOffValidate: turnOffValidate,
                  maxLength: 3,
                  radius: 6,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
          // : TextFormField(
          //     // enabled: isUpdateInfo,
          //     controller: areaController,
          //     maxLines: 1,
          //     maxLength: 3,
          //     style: StyleConst.mediumStyle(
          //         fontSize: defaultSize,
          //         color: Colors.black.withOpacity(0.8)),
          //     decoration: InputDecoration(
          //       // prefixIcon: Padding(
          //       //   padding: EdgeInsets.only(right: 20.0),
          //       //   child: Icon(
          //       //     Icons.spa,
          //       //     color: ColorConst.grey,
          //       //     size: 30.0,
          //       //   ),
          //       // ),
          //       hintText: 'Diện tích canh tác',
          //       hintStyle: StyleConst.mediumStyle(fontSize: defaultSize)
          //           .copyWith(color: ColorConst.grey),
          //       fillColor: ColorConst.primaryColor,
          //       border: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.grey)),
          //       enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.grey)),
          //       disabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.grey)),
          //       focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.grey)),
          //       suffix: Text(
          //         'ha',
          //         style: StyleConst.mediumStyle(
          //             color: ColorConst.primaryColorGradient2),
          //       ),
          //     ),
          //     inputFormatters: [
          //       FilteringTextInputFormatter.allow(
          //           RegExp(r'^[0-9]*(\.[0-9]*)?')),
          //     ],
          //     validator: (text) {
          //       if (text != null && text.isEmpty)
          //         return 'Vui lòng nhập diện tích canh tác';
          //       try {
          //         double.parse(text ?? "");
          //       } catch (e) {
          //         return 'Giá trị không hợp lệ';
          //       }
          //       return null;
          //     },
          //   ),

          sizeBox(),
          sizeBox(),
        ],
      ),
    );
  }

  _handleUpdate() async {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        authController.wardModel == null ||
        authController.districtModel == null ||
        authController.provinceModel == null) {
      setState(() {
        turnOffValidate = false;
      });
      showSnackBar(
          title: "Thông báo",
          body: "Vui lòng nhập đủ thông tin.",
          backgroundColor: ColorConst.red);
      return;
    }

    addressController.text =
        "${addressController.text.indexOf(", ") > 0 ? addressController.text.substring(0, addressController.text.indexOf(", ")) : addressController.text}"
        "${authController.wardModel != null ? ", ${authController.wardModel?.title ?? ""}" : ""}"
        "${authController.districtModel != null ? ", ${authController.districtModel?.title ?? ""}" : ""}"
        "${authController.provinceModel != null ? ", ${authController.provinceModel?.title ?? ""}" : ""}";

    authController.userUpdateMe(
      name: nameController.text,
      address: addressController.text,
      area: areaController.text,
      firstPage: widget.firstPage,
      street:
          "${addressController.text.indexOf(", ") > 0 ? addressController.text.substring(0, addressController.text.indexOf(", ")) : addressController.text}",
      wardId: authController.wardModel?.id,
      ward: authController.wardModel?.title,
      province: authController.provinceModel?.title,
      provinceId: authController.provinceModel?.id,
      district: authController.districtModel?.title,
      districtId: authController.districtModel?.id,
    );

    setState(() {
      isUpdateInfo = false;
    });
  }

  _handleEdit() async {
    addressController.text =
        "${addressController.text.indexOf(", ") > 0 ? addressController.text.substring(0, addressController.text.indexOf(", ")) : addressController.text}";
    print("${authController.districtModel?.title}");
    setState(() {
      isUpdateInfo = true;
    });
  }

  customDropdown(
      {FormComboBox? data,
      String? hintTex,
      List<FormComboBox>? listData,
      required Function(FormComboBox?) onChange}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizeBox(),
        Text(
          hintTex ?? '',
          style: StyleConst.mediumStyle(color: ColorConst.primaryColor),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(width: 1, color: ColorConst.grey)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownButton<FormComboBox>(
              value: data,
              isExpanded: true,
              isDense: true,
              hint: Text(hintTex ?? "", style: StyleConst.mediumStyle()),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 30,
              style:
                  StyleConst.mediumStyle(color: Colors.black.withOpacity(0.8)),
              underline: Container(
                height: 0,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: onChange,
              items: listData?.map<DropdownMenuItem<FormComboBox>>((item) {
                return DropdownMenuItem<FormComboBox>(
                  value: item,
                  child: Text(item.title),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  widgetDrop(
      {FormComboBox? data,
      String? hintTex,
      List<FormComboBox>? listData,
      required Function(FormComboBox?) onChange}) {
    try {
      return Visibility(
        visible: isUpdateInfo,
        child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: DropdownButton<FormComboBox>(
            value: data,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            hint: Text(
              "${hintTex ?? " "}",
              style: StyleConst.mediumStyle(color: ColorConst.grey),
            ),
            style: StyleConst.mediumStyle(),
            underline: Container(
              height: 2,
              color: ColorConst.borderInputColor,
            ),
            onChanged: onChange,
            items: listData
                ?.map<DropdownMenuItem<FormComboBox>>((FormComboBox value) {
              return DropdownMenuItem<FormComboBox>(
                value: value,
                child: Text(
                  value.title,
                  style: StyleConst.mediumStyle(),
                ),
              );
            }).toList(),
          ),
        ),
      );
    } catch (error) {
      print(error);
      return SizedBox();
    }
  }

  Future<bool> showExist(BuildContext context) async {
    bool result = false;
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Thông báo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Chào mừng bạn đến ứng dụng "Bệnh viện Cây ăn quả", vui lòng cập nhật đầy đủ thông tin để chúng tôi có thể tư vấn cho bạn được tốt hơn.'),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 16, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  WidgetButton(
                    text: 'Đồng ý',
                    textColor: Colors.white,
                    onTap: () {
                      result = true;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return result;
  }
}
