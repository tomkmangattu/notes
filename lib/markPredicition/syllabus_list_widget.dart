import 'package:flutter/material.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';
import 'package:provider/provider.dart';

class StockList extends StatefulWidget {
  final String name;
  final String mark;
  final int moduleNo;
  StockList(
      {@required this.mark, @required this.name, @required this.moduleNo});

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  bool selected = false;
  void _incrementMark(BuildContext context, int module, int mark) {
    Provider.of<Counter>(context, listen: false)
        .increamentCounter(module, mark);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 6),
          value: selected,
          onChanged: (value) {
            setState(() {
              selected = value;
            });
            if (value) {
              _incrementMark(context, widget.moduleNo, int.parse(widget.mark));
            } else {
              _incrementMark(context, widget.moduleNo, -int.parse(widget.mark));
            }
          },
          title: Text(
            widget.name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          secondary: Text(
            '${widget.mark}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
