import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({Key? key}) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      builder: (state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                    value: checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        checkboxValue = value!;
                        state.didChange(value);
                      });
                    }),
                Text(
                  "I accept all terms and conditions.",
                  style: TextStyle(color: Constant.colorGrey),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                state.errorText ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: 12,
                ),
              ),
            )
          ],
        );
      },
      validator: (value) {
        if (!checkboxValue) {
          return 'You need to accept terms and conditions';
        } else {
          return null;
        }
      },
    );
  }
}
