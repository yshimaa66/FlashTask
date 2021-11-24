import 'package:flash_test/models/rocket_model.dart';
import 'package:flash_test/modules/details/detail_page.dart';
import 'package:flash_test/modules/home/cubit/cubit.dart';
import 'package:flash_test/modules/home/cubit/states.dart';
import 'package:flash_test/utilities/constants.dart';
import 'package:flash_test/widgets/datePicker_widgets.dart';
import 'package:flash_test/widgets/rocket_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/colors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../helper/formatDate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> categoriesList = ["Next","Upcoming","Past"];

  late HomeCubit homeCubit;

  late List<RocketModel> rocketsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(),
    child: BlocConsumer<HomeCubit, HomeStates>(
    listener: (context, state) async {

      if(state is SelectCategory){

        BlocProvider.of<HomeCubit>(context).clearDate();

      }

    },
    builder: (context, state) =>  Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              BlocProvider.of<HomeCubit>(context).selectedCategory=="Past"?Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: width/1.14,
                      child: datePicker(width, height,
                          BlocProvider.of<HomeCubit>(context), context),
                    ),

                    BlocProvider.of<HomeCubit>(context).fromDate != ""
                        ? Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<HomeCubit>(context)
                                .clearDate();
                          },
                          icon: Icon(Icons.cancel,color: titleTextColor,)
                        ),
                      ),
                    )
                        : Text(""),
                  ],
                ),
              ):Text(""),

             BlocProvider.of<HomeCubit>(context).fromDate == ""
              ? StreamBuilder(
                stream:  BlocProvider.of<HomeCubit>(context)
                    .fetchRockets().asStream(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    rocketsList = snapshot.data as List<RocketModel>;
                    return rocketsList.length>0?
                    Center(child: HomeBody(rockets: rocketsList,
                      isPast: BlocProvider.of<HomeCubit>(context)
                          .selectedCategory=="Past",))
                    :Padding(
                      padding: EdgeInsets.only(top: height/3),
                      child: Text("No ${BlocProvider.of<HomeCubit>(context)
                          .selectedCategory} Rockets Found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 20,
                      color: titleTextColor,
                      fontWeight: FontWeight.bold
                      ),));
                  }else{
                    return Center(
                        child: CircularProgressIndicator());
                  }
                },

              )
                 : Center(child:
             BlocProvider.of<HomeCubit>(context)
                 .getRocketsInRange(rocketsList).length>0?
             HomeBody(rockets: BlocProvider.of<HomeCubit>(context)
                 .getRocketsInRange(rocketsList),
               isPast: BlocProvider.of<HomeCubit>(context)
                   .selectedCategory=="Past",)
                 :Padding(
                         padding: EdgeInsets.only(top: height/3),
                         child: Text("No Rockets in This Range",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                           fontSize: 20,
                           color: titleTextColor,
                           fontWeight: FontWeight.bold
                         ),
                   ),
                       )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: navigationColor,
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categoriesList.map((category) =>
              TextButton(
                onPressed: (){
                  BlocProvider.of<HomeCubit>(context).selectCategory(category);
                },
                child: Text(category,style: TextStyle(
                    color: BlocProvider.of<HomeCubit>(context).selectedCategory==category?
                    Colors.white:Colors.grey,
                    fontSize: BlocProvider.of<HomeCubit>(context)
                        .selectedCategory==category?18:16,
                    fontWeight: FontWeight.bold),
                ),
              )).toList(),
          ))
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {

  final List<RocketModel> rockets;
  final bool isPast;

  const HomeBody({Key? key, required this.rockets
             ,required this.isPast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.3,
      width: MediaQuery.of(context).size.width/(rockets.length==1?1.4:1),
      padding: EdgeInsets.only(left: rockets.length==1? 0:32),
      child: rockets.length==1?
      RocketWidget(rocketModel: rockets[0],index: 0,isNext: true,)
      : Swiper(
        itemCount: rockets.length,
        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(
        //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
        //   alignment: Alignment.bottomCenter,
        //   builder:
        //   DotSwiperPaginationBuilder(activeSize: 20, space: 8),
        // ),
        itemBuilder: (context, index) {
          return RocketWidget(rocketModel: rockets[index],
              index: index,isPast: isPast,);
        },
      ),
    );
  }
}
