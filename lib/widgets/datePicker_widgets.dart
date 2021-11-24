import 'package:flash_test/utilities/colors.dart';
import 'package:flash_test/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

datePicker(width, height, cubit, context) {
  return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        accentColor: gradientStartColor,
        accentTextTheme: TextTheme(
          button: TextStyle(
            color: gradientStartColor,
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(),
        ),
        colorScheme: ColorScheme.light(
          primary: gradientStartColor,
        ),
      ),
      child: Builder(
          builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  child: Container(
                    width: width / 1.04,
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(25.0),
                      color: titleTextColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: gradientStartColor,
                          ),
                          cubit.fromDate != "" && cubit.toDate != ""
                              ? Row(
                                  children: [
                                    Text(
                                      "  From  ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cubit.fromDate,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "  To  ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cubit.toDate,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  "  Select Date Range",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    final List<DateTime> picked =
                        await DateRangePicker.showDatePicker(
                            context: context,
                            initialFirstDate: new DateTime.now()
                                .subtract(new Duration(days: 7)),
                            initialLastDate: new DateTime.now(),
                            firstDate: new DateTime(2015),
                            lastDate: new DateTime.now());

                    if (picked != null && picked.length == 2) {
                      print("pickecd ------->>>> ${picked}");
                      cubit.getDates(picked);
                    } else {
                      showToast(msg: "You didn't pick a date range");
                    }
                  },
                  //   ),
                  // ),
                ),
              )));
}


clearDate(cubit) {
  return Visibility(
    visible: cubit.fromDate != "" && cubit.toDate != "",
    child: Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
        child: GestureDetector(
          onTap: () {
            cubit.clearDate();
          },
          child: Container(
            child: Text(
              "Clear",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
