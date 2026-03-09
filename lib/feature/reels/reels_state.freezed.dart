// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reels_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReelsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )
    content,
    required TResult Function() empty,
    required TResult Function() error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult? Function()? empty,
    TResult? Function()? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult Function()? empty,
    TResult Function()? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReelsLoading value) loading,
    required TResult Function(ReelsContent value) content,
    required TResult Function(ReelsEmpty value) empty,
    required TResult Function(ReelsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReelsLoading value)? loading,
    TResult? Function(ReelsContent value)? content,
    TResult? Function(ReelsEmpty value)? empty,
    TResult? Function(ReelsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReelsLoading value)? loading,
    TResult Function(ReelsContent value)? content,
    TResult Function(ReelsEmpty value)? empty,
    TResult Function(ReelsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReelsStateCopyWith<$Res> {
  factory $ReelsStateCopyWith(
    ReelsState value,
    $Res Function(ReelsState) then,
  ) = _$ReelsStateCopyWithImpl<$Res, ReelsState>;
}

/// @nodoc
class _$ReelsStateCopyWithImpl<$Res, $Val extends ReelsState>
    implements $ReelsStateCopyWith<$Res> {
  _$ReelsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ReelsLoadingImplCopyWith<$Res> {
  factory _$$ReelsLoadingImplCopyWith(
    _$ReelsLoadingImpl value,
    $Res Function(_$ReelsLoadingImpl) then,
  ) = __$$ReelsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReelsLoadingImplCopyWithImpl<$Res>
    extends _$ReelsStateCopyWithImpl<$Res, _$ReelsLoadingImpl>
    implements _$$ReelsLoadingImplCopyWith<$Res> {
  __$$ReelsLoadingImplCopyWithImpl(
    _$ReelsLoadingImpl _value,
    $Res Function(_$ReelsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReelsLoadingImpl implements ReelsLoading {
  const _$ReelsLoadingImpl();

  @override
  String toString() {
    return 'ReelsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReelsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )
    content,
    required TResult Function() empty,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult? Function()? empty,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult Function()? empty,
    TResult Function()? error,
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
    required TResult Function(ReelsLoading value) loading,
    required TResult Function(ReelsContent value) content,
    required TResult Function(ReelsEmpty value) empty,
    required TResult Function(ReelsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReelsLoading value)? loading,
    TResult? Function(ReelsContent value)? content,
    TResult? Function(ReelsEmpty value)? empty,
    TResult? Function(ReelsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReelsLoading value)? loading,
    TResult Function(ReelsContent value)? content,
    TResult Function(ReelsEmpty value)? empty,
    TResult Function(ReelsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ReelsLoading implements ReelsState {
  const factory ReelsLoading() = _$ReelsLoadingImpl;
}

/// @nodoc
abstract class _$$ReelsContentImplCopyWith<$Res> {
  factory _$$ReelsContentImplCopyWith(
    _$ReelsContentImpl value,
    $Res Function(_$ReelsContentImpl) then,
  ) = __$$ReelsContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<ReelGame> games,
    int currentIndex,
    bool isLoadingMore,
    bool hasReachedEnd,
    Set<String> favouritingIds,
  });
}

/// @nodoc
class __$$ReelsContentImplCopyWithImpl<$Res>
    extends _$ReelsStateCopyWithImpl<$Res, _$ReelsContentImpl>
    implements _$$ReelsContentImplCopyWith<$Res> {
  __$$ReelsContentImplCopyWithImpl(
    _$ReelsContentImpl _value,
    $Res Function(_$ReelsContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? currentIndex = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? favouritingIds = null,
  }) {
    return _then(
      _$ReelsContentImpl(
        games: null == games
            ? _value._games
            : games // ignore: cast_nullable_to_non_nullable
                  as List<ReelGame>,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasReachedEnd: null == hasReachedEnd
            ? _value.hasReachedEnd
            : hasReachedEnd // ignore: cast_nullable_to_non_nullable
                  as bool,
        favouritingIds: null == favouritingIds
            ? _value._favouritingIds
            : favouritingIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$ReelsContentImpl implements ReelsContent {
  const _$ReelsContentImpl({
    required final List<ReelGame> games,
    required this.currentIndex,
    required this.isLoadingMore,
    required this.hasReachedEnd,
    required final Set<String> favouritingIds,
  }) : _games = games,
       _favouritingIds = favouritingIds;

  final List<ReelGame> _games;
  @override
  List<ReelGame> get games {
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  @override
  final int currentIndex;
  @override
  final bool isLoadingMore;
  @override
  final bool hasReachedEnd;
  final Set<String> _favouritingIds;
  @override
  Set<String> get favouritingIds {
    if (_favouritingIds is EqualUnmodifiableSetView) return _favouritingIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_favouritingIds);
  }

  @override
  String toString() {
    return 'ReelsState.content(games: $games, currentIndex: $currentIndex, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, favouritingIds: $favouritingIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReelsContentImpl &&
            const DeepCollectionEquality().equals(other._games, _games) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            const DeepCollectionEquality().equals(
              other._favouritingIds,
              _favouritingIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_games),
    currentIndex,
    isLoadingMore,
    hasReachedEnd,
    const DeepCollectionEquality().hash(_favouritingIds),
  );

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReelsContentImplCopyWith<_$ReelsContentImpl> get copyWith =>
      __$$ReelsContentImplCopyWithImpl<_$ReelsContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )
    content,
    required TResult Function() empty,
    required TResult Function() error,
  }) {
    return content(
      games,
      currentIndex,
      isLoadingMore,
      hasReachedEnd,
      favouritingIds,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult? Function()? empty,
    TResult? Function()? error,
  }) {
    return content?.call(
      games,
      currentIndex,
      isLoadingMore,
      hasReachedEnd,
      favouritingIds,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult Function()? empty,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(
        games,
        currentIndex,
        isLoadingMore,
        hasReachedEnd,
        favouritingIds,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReelsLoading value) loading,
    required TResult Function(ReelsContent value) content,
    required TResult Function(ReelsEmpty value) empty,
    required TResult Function(ReelsError value) error,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReelsLoading value)? loading,
    TResult? Function(ReelsContent value)? content,
    TResult? Function(ReelsEmpty value)? empty,
    TResult? Function(ReelsError value)? error,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReelsLoading value)? loading,
    TResult Function(ReelsContent value)? content,
    TResult Function(ReelsEmpty value)? empty,
    TResult Function(ReelsError value)? error,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class ReelsContent implements ReelsState {
  const factory ReelsContent({
    required final List<ReelGame> games,
    required final int currentIndex,
    required final bool isLoadingMore,
    required final bool hasReachedEnd,
    required final Set<String> favouritingIds,
  }) = _$ReelsContentImpl;

  List<ReelGame> get games;
  int get currentIndex;
  bool get isLoadingMore;
  bool get hasReachedEnd;
  Set<String> get favouritingIds;

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReelsContentImplCopyWith<_$ReelsContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReelsEmptyImplCopyWith<$Res> {
  factory _$$ReelsEmptyImplCopyWith(
    _$ReelsEmptyImpl value,
    $Res Function(_$ReelsEmptyImpl) then,
  ) = __$$ReelsEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReelsEmptyImplCopyWithImpl<$Res>
    extends _$ReelsStateCopyWithImpl<$Res, _$ReelsEmptyImpl>
    implements _$$ReelsEmptyImplCopyWith<$Res> {
  __$$ReelsEmptyImplCopyWithImpl(
    _$ReelsEmptyImpl _value,
    $Res Function(_$ReelsEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReelsEmptyImpl implements ReelsEmpty {
  const _$ReelsEmptyImpl();

  @override
  String toString() {
    return 'ReelsState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReelsEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )
    content,
    required TResult Function() empty,
    required TResult Function() error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult? Function()? empty,
    TResult? Function()? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult Function()? empty,
    TResult Function()? error,
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
    required TResult Function(ReelsLoading value) loading,
    required TResult Function(ReelsContent value) content,
    required TResult Function(ReelsEmpty value) empty,
    required TResult Function(ReelsError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReelsLoading value)? loading,
    TResult? Function(ReelsContent value)? content,
    TResult? Function(ReelsEmpty value)? empty,
    TResult? Function(ReelsError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReelsLoading value)? loading,
    TResult Function(ReelsContent value)? content,
    TResult Function(ReelsEmpty value)? empty,
    TResult Function(ReelsError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class ReelsEmpty implements ReelsState {
  const factory ReelsEmpty() = _$ReelsEmptyImpl;
}

/// @nodoc
abstract class _$$ReelsErrorImplCopyWith<$Res> {
  factory _$$ReelsErrorImplCopyWith(
    _$ReelsErrorImpl value,
    $Res Function(_$ReelsErrorImpl) then,
  ) = __$$ReelsErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReelsErrorImplCopyWithImpl<$Res>
    extends _$ReelsStateCopyWithImpl<$Res, _$ReelsErrorImpl>
    implements _$$ReelsErrorImplCopyWith<$Res> {
  __$$ReelsErrorImplCopyWithImpl(
    _$ReelsErrorImpl _value,
    $Res Function(_$ReelsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReelsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReelsErrorImpl implements ReelsError {
  const _$ReelsErrorImpl();

  @override
  String toString() {
    return 'ReelsState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReelsErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )
    content,
    required TResult Function() empty,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult? Function()? empty,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<ReelGame> games,
      int currentIndex,
      bool isLoadingMore,
      bool hasReachedEnd,
      Set<String> favouritingIds,
    )?
    content,
    TResult Function()? empty,
    TResult Function()? error,
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
    required TResult Function(ReelsLoading value) loading,
    required TResult Function(ReelsContent value) content,
    required TResult Function(ReelsEmpty value) empty,
    required TResult Function(ReelsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReelsLoading value)? loading,
    TResult? Function(ReelsContent value)? content,
    TResult? Function(ReelsEmpty value)? empty,
    TResult? Function(ReelsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReelsLoading value)? loading,
    TResult Function(ReelsContent value)? content,
    TResult Function(ReelsEmpty value)? empty,
    TResult Function(ReelsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ReelsError implements ReelsState {
  const factory ReelsError() = _$ReelsErrorImpl;
}
