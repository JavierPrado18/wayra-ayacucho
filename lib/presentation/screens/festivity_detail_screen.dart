import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/Business/Entities/festivity.dart';
import 'package:wayra_ayacucho/presentation/providers/providers.dart';

class FestivityDetailScreen extends StatelessWidget {
  const FestivityDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FestivitiesProvider(),
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
    final festivityProvider =
        Provider.of<FestivitiesProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: festivityProvider.getFestivityById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final festivity = snapshot.data!;
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _CustonSliverAppBar(size: size, festivity: festivity),
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
                                              context
                                                  .read<FormularioProvider>()
                                                  .changeValuesForm(
                                                      title: festivity.nombre,
                                                      description:
                                                          festivity.descripcion,
                                                      image: festivity.imgUrl,
                                                      fecha: DateTime.utc(
                                                          2024,
                                                          festivity.mes!,
                                                          festivity.dia!),
                                                      isFestivity: true,
                                                      id: festivity.id);
                                              context.pushReplacement("/form");
                                            },
                                            icon: const Icon(Icons.edit)),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        IconButton.filledTonal(
                                            onPressed: () {
                                              context
                                                  .read<FestivitiesProvider>()
                                                  .deleteFestivity(
                                                      festivity.id!);
                                              context.pushReplacement("/");
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(festivity.descripcion),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                AdvancedCalendar(
                                  controller: AdvancedCalendarController(
                                      DateTime.utc(2024, festivity.mes!,
                                          festivity.dia!)),
                                  events: [
                                    DateTime.utc(
                                        2024, festivity.mes!, festivity.dia!)
                                  ],
                                  startWeekDay: 1,
                                ),
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
    required this.festivity,
  });

  final Size size;
  final Festivity festivity;

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
              festivity.imgUrl,
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
          festivity.nombre,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
