import 'package:flash_test/helper/navigation.dart';
import 'package:flash_test/models/rocket_model.dart';
import 'package:flash_test/modules/details/details_webview_page.dart';
import 'package:flash_test/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../utilities/colors.dart';
import '../../helper/formatDate.dart';

class RocketDetailPage extends StatefulWidget {
  final RocketModel rocketModel;

  const RocketDetailPage({Key? key, required this.rocketModel}) : super(key: key);

  @override
  _RocketDetailPageState createState() => _RocketDetailPageState();
}

class _RocketDetailPageState extends State<RocketDetailPage> {

  late YoutubePlayerController _controller ;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.rocketModel.youtubeId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigationColor,
        centerTitle: true,
        title: Text(widget.rocketModel.name,
          style: TextStyle(
          color: titleTextColor,
          fontWeight: FontWeight.w900,
        ),),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Hero(
                    tag: widget.rocketModel.id,
                    child:  widget.rocketModel.youtubeId!=null?
                    YoutubePlayer(
                      controller: _controller,
                      liveUIColor: Colors.amber,
                    ):Container(
                      //width: MediaQuery.of(context).size.width/5,
                        height: height/3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage(rocketImagePath),
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height/40),
                        Text(
                          "Rocket Id : ${widget.rocketModel.id}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Text(
                          "Rocket Launch Details : ${widget.rocketModel.details??"Not Found"}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Text(
                          "Launched Time : ${formatDate(widget.rocketModel.dateTime.toString())}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Text(
                          "Launch Pad : ${widget.rocketModel.launchpad}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Text(
                          "Flight Number : ${widget.rocketModel.flightNumber}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Text(
                          "Flight Number : ${widget.rocketModel}",
                          softWrap: true,
                          // maxLines: 5,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: contentTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: height/40),
                        Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                    child: GestureDetector(
                      onTap: (){
                        navigateTo(context,
                            DetailsWebViewPage(rocketModel: widget.rocketModel));
                      },
                      child: ListTile(
                        title: Text(
                          "Read the article",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xff47455f),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                          color: const Color(0xff47455f),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
