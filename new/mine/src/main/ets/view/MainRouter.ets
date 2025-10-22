// MainRouter.ets
import { AuthenticationPage } from './AuthenticationPage'
import { EditProfilePage } from './EditProfilePage'
import { PublishPage } from './PublishPage'
import { MinePage } from '../pages/MinePage' // 根据您的结构，可能需要导入主页面

@Component
export struct MainRouter {
  @LocalStorageLink('currentPage') currentPage: string = 'main'

  build() {
    Column() {
      if (this.currentPage === 'main') {
        // 原来的主页面内容 - 根据您的项目结构，这里应该是 MinePage
        MinePage()
      } else if (this.currentPage === 'authentication') {
        AuthenticationPage()
      } else if (this.currentPage === 'editProfile') {
        EditProfilePage()
      } else if (this.currentPage === 'publish') {
        PublishPage()
      }
    }
    .width('100%')
    .height('100%')
  }
}