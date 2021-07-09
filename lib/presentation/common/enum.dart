enum Selects { cancel, accept }

extension SelectExt on Object {
  String get name => toString().substring(toString().indexOf('.') + 1);
}
