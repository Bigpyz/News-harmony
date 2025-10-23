// Index.ets
import { MainRouter } from '../view/MainRouter'

@Entry
@Component
struct Index {
  build() {
    Column() {
      MainRouter()
    }
    .width('100%')
    .height('100%')
  }
}