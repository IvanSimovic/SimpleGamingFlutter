// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddGameState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddGameStateCopyWith<$Res> {
  factory $AddGameStateCopyWith(
    AddGameState value,
    $Res Function(AddGameState) then,
  ) = _$AddGameStateCopyWithImpl<$Res, AddGameState>;
}

/// @nodoc
class _$AddGameStateCopyWithImpl<$Res, $Val extends AddGameState>
    implements $AddGameStateCopyWith<$Res> {
  _$AddGameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddGameIdleImplCopyWith<$Res> {
  factory _$$AddGameIdleImplCopyWith(
    _$AddGameIdleImpl value,
    $Res Function(_$AddGameIdleImpl) then,
  ) = __$$AddGameIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddGameIdleImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameIdleImpl>
    implements _$$AddGameIdleImplCopyWith<$Res> {
  __$$AddGameIdleImplCopyWithImpl(
    _$AddGameIdleImpl _value,
    $Res Function(_$AddGameIdleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddGameIdleImpl implements AddGameIdle {
  const _$AddGameIdleImpl();

  @override
  String toString() {
    return 'AddGameState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddGameIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class AddGameIdle implements AddGameState {
  const factory AddGameIdle() = _$AddGameIdleImpl;
}

/// @nodoc
abstract class _$$AddGameLoadingImplCopyWith<$Res> {
  factory _$$AddGameLoadingImplCopyWith(
    _$AddGameLoadingImpl value,
    $Res Function(_$AddGameLoadingImpl) then,
  ) = __$$AddGameLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddGameLoadingImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameLoadingImpl>
    implements _$$AddGameLoadingImplCopyWith<$Res> {
  __$$AddGameLoadingImplCopyWithImpl(
    _$AddGameLoadingImpl _value,
    $Res Function(_$AddGameLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddGameLoadingImpl implements AddGameLoading {
  const _$AddGameLoadingImpl();

  @override
  String toString() {
    return 'AddGameState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddGameLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AddGameLoading implements AddGameState {
  const factory AddGameLoading() = _$AddGameLoadingImpl;
}

/// @nodoc
abstract class _$$AddGameContentImplCopyWith<$Res> {
  factory _$$AddGameContentImplCopyWith(
    _$AddGameContentImpl value,
    $Res Function(_$AddGameContentImpl) then,
  ) = __$$AddGameContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Game> results});
}

/// @nodoc
class __$$AddGameContentImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameContentImpl>
    implements _$$AddGameContentImplCopyWith<$Res> {
  __$$AddGameContentImplCopyWithImpl(
    _$AddGameContentImpl _value,
    $Res Function(_$AddGameContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = null}) {
    return _then(
      _$AddGameContentImpl(
        null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<Game>,
      ),
    );
  }
}

/// @nodoc

class _$AddGameContentImpl implements AddGameContent {
  const _$AddGameContentImpl(final List<Game> results) : _results = results;

  final List<Game> _results;
  @override
  List<Game> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'AddGameState.content(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddGameContentImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddGameContentImplCopyWith<_$AddGameContentImpl> get copyWith =>
      __$$AddGameContentImplCopyWithImpl<_$AddGameContentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return content(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return content?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class AddGameContent implements AddGameState {
  const factory AddGameContent(final List<Game> results) = _$AddGameContentImpl;

  List<Game> get results;

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddGameContentImplCopyWith<_$AddGameContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddGameEmptyImplCopyWith<$Res> {
  factory _$$AddGameEmptyImplCopyWith(
    _$AddGameEmptyImpl value,
    $Res Function(_$AddGameEmptyImpl) then,
  ) = __$$AddGameEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddGameEmptyImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameEmptyImpl>
    implements _$$AddGameEmptyImplCopyWith<$Res> {
  __$$AddGameEmptyImplCopyWithImpl(
    _$AddGameEmptyImpl _value,
    $Res Function(_$AddGameEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddGameEmptyImpl implements AddGameEmpty {
  const _$AddGameEmptyImpl();

  @override
  String toString() {
    return 'AddGameState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddGameEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class AddGameEmpty implements AddGameState {
  const factory AddGameEmpty() = _$AddGameEmptyImpl;
}

/// @nodoc
abstract class _$$AddGameErrorImplCopyWith<$Res> {
  factory _$$AddGameErrorImplCopyWith(
    _$AddGameErrorImpl value,
    $Res Function(_$AddGameErrorImpl) then,
  ) = __$$AddGameErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddGameErrorImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameErrorImpl>
    implements _$$AddGameErrorImplCopyWith<$Res> {
  __$$AddGameErrorImplCopyWithImpl(
    _$AddGameErrorImpl _value,
    $Res Function(_$AddGameErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddGameErrorImpl implements AddGameError {
  const _$AddGameErrorImpl();

  @override
  String toString() {
    return 'AddGameState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddGameErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AddGameError implements AddGameState {
  const factory AddGameError() = _$AddGameErrorImpl;
}

/// @nodoc
abstract class _$$AddGameAddedImplCopyWith<$Res> {
  factory _$$AddGameAddedImplCopyWith(
    _$AddGameAddedImpl value,
    $Res Function(_$AddGameAddedImpl) then,
  ) = __$$AddGameAddedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddGameAddedImplCopyWithImpl<$Res>
    extends _$AddGameStateCopyWithImpl<$Res, _$AddGameAddedImpl>
    implements _$$AddGameAddedImplCopyWith<$Res> {
  __$$AddGameAddedImplCopyWithImpl(
    _$AddGameAddedImpl _value,
    $Res Function(_$AddGameAddedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddGameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddGameAddedImpl implements AddGameAdded {
  const _$AddGameAddedImpl();

  @override
  String toString() {
    return 'AddGameState.added()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddGameAddedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<Game> results) content,
    required TResult Function() empty,
    required TResult Function() error,
    required TResult Function() added,
  }) {
    return added();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<Game> results)? content,
    TResult? Function()? empty,
    TResult? Function()? error,
    TResult? Function()? added,
  }) {
    return added?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<Game> results)? content,
    TResult Function()? empty,
    TResult Function()? error,
    TResult Function()? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddGameIdle value) idle,
    required TResult Function(AddGameLoading value) loading,
    required TResult Function(AddGameContent value) content,
    required TResult Function(AddGameEmpty value) empty,
    required TResult Function(AddGameError value) error,
    required TResult Function(AddGameAdded value) added,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddGameIdle value)? idle,
    TResult? Function(AddGameLoading value)? loading,
    TResult? Function(AddGameContent value)? content,
    TResult? Function(AddGameEmpty value)? empty,
    TResult? Function(AddGameError value)? error,
    TResult? Function(AddGameAdded value)? added,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddGameIdle value)? idle,
    TResult Function(AddGameLoading value)? loading,
    TResult Function(AddGameContent value)? content,
    TResult Function(AddGameEmpty value)? empty,
    TResult Function(AddGameError value)? error,
    TResult Function(AddGameAdded value)? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class AddGameAdded implements AddGameState {
  const factory AddGameAdded() = _$AddGameAddedImpl;
}
