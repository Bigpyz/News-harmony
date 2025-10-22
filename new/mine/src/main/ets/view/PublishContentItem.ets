import { PublishContent } from './PublishPage'

@Component
export struct PublishContentItem {
  @Prop content: PublishContent

  build() {
    Column() {
      // 用户信息行
      Row() {
        Image(this.content.avatar)
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#F1F5F9')

        Column() {
          Text(this.content.username)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Text(this.content.publishTime)
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        Blank()

        // 更多操作按钮
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill('#F1F5F9')

          Image($r('app.media.share_btn_Normal'))
            .width(16)
            .height(16)
            .fillColor('#64748B')
        }
        .onClick(() => {
          // 更多操作逻辑
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ bottom: 12 })

      // 发布内容
      Column() {
        // 文字内容
        if (this.content.text) {
          Text(this.content.text)
            .fontSize(16)
            .fontColor('#1E293B')
            .lineHeight(24)
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: this.content.image ? 12 : 0 })
        }

        // 图片内容
        if (this.content.image) {
          Image(this.content.image)
            .width('100%')
            .height(200)
            .borderRadius(12)
            .objectFit(ImageFit.Cover)
            .backgroundColor('#F1F5F9')
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 操作按钮行
      Row() {
        // 点赞按钮
        Row() {
          Image($r('app.media.share_btn_Normal'))
            .width(20)
            .height(20)
            .fillColor('#64748B')
            .margin({ right: 6 })

          Text('点赞')
            .fontSize(14)
            .fontColor('#64748B')
        }
        .onClick(() => {
          // 点赞逻辑
        })

        Blank()

        // 评论按钮
        Row() {
          Image($r('app.media.share_btn_Normal'))
            .width(20)
            .height(20)
            .fillColor('#64748B')
            .margin({ right: 6 })

          Text('评论')
            .fontSize(14)
            .fontColor('#64748B')
        }
        .onClick(() => {
          // 评论逻辑
        })

        Blank()

        // 分享按钮
        Row() {
          Image($r('app.media.share_btn_Normal'))
            .width(20)
            .height(20)
            .fillColor('#64748B')
            .margin({ right: 6 })

          Text('分享')
            .fontSize(14)
            .fontColor('#64748B')
        }
        .onClick(() => {
          // 分享逻辑
        })
      }
      .width('100%')
      .padding({ top: 16, bottom: 8 })
      .border({
        width: { top: 1 },
        color: '#F1F5F9'
      })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20, bottom: 20 })
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ left: 16, right: 16, bottom: 16 })
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.06)',
      offsetX: 0,
      offsetY: 2
    })
  }
}
