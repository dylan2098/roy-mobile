import 'package:flutter/material.dart';
import 'package:roy_app/providers/payment.dart';
import 'package:roy_app/screens/payment/add_receiver.dart';
import 'package:roy_app/screens/payment/payment.dart';
import 'package:roy_app/utilities/constant.dart';

class ReceiverScreen extends StatefulWidget {
  @override
  createState() {
    return new ReceiverScreenState();
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}

class ReceiverScreenState extends State<ReceiverScreen> {
  List<dynamic> items = [];
  late bool _loading;
  late dynamic currentItem;

  @override
  void initState() {
    _loading = true;
    currentItem = {};
    getListAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Constant.colorTransparent,
          elevation: 0,
          title: Text(
            'Recipient Information',
            style: TextStyle(color: Constant.colorBlack),
          ),
          leading: BackButton(
            color: Constant.colorBlack,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Constant.colorBlack,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReceiverScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: Constant.defaultPaddin / 2)
          ]),
      body: _loading
          ? Container(
              padding: EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : new ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.grey.shade400,
                  onTap: () {
                    if (currentItem["id"] != items[index]["id"]) {
                      for (var i = 0; i < items.length; i++) {
                        if (items[i]["selected"] == 1) {
                          updateSelected(items[i]["id"], false);
                        }

                        setState(() {
                          items[i]["selected"] = 0;
                        });
                      }

                      if (items[index]["id"] != null) {
                        setState(() {
                          items[index]["selected"] = 1;
                          currentItem = items[index];
                        });
                        updateSelected(items[index]["id"], true);
                      }
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage(addressReceiver: currentItem)),
                    );
                  },
                  child: ItemAddress(items[index]),
                );
              },
            ),
    );
  }

  // get list address
  Future<void> getListAddress() async {
    Map<String, dynamic> response = await PaymentProvider.getListAddress();
    if (this.mounted) {
      setState(() {
        items.addAll(response['data']);
        _loading = false;
      });
    }
  }

  Future<void> updateSelected(int id, bool selected) async {
    setState(() {
      _loading = true;
    });
    await PaymentProvider.updateSelectedAddress(id, selected);
    if (this.mounted) {
      setState(() {
        _loading = false;
      });
    }
  }
}

class ItemAddress extends StatefulWidget {
  final item;

  ItemAddress(this.item);

  @override
  _ItemAddressState createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(width: 1.0, color: (widget.item["selected"] == 1) ? Colors.green.shade600 : Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: new Center(
              child: Icon(
                Icons.check,
                color: (widget.item["selected"] == 1) ? Colors.green : Colors.transparent,
                size: 30.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: new EdgeInsets.only(left: 10.0, top: 10.0),
                child: new Text(widget.item["name"]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 10.0, top: 10.0),
                child: new Text(widget.item["phone"]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 10.0, top: 10.0),
                child: new Text(widget.item["address"]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 10.0, top: 10.0),
                child: new Text(widget.item["zipCode"]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
