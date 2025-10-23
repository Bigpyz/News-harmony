import { IconButtonModel } from '../viewmodel/IconButtonModel'
import { IconButton } from './IconButton'
import { UserProfileManager } from '../viewmodel/UserProfileData'
import type { UserProfile } from '../viewmodel/UserProfileData'

@Component
export struct otherView {
  @LocalStorageLink('currentPage') currentPage: string = 'main'
  @StorageLink('userProfile') userProfile: UserProfile = UserProfileManager.getDefaultProfile()
  otherHeight:number = 150;
  build() {
    Column() {
      Text(this.userProfile.bio)
        .width('100%')
        .fontColor(Color.White)
        .padding({ top: 18, bottom: 10 })
      Text(`IP 归属：${this.userProfile.location} >`)
        .width('100%')
        .fontColor('#C2BFC7')
        .padding({ bottom: 10 })
      Text(UserProfileManager.getAgeSchoolLabel())
        .fontColor(Color.White)
        .fontSize(14)
        .backgroundColor('#555A596A')
        .borderRadius(5)
        .padding(3)

      Row({ space: 10 }) {
        // Button('申请认证', { type: ButtonType.Normal })
        //   .borderRadius(5)
        //   .fontWeight(FontWeight.Bold)
        //   .backgroundColor('#555A596A')
        //   .height(30)
        //   .width(90)
        //   .onClick(() => {
        //     this.currentPage = 'authentication'
        //   })
        Button('编辑资料', { type: ButtonType.Normal })
          .borderRadius(5)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#555A596A')
          .height(30)
          .width(90)
          .onClick(() => {
            this.currentPage = 'editProfile'
          })
        Button({ type: ButtonType.Normal }) {
          Image($r('app.media.share_btn_Normal'))
            .margin(2)

        }
        .backgroundColor('#555A596A')
        .borderRadius(5)
        .height(30)
        .width(30)
      }
      .width('100%')
      .padding({ bottom: 18, top: 10 })
    }
    .height(this.otherHeight)
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 15 })
    .backgroundColor(0x282350)
    .width('100%')
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
              props: iconButton
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
}