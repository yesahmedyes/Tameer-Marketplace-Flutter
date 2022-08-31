import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> options;
  final Function? optionalFunction;
  final String? initial;

  const CustomDropDown({Key? key, required this.options, this.optionalFunction, this.initial}) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initial ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: dropdownValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(10),
          items: widget.options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (String? newValue) {
            if (newValue != dropdownValue) {
              setState(() {
                if (newValue != null) dropdownValue = newValue;
                if (widget.optionalFunction != null) {
                  widget.optionalFunction!(newValue, context);
                }
              });
            }
          },
        ),
      ),
    );
  }
}
