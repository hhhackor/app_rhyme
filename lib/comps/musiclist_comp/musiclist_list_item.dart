import 'package:app_rhyme/comps/chores/badge.dart';
import 'package:app_rhyme/comps/musiclist_comp/musiclist_pulldown_menu.dart';
import 'package:app_rhyme/src/rust/api/type_bind.dart';
import 'package:app_rhyme/utils/cache_helper.dart';
import 'package:app_rhyme/utils/colors.dart';
import 'package:app_rhyme/utils/source_helper.dart';
import 'package:flutter/cupertino.dart';

class MusicListListItem extends StatelessWidget {
  final MusicListW musicListW;
  final bool online;
  final bool? isDark; // Make it nullable to support theme adaptation
  final GestureTapCallback? onTap;

  const MusicListListItem({
    super.key,
    required this.musicListW,
    required this.online,
    this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var musicListInfo = musicListW.getMusiclistInfo();

    // 获取当前主题的亮度
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = isDark ?? (brightness == Brightness.dark);

    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          // 歌单的封面
          CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            onPressed: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageCacheHelper(
                musicListInfo.artPic,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 歌单的名称和介绍
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    musicListInfo.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? CupertinoColors.systemGrey5
                          : CupertinoColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    musicListInfo.desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode
                          ? CupertinoColors.systemGrey4
                          : CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 标志音乐信息来源的Badge
          Badge(
            label: sourceToShort(musicListW.source()),
          ),
          // 歌曲的操作按钮
          MusicListMenu(
            musicListW: musicListW,
            builder: (_, showMenu) => CupertinoButton(
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.ellipsis,
                color: isDarkMode ? CupertinoColors.white : activeIconRed,
              ),
            ),
            online: online,
          ),
        ],
      ),
    );
  }
}
