import 'package:asp/asp.dart';

import '../../../core/models/user_model.dart';
import '../../exceptions/auth_exceptions.dart';

final loginState = Atom<UserModel?>(null);
final loginErrorState = Atom<AppException?>(null);
final loginLoadingState = Atom<bool>(false);
