import 'package:attendence_management_sys/resources/color.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool _isOpen = false;
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 9,
            width: MediaQuery.of(context).size.width / 0.8,
            decoration: BoxDecoration(
              color: AppColors.dropdowncolor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    _selectedItem,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
        _isOpen
            ? Container(
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.dropdowncolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: widget.items
                      .map((item) => ListTile(
                            title: Text(
                              item,
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedItem = item;
                                _isOpen = false;
                                widget.onChanged(item);
                              });
                            },
                          ))
                      .toList(),
                ),
              )
            : Container(),
      ],
    );
  }
}
