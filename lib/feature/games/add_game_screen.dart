import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gaming_flutter/core/components/app_text_field.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/core/theme/app_spacing.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_state.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';

const _cardAspectRatio = 0.75;

class AddGameScreen extends ConsumerStatefulWidget {
  const AddGameScreen({super.key, required this.onNavigateBack});

  final VoidCallback onNavigateBack;

  @override
  ConsumerState<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends ConsumerState<AddGameScreen> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addGameNotifierProvider);

    ref.listen<AddGameState>(addGameNotifierProvider, (_, next) {
      if (next is AddGameAdded) widget.onNavigateBack();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addGameTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onNavigateBack,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: AppTextField(
              value: _query,
              onChanged: (q) {
                setState(() => _query = q);
                ref.read(addGameNotifierProvider.notifier).onQueryChanged(q);
              },
              label: context.l10n.search,
            ),
          ),
          Expanded(
            child: switch (state) {
              AddGameIdle() => const SizedBox.shrink(),
              AddGameLoading() => const _GameGridShimmer(),
              AddGameContent(:final results) => _SearchResultGrid(
                results: results,
                onGameSelected: (game) =>
                    ref.read(addGameNotifierProvider.notifier).addGame(game),
              ),
              AddGameEmpty() => Center(
                child: Text(
                  context.l10n.noResults,
                  style: context.typo.body1.copyWith(
                    color: context.colors.textMuted,
                  ),
                ),
              ),
              AddGameError() => Center(
                child: Text(
                  context.l10n.errorGeneric,
                  style: context.typo.body1.copyWith(
                    color: context.colors.error,
                  ),
                ),
              ),
              AddGameAdded() => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }
}

class _SearchResultGrid extends StatelessWidget {
  const _SearchResultGrid({
    required this.results,
    required this.onGameSelected,
  });

  final List<Game> results;
  final ValueChanged<Game> onGameSelected;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(AppSpacing.screenPadding),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: _cardAspectRatio,
    ),
    itemCount: results.length,
    itemBuilder: (context, index) => _GameCard(
      game: results[index],
      onTap: () => onGameSelected(results[index]),
    ),
  );
}

class _GameCard extends StatelessWidget {
  const _GameCard({required this.game, required this.onTap});

  final Game game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    ),
    child: InkWell(
      onTap: onTap,
      child: game.imageUrl.isEmpty
          ? _FallbackGameCard(name: game.name)
          : CachedNetworkImage(
              imageUrl: game.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const _ShimmerBox(),
              errorWidget: (_, __, ___) => _FallbackGameCard(name: game.name),
            ),
    ),
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
