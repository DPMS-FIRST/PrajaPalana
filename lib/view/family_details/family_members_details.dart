import 'package:praja_palana/models/configurable_fields/configurable_fields_response.dart';
import 'package:praja_palana/models/family_details/statelist_model.dart';
import 'package:praja_palana/res/CustomAlerts/alert_with_twobuttons.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:praja_palana/res/reusable_widgets/datepicker.dart';
import 'package:praja_palana/res/reusable_widgets/familymembercard.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_components.dart';
import 'package:praja_palana/res/reusable_widgets/reusable_textfield.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/dashboard_view_model.dart';
import 'package:praja_palana/view_model/schemesViewModel/family_details_view_model.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/master_data/master_data_response.dart';

class FamilyMembersDetails extends StatefulWidget {
  const FamilyMembersDetails({super.key});

  @override
  State<FamilyMembersDetails> createState() => _FamilyMembersDetailsState();
}

List<FamilyListMdl> members = [];

class _FamilyMembersDetailsState extends State<FamilyMembersDetails> {
  removeMember(FamilyListMdl member) {
    AlertwithTwoButtons().showAlert(
      context: context,
      title: 'Remove Member',
      message: 'Are you sure you want to remove this member?',
      onYesPressed: () {
        setState(() {
          members.remove(member);
        });
        Navigator.pop(context);
      },
      onNoPressed: () {
        Navigator.pop(context);
      },
    );
  }

  editMember(FamilyListMdl member, FamilydetailsEdit? editableFlagList) {
    try {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return MemberRegistrationForm(
            editableFlagList: editableFlagList,
            onMemberAdded: (editedMember) {
              int index = members.indexOf(member);
              setState(() {
                members[index] = editedMember;
              });
            },
            initialMember: member,
          );
        },
      );
    } catch (e, stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  addMember(FamilyListMdl member) {
    setState(() {
      members.add(member);
    });
  }

  FamilydetailsEdit? editableFlagList;
  @override
  void initState() {
    super.initState();
    members.clear();
    editableFlagList = FamilydetailsEdit();
    final familyProvider =
        Provider.of<FamilyDetailsViewModel>(context, listen: false);
    familyProvider.getConfigurableFamilyData().then((value) {
      setState(() {
        editableFlagList = value;
      });
    });
    familyProvider.getFamilyData().then((value) {
      setState(() {
        members.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final familyProvider = Provider.of<FamilyDetailsViewModel>(context);
    // final editableFamilyFlag =
    //     ModalRoute.of(context)?.settings.arguments as bool;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          // BackAlert().showAlert(context: context);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBarComponent(
          title: 'FAMILY MEMBERS DETAILS'.tr(),
          onPressedHome: () {
            Navigator.pushNamed(context, AppRoutes.applicantDashboard);
          },
          onPressedBack: () {
            // BackAlert().showAlert(context: context);
            Navigator.pop(context);
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage(AppAssets.appBg),
            ),
          ),
          child: Stack(
            children: <Widget>[
              /*  if (members.isEmpty)
                Center(
                  child: Text('Click + icon to add family members'),
                ), */
              Column(
                children: <Widget>[
                  ReusableComponents().ApplicationRationAndApplicantName(),
                  //ReusableComponents().officerNameAndApplicationNumber(),
                  if (members.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          return MemberCard(
                            member: members[index],
                            /* onRemovePressed: () {
                              removeMember(members[index]);
                            }, */
                            /*  onEditPressed: () {
                              editMember(members[index], editableFlagList);
                            }, */
                          );
                        },
                      ),
                    ),
                  /* editableFamilyFlag
                      ? ReusableButton(
                          onPressed: () {
                            familyProvider.SaveOnClick(
                                context: context, familyEditedList: members);
                          },
                          ButtonText: 'SAVE',
                        )
                      : SizedBox(), */
                ],
              ),
              /*  Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MemberRegistrationForm(
                            onMemberAdded: _addMember,
                            editableFlagList: editableFlagList,
                          );
                        },
                      );
                    },
                    child: Icon(Icons.add, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                ),
              ), */
              /*  ReusableButton(
                onPressed: () {
                  familyProvider.SaveOnClick(
                      context: context, familyEditedList: members);
                },
                ButtonText: 'SAVE',
              ), */
            ],
          ),
        ),
      ),
    );
  }
}

class MemberRegistrationForm extends StatefulWidget {
  final Function(FamilyListMdl) onMemberAdded;
  final FamilyListMdl? initialMember;
  final FamilydetailsEdit? editableFlagList;

  MemberRegistrationForm(
      {required this.onMemberAdded, this.initialMember, this.editableFlagList});

