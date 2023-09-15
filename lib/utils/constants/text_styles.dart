import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle smallText = GoogleFonts.ptSans(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);

TextStyle normalText = GoogleFonts.ptSansCaption(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

TextStyle normalDatatableText = GoogleFonts.ptSansCaption(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white
);

TextStyle mediumText = GoogleFonts.ptSans(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

TextStyle largeText = GoogleFonts.ptSans(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

TextStyle extraLargeText = GoogleFonts.ptSans(
  fontSize: 35,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

TextStyle xxLargeText = GoogleFonts.ptSans(
  fontSize: 45,
);


final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);