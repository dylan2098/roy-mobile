import 'package:flutter/material.dart';
import 'package:roy_app/utilities/constant.dart';

class ModalBottom {
  static modalBottomSheet({
    context,
    onFilter,
  }) {
    List<String> size = Constant.listSizeProduct;

    dynamic sortDisplayType = -1;
    dynamic checkedPriceRange = false;
    dynamic isShowBrand = false;
    dynamic isShowSupplier = false;
    dynamic selectedRange = RangeValues(0, 5000.00);
    dynamic selectedSize = -1;

    TextEditingController _brandController = new TextEditingController();
    TextEditingController _supplierController = new TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Constant.colorWhite,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(color: Constant.colorBlack, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            minWidth: 40,
                            height: 40,
                            color: Constant.colorGreyShade300,
                            elevation: 0,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.close,
                              color: Constant.colorBlack,
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 20),

                      Column(children: [
                        ListTile(
                          title: const Text('Low Price'),
                          leading: Radio(
                            value: 0,
                            groupValue: sortDisplayType,
                            onChanged: (value) {
                              setState(() {
                                sortDisplayType = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('High Price'),
                          leading: Radio(
                            value: 1,
                            groupValue: sortDisplayType,
                            onChanged: (value) {
                              setState(() {
                                sortDisplayType = value;
                              });
                            },
                          ),
                        )
                      ]),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Size',
                        style: TextStyle(color: Constant.colorBlack, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: size.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: selectedSize == index ? Constant.colorYellow800 : Constant.colorGreyShade200, shape: BoxShape.circle),
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    size[index],
                                    style: TextStyle(color: selectedSize == index ? Constant.colorWhite : Constant.colorBlack, fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Slider Price Renge filter
                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text("Show Range Price"),
                        value: checkedPriceRange,
                        onChanged: (newValue) {
                          setState(() {
                            checkedPriceRange = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      (checkedPriceRange == true)
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price Range',
                                      style: TextStyle(color: Constant.colorBlack, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$ ${selectedRange.start.toStringAsFixed(2)}',
                                          style: TextStyle(color: Constant.colorGreyShade50, fontSize: 12),
                                        ),
                                        Text(" - ", style: TextStyle(color: Constant.colorGreyShade50)),
                                        Text(
                                          '\$ ${selectedRange.end.toStringAsFixed(2)}',
                                          style: TextStyle(color: Constant.colorGreyShade50, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RangeSlider(
                                    values: selectedRange,
                                    min: 0.00,
                                    max: 5000.00,
                                    divisions: 100,
                                    inactiveColor: Constant.colorGreyShade300,
                                    activeColor: Constant.colorYellow800,
                                    labels: RangeLabels(
                                      '\$ ${selectedRange.start.toStringAsFixed(2)}',
                                      '\$ ${selectedRange.end.toStringAsFixed(2)}',
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() => selectedRange = values);
                                    }),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            )
                          : Container(),

                      CheckboxListTile(
                        title: Text("Show Input Brand"),
                        value: isShowBrand,
                        onChanged: (newValue) {
                          setState(() {
                            isShowBrand = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (isShowBrand == true)
                          ? Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Constant.primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Constant.primaryColor),
                                    ),
                                    hintText: "Please enter brand ...",
                                  ),
                                  controller: _brandController,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : Container(),

                      CheckboxListTile(
                        title: Text("Show Input Supplier"),
                        value: isShowSupplier,
                        onChanged: (newValue) {
                          setState(() {
                            isShowSupplier = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (isShowSupplier == true)
                          ? Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Constant.primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Constant.primaryColor),
                                    ),
                                    hintText: "Please enter suplier ...",
                                  ),
                                  controller: _supplierController,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : Container(),

                      SizedBox(
                        height: 30,
                      ),

                      button('Filter', () {
                        onFilter(
                          sortDisplayType,
                          (selectedSize != -1) ? size[selectedSize] : "",
                          selectedRange.start,
                          selectedRange.end,
                          _brandController.text,
                          _supplierController.text,
                        );
                        Navigator.pop(context);
                      })
                    ],
                  ),
                ],
              ));
        });
      },
    );
  }

  static button(String text, Function onPressed) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: 50,
      elevation: 0,
      splashColor: Constant.colorYellow700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Constant.colorYellow800,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Constant.colorWhite, fontSize: 18),
        ),
      ),
    );
  }

  static addToCartModal({context, colors, selectedColor, size, selectedSize, asThis}) {
    return showModalBottomSheet(
      context: context,
      transitionAnimationController: AnimationController(duration: Duration(milliseconds: 400), vsync: asThis),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Constant.colorWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Color",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: 10),
                          decoration:
                              BoxDecoration(color: selectedColor == index ? colors[index] : colors[index].withOpacity(0.5), shape: BoxShape.circle),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: selectedColor == index
                                ? Icon(
                                    Icons.check,
                                    color: Constant.colorWhite,
                                  )
                                : Container(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Size",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 100.0, right: 20.0),
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: size.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: selectedSize == index ? Constant.colorYellow800 : Constant.colorGreyShade200, shape: BoxShape.circle),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              size[index],
                              style: TextStyle(color: selectedSize == index ? Constant.colorWhite : Constant.colorBlack, fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ModalBottom.button('Add to Cart', () {
                  Navigator.pop(context);

                  // Let's show a snackbar when an item is added to the cart
                  final snackbar = SnackBar(
                    content: Text("Item added to cart"),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
