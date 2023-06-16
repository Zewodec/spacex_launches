import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spacex_launches/features/rocket_launcher_list/presentation/cubit/rocket_launches_cubit.dart';
import 'package:spacex_launches/features/rocket_launcher_list/presentation/cubit/rockets_cubit.dart';

import '../../data/models/rockets_model.dart';

final List<String> imgList = [];

class ImageCarousel extends StatefulWidget {
  const ImageCarousel(
      {super.key,
      required this.rocketsCubit,
      required this.rocketsLaunchesCubit});

  final RocketsCubit rocketsCubit;
  final RocketLaunchesCubit rocketsLaunchesCubit;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  late List<Widget> imageSliders;

  @override
  void initState() {
    LoadRockets();
    super.initState();
  }

  void LoadRockets() async {
    await widget.rocketsCubit.loadRockets();
    String? firstrocketID = widget.rocketsCubit.getFirstRocketID();

    if (firstrocketID != null) {
      widget.rocketsLaunchesCubit.loadForRocketUpcomingLaunches(firstrocketID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RocketsCubit, RocketsState>(
      bloc: widget.rocketsCubit,
      listener: (context, state) {
        if (state is RocketsLoadingError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Error loading rockets: ${state.errorMessage}",
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        }
      },
      builder: (context, state) {
        if (state is RocketsLoading) {
          return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSecondary);
        } else if (state is RocketsLoaded) {
          loadImageList(state.rockets);

          imageSliders = imgList
              .map((item) => Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child:
                          Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    ),
                  ))
              .toList();

          return Column(
            children: [
              // Image Carousel
              CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    height: 216,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                      widget.rocketsLaunchesCubit.loadForRocketUpcomingLaunches(
                          state.rockets[_current].id);
                    }),
              ),
              const SizedBox(height: 12),
              AnimatedSmoothIndicator(
                // Indicator for Image Page
                activeIndex: _current,
                count: state.rockets.length,
                effect: CustomizableEffect(
                  dotDecoration: DotDecoration(
                    color: Colors.black,
                    width: 8,
                    height: 8,
                    borderRadius: BorderRadius.circular(5),
                    dotBorder: const DotBorder(
                        color: Colors.white, padding: 2, width: 1.5),
                  ),
                  activeDotDecoration: DotDecoration(
                    width: 15,
                    height: 15,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator(color: Colors.redAccent);
      },
    );
  }
}

void loadImageList(List<RocketsModel> rockets) {
  imgList.clear();
  for (int i = 0; i < rockets.length; i++) {
    imgList.add(rockets[i].flickrImages[0]);
  }
}
