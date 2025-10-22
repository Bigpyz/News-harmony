import { iconDockView, otherView } from '../view/otherView'
import { BarSelectStyle, TabBarLayout } from '../view/TabBarLayout'
import { navBarView, topBackgroundView } from '../view/topBackgroundView'
import { memberButton, swiperImage } from '../viewmodel/mineData'
import { MainRouter } from '../view/MainRouter'
import { PublishContentItem } from '../view/PublishContentItem'
import { PublishContent } from '../view/PublishPage'

@Entry
@Component
export struct MinePage {
  @LocalStorageLink('currentPage') currentPage: string = 'main'
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  scroller: Scroller = new Scroller()
  @State colorNavBar: string = 'rgba(255,255,255,0)'
  @State offsetY: number = 0
  @State opNav: number = 0;
  @State scaleValue: number = 1
  private scrollY: number = 0
  @State headerHeight: number = (250 + 150 + 130 + 110 + 5)
  navHeight: number = 56;
  @StorageLink('publishContents') publishContents: PublishContent[] = []

  // 加载发布内容
  loadPublishContents() {
    const contents = AppStorage.get('publishContents') as PublishContent[] || []
    this.publishContents = contents
  }

  aboutToAppear() {
    // 如果没有发布内容，添加一些示例数据
    if (this.publishContents.length === 0) {
      this.addSampleData()
    }
  }

  // 添加示例数据
  addSampleData() {
    const sampleContents: PublishContent[] = [
      {
        id: '1',
        text: '人不是为了世界而生存的,而是人所生存之地,才称之为世界。——',
        publishTime: '11月12日',
        username: '大眼萌机器人',
        avatar: $r('app.media.avatar')
      }
    ]
    AppStorage.set('publishContents', sampleContents)
  }

  @Builder
  CustomSwiper() {
    Swiper() {
      ForEach(swiperImage, (item: Resource) => {
        Image(item)
          .width('100%')
          .objectFit(ImageFit.Cover)
          .backgroundColor(Color.White)
      }, (item: Resource) => JSON.stringify(item))
    }
    .autoPlay(true)
    .indicatorStyle({ selectedColor: Color.White, right: 10 })
    .height(100)
    .margin({ left: 15, right: 15, bottom: 10 })
  }

  // 构建发布内容展示
  @Builder
  buildPublishContents() {
    if (this.publishContents.length > 0) {
      Column() {
        // 标题
        Row() {
          Text('我的动态')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')

          Blank()

          Text(`${this.publishContents.length}条`)
            .fontSize(12)
            .fontColor('#64748B')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 12 })

        // 发布内容列表
        ForEach(this.publishContents, (content: PublishContent) => {
          PublishContentItem({ content: content })
        }, (content: PublishContent) => content.id)
      }
      .width('100%')
      .backgroundColor('#F8FAFC')
    } else {
      // 空状态
      Column() {
        Image($r('app.media.share_btn_Normal'))
          .width(80)
          .height(80)
          .fillColor('#CBD5E1')
          .margin({ bottom: 16 })

        Text('还没有发布任何内容')
          .fontSize(16)
          .fontColor('#64748B')
          .margin({ bottom: 8 })

        Text('点击右上角"+"按钮开始发布吧')
          .fontSize(12)
          .fontColor('#94A3B8')
      }
      .width('100%')
      .padding({ top: 40, bottom: 40 })
      .backgroundColor('#F8FAFC')
    }
  }

  build() {
    if (this.currentPage === 'main') {
      Stack({ alignContent: Alignment.Top }) {
        navBarView({ opNav: this.opNav, colorNavBar: this.colorNavBar })

        Scroll(this.scroller) {
          Column() {
            topBackgroundView({ scaleValue: this.scaleValue })
            iconDockView({ buttons: memberButton })
            this.CustomSwiper()

            Row().height(10)
              .backgroundColor(0xF2F1F2)
              .width('100%')

            // 发布内容展示区域
            this.buildPublishContents()
          }.width('100%')

        }.onScroll((xOffset: number, yOffset: number) => {
          this.offsetY = this.scroller.currentOffset().yOffset;
          if (this.offsetY < 0) {
            this.scaleValue = (Math.abs(this.offsetY) + 100) / 100;
          } else {
            this.scaleValue = 1
          }
          if (this.offsetY >= 56) {
            this.offsetY = 56
          }
          this.opNav = this.offsetY / 56;
          this.colorNavBar = `rgba(255,255,255,${this.opNav})`
        })
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
      }
    } else {
      // 使用MainRouter处理其他页面
      MainRouter()
    }
  }
}