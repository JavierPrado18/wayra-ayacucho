import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/Business/Entities/place.dart';
import 'package:wayra_ayacucho/presentation/providers/form_provider.dart';
import 'package:wayra_ayacucho/presentation/providers/place/place_detail_provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceDetailProvider(),
      child: _PlaceDetailView(id: id),
    );
  }
}

class _PlaceDetailView extends StatelessWidget {
  const _PlaceDetailView({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final placeDetailProvider =
        Provider.of<PlaceDetailProvider>(context, listen: false);
    //final formularioProvider = Provider.of<FormularioProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: placeDetailProvider.getPlaceById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final place = snapshot.data!;
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _CustonSliverAppBar(size: size, place: place),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Descripcion:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        IconButton.filledTonal(
                                            onPressed: () {
                                              context.read<FormularioProvider>().changeValuesForm(
                                                title: place.title,
                                                description: place.description,
                                                category: place.idCategory,
                                                image: place.imageUrl,
                                                latitude: place.latitude,
                                                longitude: place.longitute,
                                                id: place.id
                                                
                                              );
                                              context.pushReplacement("/form");
                                            },
                                            icon: const Icon(Icons.edit)),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        IconButton.filledTonal(
                                            onPressed: () {},
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(place.description),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: FilledButton(
                                      onPressed: () {},
                                      child: const Text("Ver en el mapa")),
                                )
                              ],
                            ),
                          ),
                      childCount: 1),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _CustonSliverAppBar extends StatelessWidget {
  const _CustonSliverAppBar({
    required this.size,
    required this.place,
  });

  final Size size;
  final Place place;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: size.height * 0.6,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          SizedBox(
            child: Image.network(
              height: double.infinity,
              width: double.infinity,
              place.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.7, 1.0],
                        colors: [Colors.transparent, Colors.black]))),
          ),
          const SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, stops: [
              0.0,
              0.3
            ], colors: [
              Color.fromARGB(225, 0, 0, 0),
              Colors.transparent
            ]))),
          ),
        ]),
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          place.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
