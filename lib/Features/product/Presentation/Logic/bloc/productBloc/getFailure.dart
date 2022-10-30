import 'package:store/Core/strings.dart';

import '../../../../../../Core/error.dart';

String getfailure({required Failure failure}) {
  switch (failure.runtimeType) {
    case CashFailure:
      {
        return apifailure;
      }
    case InternetFailure:
      {
        return internetfailure;
      }
    case ApiFailure:
      {
        return apifailure;
      }
    default:
      {
        return unexpectedfailure;
      }
  }
}
