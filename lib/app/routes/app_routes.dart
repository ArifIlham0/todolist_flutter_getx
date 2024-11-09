part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const TODO_LIST = _Paths.TODO_LIST;
  static const REGISTER = _Paths.REGISTER;
  static const BOTTOM_NAV = _Paths.BOTTOM_NAV;
  static const SPLASH = _Paths.SPLASH;
  static const COMPLETED = _Paths.COMPLETED;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const TODO_LIST = '/todo-list';
  static const REGISTER = '/register';
  static const BOTTOM_NAV = '/bottom-nav';
  static const SPLASH = '/splash';
  static const COMPLETED = '/completed';
  static const PROFILE = '/profile';
}
