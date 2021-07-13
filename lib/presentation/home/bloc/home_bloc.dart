import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:covid19_app/data/model/history.dart';
import 'package:covid19_app/data/model/world_response.dart';
import 'package:covid19_app/domain/usescase/covid_usescase.dart';
import 'package:covid19_app/presentation/common/array.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.covidUsecase)
      : super(
          HomeInitial(),
        );
  final CovidUsescase covidUsecase;
  late final World worldPbublic;
  History history = History();
  List date = [];
  List<Spot> valueCases = [];
  List<Spot> valueDeaths = [];
  List<Spot> valueRecovered = [];
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadingHomeEvent) {
      yield* _mapLoadingHomeEventToState();
    } else if (event is ChangeChartEvent) {
      if (event.status!) {
        yield ChartState(
          date: date,
          spotCases: valueCases,
          spotDeaths: valueDeaths,
          spotRecovered: valueRecovered,
        );
      } else {
        yield HomeSuccessState(world: worldPbublic);
      }
    }
  }

  Stream<HomeState> _mapLoadingHomeEventToState() async* {
    yield HomeLoadingState();
    try {
      final reponse = await covidUsecase.getWorld();
      final reponseHistory = await covidUsecase.getHistory();
      history = reponseHistory;
      date = history.itemCase!.json!.keys.toList();
      history.itemDeaths!.json!.forEach(
        (k, v) => valueDeaths.add(
          Spot(date: k, value: v * 1.0),
        ),
      );
      history.itemCase!.json!.forEach(
        (k, v) => valueCases.add(
          Spot(date: k, value: v * 1.0),
        ),
      );
      history.itemRecovered!.json!.forEach(
        (k, v) => valueRecovered.add(
          Spot(date: k, value: v * 1.0),
        ),
      );
      worldPbublic = reponse;
      yield HomeSuccessState(world: worldPbublic);
    } catch (e) {
      yield HomeFailState();
    }
  }
}
