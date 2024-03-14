import 'package:go_router/go_router.dart';
import 'package:wayra_ayacucho/presentation/screens/screens.dart';

final appRoute = GoRouter(initialLocation: "/", routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen(), routes: [
    GoRoute(
      path: 'places/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? "no-id";

        return PlaceDetailScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: 'festivities/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? "no-id";

        return FestivityDetailScreen(
          id: id,
        );
      },
    ),
  ]),
  GoRoute(
    path: '/form',
    builder: (context, state) => const FormScreen(),
  ),
]);
