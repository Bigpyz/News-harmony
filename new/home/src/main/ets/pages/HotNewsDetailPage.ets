import { ResManager } from 'common';
import router from '@ohos.router';
import { hotListData, hotListModel } from '../viewmodel/hotData';

// 定义路由参数的接口
interface NewsDetailParams {
  title: string;
  content: string;
  time: string;
  source: string;
  image: Resource;
  index: number;
}

@Entry
@Component
export struct HotNewsDetailPage {
  @State newsTitle: string = '';
  @State newsContent: string = '';
  @State newsTime: string = '';
  @State newsSource: string = '';
  @State newsImage: Resource = $r('app.media.icon');
  @State recommendedNews: hotListModel | null = null;

  aboutToAppear() {
    // 获取路由传递的参数
    const params = router.getParams() as NewsDetailParams;
    this.newsTitle = params?.title || '新闻标题';
    this.newsContent = params?.content || '这里是新闻详情内容的占位文本。';
    this.newsTime = params?.time || '2024-01-20 12:00';
    this.newsSource = params?.source || '热榜新闻';
    this.newsImage = params?.image || $r('app.media.icon');

    // 获取推荐新闻
    let recommendedIndex = Math.floor(Math.random() * hotListData.length);
    // 确保推荐的新闻不是当前新闻
    while (recommendedIndex === params.index) {
      recommendedIndex = Math.floor(Math.random() * hotListData.length);
    }
    this.recommendedNews = hotListData[recommendedIndex];
  }

  @Builder
  TopBar() {
    Row() {
      Image($r('app.media.back_normal_new_Normal'))
        .width(24)
        .height(24)
        .margin({ left: 16 })
        .onClick(() => {
          router.back();
        })

      Text('新闻详情')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .margin({ left: 16 })

      Blank()

      Image($r('app.media.toolbar_more_new_Normal'))
        .width(24)
        .height(24)
        .margin({ right: 16 })
        .onClick(() => {
          // 分享功能占位
        })
    }
    .width('100%')
    .height(56)
    .backgroundColor(ResManager.getDefaultColor())
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NewsHeader() {
    Column() {
      Text(this.newsTitle)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Start)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Text(this.newsSource)
          .fontSize(14)
          .fontColor('#666666')

        Blank()

        Text(this.newsTime)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .margin({ bottom: 16 })

      Divider()
        .strokeWidth(1)
        .color('#E5E5E5')
        .margin({ bottom: 16 })
    }
    .padding({ left: 16, right: 16, top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  NewsContent() {
    Column() {
      // 新闻图片
      Image(this.newsImage)
        .width('100%')
        .height(200)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)
        .margin({ bottom: 16 })

      Text(this.newsContent)
        .fontSize(16)
        .lineHeight(24)
        .fontColor('#333333')
        .textAlign(TextAlign.Start)
        .width('100%')
        .margin({ bottom: 20 })

      // 相关新闻推荐
      if (this.recommendedNews) {
        Column() {
          Text('相关新闻')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .margin({ bottom: 12 })

          Row() {
            Text('1')
              .fontSize(14)
              .fontColor(Color.White)
              .backgroundColor(ResManager.getDefaultColor())
              .width(20)
              .height(20)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .margin({ right: 8 })

            Text(this.recommendedNews.text)
              .fontSize(15)
              .fontColor('#333333')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 })
          .onClick(() => {
            if (this.recommendedNews) {
              router.replaceUrl({
                url: '@bundle:com.news.today/home/ets/pages/HotNewsDetailPage',
                params: {
                  title: this.recommendedNews.text,
                  content: this.recommendedNews.content,
                  time: new Date().toLocaleString(),
                  source: this.recommendedNews.source,
                  image: this.recommendedNews.image,
                  index: this.recommendedNews.index
                }
              })
            }
          })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 20 })
      }
    }
    .padding({ left: 16, right: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.NewsHeader()
          this.NewsContent()
        }
      }
      .layoutWeight(1)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
