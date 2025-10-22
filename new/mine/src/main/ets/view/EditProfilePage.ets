import prompt from '@ohos.promptAction';
import type { UserProfile } from '../viewmodel/UserProfileData'
import { UserProfileManager } from '../viewmodel/UserProfileData'

// 用户资料数据管理类
class LegacyUserProfileManager {
  static updateUsername(username: string) {
    console.log('更新用户名:', username);
    AppStorage.set('username', username);
  }

  static updateBio(bio: string) {
    console.log('更新简介:', bio);
    AppStorage.set('bio', bio);
  }

  static updateGender(gender: string) {
    console.log('更新性别:', gender);
    AppStorage.set('gender', gender);
  }

  static updateBirthday(birthday: string) {
    console.log('更新生日:', birthday);
    AppStorage.set('birthday', birthday);
  }

  static updateSchool(school: string) {
    console.log('更新学校:', school);
    AppStorage.set('school', school);
  }

  static updateOccupation(occupation: string) {
    console.log('更新职业:', occupation);
    AppStorage.set('occupation', occupation);
  }

  // 计算资料完成度
  static calculateCompletionRate(username: string, bio: string, gender: string, birthday: string, school: string, occupation: string): number {
    let completedFields = 0;
    const totalFields = 6;

    if (username && !username.includes('填写')) completedFields++;
    if (bio && !bio.includes('填写')) completedFields++;
    if (gender && !gender.includes('填写')) completedFields++;
    if (birthday && !birthday.includes('填写')) completedFields++;
    if (school && !school.includes('填写')) completedFields++;
    if (occupation && !occupation.includes('填写')) completedFields++;

    return Math.round((completedFields / totalFields) * 100);
  }
}

@Component
export struct EditProfilePage {
  @LocalStorageLink('currentPage') currentPage: string = 'main'
  @StorageLink('userProfile') userProfile: UserProfile = UserProfileManager.getDefaultProfile()
  @State completionRate: number = 50
  @State showEditDialog: boolean = false
  @State currentEditField: string = ''
  @State editValue: string = ''
  @State avatar: Resource = $r('app.media.share_btn_Normal')
  @State refreshKey: number = 0 // 用于强制刷新
  @State inputError: string = '' // 输入错误提示

  // 返回上一页
  goBack() {
    this.currentPage = 'main'
  }

  // 刷新页面
  refreshPage() {
    // 通过改变refreshKey来触发页面重新渲染
    this.refreshKey += 1
    this.updateCompletionRate()

    prompt.showToast({
      message: `页面以刷新，${this.userProfile.username}`,
      duration: 1000
    })
  }

  // 更新完成度
  updateCompletionRate() {
    this.completionRate = UserProfileManager.calculateCompletionRate(this.userProfile)
  }

  // 处理资料项点击
  handleItemClick(field: string) {
    this.currentEditField = field
    this.editValue = this.getFieldValue(field)
    this.inputError = ''
    this.showEditDialog = true
  }

  // 获取字段值
  getFieldValue(field: string): string {
    switch (field) {
      case 'username': return this.userProfile.username
      case 'bio': return this.userProfile.bio
      case 'gender': return this.userProfile.gender
      case 'birthday': return this.userProfile.birthday
      case 'school': return this.userProfile.school
      case 'occupation': return this.userProfile.occupation
      default: return ''
    }
  }

  // 验证输入
  validateInput(field: string, value: string): boolean {
    this.inputError = ''

    switch (field) {
      case 'username':
        if (value.length > 10) {
          this.inputError = '用户名不能超过10个字符'
          return false
        }
        break
      case 'bio':
        if (value.length > 20) {
          this.inputError = '简介不能超过20个字符'
          return false
        }
        break
      case 'birthday':
        // 验证是否为数字且在0-1000范围内
        const age = parseInt(value)
        if (isNaN(age) || !/^\d+$/.test(value)) {
          this.inputError = '年龄只能输入数字'
          return false
        }
        if (age < 0 || age > 1000) {
          this.inputError = '年龄必须在0-1000范围内'
          return false
        }
        break
      case 'school':
        if (value.length > 10) {
          this.inputError = '学校名称不能超过10个字符'
          return false
        }
        break
      case 'occupation':
        if (value.length > 10) {
          this.inputError = '职业不能超过10个字符'
          return false
        }
        break
    }
    return true
  }

  // 获取最大长度限制
  getMaxLength(field: string): number {
    switch (field) {
      case 'username': return 10
      case 'bio': return 20
      case 'school': return 10
      case 'occupation': return 10
      default: return 50 // 默认值
    }
  }

  // 获取输入类型
  getInputType(field: string): InputType {
    if (field === 'birthday') {
      return InputType.Number
    }
    return InputType.Normal
  }

