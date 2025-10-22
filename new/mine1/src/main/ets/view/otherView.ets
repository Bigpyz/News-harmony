import { IconButtonModel } from '../viewmodel/IconButtonModel'
import { IconButton } from './IconButton'
import router from '@ohos.router';

@Component
export struct otherView {
  otherHeight:number = 150;
  @State showTagDialog: boolean = false;
  @State showShareDialog: boolean = false;
  @State age: string = '';
  @State school: string = '';
  @State userTags: string[] = [];

  build() {
    Stack() {
      Column() {
        Text("对未来的真正慷慨，是把一切都献给现在。")
          .width('100%')
          .fontColor(Color.White)
          .padding({ top: 18, bottom: 10 })
        Text("IP 归属：北京 >")
          .width('100%')
          .fontColor('#C2BFC7')
          .padding({ bottom: 10 })
        
        // 显示已有标签
        if (this.userTags.length > 0) {
          Flex({ 
            wrap: FlexWrap.Wrap,
            justifyContent: FlexAlign.Start
          }) {
            ForEach(this.userTags, (tag: string, index: number) => {
              Text(tag)
                .fontColor(Color.White)
                .fontSize(12)
                .backgroundColor('#555A596A')
                .borderRadius(5)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ right: 8, bottom: 4 })
            })
          }
          .width('100%')
        }
        
        Text("+添加年龄、学校标签")
          .fontColor(Color.White)
          .fontSize(14)
          .backgroundColor('#555A596A')
          .borderRadius(5)
          .padding(3)
          .onClick(() => {
            this.showTagDialog = true;
          })

        Row({ space: 10 }) {
          Button('申请认证', { type: ButtonType.Normal })
            .borderRadius(5)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#555A596A')
            .height(30)
            .width(90)
            .onClick(() => {
              this.onApplyCertification();
            })
          Button('编辑资料', { type: ButtonType.Normal })
            .borderRadius(5)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#555A596A')
            .height(30)
            .width(90)
            .onClick(() => {
              this.onEditProfile();
            })
          Button({ type: ButtonType.Normal }) {
            Image($r('app.media.share_btn_Normal'))
              .margin(2)

          }
          .backgroundColor('#555A596A')
          .borderRadius(5)
          .height(30)
          .width(30)
          .onClick(() => {
            this.onShare();
          })
        }
        .width('100%')
        .padding({ bottom: 18, top: 10 })
      }
      .height(this.otherHeight)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 15 })
      .backgroundColor(0x282350)
      .width('100%')

      // 添加标签对话框
      if (this.showTagDialog) {
        this.TagDialog()
      }

      // 分享对话框
      if (this.showShareDialog) {
        this.ShareDialog()
      }
    }
  }

  // 标签输入对话框
  @Builder
  TagDialog() {
    // 背景遮罩
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .position({ x: 0, y: 0 })
      .zIndex(999)
      .onClick(() => {
        this.showTagDialog = false;
        this.age = '';
        this.school = '';
      })

    // 对话框内容
    Column() {
      Text('添加个人标签')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 20 })

      TextInput({ placeholder: '请输入年龄' })
        .width('100%')
        .height(44)
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
        .padding({ left: 12, right: 12 })
        .fontSize(16)
        .onChange((value: string) => {
          this.age = value;
        })
        .margin({ bottom: 15 })

      TextInput({ placeholder: '请输入学校' })
        .width('100%')
        .height(44)
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
        .padding({ left: 12, right: 12 })
        .fontSize(16)
        .onChange((value: string) => {
          this.school = value;
        })
        .margin({ bottom: 20 })

      Row({ space: 15 }) {
        Button('取消')
          .width(100)
          .height(44)
          .backgroundColor('#E0E0E0')
          .fontColor(Color.Black)
          .fontSize(16)
          .borderRadius(8)
          .onClick(() => {
            this.showTagDialog = false;
            this.age = '';
            this.school = '';
          })

        Button('确定')
          .width(100)
          .height(44)
          .backgroundColor('#007AFF')
          .fontColor(Color.White)
          .fontSize(16)
          .borderRadius(8)
          .onClick(() => {
            this.addTags();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('85%')
    .padding(24)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 20, color: '#1F000000', offsetX: 0, offsetY: 4 })
    .position({ x: '7.5%', y: '30%' })
    .zIndex(1000)
  }

  // 添加标签方法
  private addTags() {
    if (this.age.trim() !== '') {
      this.userTags.push(`年龄: ${this.age}`);
    }
    if (this.school.trim() !== '') {
      this.userTags.push(`学校: ${this.school}`);
    }
    this.showTagDialog = false;
    this.age = '';
    this.school = '';
  }

  // 申请认证方法
  private onApplyCertification() {
    console.log('申请认证');
    router.pushUrl({
      url: 'pages/CertificationPage'
    }).catch((error: Error) => {
      console.error('跳转认证页面失败:', error);
    });
  }

  // 编辑资料方法
  private onEditProfile() {
    console.log('编辑资料');
    router.pushUrl({
      url: 'pages/EditProfilePage'
    }).catch((error: Error) => {
      console.error('跳转编辑页面失败:', error);
    });
  }

  // 分享方法
  private onShare() {
    this.showShareDialog = true;
  }

  // 分享对话框
  @Builder
  ShareDialog() {
    // 背景遮罩
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .position({ x: 0, y: 0 })
      .zIndex(999)
      .onClick(() => {
        this.showShareDialog = false;
      })

    // 对话框内容
    Column() {
      Text('分享到')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 20 })

      Row() {
        // 微信
        Column() {
          Image($r('app.media.share_btn_Normal'))
            .width(50)
            .height(50)
            .margin({ bottom: 8 })
          Text('微信')
            .fontSize(12)
            .fontColor(Color.Black)
        }
        .onClick(() => {
          this.shareToWeChat();
        })
        .margin({ right: 30 })

        // 朋友圈
        Column() {
          Image($r('app.media.share_btn_Normal'))
            .width(50)
            .height(50)
            .margin({ bottom: 8 })
          Text('朋友圈')
            .fontSize(12)
            .fontColor(Color.Black)
        }
        .onClick(() => {
          this.shareToMoments();
        })
        .margin({ right: 30 })

        // QQ
        Column() {
          Image($r('app.media.share_btn_Normal'))
            .width(50)
            .height(50)
            .margin({ bottom: 8 })
          Text('QQ')
            .fontSize(12)
            .fontColor(Color.Black)
        }
        .onClick(() => {
          this.shareToQQ();
        })
        .margin({ right: 30 })

        // 微博
        Column() {
          Image($r('app.media.share_btn_Normal'))
            .width(50)
            .height(50)
            .margin({ bottom: 8 })
          Text('微博')
            .fontSize(12)
            .fontColor(Color.Black)
        }
        .onClick(() => {
          this.shareToWeibo();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 20 })

      Button('取消')
        .width('100%')
        .height(40)
        .backgroundColor('#E0E0E0')
        .fontColor(Color.Black)
        .borderRadius(8)
        .onClick(() => {
          this.showShareDialog = false;
        })
    }
    .width('90%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 20, color: '#1F000000', offsetX: 0, offsetY: 4 })
    .position({ x: '5%', y: '40%' })
    .zIndex(1000)
  }

  // 分享到微信
  private shareToWeChat() {
    console.log('分享到微信');
    this.showShareDialog = false;
    // TODO: 实现微信分享
  }

  // 分享到朋友圈
  private shareToMoments() {
    console.log('分享到朋友圈');
    this.showShareDialog = false;
    // TODO: 实现朋友圈分享
  }

  // 分享到QQ
  private shareToQQ() {
    console.log('分享到QQ');
    this.showShareDialog = false;
    // TODO: 实现QQ分享
  }

  // 分享到微博
  private shareToWeibo() {
    console.log('分享到微博');
    this.showShareDialog = false;
    // TODO: 实现微博分享
  }
}


