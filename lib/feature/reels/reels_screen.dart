import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/core/theme/app_spacing.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_providers.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_state.dart';

class ReelsScreen extends ConsumerStatefulWidget {
  const ReelsScreen({super.key});

  @override
  ConsumerState<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends ConsumerState<ReelsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reelsNotifierProvider);
    final favouriteIds = ref.watch(favouriteGameIdsProvider);

    return Scaffold(
      backgroundColor: context.colors.surfaceDeep,
      body: switch (state) {
        ReelsLoading() => const Center(child: CircularProgressIndicator()),
        ReelsError() => Center(
          child: Text(
            context.l10n.errorGeneric,
            style: context.typo.body1.copyWith(color: context.colors.error),
          ),
        ),
        ReelsEmpty() => Center(
          child: Text(
            context.l10n.reelsEmpty,
            style: context.typo.body1.copyWith(color: context.colors.textMuted),
          ),
        ),
        ReelsContent(
          :final games,
          :final isLoadingMore,
          :final favouritingIds,
        ) =>
          Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) => ref
                    .read(reelsNotifierProvider.notifier)
                    .onPageChanged(index),
                itemCount: games.length,
                itemBuilder: (context, index) => _ReelCard(
                  game: games[index],
                  isFavourited: favouriteIds.contains(games[index].id),
                  isFavouriting: favouritingIds.contains(games[index].id),
                  onFavouriteTap: () => ref
                      .read(reelsNotifierProvider.notifier)
                      .toggleFavourite(games[index].id),
                ),
              ),
              if (isLoadingMore)
                Positioned(
                  bottom: AppSpacing.xl,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: context.colors.brandPrimary,
                    ),
                  ),
                ),
            ],
          ),
      },
    );
  }
}

class _ReelCard extends StatelessWidget {
  const _ReelCard({
    required this.game,
    required this.isFavourited,
    required this.isFavouriting,
    required this.onFavouriteTap,
  });

  final ReelGame game;
  final bool isFavourited;
  final bool isFavouriting;
  final VoidCallback onFavouriteTap;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      // Background image — truly full screen, no safe area applied here.
      game.imageUrl.isEmpty
          ? ColoredBox(color: context.colors.surfaceHigh)
          : CachedNetworkImage(imageUrl: game.imageUrl, fit: BoxFit.cover),
      // Gradient overlay for content legibility.
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black87],
            stops: [0.4, 1.0],
          ),
        ),
      ),
      // Content — respects safe area so text stays clear of status bar
      // and home indicator on notched devices.
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Favourite button anchored to top-right within safe area.
              Align(
                alignment: Alignment.topRight,
                child: _FavouriteButton(
                  isFavourited: isFavourited,
                  isFavouriting: isFavouriting,
                  onTap: onFavouriteTap,
                ),
              ),
              const Spacer(),
              Text(
                game.name,
                style: context.typo.head3.copyWith(
                  color: context.colors.textMain,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (game.rating > 0) ...[
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: context.colors.warning,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      game.rating.toStringAsFixed(1),
                      style: context.typo.body2.copyWith(
                        color: context.colors.textMain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (game.genres.isNotEmpty)
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: game.genres
                      .take(3)
                      .map((g) => _GenreChip(label: g))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton({
    required this.isFavourited,
    required this.isFavouriting,
    required this.onTap,
  });

  final bool isFavourited;
  final bool isFavouriting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    label: isFavourited ? 'Remove from favourites' : 'Add to favourites',
    button: true,
    child: GestureDetector(
      onTap: isFavouriting ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: isFavouriting
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.colors.brandPrimary,
                ),
              )
            : Icon(
                isFavourited ? Icons.favorite : Icons.favorite_border,
                color: isFavourited
                    ? context.colors.error
                    : context.colors.textMain,
                size: 24,
              ),
      ),
    ),
  );
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
    ),
    child: Text(
      label,
      style: context.typo.body7.copyWith(color: context.colors.textMain),
    ),
  );
}
