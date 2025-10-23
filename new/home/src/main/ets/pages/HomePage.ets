import { ResManager, StyleConstants } from "common"
import CategoryTabBar from '../view/CategoryTabbar'
import router from '@ohos.router'


const searchSwiper: string[] = [
  '羽绒服跌下神坛了吗',
  '打通经济社会发展',
  "以国之名 接英雄回家",
  "马航MH370"
]

@Entry
@Component
export struct HomePage {

  @State needChange:boolean = false;
  @State searchKeyword: string = '';  // 搜索关键词状态
  @Builder
  SearchTitle() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      // 搜索输入框
      Row() {
        Image($r('app.media.topbar_isolated_search_icon_Normal'))
          .width($r('app.float.vp_twenty'))
          .height($r('app.float.vp_twenty'))
          .margin({
            left: $r('app.float.vp_twelve'),
            right: $r('app.float.vp_eight')
          })

        TextInput({ placeholder: '搜索新闻...', text: this.searchKeyword })
          .fontSize($r('app.float.small_font_size'))
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .border({ width: 0 })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.searchKeyword = value;
          })
          .onSubmit(() => {
            // 按回车键时触发搜索
            console.log('搜索关键词:', this.searchKeyword);
          })
      }
      .width('100%') // 占据全部宽度
      .height($r('app.float.search_swiper_height'))
      .borderRadius($r('app.float.vp_twenty'))
      .backgroundColor(Color.White)
    }
    .width(StyleConstants.FULL_WIDTH)
    .padding(10)
    .backgroundColor(ResManager.getDefaultColor())
  }

  build() {

    Stack({ alignContent: Alignment.Top }) {
      // 底层：放置TabBar，并使用Blank()为其顶部留出搜索栏的空间
      Column() {
        Blank().height(60) // 预留出搜索栏的高度
        CategoryTabBar({ needChange: $needChange, searchKeyword: $searchKeyword })
      }

      // 顶层：放置搜索栏，确保它在最上层接收点击事件
      this.SearchTitle()
    }
    .backgroundColor(this.needChange ? ResManager.getDefaultColor() : Color.White)

  }
}