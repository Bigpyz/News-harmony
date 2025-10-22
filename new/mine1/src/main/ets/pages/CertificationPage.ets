import router from '@ohos.router';

@Entry
@Component
export struct CertificationPage {
  @State name: string = '';
  @State idCard: string = '';
  @State phone: string = '';
  @State email: string = '';
  @State selectedType: number = 0;
  @State certificationTypes: string[] = ['个人认证', '企业认证', '机构认证'];

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
        Text('申请认证')
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
          // 认证类型选择
          Text('认证类型')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .alignSelf(ItemAlign.Start)
            .margin({ top: 20, bottom: 10 })

          Row() {
            ForEach(this.certificationTypes, (type: string, index: number) => {
              Button(type)
                .fontSize(14)
                .height(36)
                .padding({ left: 16, right: 16 })
                .backgroundColor(this.selectedType === index ? '#007AFF' : '#F5F5F5')
                .fontColor(this.selectedType === index ? Color.White : Color.Black)
                .borderRadius(18)
                .margin({ right: 10 })
                .onClick(() => {
                  this.selectedType = index;
                })
            })
          }
          .width('100%')
          .margin({ bottom: 30 })

          // 姓名输入
          this.InputField('姓名', this.name, (value: string) => {
            this.name = value;
          })

          // 身份证号输入
          this.InputField('身份证号', this.idCard, (value: string) => {
            this.idCard = value;
          })

          // 手机号输入
          this.InputField('手机号', this.phone, (value: string) => {
            this.phone = value;
          })

          // 邮箱输入
          this.InputField('邮箱', this.email, (value: string) => {
            this.email = value;
          })

          // 上传证件照片
          Text('上传证件照片')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .alignSelf(ItemAlign.Start)
            .margin({ top: 20, bottom: 10 })

          Row() {
            Button('+ 上传身份证正面')
              .width(120)
              .height(80)
              .backgroundColor('#F5F5F5')
              .fontColor('#999999')
              .fontSize(12)
              .borderRadius(8)
              .onClick(() => {
                this.uploadIdCardFront();
              })

            Button('+ 上传身份证反面')
              .width(120)
              .height(80)
              .backgroundColor('#F5F5F5')
              .fontColor('#999999')
              .fontSize(12)
              .borderRadius(8)
              .margin({ left: 10 })
              .onClick(() => {
                this.uploadIdCardBack();
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .margin({ bottom: 30 })

          // 提交按钮
          Button('提交认证申请')
            .width('100%')
            .height(50)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .borderRadius(25)
            .onClick(() => {
              this.submitCertification();
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

  private uploadIdCardFront() {
    console.log('上传身份证正面');
    // TODO: 实现图片上传功能
  }

  private uploadIdCardBack() {
    console.log('上传身份证反面');
    // TODO: 实现图片上传功能
  }

  private submitCertification() {
    if (!this.name || !this.idCard || !this.phone) {
      console.log('请填写完整信息');
      return;
    }
    console.log('提交认证申请');
    // TODO: 实现认证申请提交逻辑
    router.back();
  }
}
