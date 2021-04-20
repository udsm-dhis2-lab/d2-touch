// class QueryFilterCondition {
//   static equal() => 'eq';
//   static include() => 'IN';
//   static ilike() => 'ilike';
//   static lesstThan() => 'lt';
//   static lessThanOrEqualTo() => 'le';
//   static greaterThan() => 'gt';
//   static greaterThanOrEqualTo() => 'ge';
// }

enum QueryCondition {
  In,
  Equal,
  Ilike,
  LessThan,
  LessThanOrEqualTo,
  GreaterThan,
  GreaterThanOrEqualTo
}
