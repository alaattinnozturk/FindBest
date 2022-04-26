import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class PersonalInfoForms extends StatefulWidget {
  Function callback;

  PersonalInfoForms({required this.callback});

  @override
  State<PersonalInfoForms> createState() => _PersonalInfoFormsState();
}

class _PersonalInfoFormsState extends State<PersonalInfoForms> {
  GlobalKey<FormState> textFormKey = GlobalKey<FormState>();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController birthdayCtr = TextEditingController();
  TextEditingController phoneNoCtr = TextEditingController();

  String cityDropDownValue = 'Select City';
  String genderDropDownValue = 'Select Gender';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: textFormKey,
      child: ListView(
        children: [
          textFormField(
            nameCtr,
            'Name',
          ),
          textFormField(
            surnameCtr,
            'Surname',
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: kTurquoise,
              ),
            ),
            child: Center(
              child: DropdownButton<String>(
                isExpanded: true,
                value: cityDropDownValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
                elevation: 16,
                underline: Container(),
                borderRadius: BorderRadius.circular(16),
                onChanged: (String? newValue) {
                  setState(() {
                    cityDropDownValue = newValue!;
                    print(newValue);
                  });
                },
                items: ['Select City', 'Kayseri', 'İstanbul', 'Ankara']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Select City'
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: kTurquoise,
              ),
            ),
            child: Center(
              child: DropdownButton<String>(
                isExpanded: true,
                value: genderDropDownValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
                elevation: 16,
                underline: Container(),
                borderRadius: BorderRadius.circular(16),
                onChanged: (String? newValue) {
                  setState(() {
                    genderDropDownValue = newValue!;
                    print(newValue);
                  });
                },
                items: ['Select Gender', 'Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Select Gender'
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          textFormField(
            birthdayCtr,
            'Birthday (01.04.1999)',
          ),
          textFormField(
            phoneNoCtr,
            'Phone No. (555 555 55 55)',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (Provider.of<BasicUserInfo>(context, listen: false)
                          .basicUser
                          .type ==
                      'Employer') {
                    widget.callback(2);
                  }
                },
                child: Container(
                  width: 120,
                  height: 50,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kTurquoise,
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding textFormField(
    TextEditingController ctr,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextFormField(
        keyboardType: hintText == 'Birthday (01.04.1999)' ||
                hintText == 'Phone No. (555 555 55 55)'
            ? TextInputType.number
            : TextInputType.text,
        controller: ctr,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              color: kTurquoise,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise, width: 2),
          ),
        ),
      ),
    );
  }
}
