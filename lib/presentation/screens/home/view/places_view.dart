import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wayra_ayacucho/Business/Entities/place_dto.dart';
import 'package:wayra_ayacucho/presentation/providers/place/places_provider.dart';
import 'package:wayra_ayacucho/presentation/widgets/horizontal_listview.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    final placesProvider = Provider.of<PlacesProvider>(context, listen: false);
    
    return FutureBuilder(
      future: placesProvider.getPlaces(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<PlaceDto> places = snapshot.data!;
          final List<PlaceDto> parks = [];
          final List<PlaceDto> churches = [];
          final List<PlaceDto> viewpoints = [];
          final List<PlaceDto> museums = [];
          for (PlaceDto place in places) {
            if (place.idCategory == 1) {
              parks.add(place);
            } else if (place.idCategory == 2) {
              viewpoints.add(place);
            } else if (place.idCategory == 3) {
              museums.add(place);
            } else {
              churches.add(place);
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                HorizontalListView(
                  places: parks,
                  title: 'Parques',
                ),
                HorizontalListView(
                  places: viewpoints,
                  title: 'Miradores',
                ),
                HorizontalListView(
                  places: museums,
                  title: 'Museos',
                ),
                HorizontalListView(
                  places: churches,
                  title: 'Iglesias',
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// FutureBuilder(
//       future: courseProvider.obtenerCourses(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final List<Course> courses = snapshot.data!;
//           return ListView.builder(
//             itemCount: courses.length,
//             itemBuilder: (context, index) {
//               final Course course = courses[index];
//               return ListTile(
//                 title: Text(course.name),
//                 subtitle: Text(course.area),
//               );
//             },
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );