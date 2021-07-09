import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

///nhan vao mot String conten,String label, va [BuildContext] scaffold show snackbar voi conten va label
void showSnackbar(String conten, String label, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(conten),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(label: label, onPressed: () {}),
    ),
  );
}

///nhan vao String text, [BuildContext]context,[Color]color,[IconData]icon va [FToast] f
void showToast(
    String text, BuildContext context, Color color, IconData icon, FToast f) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Wrap(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: SizedBox(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}
