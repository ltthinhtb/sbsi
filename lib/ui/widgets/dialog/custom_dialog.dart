import 'package:flutter/material.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';

class CustomDialog {
  static Future<bool?> showConfirmDialog(
      BuildContext context, String label, List<String> contents,
      {List<Color>? buttonColors, List<Color>? textButtonColors}) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: AppTextStyle.H3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contents.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Text(
                              contents[i],
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[0]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[0]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[1]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                // side: BorderSide(width: 0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(
                                  S.of(context).confirm,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[1]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                      // children: buttonlabels.map((e) {
                      //   int i = buttonlabels.indexOf(e);
                      //   return Expanded(
                      //     flex: 1,
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 5),
                      //       child: Material(
                      //         color: buttonColors != null
                      //             ? buttonColors[i]
                      //             : Colors.transparent,
                      //         shape: const RoundedRectangleBorder(
                      //           side: BorderSide(),
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(5),
                      //           ),
                      //         ),
                      //         child: MaterialButton(
                      //           padding: const EdgeInsets.all(0),
                      //           materialTapTargetSize:
                      //               MaterialTapTargetSize.shrinkWrap,
                      //           onPressed: () => Navigator.of(context).pop(i),
                      //           child: Text(
                      //             buttonlabels[i],
                      //             style: TextStyle(
                      //                 color: textButtonColors != null
                      //                     ? textButtonColors[i]
                      //                     : null),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
