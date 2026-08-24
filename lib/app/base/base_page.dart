import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../app.dart';

abstract class BasePage<T extends StatefulWidget, B extends BaseBloc> extends BasePageDelegate<T, B> {}

abstract class BasePageDelegate<T extends StatefulWidget, B extends BaseBloc> extends State<T> {
  late final B bloc = GetIt.instance.get<B>();
  late final AppRouter navigator = GetIt.instance.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
      ],
      child: buildPage(context),
    );
  }

  Widget buildPage(BuildContext context);
}
