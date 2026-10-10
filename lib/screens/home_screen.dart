import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../widgets/asset_icon.dart';
import '../widgets/oracle_seal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onDrawFortune});

  static const routeName = '/home';

  final VoidCallback? onDrawFortune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.55,
                child: SvgPicture.asset(
                  'assets/icons/starlight.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: [
                  const _DateCapsule(),
                  const SizedBox(height: 8),
                  const _TitleBlock(),
                  const SizedBox(height: 20),
                  const _FortuneCard(),
                  const SizedBox(height: 20),
                  _DrawFortuneButton(onPressed: onDrawFortune),
                  const SizedBox(height: 10),
                  const _ResetHint(),
                  const SizedBox(height: 16),
                  const _GuidanceBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateCapsule extends StatelessWidget {
  const _DateCapsule();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.pink,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'COSMIC FLOW',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '·',
            style: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.4),
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            '2024년 10월 24일 목요일',
            style: TextStyle(
              color: AppColors.lavender,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AssetIcon('assets/icons/bracket_l.svg', width: 9, height: 15),
            const SizedBox(width: 6),
            const Text(
              '우주가 전하는 오늘의 메시지',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.55,
                height: 30 / 22,
              ),
            ),
            const SizedBox(width: 6),
            const AssetIcon('assets/icons/sparkle_title.svg', width: 17, height: 17),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          '영혼의 주파수가 성운과 공명하는 찬란한 아침입니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            letterSpacing: 0.12,
            height: 18 / 12,
          ),
        ),
      ],
    );
  }
}

class _FortuneCard extends StatelessWidget {
  const _FortuneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -96,
            right: -64,
            child: _GlowBlob(
              size: 224,
              color: AppColors.magenta.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -48,
            child: _GlowBlob(
              size: 208,
              color: AppColors.purple.withValues(alpha: 0.25),
            ),
          ),
          const Column(
            children: [
              SizedBox(height: 8),
              OracleSeal(),
              SizedBox(height: 12),
              _ArchetypeLabel(),
              SizedBox(height: 4),
              Text(
                '오늘의 총운: 반짝이는 영감의 날',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.45,
                  height: 26 / 18,
                ),
              ),
              SizedBox(height: 16),
              _ScoreBar(),
              SizedBox(height: 12),
              Text(
                '“예상치 못한 순간에 뜻밖의 행운과 통찰이 찾아옵니다.\n'
                '마음 깊은 곳의 직관을 믿고 새로운 기회를\n'
                '향해 담대히 한 걸음 나아가세요.”',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  height: 22.75 / 14,
                ),
              ),
              SizedBox(height: 16),
              _StarDivider(),
              SizedBox(height: 12),
              _InsightBadge(
                icon: 'assets/icons/heart.svg',
                iconBg: Color(0x6685145A),
                label: '애정운',
                labelColor: AppColors.pinkSoft,
                detail: '설레는 대화와 따스한 조화',
                pill: '95%',
                pillBg: Color(0x8085145A),
                pillColor: AppColors.pink,
              ),
              SizedBox(height: 8),
              _InsightBadge(
                icon: 'assets/icons/coin.svg',
                iconBg: Color(0x4D0EABE5),
                label: '재물운',
                labelColor: AppColors.cyan,
                detail: '신중한 판단이 큰 결실을 맺음',
                pill: '88%',
                pillBg: Color(0x4D0EABE5),
                pillColor: AppColors.cyan,
              ),
              SizedBox(height: 8),
              _InsightBadge(
                icon: 'assets/icons/sun.svg',
                iconBg: Color(0x4DC084FC),
                label: '행운의 요소',
                labelColor: AppColors.lavender,
                detail: '라벤더 퍼플 · 행운의 수 7 · 북쪽',
                trailingIcon: 'assets/icons/sparkle_sm.svg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _ArchetypeLabel extends StatelessWidget {
  const _ArchetypeLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ORACLE ARCH',
          style: TextStyle(
            color: AppColors.pink,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          '제 7영역의 각성',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.surfaceElevated,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const AssetIcon('assets/icons/chart.svg', width: 18, height: 14),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '영성 조화 지수',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    letterSpacing: 0.8,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '94점',
                      style: TextStyle(
                        color: AppColors.lavender,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.28,
                      ),
                    ),
                    SizedBox(width: 4),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        '/ 100',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: List.generate(5, (i) {
                  final asset = i < 4
                      ? 'assets/icons/star_full.svg'
                      : 'assets/icons/star_half.svg';
                  return Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: AssetIcon(asset, width: 15, height: 14),
                  );
                }),
              ),
              const SizedBox(height: 2),
              const Text(
                '최상의 길운기류',
                style: TextStyle(
                  color: AppColors.pink,
                  fontSize: 10,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarDivider extends StatelessWidget {
  const _StarDivider();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, AppColors.border],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const AssetIcon('assets/icons/divider_star.svg', width: 10, height: 9),
          const SizedBox(width: 8),
          Container(
            width: 64,
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.border, Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightBadge extends StatelessWidget {
  const _InsightBadge({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.labelColor,
    required this.detail,
    this.pill,
    this.pillBg,
    this.pillColor,
    this.trailingIcon,
  });

  final String icon;
  final Color iconBg;
  final String label;
  final Color labelColor;
  final String detail;
  final String? pill;
  final Color? pillBg;
  final Color? pillColor;
  final String? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: AssetIcon(icon, width: 14, height: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 10,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    letterSpacing: 0.12,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
          ),
          if (pill != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: pillBg,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                pill!,
                style: TextStyle(
                  color: pillColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          if (trailingIcon != null)
            AssetIcon(trailingIcon!, width: 15, height: 15),
        ],
      ),
    );
  }
}

class _DrawFortuneButton extends StatelessWidget {
  const _DrawFortuneButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.ctaGradient,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.35),
                blurRadius: 28,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetIcon('assets/icons/cta_sparkle.svg', width: 20, height: 20),
              SizedBox(width: 8),
              Text(
                '새로운 오늘의 운세 뽑기',
                style: TextStyle(
                  color: AppColors.purpleDeep,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.45,
                ),
              ),
              SizedBox(width: 8),
              AssetIcon('assets/icons/arrow.svg', width: 13, height: 13),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResetHint extends StatelessWidget {
  const _ResetHint();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetIcon('assets/icons/reset.svg', width: 13, height: 9),
        SizedBox(width: 6),
        Text(
          '하루 1회 무료 리셋 가능 · 성운의 카드 셔플',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class _GuidanceBar extends StatelessWidget {
  const _GuidanceBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.borderSoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const AssetIcon('assets/icons/meditate.svg', width: 14, height: 12),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              '오늘 저녁 9시 30분, 밤하늘 달의 기운이 가장 맑아지는\n시간에 명상과 함께 소원을 빌어보세요.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                letterSpacing: 0.12,
                height: 15 / 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
