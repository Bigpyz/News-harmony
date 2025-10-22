import prompt from '@ohos.promptAction';
import picker from '@ohos.file.picker';
import type { UserProfile } from '../viewmodel/UserProfileData'
import { UserProfileManager } from '../viewmodel/UserProfileData'

// 发布内容数据模型
export interface PublishContent {
  id: string
  text: string
  image?: Resource
  publishTime: string
  username: string
  avatar: Resource
}

@Component
export struct PublishPage {
  @LocalStorageLink('currentPage') currentPage: string = 'main'
  @StorageLink('userProfile') userProfile: UserProfile = UserProfileManager.getDefaultProfile()
  
  @State publishText: string = ''
  @State selectedImage: Resource | null = null
  @State isPublishing: boolean = false
  @State textError: string = ''

  // 返回上一页
  goBack() {
    this.currentPage = 'main'
  }

  // 选择图片
  async selectImage() {
    try {
      const photoSelectOptions = new picker.PhotoSelectOptions()
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
      photoSelectOptions.maxSelectNumber = 1
      
      const photoSelectPicker = new picker.PhotoViewPicker()
      const result = await photoSelectPicker.select(photoSelectOptions)
      
      if (result && result.photoUris && result.photoUris.length > 0) {
        // 这里简化处理，实际项目中需要将图片转换为Resource
        this.selectedImage = $r('app.media.avatar') // 临时使用默认图片
        prompt.showToast({
          message: '图片选择成功',
          duration: 1500
        })
      }
    } catch (error) {
      console.error('选择图片失败:', error)
      prompt.showToast({
        message: '图片选择失败',
        duration: 2000
      })
    }
  }

  // 移除图片
  removeImage() {
    this.selectedImage = null
  }

  // 验证输入
  validateInput(): boolean {
    this.textError = ''
    
    if (this.publishText.trim().length === 0) {
      this.textError = '请输入发布内容'
      return false
    }
    
    if (this.publishText.length > 150) {
      this.textError = '内容不能超过150个字符'
      return false
    }
    
    return true
  }

  // 发布内容
  async publishContent() {
    if (!this.validateInput()) {
      prompt.showToast({
        message: this.textError,
        duration: 2000
      })
      return
    }

    this.isPublishing = true

    try {
      // 创建发布内容
      const publishContent: PublishContent = {
        id: Date.now().toString(),
        text: this.publishText.trim(),
        image: this.selectedImage || undefined,
        publishTime: this.getCurrentTime(),
        username: this.userProfile.username,
        avatar: this.userProfile.avatar
      }

      // 获取现有的发布内容列表
      const existingContent = AppStorage.get('publishContents') as PublishContent[] || []
      
      // 添加新内容到列表开头
      const updatedContent = [publishContent, ...existingContent]
      
      // 保存到AppStorage
      AppStorage.set('publishContents', updatedContent)

      // 显示成功提示
      prompt.showToast({
        message: '发布成功',
        duration: 2000
      })

      // 清空输入
      this.publishText = ''
      this.selectedImage = null
      this.textError = ''

      // 延迟返回主页面
      setTimeout(() => {
        this.currentPage = 'main'
      }, 1000)

    } catch (error) {
      console.error('发布失败:', error)
      prompt.showToast({
        message: '发布失败，请重试',
        duration: 2000
      })
    } finally {
      this.isPublishing = false
    }
  }

  // 获取当前时间
  getCurrentTime(): string {
    const now = new Date()
    const month = now.getMonth() + 1
    const day = now.getDate()
    return `${month}月${day}日`
  }

  build() {
    Stack() {
      Column() {
        // 顶部导航栏
        this.buildTopNavigation()

        Scroll() {
          Column() {
            // 发布内容区域
            this.buildPublishContent()
          }
          .width('100%')
        }
        .flexGrow(1)
        .backgroundColor('#F8FAFC')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }

  // 构建顶部导航栏
  @Builder
  buildTopNavigation() {
    Row() {
      // 返回按钮
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill('#F1F5F9')
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.1)',
            offsetX: 0,
            offsetY: 2
          })

        Image($r('app.media.scan_icon_Normal'))
          .width(20)
          .height(20)
          .fillColor('#475569')
      }
      .onClick(() => this.goBack())

