// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskzoo_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskzooPreferencesCollection on Isar {
  IsarCollection<TaskzooPreferences> get taskzooPreferences =>
      this.collection();
}

const TaskzooPreferencesSchema = CollectionSchema(
  name: r'TaskzooPreferences',
  id: -7322277552778857618,
  properties: {
    r'value': PropertySchema(
      id: 0,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _taskzooPreferencesEstimateSize,
  serialize: _taskzooPreferencesSerialize,
  deserialize: _taskzooPreferencesDeserialize,
  deserializeProp: _taskzooPreferencesDeserializeProp,
  idName: r'taskid',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _taskzooPreferencesGetId,
  getLinks: _taskzooPreferencesGetLinks,
  attach: _taskzooPreferencesAttach,
  version: '3.1.0+1',
);

int _taskzooPreferencesEstimateSize(
  TaskzooPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _taskzooPreferencesSerialize(
  TaskzooPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.value);
}

TaskzooPreferences _taskzooPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskzooPreferences(
    taskid: id,
    value: reader.readLong(offsets[0]),
  );
  return object;
}

P _taskzooPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskzooPreferencesGetId(TaskzooPreferences object) {
  return object.taskid;
}

List<IsarLinkBase<dynamic>> _taskzooPreferencesGetLinks(
    TaskzooPreferences object) {
  return [];
}

void _taskzooPreferencesAttach(
    IsarCollection<dynamic> col, Id id, TaskzooPreferences object) {
  object.taskid = id;
}

extension TaskzooPreferencesQueryWhereSort
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QWhere> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhere>
      anyTaskid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TaskzooPreferencesQueryWhere
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QWhereClause> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhereClause>
      taskidEqualTo(Id taskid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: taskid,
        upper: taskid,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhereClause>
      taskidNotEqualTo(Id taskid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: taskid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: taskid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: taskid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: taskid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhereClause>
      taskidGreaterThan(Id taskid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: taskid, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhereClause>
      taskidLessThan(Id taskid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: taskid, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterWhereClause>
      taskidBetween(
    Id lowerTaskid,
    Id upperTaskid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerTaskid,
        includeLower: includeLower,
        upper: upperTaskid,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskzooPreferencesQueryFilter
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QFilterCondition> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      taskidEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      taskidGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      taskidLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskid',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      taskidBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      valueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      valueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      valueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterFilterCondition>
      valueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskzooPreferencesQueryObject
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QFilterCondition> {}

extension TaskzooPreferencesQueryLinks
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QFilterCondition> {}

extension TaskzooPreferencesQuerySortBy
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QSortBy> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension TaskzooPreferencesQuerySortThenBy
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QSortThenBy> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      thenByTaskid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskid', Sort.asc);
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      thenByTaskidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskid', Sort.desc);
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension TaskzooPreferencesQueryWhereDistinct
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QDistinct> {
  QueryBuilder<TaskzooPreferences, TaskzooPreferences, QDistinct>
      distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension TaskzooPreferencesQueryProperty
    on QueryBuilder<TaskzooPreferences, TaskzooPreferences, QQueryProperty> {
  QueryBuilder<TaskzooPreferences, int, QQueryOperations> taskidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskid');
    });
  }

  QueryBuilder<TaskzooPreferences, int, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
