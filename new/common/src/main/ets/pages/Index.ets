import router from '@ohos.router'
@Entry
@Component
struct Index {
  @State message: string = 'Test'

  build() {
    Row() {
      Column() {
        Button('点击跳转msy')
          .onClick(()=>{

            router.pushUrl({
              url: 'pages/MainPage'
            }).then(() => {
              console.log("push page success");
            }).catch(() => {
              console.error('pushUrl failed');
            })

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}