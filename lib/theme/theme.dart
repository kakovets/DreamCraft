import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColors extends ThemeExtension<MyColors> {

  const MyColors({
    required this.backgroundGradientFirst,
    required this.backgroundGradientSecond,
    required this.buttonGradientFirst,
    required this.buttonGradientSecond,
    required this.transparentWhite,
    required this.transparentGreen,
    required this.accentCyan,
    required this.acidGreen,
    required this.greenyCyan,
  });

  final Color backgroundGradientFirst;
  final Color backgroundGradientSecond;
  final Color buttonGradientFirst;
  final Color buttonGradientSecond;
  final Color transparentWhite;
  final Color transparentGreen;
  final Color accentCyan;
  final Color acidGreen;
  final Color greenyCyan;


  @override
  ThemeExtension<MyColors> copyWith({
    Color? backgroundGradientFirst,
    Color? backgroundGradientSecond,
    Color? buttonGradientFirst,
    Color? buttonGradientSecond,
    Color? transparentWhite,
    Color? transparentGreen,
    Color? accentCyan,
    Color? acidGreen,
    Color? greenyCyan,
  }) {
    return MyColors(
      backgroundGradientFirst: backgroundGradientFirst ?? this.backgroundGradientFirst,
      backgroundGradientSecond: backgroundGradientSecond ?? this.backgroundGradientSecond,
      buttonGradientFirst: buttonGradientFirst ?? this.buttonGradientFirst,
      buttonGradientSecond: buttonGradientSecond ?? this.buttonGradientSecond,
      transparentWhite: transparentWhite ?? this.transparentWhite,
      transparentGreen: transparentGreen ?? this.transparentGreen,
      accentCyan: accentCyan ?? this.accentCyan,
      acidGreen: acidGreen ?? this.acidGreen,
      greenyCyan: greenyCyan ?? this.greenyCyan,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
      covariant ThemeExtension<MyColors>? other, double t,) {
    if (other == null) return this;
    if (other is MyColors) {
      return MyColors(
        backgroundGradientFirst: Color.lerp(backgroundGradientFirst, other.backgroundGradientFirst, t)!,
        backgroundGradientSecond: Color.lerp(backgroundGradientSecond, other.backgroundGradientSecond, t)!,
        buttonGradientFirst: Color.lerp(buttonGradientFirst, other.buttonGradientFirst, t)!,
        buttonGradientSecond: Color.lerp(buttonGradientSecond, other.buttonGradientSecond, t)!,
        transparentWhite: Color.lerp(transparentWhite, other.transparentWhite, t)!,
        transparentGreen: Color.lerp(transparentGreen, other.transparentGreen, t)!,
        accentCyan: Color.lerp(accentCyan, other.accentCyan, t)!,
        acidGreen: Color.lerp(acidGreen, other.acidGreen, t)!,
        greenyCyan: Color.lerp(greenyCyan, other.greenyCyan, t)!,
      );
    }
    throw ArgumentError.value(
      other, 'other', 'Cannot interpolate between different types',);
  }
}

ThemeData lightMode = ThemeData(
  extensions: const <ThemeExtension<MyColors>>[
    MyColors(
      backgroundGradientFirst: Color(0xFF62C1A4),
      backgroundGradientSecond: Color(0xFF1A5C80),
      buttonGradientFirst: Color(0xFF5200FF),
      buttonGradientSecond: Color(0xFFDB00FF),
      transparentWhite: Color(0x50FFFFFF),
      transparentGreen: Color(0x332BCC02),
      accentCyan: Color(0xFF25FFF2),
      acidGreen: Color(0xFF14F999),
      greenyCyan: Color(0xFF90FFDE),
    ),
  ],
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    outline: Colors.black,
    surfaceTint: Colors.transparent,
  ),

  scaffoldBackgroundColor: Colors.transparent,

  textTheme: GoogleFonts.tekturTextTheme().apply(
      bodyColor: Colors.white,
  ),


  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blue.shade700,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFE7E7E7),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    hintStyle: const TextStyle(
      fontSize: 12,
      color: Color(0xFF8F8F8F),
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(Color(0xFF25FFF2)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
  ),

  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),

  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: const Color(0xFFDEC0F1),
    indicatorColor: Colors.yellow.shade100.withOpacity(0.8),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.shifting,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Color(0xFFDEC0F1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  ),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.black,
  ),

);

ThemeData darkMode = ThemeData(
  extensions: const <ThemeExtension<MyColors>>[
    // MyColors(
    //   backgroundGradientFirst: Color(0xFF62C1A4),
    //   backgroundGradientSecond: Color(0xFF1A5C80),
    //   transparentWhite: Colors.white,
    //   transparentGreen: Colors.white,
    //   acidGreen: Colors.black,
    // ),
  ],
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    outline: Colors.white,
    // background: Color(0xFF4D3B4D),
    surfaceTint: Colors.transparent,
  ),

  textTheme: GoogleFonts.tekturTextTheme(),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.cyan.shade700),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
  ),

  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: Colors.transparent,
    backgroundColor: const Color(0xFF855C99),
    indicatorColor: Colors.yellow.shade100.withOpacity(0.8),
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Color(0xFF855C99),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.black,
  ),

);