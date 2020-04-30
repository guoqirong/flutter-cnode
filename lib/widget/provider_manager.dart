import 'package:flutter_cnode/model/index/index_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<IndexModel>.value(value: IndexModel()),
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildCloneableWidget> dependentServices = [
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
