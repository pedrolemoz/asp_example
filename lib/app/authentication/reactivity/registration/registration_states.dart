import 'package:asp/asp.dart';

import '../../../core/models/user_model.dart';
import '../../exceptions/auth_exceptions.dart';

final registrationState = Atom<UserModel?>(null);
final registrationErrorState = Atom<AppException?>(null);
final registrationLoadingState = Atom<bool>(false);
