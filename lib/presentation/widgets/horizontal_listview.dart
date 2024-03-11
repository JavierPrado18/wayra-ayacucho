import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:go_router/go_router.dart';
import 'package:wayra_ayacucho/Business/Entities/place_dto.dart';

class HorizontalListView extends StatelessWidget {
  final List<PlaceDto> places;
  final String? title;
  const HorizontalListView({
    super.key,
    required this.places,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          if (title != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: places.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(child: _Slide(place: places[index]));
              },
            ),
          )
        ]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final PlaceDto place;
  const _Slide({required this.place});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              place.imageUrl,
              height: 200,
              width: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GestureDetector(
                    onTap: () {
                      context.push('/places/${place.id}');
                    },
                    child: FadeInRight(child: child));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          place.title,
          style: textStyles.titleSmall,
          maxLines: 2,
        ),
        const SizedBox(
          height: 4,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.edit)),
        //     SizedBox(
        //       width: 16,
        //     ),
        //     IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.delete)),
        //   ],
        // )
      ]),
    );
  }
}
