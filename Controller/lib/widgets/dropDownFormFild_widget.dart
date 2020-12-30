import 'package:flutter/material.dart';
class DropDownFormFild extends StatefulWidget {

  final void Function() setRGB;
  final void Function() setNormal;
  final void Function() setSlider;
  int selected;
  DropDownFormFild({this.setNormal, this.setRGB, this.setSlider, this.selected = 0});
  @override
  _DropDownFormFildState createState() => _DropDownFormFildState(setNormal, setRGB, setSlider, selected);
}

class _DropDownFormFildState extends State<DropDownFormFild> {
  String _formvalue;

  void Function() setRGB;
  void Function() setNormal;
  void Function() setSlider;

  _DropDownFormFildState(this.setNormal, this.setRGB, this.setSlider, int selected):
      _formvalue = selected == 0 ? null : selected == 1 ? "RGB" : selected == 2 ? "Normal" : "Slider"
  ;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.grey[700],
      validator: (value) => value == null ? 'Selecione o tipo!' : null,
      items: [
        DropdownMenuItem(
          value: "Normal",
          child: Text("Normal"),
        ),
        DropdownMenuItem(
            value: "Slider",
            child: Text("Slider"),
        ),
        DropdownMenuItem(
            value: "RGB",
            child: Text("RGB"),
        ),
      ],
      onChanged: (newValue) {
        setState(() =>  _formvalue = newValue );
        _formvalue == "RGB" ? setRGB() :_formvalue == "Normal" ? setNormal(): setSlider();
      },
      value: _formvalue,
      style: TextStyle(color: Colors.grey[200]),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100], width: 2),
        ),
        labelText: "Tipo da pagina",
        hintStyle: TextStyle(
          color:  Colors.grey[600],
        ),
        labelStyle: TextStyle(
          color:  Colors.grey[200],
        ),
      ),
    );
  }
}
