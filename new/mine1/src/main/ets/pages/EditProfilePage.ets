import router from '@ohos.router';

@Entry
@Component
export struct EditProfilePage {
  @State nickname: string = '大眼萌机器人';
  @State gender: number = 0; // 0: 男, 1: 女, 2: 保密
  @State birthday: string = '';
  @State location: string = '北京';
  @State bio: string = '对未来的真正慷慨，是把一切都献给现在。';
  @State avatar: Resource = $r('app.media.avatar');

  build() {
    Column() {
      // 导航栏
      Row() {
        Text('←')
          .fontSize(24)
          .fontColor('#007AFF')
          .onClick(() => {
            router.back();
          })
        Text('编辑资料')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 12 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // 头像编辑
          Column() {
            Text('头像')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 10 })

            Row() {
              Image(this.avatar)
                .width(80)
                .height(80)
                .borderRadius(40)
                .objectFit(ImageFit.Cover)

              Column() {
                Button('更换头像')
                  .width(100)
                  .height(36)
                  .backgroundColor('#007AFF')
                  .fontColor(Color.White)
                  .fontSize(14)
                  .borderRadius(18)
                  .onClick(() => {
                    this.changeAvatar();
                  })

                Text('支持JPG、PNG格式')
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .margin({ left: 20 })
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 30 })

          // 昵称编辑
          this.InputField('昵称', this.nickname, (value: string) => {
            this.nickname = value;
          })

          // 性别选择
          Column() {
            Text('性别')
              .fontSize(14)
              .fontColor(Color.Black)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 8 })

            Row() {
              Button('男')
                .width(80)
                .height(36)
                .backgroundColor(this.gender === 0 ? '#007AFF' : '#F5F5F5')
                .fontColor(this.gender === 0 ? Color.White : Color.Black)
                .fontSize(14)
                .borderRadius(18)
                .onClick(() => {
                  this.gender = 0;
                })

              Button('女')
                .width(80)
                .height(36)
                .backgroundColor(this.gender === 1 ? '#007AFF' : '#F5F5F5')
                .fontColor(this.gender === 1 ? Color.White : Color.Black)
                .fontSize(14)
                .borderRadius(18)
                .margin({ left: 10 })
                .onClick(() => {
                  this.gender = 1;
                })

              Button('保密')
                .width(80)
                .height(36)
                .backgroundColor(this.gender === 2 ? '#007AFF' : '#F5F5F5')
                .fontColor(this.gender === 2 ? Color.White : Color.Black)
                .fontSize(14)
                .borderRadius(18)
                .margin({ left: 10 })
                .onClick(() => {
                  this.gender = 2;
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 20 })

          // 生日选择
          this.InputField('生日', this.birthday, (value: string) => {
            this.birthday = value;
          })

          // 所在地编辑
          this.InputField('所在地', this.location, (value: string) => {
            this.location = value;
          })

          // 个人简介编辑
          Column() {
            Text('个人简介')
              .fontSize(14)
              .fontColor(Color.Black)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 8 })

            TextArea({ placeholder: '请输入个人简介' })
              .width('100%')
              .height(100)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .padding(12)
              .fontSize(16)
              .onChange((value: string) => {
                this.bio = value;
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .margin({ bottom: 30 })

          // 保存按钮
          Button('保存')
            .width('100%')
            .height(50)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .borderRadius(25)
            .onClick(() => {
              this.saveProfile();
            })
            .margin({ top: 20, bottom: 30 })

        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .flexGrow(1)
      .backgroundColor('#F8F8F8')

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  @Builder
  InputField(label: string, value: string, onChange: (value: string) => void) {
    Column() {
      Text(label)
        .fontSize(14)
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 8 })

      TextInput({ placeholder: `请输入${label}` })
        .width('100%')
        .height(44)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .padding({ left: 12, right: 12 })
        .fontSize(16)
        .onChange(onChange)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 20 })
  }

  private changeAvatar() {
    console.log('更换头像');
    // TODO: 实现头像选择功能
  }

  private saveProfile() {
    console.log('保存资料');
    console.log('昵称:', this.nickname);
    console.log('性别:', this.gender);
    console.log('生日:', this.birthday);
    console.log('所在地:', this.location);
    console.log('个人简介:', this.bio);
    // TODO: 实现资料保存逻辑
    router.back();
  }
}
