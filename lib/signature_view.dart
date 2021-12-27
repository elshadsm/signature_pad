import 'package:flutter/material.dart';

import 'signature_painter.dart';

class SignatureView extends StatefulWidget {
  SignatureView({Key? key}) : super(key: key);

  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  List<Offset?> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(
          excludeFromSemantics: true,
          onPanStart: handleOnPanStart,
          onPanUpdate: handleOnPanUpdate,
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(
          painter: SignaturePainter(_points),
        )
      ],
    );
  }

  void handleOnPanStart(DragStartDetails details) {
    RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    updatePoints(localPosition);
  }

  void handleOnPanUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    updatePoints(localPosition);
  }

  void updatePoints(Offset localPosition) {
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }
}
