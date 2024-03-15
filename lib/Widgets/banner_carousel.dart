import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:resqfood/Objects/supabase_image_provider.dart';
import 'package:resqfood/Widgets/skeletonized_image.dart';
import 'package:resqfood/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  Future<List<ImageProvider>>? query;

  LoopPageController controller = LoopPageController();
  RestartableTimer? autoScroll;

  @override
  void initState() {
    query = getImages();
    autoScroll = RestartableTimer(
      const Duration(seconds: 5),
      () => controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeIn)
    );
    super.initState();
  }

  Future<List<ImageProvider>> getImages() async{
    final data = await supabase.from('advertisements').select('*').order('id', ascending: true);
    return data.map((e) => SupabaseImageProvider(bucket: 'images', path: e['image_path'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: FutureBuilder(
        future: query,
        builder: (context, snapshot) => Stack(
          fit: StackFit.expand,
          children: [
            LoopPageView.builder(
              itemCount: snapshot.data?.length ?? 1,
              controller: controller,
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                autoScroll?.reset();
              },
              itemBuilder: (context, index){
                if(!snapshot.hasData){
                  return const Skeletonizer(child: Bone());
                }
                return Image(
                  image: snapshot.data![index],
                  fit: BoxFit.cover,
                  frameBuilder: skeletonizedImageFrameBuilder,
                );
              },
            ),
            !snapshot.hasData ? const SizedBox.shrink() :
            Positioned(
              left: 0,
              right: 0,
              bottom: 3,
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, child) => Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 3,
                  children: List.generate(
                    snapshot.data!.length,
                    (index){
                      double page = controller.hasClients?controller.page:0;
                      if(index == 0 && page > 1){
                        page -= snapshot.data!.length;
                      }
                      double lerp = (1 - (page - index).abs()).clamp(0, 1);
                      return Container(
                        height: 10,
                        width: lerpDouble(10, 40, lerp),
                        decoration: BoxDecoration(
                          color: Color.lerp(Colors.grey.shade700, Colors.white, lerp),
                          borderRadius: BorderRadius.circular(1000)
                        ),
                      );
                    }
                  ),
                )
              ),
            )
          ]
        )
      )
    );
  }
}