import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/interfaces/home/home_presenter.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        title: 'Irroba',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFAFAF9),
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFDC2626),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          extensions: const [
            CustomTheme(primary: Color(0xFFDC2626), secondary: Color(0xFFECECEC)),
          ],
        ),
        home: const InjectionPage(
          child: HomePresenter(),
        ),
      ),
    );
  }
}

class InjectionPage extends StatefulWidget {
  final Widget child;
  const InjectionPage({super.key, required this.child});

  @override
  State<InjectionPage> createState() => _InjectionPageState();
}

class _InjectionPageState extends State<InjectionPage> {
  @override
  void initState() {
    super.initState();
    setupDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.child);
  }
}

class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color primary;
  final Color secondary;

  const CustomTheme({required this.primary, required this.secondary});

  @override
  ThemeExtension<CustomTheme> copyWith({
    Color? primary,
    Color? secondary,
  }) {
    return CustomTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(covariant CustomTheme? other, double t) {
    return CustomTheme(
      primary: Color.lerp(primary, other!.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
    );
  }
}