@Component
export struct iconDockView {
  buttons: IconButtonModel[] = [];

  @Styles
  cardStyle(){
    .height(110)
    .width('100%')
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.buttons, (iconButton: IconButtonModel) => {
          GridItem() {
            IconButton({
              props: iconButton,
              click: (key: number) => {
                this.onIconButtonClick(key);
              }
            })
          }
        }, (iconButton: IconButtonModel) => JSON.stringify(iconButton))
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .cardStyle()

    }.margin({ top: 10, bottom: 10 })
  }

  // 处理图标按钮点击事件
  private onIconButtonClick(key: number) {
    switch (key) {
      case 0: // 消息私信
        this.onMessageClick();
        break;
      case 1: // 浏览历史
        this.onHistoryClick();
        break;
      case 2: // 点赞
        this.onLikeClick();
        break;
      case 3: // 活动广场
        this.onActivityClick();
        break;
      case 4: // 我的订单
        this.onOrderClick();
        break;
      case 5: // 创作中心
        this.onCreationClick();
        break;
      case 6: // 草稿箱
        this.onDraftClick();
        break;
      case 7: // 全部
        this.onAllClick();
        break;
      default:
        console.log(`点击了按钮 ${key}`);
    }
  }

  // 消息私信
  private onMessageClick() {
    console.log('消息私信');
    // TODO: 跳转到消息页面
  }

  // 浏览历史
  private onHistoryClick() {
    console.log('浏览历史');
    // TODO: 跳转到历史记录页面
  }

  // 点赞
  private onLikeClick() {
    console.log('点赞');
    // TODO: 跳转到点赞列表页面
  }

  // 活动广场
  private onActivityClick() {
    console.log('活动广场');
    // TODO: 跳转到活动页面
  }

  // 我的订单
  private onOrderClick() {
    console.log('我的订单');
    // TODO: 跳转到订单页面
  }

  // 创作中心
  private onCreationClick() {
    console.log('创作中心');
    // TODO: 跳转到创作页面
  }

  // 草稿箱
  private onDraftClick() {
    console.log('草稿箱');
    // TODO: 跳转到草稿箱页面
  }

  // 全部
  private onAllClick() {
    console.log('全部');
    // TODO: 显示更多选项
  }
}