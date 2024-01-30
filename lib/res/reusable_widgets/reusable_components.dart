import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/applicant_details/applicant_schemewise_details_response.dart';
import 'package:praja_palana/models/cheyuta/beedi_thekadar.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/dropdown_resuable.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/res/reusable_widgets/row_radio_component.dart';
import 'package:praja_palana/res/reusable_widgets/table_fivecoloum.dart';
import 'package:praja_palana/view_model/schemesViewModel/cheyuthaSchemeViewModel.dart';

import '../../models/master_data/master_geograpics_response.dart';

class ReusableComponents {
  officerNameAndApplicationNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              AppConstants.applicantNumber.toString(),
              style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              AppConstants.userName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  startSurveyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Start",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Release",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String maskNumber(int number) {
    String numberString = number.toString();

    // Check if the number has more than two digits
    if (numberString.length > 4) {
      // Mask all digits except the last two
      String maskedPart = 'X' * (numberString.length - 4);

      // Extract the last two digits
      String lastTwoDigits = numberString.substring(numberString.length - 4);

      // Combine the masked part with the last two digits
      return maskedPart + lastTwoDigits;
    } else {
      // If the number has two or fewer digits, show the number as is
      return numberString;
    }
  }

  ApplicationRationAndApplicantName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RationCard: ${AppConstants.rationNumber.toString()}",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: AppColors.appColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Aadhaar: ${maskNumber(int.tryParse(AppConstants.aadharNumber) ?? 0)}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.appColor,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Applicant Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: AppColors.appColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "${AppConstants.applicantName.toString()}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.appColor,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          /*  Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Applicant Name \n${AppConstants.applicantName.toString()}",
              style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ), */
        ],
      ),
    );
  }

  toodyTapperLayout(TextEditingController registrationTypeController) {
    return Column(
      children: [
        ReusableTextFormField(
            controller: registrationTypeController,
            labelText: "Registration Type")
      ],
    );
  }

  weaverLayout(CheyuthaSchemeViewModel cheyuthaProvider) {
    return RowRadioComponent(
      title: "IS APPLICANT MEMBER OF WEAVER COOPERATIVE ".tr(),
      row: Row(
        children: [
          Radio(
            value: 'Y',
            groupValue: cheyuthaProvider.selectedApplicantCooperativeSociety,
            onChanged: (value) {
              cheyuthaProvider
                  .changeStatusOfApplicantCooperativeSociety(value.toString());
            },
          ),
          Text("Yes".tr()),
          Radio(
            value: 'N',
            groupValue: cheyuthaProvider.selectedApplicantCooperativeSociety,
            onChanged: (value) {
              cheyuthaProvider
                  .changeStatusOfApplicantCooperativeSociety(value.toString());
            },
          ),
          Text("No".tr()),
        ],
      ),
    );
  }

  singleWomenLayout(List<Singlewomen> singlewomenList,
      CheyuthaSchemeViewModel cheyuthaProvider) {
    return Column(
      children: [
        DropdownTextFormFieldComponent(
            hintText: AppStrings.select_category,
            labelText: AppStrings.select_category,
            items: singlewomenList.map((Singlewomen? option) {
              return DropdownMenuItem<Singlewomen>(
                value: option,
                child: Text(option?.sWNAME ?? ''),
              );
            }).toList(),
            onChanged: (newValue) {
              cheyuthaProvider.changeSingleWomenCategory(newValue);
            },
            value: cheyuthaProvider.selectedSingleWomenCategory),
        SizedBox(
          height: 10.0,
        ),
        RowRadioComponent(
          title: "LEAGAL DOCUMENTS AVAILABLE IN CASE OF MARRIED".tr(),
          row: Row(
            children: [
              Radio(
                value: 'Y',
                groupValue: cheyuthaProvider.selectedLegalDocumentSingleWomen,
                onChanged: (value) {
                  cheyuthaProvider
                      .changeLeagalDocumentSingleWomen(value.toString());
                },
              ),
              Text("Yes".tr()),
              Radio(
                value: 'N',
                groupValue: cheyuthaProvider.selectedLegalDocumentSingleWomen,
                onChanged: (value) {
                  cheyuthaProvider
                      .changeLeagalDocumentSingleWomen(value.toString());
                },
              ),
              Text("No".tr()),
            ],
          ),
        )
      ],
    );
  }

  beediTekedarLayout(
      CheyuthaSchemeViewModel cheyuthaProvider,
      BuildContext context,
      TextEditingController industryController,
      TextEditingController licenseIssueDateController,
      TextEditingController licensevalidDateController,
      TextEditingController licenceNoController,
      FamilyListMdl? familyListMdl,
      List<BeediThekadarModel> beediThekedarList,
      void Function()? onPressed) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ReusableTextFormField(
                  maxLength: 17,
                  controller: industryController,
                  keyboardType: TextInputType.text,
                  labelText: "Industry Name".tr()),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            TextButton(
                onPressed: onPressed,
                /* () {
                  if (industryController.text.isNotEmpty) {
                    BeediThekadarModel beedThikedar = BeediThekadarModel();
                    beedThikedar.industryName =
                        industryController.text.toString();
                    beedThikedar.licenseIssueDate =
                        licenseIssueDateController.text.toString();
                    beedThikedar.licenseNo =
                        licenceNoController.text.toString();
                    beedThikedar.licenseValid =
                        licensevalidDateController.text.toString();
                    beedThikedar.thekadarName = familyListMdl?.name ?? "";
                    industryController.text = "";
                    // familyList.removeWhere(
                    //     (item) => item.id == diyangselectedID);
                    // familyList.forEach((item) {
                    //   print(
                    //       'onclickckk${item.id}: ${item.name}');
                    // });
                    setState(() {
                      beediThekedarList.add(beedThikedar);
                      // familyList;
                      // familyListMdl = familyList[0];
                    });
                  } else {
                    ValidationIoSAlert().showAlert(context,
                        description: "Please enter industry name");
                  }
                }, */
                child: Text("Save")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ReusableTextFormField(
              maxLength: 17,
              controller: licenceNoController,
              keyboardType: TextInputType.phone,
              labelText: "License Number".tr()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: datePickerComponent(
            hintText: "License Issue Date",
            nameController: licenseIssueDateController,
            errorMessage: '',
            obsecuretext: false,
            editable: true,

            // node: _node,
            action: TextInputAction.next,
            onEditingComplete: () {
              //_node.nextFocus();
            },
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: datePickerComponent(
            hintText: "License Valid upto Date",
            nameController: licensevalidDateController,
            errorMessage: '',
            obsecuretext: false,
            editable: true,

            // node: _node,
            action: TextInputAction.next,
            onEditingComplete: () {
              //_node.nextFocus();
            },
            suffixIcon: Icon(
              Icons.calendar_month,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: beediThekedarList.length,
          itemBuilder: (context, index) {
            return TableFiveColumnReusable(
              serialNumber: (index + 1).toString(),
              entredField1: beediThekedarList[index].industryName,
              entredField2: beediThekedarList[index].industryName,
              entredField3: beediThekedarList[index].licenseNo,
              entredField4: beediThekedarList[index].licenseIssueDate,
              entredField5: beediThekedarList[index].licenseValid,
              removeicons: Icon(Icons.delete),
              cardcolor: Colors.white,
              height: MediaQuery.of(context).size.height * 0.074,
              ontap: () {
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Do you want to delete?",
                        style: TextStyle(fontSize: 16),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${beediThekedarList[index].industryName}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${beediThekedarList[index].licenseNo}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${beediThekedarList[index].licenseIssueDate}")
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppColors.appColor,
                                ),
                              ),
                              child: Text("Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                /*  setState(() {
                                  // familyList.add(FamilyListMdl(
                                  //     id: widowselectedID,
                                  //     name: widowList[
                                  //             index]
                                  //         .widowName));
                                  // widowList
                                  //     .removeAt(index);
                                  // familyList;
                                  // familyListMdl =
                                  //     familyList[0];
                                }); */
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              borderradius: BorderRadius.circular(0),
            );
          },
        ),
      ],
    );
  }
}
