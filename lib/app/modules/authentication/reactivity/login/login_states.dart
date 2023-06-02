import 'package:asp/asp.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/models/user_model.dart';

final loginState = Atom<UserModel?>(null);
final loginErrorState = Atom<AppException?>(null);
final loginLoadingState = Atom<bool>(false);
