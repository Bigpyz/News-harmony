import { RefreshPullView } from 'common';
import { ResManager } from 'common/src/main/ets/constants/ResManager';
import { hotListModel, LocalDataManager } from '../viewmodel/hotData';
import router from '@ohos.router';


@Component
export struct HotListView {
  private localManager: LocalDataManager = LocalDataManager.instance();
  @State array: Array<hotListModel> = [];
  private listScroller: Scroller = new Scroller();
  private hotTitleHeight: number = 55;
  @State offsetY: number = 0;
  @State distance: number = 18;
  @State secondData: Array<hotListModel> = [];

  // 组件生命周期：加载数据
  async aboutToAppear() {
    try {
      this.array = await this.localManager.queryFirstList();
      this.secondData = await this.localManager.querySecondList();
    } catch (error) {
      console.error('加载数据失败:', error);
      // 如果网络请求失败，使用本地数据
      this.array = this.localManager.getLocalFirstList();
      this.secondData = this.localManager.getLocalSecondList();
    }
  }

  // 跳转到热榜新闻详情页
  navigateToHotNewsDetail(newsItem: hotListModel) {
    router.pushUrl({
      url: '@bundle:com.news.today/home/ets/pages/HotNewsDetailPage',
      params: {
        title: newsItem.text,
        content: newsItem.content, // 传递详细内容
        time: new Date().toLocaleString(),
        source: newsItem.source, // 传递新闻来源
        image: newsItem.image, // 传递图片资源
        index: newsItem.index // 传递新闻索引
      }
    }).catch((error: Error) => {
      console.error('Navigation failed:', error.message);
    });
  }

  @Builder itemHead() {
    // 移除顶部标题栏，只保留一个简单的间距
    Row()
      .height(10)
      .width('100%')
  }

  async refreshNewsData(): Promise<string> {
    try {
      // 重新加载数据
      this.array = await this.localManager.queryFirstList();
      this.secondData = await this.localManager.querySecondList();
      return "刷新成功";
    } catch (error) {
      console.error('刷新数据失败:', error);
      // 如果网络请求失败，使用本地数据
      this.array = this.localManager.getLocalFirstList();
      this.secondData = this.localManager.getLocalSecondList();
      return "刷新失败，使用本地数据";
    }
  }

  @Builder ListLayout() {

    RefreshPullView({
      onRefresh: (): Promise<string> => this.refreshNewsData(),
      ldColor:'#ffffff',
      bgColor:ResManager.getDefaultColor(),
      tipStr:'已更新到最新',
      customList: () => {
        this.getListView()
      }

    })

  }

  @Builder
  getListView(){

    Stack({ alignContent: Alignment.Top }) {

      Row()
        .height('50%')
        .width('100%')
        .backgroundColor(ResManager.getDefaultColor())


      List({ scroller: this.listScroller }) {


        ListItemGroup({ header: this.itemHead() }) {
          ForEach(this.array, (item: hotListModel, index: number) => {

            ListItem() {

              Stack({ alignContent: Alignment.Bottom }) {
                Row({ space: 8 }) {
                  if (item.icon) {
                    Image(item.icon)
                      .width(25)
                      .height(25)
                  } else {
                    Text(item.index.toString())
                      .fontSize(18)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(index <= 3 ? Color.Red : Color.Black)
                      .padding({ left: 7 })

                  }
                  Text(item.text)
                    .fontSize(15)
                    .padding({ left: index === 0 ? 2 : 8 })
                  Text(item.hotWord ? item.hotWord : '')
                    .fontSize(12)
                    .padding(4)
                    .borderRadius(4)
                    .fontColor(item.color)
                    .backgroundColor(item.bgColor)

                }
                .width('100%')
                .height('100%')

                Column().width("95%")
                  .height(1)
                  .backgroundColor(0xF0F1F1)
              }
              .height('100%')
              .onClick(() => {
                this.navigateToHotNewsDetail(item);
              })

            }
            .padding({ left: 10, right: 10 })
            .width('100%')
            .height(60)
            .backgroundColor(Color.White)
            .borderRadius({
              topLeft: index === 0 ? 10 : 0,
              topRight: index === 0 ? 10 : 0,
              bottomLeft: (index === this.array.length - 1) ? 10 : 0,
              bottomRight: (index === this.array.length - 1) ? 10 : 0
            })

          }, (item: hotListModel) => item.index.toString())


          ListItem() {
            Divider()
              .strokeWidth(5)
              .backgroundColor("#F1F2F3")
          }

          ListItem() {

            Column() {
              ForEach(this.secondData, (item: hotListModel, index: number) => {
                Row() {
                  // 左侧：标题和来源
                  Column() {
                    Text(item.text)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    Text(item.source)
                      .fontSize(12)
                      .fontColor('#99182431')
                      .margin({ top: 8 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)

                  // 右侧：图片
                  if (item.image) {
                    Image(item.image)
                      .width(120)
                      .height(80)
                      .objectFit(ImageFit.Cover)
                      .borderRadius(4)
                      .margin({ left: 10 })
                  }
                }
                .width('100%')
                .padding(10)
                .onClick(() => {
                  this.navigateToHotNewsDetail(item);
                })
              })
            }.backgroundColor(Color.White)

          }

        }

      }
      .edgeEffect(EdgeEffect.Spring)
      .sticky(StickyStyle.Header)
      .onScroll((offset, status) => {
        this.offsetY += offset;
      })

    }
  }

  build() {


    Scroll() {
      Column() {


        this.ListLayout()
      }

    }

  }
}