      // 标题
      Text('发布动态')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .margin({ left: 16 })

      Blank()

      // 发布按钮
      Button('发布', { type: ButtonType.Normal })
        .onClick(() => this.publishContent())
        .backgroundColor(this.publishText.trim().length > 0 ? '#6366F1' : '#94A3B8')
        .fontColor(Color.White)
        .borderRadius(20)
        .padding({ left: 20, right: 20, top: 8, bottom: 8 })
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .enabled(this.publishText.trim().length > 0 && !this.isPublishing)
        .shadow(this.publishText.trim().length > 0 ? {
          radius: 8,
          color: 'rgba(99, 102, 241, 0.3)',
          offsetX: 0,
          offsetY: 4
        } : undefined)
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 12,
      color: 'rgba(0,0,0,0.08)',
      offsetX: 0,
      offsetY: 4
    })
  }

  // 构建发布内容区域
  @Builder
  buildPublishContent() {
    Column() {
      // 用户信息
      Row() {
        Image(this.userProfile.avatar)
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#F1F5F9')

        Column() {
          Text(this.userProfile.username)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Text('分享你的想法...')
            .fontSize(12)
            .fontColor('#64748B')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .padding({ left: 20, right: 20, top: 20, bottom: 16 })

      // 文本输入区域
      Column() {
        TextArea({
          placeholder: '分享你的想法...',
          text: this.publishText
        })
          .onChange((value: string) => {
            this.publishText = value
            this.textError = ''
          })
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .padding(16)
          .width('100%')
          .height(120)
          .fontSize(16)
          .fontColor('#1E293B')
          .border({
            width: 1,
            color: this.textError ? '#EF4444' : '#E2E8F0'
          })
          .maxLength(150)

        // 字符计数和错误提示
        Row() {
          if (this.textError) {
            Row() {
              Image($r('app.media.share_btn_Normal'))
                .width(14)
                .height(14)
                .fillColor('#EF4444')
                .margin({ right: 6 })

              Text(this.textError)
                .fontSize(12)
                .fontColor('#EF4444')
            }
          }

          Blank()

          Text(`${this.publishText.length}/150`)
            .fontSize(12)
            .fontColor(this.publishText.length > 120 ? '#F59E0B' : '#94A3B8')
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 20 })

      // 图片选择区域
      Column() {
        if (this.selectedImage) {
          // 显示已选择的图片
          Stack() {
            Image(this.selectedImage)
              .width('100%')
              .height(200)
              .borderRadius(12)
              .objectFit(ImageFit.Cover)

            // 删除按钮
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill('rgba(0,0,0,0.6)')

              Image($r('app.media.share_btn_Normal'))
                .width(16)
                .height(16)
                .fillColor('#FFFFFF')
            }
            .position({ x: '90%', y: '10%' })
            .onClick(() => this.removeImage())
          }
          .width('100%')
          .margin({ bottom: 16 })
        } else {
          // 图片选择按钮
          Button('添加图片', { type: ButtonType.Normal })
            .onClick(() => this.selectImage())
            .backgroundColor('#F0F4FF')
            .fontColor('#6366F1')
            .borderRadius(12)
            .height(60)
            .width('100%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .border({ width: 1, color: '#E0E7FF' })
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 20 })

      // 发布提示
      Column() {
        Row() {
          Circle()
            .width(4)
            .height(4)
            .fill('#94A3B8')
            .margin({ right: 8 })

          Text('发布须知')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#64748B')
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 8 })

        Text('请确保内容健康向上，遵守社区规范')
          .fontSize(12)
          .fontColor('#94A3B8')
          .textAlign(TextAlign.Center)
          .lineHeight(18)
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 16, bottom: 32 })
      .backgroundColor('#F8FAFC')
      .borderRadius(12)
      .margin({ left: 20, right: 20 })
    }
    .width('100%')
  }
}
