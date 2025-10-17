import { IconButtonModel } from './IconButtonModel'
import { productModel, profileInfo } from './productModel'


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


const productDataList: Array<productModel> = [
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '11月12'), $r('app.media.product1'), $r('app.string.content10'), 20, 10),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '10月21'), $r('app.media.product2'), $r('app.string.content1'), 9, 234),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '1月9'), $r('app.media.product3'), $r('app.string.content2'), 0, 0),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '9月20'), $r('app.media.product4'), $r('app.string.content3'), 899, 0),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '12月30'), $r('app.media.product5'), $r('app.string.content4'), 0, 2)
]


const productCollectDataList: Array<productModel> = [
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '5月21'), $r('app.media.product6'), $r('app.string.content9'), 20, 10),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '10月21'), $r('app.media.product7'), $r('app.string.content8'), 9, 234),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '1月9'), $r('app.media.product8'), $r('app.string.content7'), 0, 0),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '9月20'), $r('app.media.product9'), $r('app.string.content6'), 899, 0),
  new productModel(new profileInfo($r('app.media.avatar'), $r('app.string.nickName'), '12月30'), $r('app.media.product10'), $r('app.string.content5'), 0, 2)
]


export { memberButton, swiperImage,productDataList,productCollectDataList }