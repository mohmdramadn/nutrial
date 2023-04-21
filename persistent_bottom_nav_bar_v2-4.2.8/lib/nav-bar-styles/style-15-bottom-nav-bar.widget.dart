part of persistent_bottom_nav_bar_v2;

class BottomNavStyle15 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;
  final NavBarDecoration? navBarDecoration;

  const BottomNavStyle15({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
    this.navBarDecoration = const NavBarDecoration(),
  }) : super(key: key);

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return navBarEssentials!.navBarHeight == 0
        ? const SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
            color: isSelected
                ? (item.activeColorSecondary ?? item.activeColorPrimary)
                : item.inactiveColorPrimary ?? item.activeColorPrimary,
            padding: EdgeInsets.only(
                top: navBarEssentials!.padding?.top ??
                    navBarEssentials!.navBarHeight! * 0.15,
                bottom: navBarEssentials!.padding?.bottom ??
                    navBarEssentials!.navBarHeight! * 0.12),
            child: Container(
              alignment: Alignment.center,
              height: height,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: IconTheme(
                          data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? (item.activeColorSecondary ??
                                      item.activeColorPrimary)
                                  : item.inactiveColorPrimary ??
                                      item.activeColorPrimary),
                          child: isSelected
                              ? item.icon
                              : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                      item.title == null
                          ? const SizedBox.shrink()
                          : Material(
                              type: MaterialType.transparency,
                              child: FittedBox(
                                  child: Text(
                                item.title!,
                                style: item.textStyle != null
                                    ? (item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorSecondary ??
                                                item.activeColorPrimary)
                                            : item.inactiveColorPrimary))
                                    : TextStyle(
                                        color: isSelected
                                            ? (item.activeColorSecondary ??
                                                item.activeColorPrimary)
                                            : item.inactiveColorPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0),
                              )),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  Widget _buildMiddleItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return navBarEssentials!.navBarHeight == 0
        ? const SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(
                top: navBarEssentials!.padding?.top ?? 0.0,
                bottom: navBarEssentials!.padding?.bottom ?? 0.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Center(
                    child: Container(
                      width: 60.0,
                      height: 150,
                      margin: const EdgeInsets.only(top: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: isSelected
                            ? (item.activeColorSecondary ??
                                item.activeColorPrimary)
                            : item.inactiveColorPrimary ??
                                item.activeColorPrimary,
                        border:
                            Border.all(color: Colors.transparent, width: 5.0),
                        boxShadow: navBarDecoration!.boxShadow,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: IconTheme(
                          data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? item.activeColorSecondary ??
                                      item.activeColorPrimary
                                  : item.inactiveColorPrimary ??
                                      item.inactiveColorSecondary),
                          child: isSelected
                              ? item.icon
                              : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                    ),
                  ),
                ),
                item.title == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                                child: Text(
                              item.title!,
                              style: item.textStyle != null
                                  ? (item.textStyle!.apply(
                                      color: isSelected
                                          ? (item.activeColorSecondary ??
                                              item.activeColorPrimary)
                                          : item.inactiveColorPrimary ??
                                              item.inactiveColorSecondary))
                                  : TextStyle(
                                      color: isSelected
                                          ? (item.activeColorPrimary)
                                          : item.inactiveColorPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                            )),
                          ),
                        ),
                      )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final midIndex = (navBarEssentials!.items!.length / 2).floor();
    return SizedBox(
      width: double.infinity,
      height: navBarEssentials!.navBarHeight,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: navBarDecoration!.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: navBarEssentials!
                      .items![navBarEssentials!.selectedIndex!].filter ??
                  ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: navBarEssentials!.items!.map((item) {
                  int index = navBarEssentials!.items!.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (navBarEssentials!.items![index].onPressed != null) {
                          navBarEssentials!.items![index].onPressed!(
                              navBarEssentials!.selectedScreenBuildContext);
                        } else {
                          navBarEssentials!.onItemSelected!(index);
                        }
                      },
                      child: index == midIndex
                          ? Container(width: 150, color: Colors.transparent)
                          : _buildItem(
                              item,
                              navBarEssentials!.selectedIndex == index,
                              navBarEssentials!.navBarHeight),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          navBarEssentials!.navBarHeight == 0
              ? const SizedBox.shrink()
              : Center(
                  child: GestureDetector(
                      onTap: () {
                        if (navBarEssentials!.items![midIndex].onPressed !=
                            null) {
                          navBarEssentials!.items![midIndex].onPressed!(
                              navBarEssentials!.selectedScreenBuildContext);
                        } else {
                          navBarEssentials!.onItemSelected!(midIndex);
                        }
                      },
                      child: _buildMiddleItem(
                          navBarEssentials!.items![midIndex],
                          navBarEssentials!.selectedIndex == midIndex,
                          navBarEssentials!.navBarHeight)),
                )
        ],
      ),
    );
  }
}