  // 保存编辑
  saveEdit() {
    // 验证输入
    if (!this.validateInput(this.currentEditField, this.editValue)) {
      prompt.showToast({
        message: this.inputError,
        duration: 2000
      })
      return
    }

    // 通过UserProfileManager更新AppStorage，@StorageLink会自动同步
    switch (this.currentEditField) {
      case 'username':
        UserProfileManager.updateUsername(this.editValue)
        break
      case 'bio':
        UserProfileManager.updateBio(this.editValue)
        break
      case 'gender':
        UserProfileManager.updateGender(this.editValue)
        break
      case 'birthday':
        UserProfileManager.updateBirthday(this.editValue)
        break
      case 'school':
        UserProfileManager.updateSchool(this.editValue)
        break
      case 'occupation':
        UserProfileManager.updateOccupation(this.editValue)
        break
    }

    this.updateCompletionRate()
    this.showEditDialog = false

    // 显示保存成功提示
    prompt.showToast({
      message: '保存成功',
      duration: 2000
    })
  }

  // 取消编辑
  cancelEdit() {
    this.showEditDialog = false
    this.inputError = ''
  }

  // 构建顶部导航栏
  @Builder
  buildTopNavigation() {
    Column() {
      // 导航栏内容
      Row() {
        // 返回按钮 - 美化设计
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

          Image($r('app.media.share_btn_Normal'))
            .width(20)
            .height(20)
            .fillColor('#475569')
        }
        .onClick(() => this.goBack())

        // 标题和完成度 - 美化设计
        Column() {
        Text('编辑资料')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 16 })

        Blank()

        // 刷新按钮 - 美化设计
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

          Image($r('app.media.share_btn_Normal'))
            .width(20)
            .height(20)
            .fillColor('#475569')
        }
        .onClick(() => this.refreshPage())
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
    .width('100%')
  }

  build() {
    Stack() {
      Column() {
        // 顶部导航栏 - 美化设计
        this.buildTopNavigation()

        Scroll() {
          Column() {
            // 使用refreshKey来强制重新构建内容
            this.buildProfileContent()
          }
          .width('100%')
        }
        .flexGrow(1)
        .backgroundColor('#F8FAFC')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .onAppear(() => {
        this.updateCompletionRate()
      })

      // 编辑弹窗
      if (this.showEditDialog) {
        this.buildEditDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  // 构建资料内容区域 - 单独提取出来以便刷新
  @Builder
  buildProfileContent() {
    Column() {
      // 头像区域 - 美化设计
      Column() {
        // 头像容器
        Stack() {
          // 头像背景渐变
          Circle()
            .width(120)
            .height(120)
            .fill('#E0E7FF')
            .shadow({
              radius: 20,
              color: 'rgba(99, 102, 241, 0.3)',
              offsetX: 0,
              offsetY: 8
            })

          // 头像图片
          Image(this.avatar)
            .width(100)
            .height(100)
            .borderRadius(50)
            .backgroundColor('#F1F5F9')
            .border({ width: 4, color: '#FFFFFF' })

          // 相机图标 - 美化设计
          Stack() {
            Circle()
              .width(36)
              .height(36)
              .fill('#6366F1')
              .shadow({
                radius: 8,
                color: 'rgba(99, 102, 241, 0.4)',
                offsetX: 0,
                offsetY: 4
              })

            Image($r('app.media.share_btn_Normal'))
              .width(18)
              .height(18)
              .fillColor('#FFFFFF')
          }
          .position({ x: '75%', y: '75%' })
        }
        .margin({ bottom: 16 })

        // 更换头像按钮 - 美化设计
        Button('更换头像', { type: ButtonType.Normal })
          .fontSize(14)
          .fontColor('#6366F1')
          .backgroundColor('#F0F4FF')
          .borderRadius(20)
          .padding({ left: 20, right: 20, top: 8, bottom: 8 })
          .border({ width: 1, color: '#E0E7FF' })
          .onClick(() => {
            // 头像选择逻辑
            prompt.showToast({
              message: '头像选择功能开发中',
              duration: 2000
            })
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 32, bottom: 24 })

      // 资料列表 - 美化设计
      Column() {
        this.buildProfileItem('用户名  ', this.userProfile.username, 'username', '👤')
        this.buildProfileItem('简介  ', this.userProfile.bio, 'bio', '📝')
        this.buildProfileItem('性别  ', this.userProfile.gender, 'gender', '⚥')
        this.buildProfileItem('年龄  ', this.userProfile.birthday, 'birthday', '🎂')
        this.buildProfileItem('学校  ', this.userProfile.school, 'school', '🎓', true)
        this.buildProfileItem('职业  ', this.userProfile.occupation, 'occupation', '💼', true)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .margin({ left: 16, right: 16 })
      .shadow({
        radius: 12,
        color: 'rgba(0,0,0,0.08)',
        offsetX: 0,
        offsetY: 4
      })


    }
    .id(`profileContent_${this.refreshKey}`) // 添加key以便刷新
  }

  // 构建资料项 - 美化设计
  @Builder
  buildProfileItem(label: string, value: string, field: string, icon: string, showRedDot: boolean = false) {
    Row() {
      // 左侧图标和标签
      Row() {
        Text(icon)
          .fontSize(20)
          .margin({ right: 12 })

        Text(label)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      // 右侧内容和箭头
      Row() {
        Text(value)
          .fontSize(15)
          .fontColor(value.includes('填写') ? '#94A3B8' : '#475569')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (showRedDot) {
          Circle()
            .width(8)
            .height(8)
            .fill('#EF4444')
            .margin({ left: 8 })
        }

      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .padding({ left: 20, right: 20 })
    .border({
      width: { bottom: 1 },
      color: '#F1F5F9'
    })
    .onClick(() => this.handleItemClick(field))
    .backgroundColor('#FFFFFF')
    .borderRadius(showRedDot ? 0 : 8)
  }

  // 构建编辑弹窗 - 美化设计
  @Builder
  buildEditDialog() {
    Stack() {
      // 弹窗背景遮罩 - 美化设计
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.6)')
        .onClick(() => this.cancelEdit())

      // 弹窗内容 - 美化设计
      Column() {
        // 弹窗头部
        Row() {
          Text(this.getFieldLabel(this.currentEditField))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')

          Blank()

          // 关闭按钮
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
          .onClick(() => this.cancelEdit())
        }
        .width('100%')
        .margin({ bottom: 24 })

        // 输入框 - 美化设计
        Column() {
          TextInput({
            text: this.editValue,
            placeholder: `请输入${this.getFieldLabel(this.currentEditField)}`
          })
            .onChange((value: string) => {
              this.editValue = value
              // 实时验证
              this.validateInput(this.currentEditField, value)
            })
            .backgroundColor('#F8FAFC')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .borderRadius(12)
            .width('100%')
            .border({
              width: 1,
              color: this.inputError ? '#EF4444' : '#E2E8F0'
            })
            .fontSize(16)
            .fontColor('#1E293B')
            .maxLength(this.getMaxLength(this.currentEditField))
            .type(this.getInputType(this.currentEditField))

          // 错误提示
          if (this.inputError) {
            Row() {
              Image($r('app.media.share_btn_Normal')) // 可以使用错误图标
                .width(14)
                .height(14)
                .fillColor('#EF4444')
                .margin({ right: 6 })

              Text(this.inputError)
                .fontSize(12)
                .fontColor('#EF4444')
            }
            .alignSelf(ItemAlign.Start)
            .margin({ top: 8 })
          }

          // 字符计数
          Row() {
            Blank()
            Text(`${this.editValue.length}/${this.getMaxLength(this.currentEditField)}`)
              .fontSize(12)
              .fontColor(this.inputError ? '#EF4444' :
                this.editValue.length > this.getMaxLength(this.currentEditField) * 0.8 ? '#F59E0B' : '#94A3B8')
          }
          .width('100%')
          .margin({ top: 8 })
        }
        .width('100%')
        .margin({ bottom: 24 })

        // 按钮组 - 美化设计
        Row({ space: 12 }) {
          Button('取消', { type: ButtonType.Normal })
            .onClick(() => this.cancelEdit())
            .backgroundColor('#F1F5F9')
            .fontColor('#64748B')
            .borderRadius(12)
            .height(48)
            .flexGrow(1)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Button('确定', { type: ButtonType.Normal })
            .onClick(() => this.saveEdit())
            .backgroundColor(this.inputError ? '#94A3B8' : '#6366F1')
            .fontColor(Color.White)
            .borderRadius(12)
            .height(48)
            .flexGrow(1)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .enabled(!this.inputError) // 有错误时禁用
            .shadow(this.inputError ? undefined : {
              radius: 8,
              color: 'rgba(99, 102, 241, 0.3)',
              offsetX: 0,
              offsetY: 4
            })
        }
        .width('100%')
      }
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .backgroundColor(Color.White)
      .borderRadius(20)
      .margin({ left: 24, right: 24 })
      .shadow({
        radius: 24,
        color: 'rgba(0,0,0,0.15)',
        offsetX: 0,
        offsetY: 12
      })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }

  // 获取字段标签
  getFieldLabel(field: string): string {
    switch (field) {
      case 'username': return '用户名 '
      case 'bio': return '简介 '
      case 'gender': return '性别 '
      case 'birthday': return '年龄 '
      case 'school': return '学校 '
      case 'occupation': return '职业 '
      default: return ''
    }
  }
}