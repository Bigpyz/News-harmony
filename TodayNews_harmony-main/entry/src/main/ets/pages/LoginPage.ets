import router from '@ohos.router'
import { UserStore } from 'common/src/main/ets/presentation/user/UserStore'

interface User {
  username: string
  password: string
  follow: number
  fans: number
  likes: number
  signature: string
}

interface ApiUserResponse {
  user: User
}

@Entry
@Component
struct LoginPage {
  @State isRegister: boolean = false
  @State username: string = ''
  @State password: string = ''
  @State loading: boolean = false
  @State errorMsg: string = ''

  private handleAuth() {
    if (!this.username || !this.password) {
      this.errorMsg = '请输入用户名和密码'
      return
    }
    this.errorMsg = ''
    this.loading = true

    const store = new UserStore()
    const action = this.isRegister ? store.register(this.username, this.password) : store.login(this.username, this.password)
    action.then(user => {
      if (user && user.username) {
        router.replaceUrl({ url: 'pages/MainPage' })
      } else {
        this.errorMsg = '登录失败：返回数据异常'
      }
    }).catch(() => {
      this.errorMsg = '请求失败，请稍后再试'
    }).finally(() => {
      this.loading = false
    })
  }

  aboutToAppear() {
    const isLoggedIn: boolean = AppStorage.Get<boolean>('isLoggedIn') ?? false
    if (isLoggedIn) {
      router.replaceUrl({ url: 'pages/MainPage' })
    }
  }

  build() {
    Column({ space: 16 }) {
      Text(this.isRegister ? '注册' : '登录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      TextInput({ placeholder: '用户名', text: this.username })
        .onChange((v: string) => this.username = v)
        .type(InputType.Normal)
        .width('90%')
        .height(40)
        .padding(8)
        .border({ width: 1, color: 0x22000000, radius: 8 })

      TextInput({ placeholder: '密码', text: this.password })
        .onChange((v: string) => this.password = v)
        .type(InputType.Password)
        .width('90%')
        .height(40)
        .padding(8)
        .border({ width: 1, color: 0x22000000, radius: 8 })

      if (this.errorMsg) {
        Text(this.errorMsg)
          .fontColor(Color.Red)
          .fontSize(12)
      }

      Button(this.loading ? '请稍候…' : (this.isRegister ? '注册并进入' : '登录并进入'))
        .enabled(!this.loading)
        .onClick(() => this.handleAuth())
        .width('90%')
        .height(44)

      Row({ space: 6 }) {
        Text(this.isRegister ? '已有账号？' : '没有账号？')
          .fontSize(12)
        Text(this.isRegister ? '去登录' : '去注册')
          .fontSize(12)
          .fontColor('#e92f4f')
          .onClick(() => this.isRegister = !this.isRegister)
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(16)
  }
}


