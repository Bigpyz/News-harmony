import type { User } from 'common/src/main/ets/domain/user/User'

@Component
export struct authorView {
  @State follow: number = ((AppStorage.Get('currentUser') as User | undefined)?.follow) ?? 0
  @State fans: number = ((AppStorage.Get('currentUser') as User | undefined)?.fans) ?? 0
  @State likes: number = ((AppStorage.Get('currentUser') as User | undefined)?.likes) ?? 0

  aboutToAppear(){
    // 当 currentUser 更新时，拉取最新数值
    const user: User | undefined = AppStorage.Get('currentUser') as User | undefined
    if (user) {
      console.log(`${JSON.stringify(user)}`)

      this.follow = user.follow ?? 0
      this.fans = user.fans ?? 0
      this.likes = user.likes ?? 0
    }
  }

  build() {
    Row() {
      Image($r('app.media.avatar'))
        .borderRadius(40)
        .borderWidth(2)
        .borderColor(Color.White)
        .height(80)
        .width(80)
        .backgroundColor(Color.White)
      Column({ space: 8 }) {
        Text("大眼萌机器人")
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
        Text() {
          Span(`${this.follow}`)
            .fontColor(Color.White)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
          Span("  关注")
            .fontColor(Color.White)
            .fontSize(14)
          Span("  |  ")
            .fontColor(Color.White)
            .fontSize(14)
          Span(`${this.fans}`)
            .fontColor(Color.White)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
          Span("  粉丝")
            .fontColor(Color.White)
            .fontSize(14)
          Span("  |  ")
            .fontColor(Color.White)
            .fontSize(14)
          Span(`${this.likes}`)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
          Span("  获赞")
            .fontColor(Color.White)
            .fontSize(14)
        }

      }.alignItems(HorizontalAlign.Start)
      .margin({ left: 15 })
    }.margin({ left: 15 })
  }
}
