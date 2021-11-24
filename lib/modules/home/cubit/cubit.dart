import 'dart:convert';
import 'dart:io';
import 'package:flash_test/helper/formatDate.dart';
import 'package:flash_test/models/rocket_model.dart';
import 'package:flash_test/modules/home/cubit/states.dart';
import 'package:flash_test/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(Initial());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;

  String selectedCategory = "Next";

  DateTime? fromDateTime,toDateTime;

  DateTime? initialFirstDate,initialPastDate;

  String fromDate = "";
  String toDate = "";

  getDates(List<DateTime> picked){

    fromDateTime = picked[0];
    toDateTime = picked[1];

    fromDate = formatDatePicker(picked[0]);
    toDate = formatDatePicker(picked[1]);

    print("from $fromDate to $toDate");

    emit(DatePicked());

  }

  formatDatePicker(var dateTime, {bool showTime = false}){
    String formattedDate = !showTime?
    DateFormat('MMMM dd, yyyy').format(dateTime)
        :DateFormat('MMMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  clearDate(){
    fromDate = "";
    toDate = "";
    emit(ClearDate());
  }

  selectCategory(String category){
    selectedCategory = category;
    emit(SelectCategory());
  }


  fetchRockets() async {
    try {
      final subUrl = selectedCategory;

      var fullUrl = baseUrl + subUrl.toLowerCase();
      print(fullUrl);

      var response = await http.get(Uri.parse(fullUrl));

      print(response.statusCode);
      print(response.body);

      if(selectedCategory!="Next"){
      List parsed = json.decode(response.body);
      print(parsed);

      if (response.statusCode == 200) {
        return parsed.map((e) => RocketModel.fromJson(e)).toList();
      }
      }else{
        final parsed = json.decode(response.body);
        print(parsed);

        if (response.statusCode == 200) {
          List <RocketModel> nextRockets = [];
          nextRockets.add(RocketModel.fromJson(parsed));
          return nextRockets;
        }
      }
    } catch (e) {
      print(e);
    }
  }


  getRocketsInRange(List <RocketModel> pastRockets){

    print("get Rocket in range");
    List<RocketModel> pickedPastRockets = [];

    for(var pastRocket in pastRockets){
      
      DateTime pastRocketDate = DateTime.fromMillisecondsSinceEpoch
        (int.parse(pastRocket.dateTime.toString())*1000);

      print("PastRocketDate ${pastRocketDate.toString()}");

      print(fromDateTime);
      print(toDateTime);

      if((pastRocketDate.isBefore(toDateTime!)
          && pastRocketDate.isAfter(fromDateTime!))
          || (pastRocketDate == toDateTime)
          || (pastRocketDate == fromDateTime)){
        pickedPastRockets.add(pastRocket);
      }

    }

    return pickedPastRockets;

  }


  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }



}
