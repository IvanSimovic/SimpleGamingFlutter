import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/core/theme/app_spacing.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_state.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';

const _cardAspectRatio = 0.75;

class FavouriteGamesScreen extends ConsumerWidget {
  const FavouriteGamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(favouriteGamesNotifierProvider);
    final gamesAsync = ref.watch(favouriteGamesProvider);

    final isSelecting = uiState is FavouriteGamesSelecting;
    final isDeleting = uiState is FavouriteGamesDeleting;
    final activeGameId = switch (uiState) {
      FavouriteGamesSelecting(:final gameId) => gameId,
      FavouriteGamesDeleting(:final gameId) => gameId,
      _ => null,
    };

    return PopScope(
      canPop: !isSelecting && !isDeleting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && isSelecting) {
          ref.read(favouriteGamesNotifierProvider.notifier).cancelSelection();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.navFavourites)),
        body: gamesAsync.when(
          loading: () => const _GameGridShimmer(),
          error: (_, __) => Center(
            child: Text(
              context.l10n.errorGeneric,
              style: context.typo.body1.copyWith(color: context.colors.error),
            ),
          ),
          data: (games) {
            if (games.isEmpty) {
              return Center(
                child: Text(
                  context.l10n.noFavourites,
                  style: context.typo.body1.copyWith(
                    color: context.colors.textMuted,
                  ),
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: _cardAspectRatio,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                final isTargeted = game.id == activeGameId;
                final isOtherSelected =
                    (isSelecting || isDeleting) && !isTargeted;
                return _FavouriteGameCard(
                  key: ValueKey(game.id),
                  game: game,
                  isTargeted: isTargeted,
                  isDeleting: isDeleting && isTargeted,
                  isOtherSelected: isOtherSelected,
                  onLongPress: (isSelecting || isDeleting)
                      ? null
                      : () => ref
                            .read(favouriteGamesNotifierProvider.notifier)
                            .onLongPress(game.id),
                  onDelete: () =>
                      ref.read(favouriteGamesNotifierProvider.notifier).delete(),
                  onCancel: () => ref
                      .read(favouriteGamesNotifierProvider.notifier)
                      .cancelSelection(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FavouriteGameCard extends StatefulWidget {
  const _FavouriteGameCard({
    super.key,
    required this.game,
    required this.isTargeted,
    required this.isDeleting,
    required this.isOtherSelected,
    required this.onLongPress,
    required this.onDelete,
    required this.onCancel,
  });

  final Game game;
  final bool isTargeted;
  final bool isDeleting;
  final bool isOtherSelected;
  final VoidCallback? onLongPress;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  State<_FavouriteGameCard> createState() => _FavouriteGameCardState();
}

class _FavouriteGameCardState extends State<_FavouriteGameCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void didUpdateWidget(_FavouriteGameCard old) {
    super.didUpdateWidget(old);
    if (widget.isTargeted && !old.isTargeted) {
      _shakeController.forward(from: 0);
    } else if (!widget.isTargeted) {
      _shakeController.stop();
      _shakeController.reset();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (_, child) => Transform.translate(
        // sin(value * 8π) = 4 full oscillations, always 0 at start and end
        offset: Offset(
          math.sin(_shakeController.value * math.pi * 8) * 8,
          0,
        ),
        child: child,
      ),
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.game.imageUrl.isEmpty
                  ? _FallbackGameCard(name: widget.game.name)
                  : CachedNetworkImage(
                      imageUrl: widget.game.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const _ShimmerBox(),
                      errorWidget: (_, __, ___) =>
                          _FallbackGameCard(name: widget.game.name),
                    ),
              AnimatedOpacity(
                opacity: widget.isOtherSelected ? 0.6 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const ColoredBox(color: Colors.black),
              ),
              if (widget.isTargeted)
                _DeleteOverlay(
                  isDeleting: widget.isDeleting,
                  onDelete: widget.onDelete,
                  onCancel: widget.onCancel,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteOverlay extends StatelessWidget {
  const _DeleteOverlay({
    required this.isDeleting,
    required this.onDelete,
    required this.onCancel,
  });

  final bool isDeleting;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    if (isDeleting) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      );
    }

    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(AppSpacing.xl),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Text(
                context.l10n.delete.toUpperCase(),
                style: context.typo.body2.copyWith(
                  color: const Color(0xFFEF5350),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: AppSpacing.md,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(AppSpacing.xl),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Text(
                  context.l10n.cancel.toUpperCase(),
                  style: context.typo.body2.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FallbackGameCard extends StatelessWidget {
  const _FallbackGameCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.colors.surfaceHigh,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Text(
          name,
          style: context.typo.body2.copyWith(color: context.colors.textMuted),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

class _GameGridShimmer extends StatelessWidget {
  const _GameGridShimmer();

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(AppSpacing.screenPadding),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: _cardAspectRatio,
    ),
    itemCount: 6,
    itemBuilder: (_, __) => ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Shimmer.fromColors(
        baseColor: context.colors.surfaceHigh,
        highlightColor: context.colors.divider,
        child: const ColoredBox(color: Colors.white),
      ),
    ),
  );
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox();

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: context.colors.surfaceHigh,
    highlightColor: context.colors.divider,
    child: const ColoredBox(color: Colors.white),
  );
}
