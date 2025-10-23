import prompt from '@ohos.promptAction';

@Component
export struct AuthenticationPage {
  @LocalStorageLink('currentPage') currentPage: string = 'main'
  @State authType: string = ''
  @State authInfo: string = ''
  @State idCard: string = ''
  @State studentId: string = ''
  @State proofImages: string[] = []

  // 返回上一页
  goBack() {
    this.currentPage = 'main'
  }

  // 提交认证申请
  submitAuthentication() {
    if (!this.authType) {
      prompt.showToast({
        message: '请选择认证类型',
        duration: 2000
      })
      return
    }

    if (!this.authInfo) {
      prompt.showToast({
        message: '请填写认证信息',
        duration: 2000
      })
      return
    }

    // 根据不同类型进行验证
    if (this.authType === 'student' && !this.studentId) {
      prompt.showToast({
        message: '请填写学号',
        duration: 2000
      })
      return
    }

    // 提交认证逻辑
    console.log(`提交${this.getAuthTypeText()}认证:`, {
      type: this.authType,
      info: this.authInfo,
      studentId: this.studentId,
      idCard: this.idCard
    })

    prompt.showToast({
      message: `${this.getAuthTypeText()}认证申请已提交，审核中...`,
      duration: 3000
    })

    // 这里可以添加API调用
  }

  getAuthTypeText(): string {
    switch (this.authType) {
      case 'student':
        return '学生'
      case 'teacher':
        return '教师'
      case 'alumni':
        return '校友'
      default:
        return ''
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.share_btn_Normal')) // 返回图标
          .width(24)
          .height(24)
          .onClick(() => this.goBack())

        Text('申请认证')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 10 })

        Blank()
      }
      .width('100%')
      .padding({
        left: 15,
        right: 15,
        top: 10,
        bottom: 10
      })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 20 }) {
          // 认证类型选择
          Column() {
            Text('选择认证类型')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ bottom: 15 })

            Column({ space: 12 }) {
              // 学生认证
              Row() {
                Image($r('app.media.share_btn_Normal'))
                  .width(40)
                  .height(40)
                Column() {
                  Text('学生认证')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  Text('在校学生身份认证')
                    .fontSize(12)
                    .fontColor('#666666')
                }
                .margin({ left: 10 })
                .alignItems(HorizontalAlign.Start)

                Blank()

                if (this.authType === 'student') {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                } else {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                }
              }
              .width('100%')
              .padding(15)
              .backgroundColor(this.authType === 'student' ? '#E6F7FF' : '#F5F5F5')
              .borderRadius(10)
              .onClick(() => {
                this.authType = 'student'
              })

              // 教师认证
              Row() {
                Image($r('app.media.share_btn_Normal'))
                  .width(40)
                  .height(40)
                Column() {
                  Text('教师认证')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  Text('在职教师身份认证')
                    .fontSize(12)
                    .fontColor('#666666')
                }
                .margin({ left: 10 })
                .alignItems(HorizontalAlign.Start)

                Blank()

                if (this.authType === 'teacher') {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                } else {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                }
              }
              .width('100%')
              .padding(15)
              .backgroundColor(this.authType === 'teacher' ? '#E6F7FF' : '#F5F5F5')
              .borderRadius(10)
              .onClick(() => {
                this.authType = 'teacher'
              })

              // 校友认证
              Row() {
                Image($r('app.media.share_btn_Normal'))
                  .width(40)
                  .height(40)
                Column() {
                  Text('校友认证')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  Text('毕业校友身份认证')
                    .fontSize(12)
                    .fontColor('#666666')
                }
                .margin({ left: 10 })
                .alignItems(HorizontalAlign.Start)

                Blank()

                if (this.authType === 'alumni') {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                } else {
                  Image($r('app.media.share_btn_Normal'))
                    .width(20)
                    .height(20)
                }
              }
              .width('100%')
              .padding(15)
              .backgroundColor(this.authType === 'alumni' ? '#E6F7FF' : '#F5F5F5')
              .borderRadius(10)
              .onClick(() => {
                this.authType = 'alumni'
              })
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .shadow({
            radius: 5,
            color: '#000000',
            offsetX: 0,
            offsetY: 2
          })

          // 认证信息表单
          if (this.authType) {
            Column() {
              Text(`${this.getAuthTypeText()}认证信息`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .width('100%')
                .margin({ bottom: 15 })

              Column({ space: 15 }) {
                // 姓名/学校名称
                TextInput({ placeholder: `请输入${this.getAuthTypeText()}姓名`, text: this.authInfo })
                  .onChange((value: string) => {
                    this.authInfo = value
                  })
                  .backgroundColor('#F8F8F8')
                  .padding(15)
                  .borderRadius(8)
                  .width('100%')

                // 根据认证类型显示不同字段
                if (this.authType === 'student') {
                  TextInput({ placeholder: '请输入学号', text: this.studentId })
                    .onChange((value: string) => {
                      this.studentId = value
                    })
                    .backgroundColor('#F8F8F8')
                    .padding(15)
                    .borderRadius(8)
                    .width('100%')
                }

                if (this.authType === 'teacher') {
                  TextInput({ placeholder: '请输入教师工号', text: this.studentId })
                    .onChange((value: string) => {
                      this.studentId = value
                    })
                    .backgroundColor('#F8F8F8')
                    .padding(15)
                    .borderRadius(8)
                    .width('100%')
                }

                // 身份证号（可选）
                TextInput({ placeholder: '身份证号（选填）', text: this.idCard })
                  .onChange((value: string) => {
                    this.idCard = value
                  })
                  .backgroundColor('#F8F8F8')
                  .padding(15)
                  .borderRadius(8)
                  .width('100%')

                // 证明材料上传
                Column() {
                  Text('证明材料')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .width('100%')
                    .margin({ bottom: 10 })

                  Text('请上传学生证、教师证或其他相关证明文件')
                    .fontSize(12)
                    .fontColor('#666666')
                    .width('100%')
                    .margin({ bottom: 15 })

                  // 图片上传区域 - 使用 Flex 替代 Row 实现换行
                  Flex({ wrap: FlexWrap.Wrap }) {
                    // 添加图片按钮
                    Column() {
                      Image($r('app.media.share_btn_Normal'))
                        .width(40)
                        .height(40)
                      Text('添加图片')
                        .fontSize(12)
                        .fontColor('#666666')
                        .margin({ top: 5 })
                    }
                    .width(80)
                    .height(80)
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor('#F8F8F8')
                    .borderRadius(8)
                    .margin({ right: 10, bottom: 10 })
                    .onClick(() => {
                      // 图片上传逻辑
                    })

                    // 已上传的图片预览
                    ForEach(this.proofImages, (image: string, index: number) => {
                      Image(image)
                        .width(80)
                        .height(80)
                        .borderRadius(8)
                        .margin({ right: 10, bottom: 10 })
                    }, (image: string) => image)
                  }
                  .width('100%')
                }
                .width('100%')
              }
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(10)
            .shadow({
              radius: 5,
              color: '#000000',
              offsetX: 0,
              offsetY: 2
            })
          }

          // 提交按钮
          if (this.authType) {
            Button('提交认证申请', { type: ButtonType.Normal })
              .onClick(() => {
                this.submitAuthentication()
              })
              .width('90%')
              .height(50)
              .backgroundColor('#4A90E2')
              .fontColor(Color.White)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .borderRadius(25)
              .margin({ top: 20 })
          }
        }
        .width('100%')
        .padding(20)
      }
      .flexGrow(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}