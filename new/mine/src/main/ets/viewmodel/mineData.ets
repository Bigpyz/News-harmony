import { IconButtonModel } from './IconButtonModel'


const memberButton: IconButtonModel[] = [
  new IconButtonModel($r('app.media.comment_Normal'), $r('app.string.focus_map_1'), 0, 99),
  new IconButtonModel($r('app.media.more_ask_icon_Normal'), $r('app.string.focus_map_2'), 1),
  new IconButtonModel($r('app.media.sixin_Normal'), $r('app.string.focus_map_3'), 2),
  new IconButtonModel($r('app.media.edit_list_icon_Normal'), $r('app.string.focus_map_4')),
  new IconButtonModel($r('app.media.digup_allshare_Normal'), $r('app.string.focus_map_5')),
  new IconButtonModel($r('app.media.Video_Normal'), $r('app.string.focus_map_6')),
  new IconButtonModel($r('app.media.boost_allshare_Normal'), $r('app.string.focus_map_7')),
  new IconButtonModel($r('app.media.airdrop_allshare_Normal'), $r('app.string.focus_map_8'))
]


const swiperImage: Resource[] = [
$r('app.media.1'),
$r('app.media.2'),
$r('app.media.3'),
]


export { memberButton, swiperImage }