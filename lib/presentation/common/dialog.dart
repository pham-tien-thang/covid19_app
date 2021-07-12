
import 'package:covid19_app/presentation/common/enum.dart';
import 'package:flutter/material.dart';


showDialogApp(BuildContext context,String cancel, String accept,String title) async {
  Selects value;
  var a = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              width: 2.0,
                              color: Colors.white54,
                            ),
                            onPrimary: Colors.grey,
                            primary: Colors.green,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            fixedSize: const Size(120, 25)),
                        onPressed: () {
                          value = Selects.accept;
                          Navigator.pop(context, value);
                        },
                        child:  Text(
                          accept,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              width: 2.0,
                              color: Colors.white54,
                            ),
                            onPrimary: Colors.grey,
                            primary: Colors.grey,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            fixedSize: const Size(100, 25)),
                        onPressed: () {
                          value = Selects.cancel;
                          Navigator.pop(context, value);
                        },
                        child:  Text(
                          cancel,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ); //this r
      });
  return a;
}
