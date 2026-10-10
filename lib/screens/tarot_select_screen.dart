import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/asset_icon.dart';

class TarotSelectScreen extends StatefulWidget {
  const TarotSelectScreen({super.key});

  static const routeName = '/tarot';

  @override
  State<TarotSelectScreen> createState() => _TarotSelectScreenState();
}

class _TarotSelectScreenState extends State<TarotSelectScreen> {
  /// Slot 0 filled in design; user selects remaining 2.
  final List<String?> _slots = ['assets/tarot/slot_past.png', null, null];
  int _activeSlot = 1;
  int _focusCard = 2;

  static const _deck = [
    'assets/tarot/card1.png',
    'assets/tarot/card2.png',
    'assets/tarot/card5.png',
    'assets/tarot/card3.png',
    'assets/tarot/card4.png',
  ];

  int get _selectedCount => _slots.where((s) => s != null).length;
  int get _remaining => 3 - _selectedCount;

  void _selectFocusedCard() {
    if (_activeSlot > 2 || _slots[_activeSlot] != null) return;
    setState(() {
      _slots[_activeSlot] = _deck[_focusCard];
      if (_activeSlot < 2) {
        _activeSlot++;
      }
    });
  }

  void _reshuffle() {
    setState(() {
      _slots[1] = null;
      _slots[2] = null;
      _activeSlot = 1;
      _focusCard = (_focusCard + 1) % _deck.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const _AmbientGlow(),
          SafeArea(
            child: Column(
              children: [
                const _AstraHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      children: [
                        const _SpiritualHeader(step: 1),
                        const SizedBox(height: 16),
                        _SpreadSlots(
                          slots: _slots,
                          activeSlot: _activeSlot,
                          onActiveTap: _selectFocusedCard,
                        ),
                        const SizedBox(height: 20),
                        _DeckSection(
                          deck: _deck,
                          focusIndex: _focusCard,
                          onFocusChanged: (i) => setState(() => _focusCard = i),
                          onCenterTap: _selectFocusedCard,
                        ),
                        const SizedBox(height: 12),
                        const _IntuitionPrompt(),
                        const SizedBox(height: 16),
                        _ActionBar(
                          remaining: _remaining,
                          onReshuffle: _reshuffle,
                        ),
                        const SizedBox(height: 12),
                        const _WisdomFooter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: -80,
            top: -128,
            child: _blob(384, AppColors.purple.withValues(alpha: 0.2)),
          ),
          Positioned(
            right: -96,
            top: 380,
            child: _blob(320, AppColors.magenta.withValues(alpha: 0.25)),
          ),
          Positioned(
            left: 98,
            bottom: 80,
            child: _blob(288, AppColors.cyanDeep.withValues(alpha: 0.15)),
          ),
          Positioned(left: 24, top: 112, child: _dot(6, AppColors.lavender, 0.6)),
          Positioned(right: 40, top: 240, child: _dot(8, AppColors.pink, 0.4)),
          Positioned(left: 48, top: 448, child: _dot(4, AppColors.cyan, 0.7)),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );

  Widget _dot(double size, Color color, double opacity) => Opacity(
        opacity: opacity,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      );
}

class _AstraHeader extends StatelessWidget {
  const _AstraHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lavender.withValues(alpha: 0.25),
                  blurRadius: 10,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const AssetIcon('assets/icons/astra_star.svg', width: 18, height: 18),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '아스트라',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ASTRA',
                      style: TextStyle(
                        color: AppColors.lavender,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Tarot Reading',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              children: [
                AssetIcon('assets/icons/bell.svg', width: 12, height: 11),
                SizedBox(width: 6),
                Text(
                  '신비한 타로 리딩',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 32,
                height: 32,
                color: AppColors.surfaceElevated,
                child: const Icon(Icons.person, size: 18, color: AppColors.lavender),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpiritualHeader extends StatelessWidget {
  const _SpiritualHeader({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetIcon('assets/icons/chevron.svg', width: 6, height: 11),
              SizedBox(width: 6),
              Text(
                '3-CARD SPREAD · 과거 · 현재 · 미래',
                style: TextStyle(
                  color: AppColors.lavender,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '마음속 질문을 떠올리고\n카드 3장을 선택하세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.7,
            height: 36 / 28,
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(
          width: 280,
          child: Text(
            '호흡을 가다듬고, 당신의 직관이 깊게 이끄는 카드를\n차례대로 터치해주세요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              letterSpacing: 0.12,
              height: 18 / 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(color: AppColors.lavender, size: 10, glow: true),
              const SizedBox(width: 6),
              _PulseDot(color: AppColors.pink, size: 10, glow: true),
              const SizedBox(width: 6),
              _PulseDot(color: AppColors.borderSoft, size: 8, glow: false),
              const SizedBox(width: 12),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                  children: [
                    const TextSpan(text: '진행 단계 '),
                    TextSpan(
                      text: '$step',
                      style: const TextStyle(
                        color: AppColors.lavender,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' / 3'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot({
    required this.color,
    required this.size,
    required this.glow,
  });

  final Color color;
  final double size;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: glow
            ? [BoxShadow(color: color.withValues(alpha: 0.85), blurRadius: 8)]
            : null,
      ),
    );
  }
}

class _SpreadSlots extends StatelessWidget {
  const _SpreadSlots({
    required this.slots,
    required this.activeSlot,
    required this.onActiveTap,
  });

  final List<String?> slots;
  final int activeSlot;
  final VoidCallback onActiveTap;

  _SlotState _stateFor(int index) {
    if (slots[index] != null) return _SlotState.done;
    if (index == activeSlot) return _SlotState.active;
    if (index > activeSlot) return _SlotState.pending;
    return _SlotState.idle;
  }

  String _badgeFor(_SlotState state) => switch (state) {
        _SlotState.done => '선택완료',
        _SlotState.active => '선택 중',
        _ => '대기 중',
      };

  @override
  Widget build(BuildContext context) {
    final s0 = _stateFor(0);
    final s1 = _stateFor(1);
    final s2 = _stateFor(2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SlotCard(
            state: s0,
            badge: _badgeFor(s0),
            title: 'I. 과거',
            subtitle: '발단의 기운',
            image: slots[0],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Transform.scale(
            scale: s1 == _SlotState.active ? 1.03 : 1,
            child: _SlotCard(
              state: s1,
              badge: _badgeFor(s1),
              title: 'II. 현재',
              subtitle: '당면한 흐름',
              image: slots[1],
              onTap: s1 == _SlotState.active ? onActiveTap : null,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Opacity(
            opacity: s2 == _SlotState.pending ? 0.8 : 1,
            child: _SlotCard(
              state: s2,
              badge: _badgeFor(s2),
              title: 'III. 미래',
              subtitle: '조언 및 결말',
              image: slots[2],
              pendingLabel: '3번째 선택',
              onTap: s2 == _SlotState.active ? onActiveTap : null,
            ),
          ),
        ),
      ],
    );
  }
}

enum _SlotState { done, active, pending, idle }

class _SlotCard extends StatelessWidget {
  const _SlotCard({
    required this.state,
    required this.badge,
    required this.title,
    required this.subtitle,
    this.image,
    this.onTap,
    this.pendingLabel,
  });

  final _SlotState state;
  final String badge;
  final String title;
  final String subtitle;
  final String? image;
  final VoidCallback? onTap;
  final String? pendingLabel;

  @override
  Widget build(BuildContext context) {
    final isActive = state == _SlotState.active;
    final bg = switch (state) {
      _SlotState.active => AppColors.borderSoft.withValues(alpha: 0.95),
      _SlotState.done => AppColors.surfaceElevated.withValues(alpha: 0.9),
      _ => AppColors.surfaceMuted.withValues(alpha: 0.5),
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.pink.withValues(alpha: 0.35),
                    blurRadius: 24,
                  ),
                ]
              : state == _SlotState.done
                  ? [
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: 0.18),
                        blurRadius: 20,
                      ),
                    ]
                  : null,
          border: isActive
              ? Border.all(color: AppColors.pink.withValues(alpha: 0.5), width: 1.5)
              : null,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _StatusBadge(label: badge, state: state),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _SlotBody(
                  state: state,
                  image: image,
                  pendingLabel: pendingLabel,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: isActive
                    ? AppColors.pink
                    : state == _SlotState.done
                        ? AppColors.lavender
                        : AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: state == _SlotState.pending
                    ? AppColors.textMuted
                    : AppColors.textSecondary,
                fontSize: 9,
                height: 13.5 / 9,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.state});

  final String label;
  final _SlotState state;

  @override
  Widget build(BuildContext context) {
    final bg = switch (state) {
      _SlotState.active => AppColors.magenta.withValues(alpha: 0.8),
      _SlotState.done => AppColors.purple.withValues(alpha: 0.3),
      _ => AppColors.surfaceElevated.withValues(alpha: 0.6),
    };
    final fg = switch (state) {
      _SlotState.active => AppColors.pinkSoft,
      _SlotState.done => AppColors.lavender,
      _ => AppColors.textSecondary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        boxShadow: state == _SlotState.active
            ? [
                BoxShadow(
                  color: const Color(0xFFFF93C8).withValues(alpha: 0.4),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state == _SlotState.done) ...[
            const AssetIcon('assets/icons/check.svg', width: 8, height: 8),
            const SizedBox(width: 2),
          ],
          if (state == _SlotState.active) ...[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.pinkSoft,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(color: fg, fontSize: 10, letterSpacing: 0.4),
          ),
        ],
      ),
    );
  }
}

class _SlotBody extends StatelessWidget {
  const _SlotBody({
    required this.state,
    this.image,
    this.pendingLabel,
  });

  final _SlotState state;
  final String? image;
  final String? pendingLabel;

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image!, fit: BoxFit.cover),
            const Positioned(
              top: 6,
              right: 6,
              child: AssetIcon('assets/icons/glint_card.svg', width: 8, height: 8),
            ),
          ],
        ),
      );
    }

    if (state == _SlotState.active) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.pink.withValues(alpha: 0.1),
              Colors.transparent,
              AppColors.lavender.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pink.withValues(alpha: 0.5),
                    blurRadius: 16,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const AssetIcon('assets/icons/hand.svg', width: 15, height: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              '터치하여 안치',
              style: TextStyle(color: AppColors.pinkSoft, fontSize: 10),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDeep.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AssetIcon('assets/icons/lock.svg', width: 12, height: 16),
          const SizedBox(height: 6),
          Text(
            pendingLabel ?? '대기',
            style: const TextStyle(color: AppColors.border, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _DeckSection extends StatelessWidget {
  const _DeckSection({
    required this.deck,
    required this.focusIndex,
    required this.onFocusChanged,
    required this.onCenterTap,
  });

  final List<String> deck;
  final int focusIndex;
  final ValueChanged<int> onFocusChanged;
  final VoidCallback onCenterTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const AssetIcon('assets/icons/deck_star.svg', width: 15, height: 15),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                '운명의 덱 (The Astral Deck)',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Row(
                children: [
                  AssetIcon('assets/icons/swipe.svg', width: 10, height: 11),
                  SizedBox(width: 4),
                  Text(
                    '좌우로 넘겨 선택',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              final v = details.primaryVelocity ?? 0;
              if (v < -100) {
                onFocusChanged((focusIndex + 1) % deck.length);
              } else if (v > 100) {
                onFocusChanged((focusIndex - 1 + deck.length) % deck.length);
              }
            },
            onTap: onCenterTap,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(deck.length, (i) {
                final offset = i - focusIndex;
                final abs = offset.abs();
                if (abs > 2) return const SizedBox.shrink();
                final angle = offset * 0.12;
                final dx = offset * 58.0;
                final dy = abs * 8.0;
                final scale = 1.0 - abs * 0.06;
                final isFocus = offset == 0;

                return Transform.translate(
                  offset: Offset(dx, dy),
                  child: Transform.rotate(
                    angle: angle,
                    child: Transform.scale(
                      scale: scale,
                      child: _FanCard(
                        image: deck[i],
                        elevated: isFocus,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _FanCard extends StatelessWidget {
  const _FanCard({required this.image, required this.elevated});

  final String image;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: elevated ? 110 : 105,
      height: elevated ? 170 : 162,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: elevated
            ? Border.all(color: AppColors.lavender.withValues(alpha: 0.7), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: elevated
                ? AppColors.lavender.withValues(alpha: 0.45)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: elevated ? 24 : 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            if (elevated)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'RESONANCE',
                      style: TextStyle(
                        color: AppColors.lavender,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _IntuitionPrompt extends StatelessWidget {
  const _IntuitionPrompt();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetIcon('assets/icons/heart_prompt.svg', width: 13, height: 13),
        SizedBox(width: 6),
        Text(
          '손끝에 전해지는 온기와 직관을 믿어보세요.',
          style: TextStyle(
            color: Color(0xE6CEC3D3),
            fontSize: 12,
            letterSpacing: -0.3,
            height: 18 / 12,
          ),
        ),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.remaining,
    required this.onReshuffle,
  });

  final int remaining;
  final VoidCallback onReshuffle;

  @override
  Widget build(BuildContext context) {
    final complete = remaining <= 0;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onReshuffle,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(
                    color: AppColors.border.withValues(alpha: 0.6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                icon: const AssetIcon('assets/icons/dice.svg', width: 14, height: 14),
                label: const Text(
                  '새로운 기운으로 덱 섞기',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const AssetIcon('assets/icons/help.svg', width: 17, height: 17),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: complete
                ? null
                : AppColors.surfaceElevated.withValues(alpha: 0.55),
            gradient: complete ? AppColors.ctaGradient : null,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetIcon(
                'assets/icons/hourglass.svg',
                width: 13,
                height: 17,
                color: complete ? AppColors.purpleDeep : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              if (complete)
                const Text(
                  '운명의 해석 열기',
                  style: TextStyle(
                    color: AppColors.purpleDeep,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: '카드 '),
                      TextSpan(
                        text: '$remaining장',
                        style: const TextStyle(
                          color: AppColors.pink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(text: '을 더 선택해주세요'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WisdomFooter extends StatelessWidget {
  const _WisdomFooter();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetIcon('assets/icons/quote.svg', width: 12, height: 11),
        SizedBox(width: 6),
        Flexible(
          child: Text(
            '직관이 머무는 곳에 이미 우주의 답이 숨 쉬고 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              height: 14 / 10,
            ),
          ),
        ),
      ],
    );
  }
}
