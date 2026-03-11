import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/core/theme/app_colors.dart';
import 'package:simple_gaming_flutter/core/theme/app_gradients.dart';
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
      backgroundColor: AppColors.mediaBackground,
      body: switch (state) {
        ReelsLoading() => const _FullScreenShimmer(),
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
        ReelsContent(:final games, :final favouritingIds) => PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) =>
              ref.read(reelsNotifierProvider.notifier).onPageChanged(index),
          itemCount: games.length,
          itemBuilder: (context, index) => _ReelPage(
            game: games[index],
            isFavourited: favouriteIds.contains(games[index].id),
            isFavouriting: favouritingIds.contains(games[index].id),
            onFavouriteTap: () => ref
                .read(reelsNotifierProvider.notifier)
                .toggleFavourite(games[index].id),
          ),
        ),
      },
    );
  }
}

class _ReelPage extends StatefulWidget {
  const _ReelPage({
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
  State<_ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<_ReelPage> {
  int? _selectedScreenshotIndex;

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Hero image — truly full screen.
        game.imageUrl.isEmpty
            ? const ColoredBox(color: AppColors.mediaBackground)
            : CachedNetworkImage(
                imageUrl: game.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const _FullScreenShimmer(),
                errorWidget: (_, __, ___) =>
                    const ColoredBox(color: AppColors.mediaBackground),
              ),
        // Top scrim — covers status bar area.
        const DecoratedBox(
          decoration: BoxDecoration(gradient: AppGradients.reelScrimTop),
        ),
        // Bottom scrim — covers info column area.
        const DecoratedBox(
          decoration: BoxDecoration(gradient: AppGradients.reelScrimBottom),
        ),
        // Favourite button — top-right, status bar aware.
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSpacing.md,
          right: AppSpacing.md,
          child: _FavouriteButton(
            isFavourited: widget.isFavourited,
            isFavouriting: widget.isFavouriting,
            onTap: widget.onFavouriteTap,
          ),
        ),
        // Back-button intercept when screenshot viewer is open.
        if (_selectedScreenshotIndex != null)
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (_, __) =>
                setState(() => _selectedScreenshotIndex = null),
            child: const SizedBox.shrink(),
          ),
        // Info column — bottom-start.
        Positioned(
          left: AppSpacing.screenPadding,
          right: AppSpacing.screenPadding,
          bottom: MediaQuery.of(context).padding.bottom + AppSpacing.lg,
          child: _GameInfoColumn(
            game: game,
            onScreenshotTap: (index) =>
                setState(() => _selectedScreenshotIndex = index),
          ),
        ),
        // Fullscreen screenshot viewer — rendered on top when active.
        if (_selectedScreenshotIndex != null)
          _FullScreenImageViewer(
            images: game.screenshots,
            initialIndex: _selectedScreenshotIndex!,
            onDismiss: () => setState(() => _selectedScreenshotIndex = null),
          ),
      ],
    );
  }
}

class _GameInfoColumn extends StatelessWidget {
  const _GameInfoColumn({required this.game, required this.onScreenshotTap});

  final ReelGame game;
  final void Function(int index) onScreenshotTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (game.metacritic != null || game.rating > 0) ...[
          _MetacriticRatingRow(
            metacritic: game.metacritic,
            rating: game.rating,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          game.name,
          style: context.typo.head4.copyWith(color: AppColors.onMedia),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (game.genres.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: game.genres
                .take(3)
                .map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: _Chip(label: g),
                  ),
                )
                .toList(),
          ),
        ],
        if (game.description.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            game.description,
            style: context.typo.body3.copyWith(color: AppColors.onMediaMuted),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (game.screenshots.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          _ScreenshotRow(screenshots: game.screenshots, onTap: onScreenshotTap),
        ],
        if (game.playtime > 0 || game.platforms.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlatformRow(playtime: game.playtime, platforms: game.platforms),
        ],
      ],
    );
  }
}

class _MetacriticRatingRow extends StatelessWidget {
  const _MetacriticRatingRow({required this.metacritic, required this.rating});

  final int? metacritic;
  final double rating;

  @override
  Widget build(BuildContext context) {
    if (metacritic == null && rating <= 0) return const SizedBox.shrink();
    return Row(
      children: [
        if (metacritic != null) ...[
          _MetacriticBadge(score: metacritic!),
          const SizedBox(width: AppSpacing.md),
        ],
        if (rating > 0)
          Text(
            '★ ${rating.toStringAsFixed(1)}',
            style: context.typo.body2.copyWith(color: AppColors.onMedia),
          ),
      ],
    );
  }
}

class _MetacriticBadge extends StatelessWidget {
  const _MetacriticBadge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final color = switch (score) {
      >= 75 => AppColors.scoreGood,
      >= 50 => AppColors.scoreMixed,
      _ => AppColors.scoreBad,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.xs),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          score.toString(),
          style: context.typo.body6.copyWith(color: AppColors.onMedia),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.onMediaChip,
      borderRadius: BorderRadius.circular(AppSpacing.xl),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        label,
        style: context.typo.body3.copyWith(color: AppColors.onMedia),
      ),
    ),
  );
}

class _ScreenshotRow extends StatelessWidget {
  const _ScreenshotRow({required this.screenshots, required this.onTap});

  final List<String> screenshots;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 68,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: screenshots.length,
      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => onTap(index),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          child: CachedNetworkImage(
            imageUrl: screenshots[index],
            width: 120,
            height: 68,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

class _PlatformRow extends StatelessWidget {
  const _PlatformRow({required this.playtime, required this.platforms});

  final int playtime;
  final List<String> platforms;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.md,
    runSpacing: AppSpacing.xs,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      if (playtime > 0)
        Text(
          '🕹 ${playtime}h',
          style: context.typo.body3.copyWith(color: AppColors.onMediaSubtle),
        ),
      ...platforms.take(4).map((p) => _Chip(label: p)),
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
    label: isFavourited
        ? context.l10n.reelsRemoveFromFavourites
        : context.l10n.reelsAddToFavourites,
    button: true,
    child: GestureDetector(
      onTap: isFavouriting ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: const BoxDecoration(
          color: AppColors.overlayActionButton,
          shape: BoxShape.circle,
        ),
        child: isFavouriting
            ? SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.colors.brandPrimary,
                ),
              )
            : Icon(
                isFavourited ? Icons.favorite : Icons.favorite_border,
                color: isFavourited ? context.colors.error : AppColors.onMedia,
                size: 28,
              ),
      ),
    ),
  );
}

class _FullScreenImageViewer extends StatefulWidget {
  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
    required this.onDismiss,
  });

  final List<String> images;
  final int initialIndex;
  final VoidCallback onDismiss;

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: widget.onDismiss,
    child: ColoredBox(
      color: AppColors.mediaViewerBackground,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        itemBuilder: (context, index) => CachedNetworkImage(
          imageUrl: widget.images[index],
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

class _FullScreenShimmer extends StatelessWidget {
  const _FullScreenShimmer();

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: AppColors.mediaShimmerBase,
    highlightColor: AppColors.mediaShimmerHighlight,
    child: const ColoredBox(color: AppColors.mediaShimmerBase),
  );
}