  @override
  _MemberRegistrationFormState createState() => _MemberRegistrationFormState();
}

class _MemberRegistrationFormState extends State<MemberRegistrationForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _aadhaarno = TextEditingController();
  TextEditingController _dob = TextEditingController();
  List<Gender> genderList = [];
  List<Relationships> realationship = [];
  Gender? selectedGender;
  Relationships? selectedRelationShip;
  StatestList? selectedRelation;

  @override
  void initState() {
    super.initState();
    final applicationDetails =
        Provider.of<DashboardViewModel>(context, listen: false);
    genderList.insert(
        0, Gender(gendername: AppStrings.select_gender_name, genderid: "0"));
    applicationDetails.getDbGenderList?.forEach((element) {
      genderList.add(element!);
    });
    realationship.insert(
        0, Relationships(relationname: AppStrings.select_rel_name, id: "0"));
    applicationDetails.getDbRelationsList?.forEach((element) {
      realationship.add(element!);
    });
    setState(() {});
    // selectedGender = genderList[0];
    // selectedRelation = relationList[0];
    if (widget.initialMember != null) {
      _name.text = widget.initialMember!.name ?? "";
      _aadhaarno.text = widget.initialMember!.aadhaRNO ?? "";
      _dob.text = widget.initialMember!.datEOFBIRTH ?? "";
      selectedGender = genderList.firstWhere(
          (element) => element.genderid == widget.initialMember?.gender);
      selectedRelationShip = realationship.firstWhere(
          (element) => element.id == widget.initialMember?.relation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final editableFamFLag = ModalRoute.of(context)?.settings.arguments as bool;
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColors.primaryColorDark,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.cancel_presentation_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Member Registration',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            ReusableTextFormField(
              controller: _name,
              readOnly: widget.editableFlagList?.name?.toLowerCase() == "y"
                  ? false
                  : true,
              labelText: "NAME".tr(),
            ),
            ReusableTextFormField(
              controller: _aadhaarno,
              readOnly:
                  (widget.editableFlagList?.aadhaRNO?.toLowerCase() == "y" ||
                          editableFamFLag == true)
                      ? false
                      : true,
              labelText: "AADHAAR NO".tr(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Gender>(
                value: selectedGender,
                items: genderList.map((Gender? option) {
                  return DropdownMenuItem<Gender>(
                    value: option,
                    child: Text(option?.gendername ?? ''),
                  );
                }).toList(),
                onChanged: widget.editableFlagList?.gender?.toLowerCase() == "y"
                    ? (Gender? newValue) {
                        setState(() {
                          selectedGender = newValue;
                          // grievanceSubIssueTypeData = newValue;
                        });
                      }
                    : null,
                hint: Text(AppStrings.select_gender_name),
                decoration: InputDecoration(
                  labelText: selectedGender?.gendername.toString(),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Relationships>(
                value: selectedRelationShip,
                items: realationship.map((Relationships? option) {
                  return DropdownMenuItem<Relationships>(
                    value: option,
                    child: Text(option?.relationname ?? ''),
                  );
                }).toList(),
                onChanged:
                    widget.editableFlagList?.relation?.toLowerCase() == "y"
                        ? (Relationships? newValue) {
                            setState(() {
                              selectedRelationShip = newValue;
                              // grievanceSubIssueTypeData = newValue;
                            });
                          }
                        : null,
                hint: Text(AppStrings.select_rel_name),
                decoration: InputDecoration(
                  labelText: selectedGender?.gendername.toString(),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            datePickerComponent(
              editable:
                  widget.editableFlagList?.datEOFBIRTH?.toLowerCase() == "y"
                      ? true
                      : false,
              hintText: "DATE OF BIRTH".tr(),
              nameController: _dob,
              errorMessage: '',
              obsecuretext: false,
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
            SizedBox(height: 20),
            ReusableButton(
              onPressed: () {
                String name = _name.text;
                String aadhaar = _aadhaarno.text;
                String dob = _dob.text;
                FamilyListMdl member = FamilyListMdl(
                  name: name,
                  aadhaRNO: aadhaar,
                  datEOFBIRTH: dob,
                  relatioNNAME: selectedRelationShip?.id,
                  relation: selectedRelationShip?.relationname,
                  gender: selectedGender?.gendername,
                );
                widget.onMemberAdded(member);
                Navigator.pop(context);
              },
              ButtonText: 'SUBMIT',
            ),
          ],
        ),
      ),
    );
  }

  bool Validate(
    String name,
    String age,
    String gender,
    String relation,
  ) {
    return true;
  }
}
