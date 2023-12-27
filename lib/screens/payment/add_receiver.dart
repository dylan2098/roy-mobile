import 'package:flutter/material.dart';
import 'package:roy_app/bloc/authorize/receiver_address.dart';
import 'package:roy_app/providers/payment.dart';
import 'package:roy_app/screens/payment/payment.dart';
import 'package:roy_app/screens/widgets/theme_helper.dart';
import 'package:roy_app/utilities/constant.dart';

class AddReceiverScreen extends StatefulWidget {
  const AddReceiverScreen({Key? key}) : super(key: key);

  @override
  _AddReceiverScreenState createState() => _AddReceiverScreenState();
}

class _AddReceiverScreenState extends State<AddReceiverScreen> {
  final _formKey = GlobalKey<FormState>();

  ReceiverAddressBloc receiverBloc = new ReceiverAddressBloc();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _zipCodeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.colorWhite,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: receiverBloc.nameStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Name*',
                                'Enter your name',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _nameController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: receiverBloc.emailStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Email*',
                                'Enter your email',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _emailController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: receiverBloc.phoneStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Phone*',
                                'Enter your phone',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _phoneController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: receiverBloc.addressStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Address*',
                                'Enter your address',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _addressController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: receiverBloc.zipCodeStream,
                            builder: (context, snapshot) => TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                'Zip Code',
                                'Enter your zip code',
                                snapshot.hasError ? snapshot.error.toString() : "",
                              ),
                              controller: _zipCodeController,
                            ),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Add Address".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Constant.colorWhite,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              String name = _nameController.text;
                              String phone = _phoneController.text;
                              String email = _emailController.text;
                              String address = _addressController.text;
                              String zipCode = _zipCodeController.text;

                              if (receiverBloc.inValidInfo(name, phone, email, address, zipCode)) {
                                Object dataAddressReciver = await PaymentProvider.addReciverAddress(name, phone, email, address, zipCode);
                                if ((dataAddressReciver as Map)['error'] == true) {
                                  ThemeHelper.alartDialog(context, "Error", dataAddressReciver['message']);
                                }

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(),
                                    ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
