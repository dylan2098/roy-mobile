import 'dart:async';

class ReceiverAddressBloc {
  StreamController _nameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _addressController = new StreamController();
  StreamController _zipCodeController = new StreamController();
  StreamController _emailController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get addressStream => _addressController.stream;
  Stream get zipCodeStream => _zipCodeController.stream;
  Stream get emailStream => _emailController.stream;

  bool inValidInfo(String name, String phone, String email, String address, String zipCode) {
    if (!(name.length > 0)) {
      _nameController.sink.addError("Name invalid!");
      return false;
    }
    _nameController.sink.add("OK");

    if (!(name.length > 0)) {
      _nameController.sink.addError("Phone invalid!");
      return false;
    }
    _nameController.sink.add("OK");

    if (!(email.length > 0)) {
      _emailController.sink.addError("Phone invalid!");
      return false;
    }
    _nameController.sink.add("OK");

    if (!(address.length > 0)) {
      _addressController.sink.addError("Address invalid!");
      return false;
    }
    _nameController.sink.add("OK");

    return true;
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _addressController.close();
    _zipCodeController.close();
    _emailController.close();
  }
}
