import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../resources/Colors/colors.dart';

class LoadingKit {
  static final spinkit = SpinKitWave(
    duration:const Duration(milliseconds: 1000),
    color: ExternalColors.lightgreen,
    size: 30,
  );

  static final imagespinkit =
      SpinKitPulsingGrid(color: ExternalColors.lightgreen);
}
