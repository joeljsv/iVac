import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/vaccine/districts.dart';
import 'package:vacinefinder/models/vaccine/states.dart';
import 'package:vacinefinder/provider/locationPro.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';
import 'package:vacinefinder/widgets/vaccine/dropDownCity.dart';

import 'DisandPinList.dart';

class AddCenter extends StatefulWidget {
  @override
  _AddCenterState createState() => _AddCenterState();
}

class _AddCenterState extends State<AddCenter> {
  String sId = "1";
  String dId;
  String meth = "District";
  bool isDis = false;
  bool isStates = false;
  bool isPin = false;
  bool isLoading = false;
  bool isSerach = false;
  String pinCode = "110001";
  String titleScren = '';
  List<States> staeList = [];
  List<Districts> districtList = [];
  final svg = SvgPicture.asset("assets/icons/dropdown.svg");

  @override
  Widget build(BuildContext context) {
    final locprovider = Provider.of<LocationProv>(context, listen: false);
    Future getStaList() async {
      staeList = await locprovider.fetchStates();

      sId = staeList[0].stateId.toString();
      print("dtate");
    }

    Future getDisList(id) async {
      setState(() {
        isLoading = true;
      });
      districtList = await locprovider.fetchDistricts(id: id);
      setState(() {
        isDis = true;
        dId = districtList[0].stateId.toString();
        titleScren=districtList[0].stateName;
        sId = id;
        isStates = true;
        isLoading = false;
      });
      print(districtList.length);
      print("Distrc");
    }

    Future gettim() async {
      print("pass");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Center",
          style: TextStyle(
            color: appPrimaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            searchMethod(),
            !isPin
                ? const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: appPrimaryColor,
                      thickness: 2,
                    ),
                  )
                : SizedBox(
                    height: 5,
                  ),
            isPin
                ? DropDownCity(
                    city: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    
                    onChanged: (val) {
                      if (val.length > 0 && val.length < 7) {
                        pinCode = val;
                        print("h");
                        setState(() {
                          isSerach = true;
                        });
                      } else {
                        pinCode = "110001";
                        isSerach = false;
                      }
                    },
                    decoration: InputDecoration(
                      counterText: ''
,
                        border: InputBorder.none,
                        hintText: "Pincode",
                        hintStyle: TextStyle(color: appPrimaryColor)),
                  ))
                : districtCentersListView(getStaList, gettim, getDisList),
            if (isDis ||(isPin&&isSerach)) findButton(),
          ],
        ),
      ),
    );
  }

  DropDownCity searchMethod() {
    return DropDownCity(
      city: DropdownButton(
        underline: SizedBox(),
        icon: svg,
        value: meth,
        items: ["Pincode", "District"].map<DropdownMenuItem>((type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text("By $type"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            meth = value;
            if (value == "Pincode") {
              isPin = true;
            } else {
              isPin = false;
            }
          });
        },
      ),
    );
  }

  Widget districtCentersListView(
      Future getStaList(), Future gettim(), Future getDisList(dynamic id)) {
    return isLoading
        ? CenterLoading()
        : FutureBuilder(
            future: !isStates ? getStaList() : gettim(),
            builder: (BuildContext build, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CenterLoading());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropDownCity(
                    city: DropdownButton(
                      isExpanded: true,
                      hint: Text("Choose State"),
                      underline: SizedBox(),
                      icon: svg,
                      value: sId,
                      items: staeList.map<DropdownMenuItem>((place) {
                        return DropdownMenuItem<String>(
                          value: place.stateId.toString(),
                          child: Text(place.stateName),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        print(value);
                        getDisList(value.toString());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isDis)
                    DropDownCity(
                      city: DropdownButton(
                        isExpanded: true,
                        hint: Text("Choose District"),
                        underline: SizedBox(),
                        icon: svg,
                        value: dId,
                        items: districtList.map<DropdownMenuItem>((place) {
                         
                          return DropdownMenuItem<String>(
                            value: place.stateId.toString(),
                            child: Text(place.stateName),
                          );
                        }).toList(),
                        onChanged: (value) async {
                         
                            Districts name=districtList.firstWhere((dd) => dd.stateId.toString()=="$value");

                          setState(() {
                            titleScren=name.stateName;
                            dId = value.toString();
                          }); print(titleScren);
                        },
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
  }

  Padding findButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => isPin
                    ? DisandPinList(
                        pinCode,
                        pin: pinCode,
                      )
                    : DisandPinList(
                        titleScren,
                        dis: dId,
                      ),
              ),
            );
          },
          icon: Icon(Icons.search),
          label: Text("Find Now")),
    );
  }

  // FutureBuilder<void> futureDropDown(LocationProv sates, type) {
  //   return FutureBuilder(
  //       future:
  //           (type == "State") ? sates.fetchStates() : sates.fetchDistricts(),
  //       builder: (build, snap) {
  //         print("DD");
  //         if (snap.connectionState == ConnectionState.waiting) {
  //           return CenterLoading();
  //         }

  //         return DropDownCity(
  //           city: (type == "State") ? sates.stateLis : sates.districList,
  //           type: type,
  //           isState: (type == "State"),
  //         );
  //       });
  // }
}
