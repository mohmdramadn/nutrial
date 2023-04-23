part of persistent_bottom_nav_bar_v2;

class PersistentBottomNavBar extends StatelessWidget {
  final EdgeInsets? margin;
  final bool? confineToSafeArea;
  final Widget Function(NavBarEssentials navBarEssentials)? customNavBarWidget;
  final bool? hideNavigationBar;
  final Function(bool, bool)? onAnimationComplete;
  final NeumorphicProperties? neumorphicProperties;
  final NavBarEssentials? navBarEssentials;
  final NavBarDecoration? navBarDecoration;
  final NavBarStyle? navBarStyle;
  final bool? isCustomWidget;

  const PersistentBottomNavBar({
    Key? key,
    this.margin,
    this.confineToSafeArea,
    this.customNavBarWidget,
    this.hideNavigationBar,
    this.onAnimationComplete,
    this.neumorphicProperties = const NeumorphicProperties(),
    this.navBarEssentials,
    this.navBarDecoration,
    this.navBarStyle,
    this.isCustomWidget = false,
  }) : super(key: key);

  Widget _navBarWidget() => Padding(
        padding: margin!,
        child: isCustomWidget!
            ? margin!.bottom > 0
                ? SafeArea(
                    top: false,
                    bottom: navBarEssentials!.navBarHeight == 0.0 ||
                            (hideNavigationBar ?? false)
                        ? false
                        : confineToSafeArea ?? true,
                    child: Container(
                      color: navBarEssentials!.backgroundColor,
                      height: navBarEssentials!.navBarHeight,
                      child:
                          customNavBarWidget?.call(navBarEssentials!),
                    ),
                  )
                : Container(
                    color: navBarEssentials!.backgroundColor,
                    child: SafeArea(
                      top: false,
                      bottom: navBarEssentials!.navBarHeight == 0.0 ||
                              (hideNavigationBar ?? false)
                          ? false
                          : confineToSafeArea ?? true,
                      child: SizedBox(
                        height: navBarEssentials!.navBarHeight,
                        child: customNavBarWidget
                            ?.call(navBarEssentials!),
                      ),
                    ),
                  )
            : navBarStyle == NavBarStyle.style15 ||
                    navBarStyle == NavBarStyle.style16
                ? margin!.bottom > 0
                    ? SafeArea(
                        top: false,
                        right: false,
                        left: false,
                        bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                (hideNavigationBar ?? false)
                            ? false
                            : confineToSafeArea ?? true,
                        child: Container(
                          decoration: getNavBarDecoration(
                            decoration: navBarDecoration,
                            color: navBarEssentials!.backgroundColor,
                            opacity: navBarEssentials!
                                .items![navBarEssentials!.selectedIndex!]
                                .opacity,
                          ),
                          child: getNavBarStyle(),
                        ),
                      )
                    : Container(
                        decoration: getNavBarDecoration(
                          decoration: navBarDecoration,
                          color: navBarEssentials!.backgroundColor,
                          opacity: navBarEssentials!
                              .items![navBarEssentials!.selectedIndex!]
                              .opacity,
                        ),
                        child: SafeArea(
                          top: false,
                          right: false,
                          left: false,
                          bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                  (hideNavigationBar ?? false)
                              ? false
                              : confineToSafeArea ?? true,
                          child: getNavBarStyle()!,
                        ),
                      )
                : Container(
                    decoration: getNavBarDecoration(
                      decoration: navBarDecoration,
                      showBorder: false,
                      color: navBarEssentials!.backgroundColor,
                      opacity: navBarEssentials!
                          .items![navBarEssentials!.selectedIndex!]
                          .opacity,
                    ),
                    child: ClipRRect(
                      borderRadius: navBarDecoration!.borderRadius ??
                          BorderRadius.zero,
                      child: BackdropFilter(
                        filter: navBarEssentials!
                                .items![navBarEssentials!.selectedIndex!]
                                .filter ??
                            ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          decoration: getNavBarDecoration(
                            showOpacity: false,
                            decoration: navBarDecoration,
                            color: navBarEssentials!.backgroundColor,
                            opacity: navBarEssentials!
                                .items![navBarEssentials!.selectedIndex!]
                                .opacity,
                          ),
                          child: SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            bottom:
                                navBarEssentials!.navBarHeight == 0.0 ||
                                        (hideNavigationBar ?? false)
                                    ? false
                                    : confineToSafeArea ?? true,
                            child: getNavBarStyle()!,
                          ),
                        ),
                      ),
                    ),
                  ),
      );

  @override
  Widget build(BuildContext context) {
    return hideNavigationBar == null
        ? _navBarWidget()
        : OffsetAnimation(
            hideNavigationBar: hideNavigationBar,
            navBarHeight: navBarEssentials!.navBarHeight,
            onAnimationComplete: (isAnimating, isComplete) {
              onAnimationComplete!(isAnimating, isComplete);
            },
            child: _navBarWidget(),
          );
  }

  PersistentBottomNavBar copyWith({
    EdgeInsets? margin,
    bool? confineToSafeArea,
    Widget Function(NavBarEssentials)? customNavBarWidget,
    bool? hideNavigationBar,
    Function(bool, bool)? onAnimationComplete,
    NeumorphicProperties? neumorphicProperties,
    NavBarEssentials? navBarEssentials,
    NavBarDecoration? navBarDecoration,
    NavBarStyle? navBarStyle,
    bool? isCustomWidget,
  }) =>
      PersistentBottomNavBar(
        margin: margin ?? this.margin,
        confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
        customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
        hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
        onAnimationComplete: onAnimationComplete ?? this.onAnimationComplete,
        neumorphicProperties: neumorphicProperties ?? this.neumorphicProperties,
        navBarEssentials: navBarEssentials ?? this.navBarEssentials,
        navBarDecoration: navBarDecoration ?? this.navBarDecoration,
        navBarStyle: navBarStyle ?? this.navBarStyle,
        isCustomWidget: isCustomWidget ?? this.isCustomWidget,
      );

  bool opaque(int? index) {
    return navBarEssentials!.items == null
        ? true
        : !(navBarEssentials!.items![index!].opacity < 1.0);
  }

  Widget? getNavBarStyle() {
    if (isCustomWidget!) {
      return customNavBarWidget?.call(navBarEssentials!);
    } else {
      switch (navBarStyle) {

        case NavBarStyle.style15:
          return BottomNavStyle15(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
        default:
          return BottomNavStyle15(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
      }
    }
  }
}
