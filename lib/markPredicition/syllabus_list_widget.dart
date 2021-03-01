import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';

class StockList extends StatefulWidget {
  String name;
  int mark;
  StockList({this.mark,this.name});

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  final _firestore = Firestore.instance;
bool tickvisibility = true;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(
                widget.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(child: new IconButton(icon: new Icon(Icons.offline_pin_rounded),onPressed: (){
                  setState(() {
                    totalMark= totalMark + widget.mark;
                    tickvisibility =false;
                    controllerVisibility = false;
                  });
                }),
                visible: tickvisibility,),
                widget.mark!=0? Visibility(child: new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>widget.mark--),),visible: controllerVisibility,):new Container(),
                new Text(widget.mark.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                Visibility(child: new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>widget.mark++)),visible: controllerVisibility,),
              ],
            ),

            // Text(
            //     '${widget.mark}',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 18)
            // ),
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
