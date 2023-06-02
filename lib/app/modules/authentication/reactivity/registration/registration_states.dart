import 'package:asp/asp.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/models/user_model.dart';

final registrationState = Atom<UserModel?>(null);
final registrationErrorState = Atom<AppException?>(null);
final registrationLoadingState = Atom<bool>(false);
