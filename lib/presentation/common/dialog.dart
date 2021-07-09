import 'dart:io';

import 'package:covid19_app/presentation/common/enum.dart';
import 'package:covid19_app/presentation/login/ui/login_screen.dart';
import 'package:flutter/material.dart';

///neu nguoi dung chon "Đồng ý" thi an dialog va goi ham [exit] thoat app
///neu nguoi dung chon "Hủy" thi an dialog
showDialogFunction(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), //this right here
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Thoát ứng dụng ?",
                      style: TextStyle(
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
                            fixedSize: const Size(100, 25)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          exit(0);
                        },
                        child: const Text(
                          "Đồng ý",
                          style: TextStyle(color: Colors.white),
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
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

///neu nguoi dung chon "Đăng nhập" thi an dialog va chuyen den man hinh [LoginScreen]
///neu nguoi dung chon "Hủy" thi an dialog
showDialogLogin(BuildContext context) {
  showDialog(
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
                  const Center(
                    child: Text(
                      "Bạn chưa đăng nhập",
                      style: TextStyle(
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
                            fixedSize: const Size(125, 25)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white),
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
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
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
}

showDialogDelete(BuildContext context) async {
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
                  const Center(
                    child: Text(
                      "Xóa quốc gia này ?",
                      style: TextStyle(
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
                            fixedSize: const Size(100, 25)),
                        onPressed: () {
                          value = Selects.accept;
                          Navigator.pop(context, value);
                        },
                        child: const Text(
                          "Đồng ý",
                          style: TextStyle(color: Colors.white),
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
                        child: const Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
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
