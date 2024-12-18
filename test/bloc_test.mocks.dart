// Mocks generated by Mockito 5.4.4 from annotations
// in sohotest/test/bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:sohotest/app/data_source/task/task_data_source.dart' as _i2;
import 'package:sohotest/app/entity_models/task/task_entity.dart' as _i5;
import 'package:sohotest/app/enums/filter_enum.dart' as _i6;
import 'package:sohotest/app/repository/task_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTaskDataSource_0 extends _i1.SmartFake
    implements _i2.TaskDataSource {
  _FakeTaskDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TaskRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskRepository extends _i1.Mock implements _i3.TaskRepository {
  MockTaskRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TaskDataSource get dataSource => (super.noSuchMethod(
        Invocation.getter(#dataSource),
        returnValue: _FakeTaskDataSource_0(
          this,
          Invocation.getter(#dataSource),
        ),
      ) as _i2.TaskDataSource);

  @override
  _i4.Future<List<_i5.TaskEntity>> getTasks({
    required int? page,
    int? limit = 20,
    _i6.FilterEnum? filter = _i6.FilterEnum.all,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
          {
            #page: page,
            #limit: limit,
            #filter: filter,
          },
        ),
        returnValue: _i4.Future<List<_i5.TaskEntity>>.value(<_i5.TaskEntity>[]),
      ) as _i4.Future<List<_i5.TaskEntity>>);

  @override
  _i4.Future<void> insertTask(_i5.TaskEntity? task) => (super.noSuchMethod(
        Invocation.method(
          #insertTask,
          [task],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> updateTask(_i5.TaskEntity? task) => (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [task],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> deleteTask(int? taskId) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [taskId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> completeOrUncompleteTask(int? taskId) => (super.noSuchMethod(
        Invocation.method(
          #completeOrUncompleteTask,
          [taskId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> clearTasks() => (super.noSuchMethod(
        Invocation.method(
          #clearTasks,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i5.TaskEntity?> getTaskById(int? taskId) => (super.noSuchMethod(
        Invocation.method(
          #getTaskById,
          [taskId],
        ),
        returnValue: _i4.Future<_i5.TaskEntity?>.value(),
      ) as _i4.Future<_i5.TaskEntity?>);

  @override
  _i4.Future<int> getTotalTaskCount() => (super.noSuchMethod(
        Invocation.method(
          #getTotalTaskCount,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> getCompletedTaskCount() => (super.noSuchMethod(
        Invocation.method(
          #getCompletedTaskCount,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> getPendingTaskCount() => (super.noSuchMethod(
        Invocation.method(
          #getPendingTaskCount,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}