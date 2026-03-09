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

class FavouriteGamesScreen extends ConsumerStatefulWidget {
  const FavouriteGamesScreen({super.key});

  @override
  ConsumerState<FavouriteGamesScreen> createState() =>
      _FavouriteGamesScreenState();
}

class _FavouriteGamesScreenState extends ConsumerState<FavouriteGamesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _shakeAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(favouriteGamesNotifierProvider);
    final gamesAsync = ref.watch(favouriteGamesProvider);

    ref.listen<FavouriteGamesState>(favouriteGamesNotifierProvider, (_, next) {
      if (next is FavouriteGamesSelecting) {
        if (!_shakeController.isAnimating) _shakeController.repeat(reverse: true);
      } else {
        _shakeController
          ..stop()
          ..reset();
      }
    });

    final isSelecting = uiState is FavouriteGamesSelecting;
    final isDeleting = uiState is FavouriteGamesDeleting;
    final selectedIds =
        uiState is FavouriteGamesSelecting ? uiState.selectedIds : const <String>{};

    return PopScope(
      canPop: !isSelecting && !isDeleting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && isSelecting) {
          ref.read(favouriteGamesNotifierProvider.notifier).cancelSelection();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.navFavourites),
          leading: isSelecting
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed:
                      ref.read(favouriteGamesNotifierProvider.notifier).cancelSelection,
                )
              : null,
          actions: [
            if (isSelecting)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed:
                    ref.read(favouriteGamesNotifierProvider.notifier).deleteSelected,
              )
            else if (isDeleting)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
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
                  style: context.typo.body1
                      .copyWith(color: context.colors.textMuted),
                ),
              );
            }
            return AbsorbPointer(
              absorbing: isDeleting,
              child: GridView.builder(
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
                return _FavouriteGameCard(
                  game: game,
                  isSelecting: isSelecting,
                  isSelected: selectedIds.contains(game.id),
                  shakeAnimation: _shakeAnimation,
                  index: index,
                  onTap: () =>
                      ref.read(favouriteGamesNotifierProvider.notifier).onTap(game.id),
                  onLongPress: () => ref
                      .read(favouriteGamesNotifierProvider.notifier)
                      .onLongPress(game.id),
                );
              },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FavouriteGameCard extends StatelessWidget {
  const _FavouriteGameCard({
    required this.game,
    required this.isSelecting,
    required this.isSelected,
    required this.shakeAnimation,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });

  final Game game;
  final bool isSelecting;
  final bool isSelected;
  final Animation<double> shakeAnimation;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: isSelecting ? null : onLongPress,
        child: Stack(
          fit: StackFit.expand,
          children: [
            game.imageUrl.isEmpty
                ? _FallbackGameCard(name: game.name)
                : CachedNetworkImage(
                    imageUrl: game.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const _ShimmerBox(),
                    errorWidget: (_, __, ___) =>
                        _FallbackGameCard(name: game.name),
                  ),
            if (isSelecting) _SelectionOverlay(isSelected: isSelected),
          ],
        ),
      ),
    );

    if (!isSelecting) return card;

    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (_, child) => Transform.rotate(
        angle: shakeAnimation.value * (index.isEven ? 1 : -1),
        child: child,
      ),
      child: card,
    );
  }
}

class _SelectionOverlay extends StatelessWidget {
  const _SelectionOverlay({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: isSelected
            ? context.colors.brandPrimary.withOpacity(0.5)
            : Colors.black.withOpacity(0.3),
        child: isSelected
            ? const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: Icon(Icons.check_circle, color: Colors.white),
                ),
              )
            : null,
      );
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
              style:
                  context.typo.body2.copyWith(color: context.colors.textMuted),
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
