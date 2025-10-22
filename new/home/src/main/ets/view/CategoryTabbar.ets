import categoryTitleViewModel from '../viewmodel/CategoryTitleViewModel'
import display from '@ohos.display';
import NewsDataList from './NewsDataList';
import { EmptyPage, FailureLayout, ResManager, TabBarLayout } from 'common';
import promptAction from '@ohos.promptAction';
import { HotListView } from './HotListView';

interface CustomListItem {
  index: number;
}

@Component
export default struct CategoryTabBar {
  @State tabBarArray: string[] = categoryTitleViewModel.getDefaultCategoryList();
  @State currentIndex: number = 0;
  @State displayWidth: number = 0;
  @Link needChange: boolean;


  aboutToAppear() {

    let displayClass = display.getDefaultDisplaySync();

    this.displayWidth = px2vp(displayClass.width);

  }

  @Builder
  newsListView(index: number) {
    // 热榜页面使用独立的组件
    if (index === 1) {
      HotListView()
    } else {
      // 其他所有新闻分类页面都使用NewsDataList组件
      NewsDataList({ categoryId: $currentIndex, pageIndex: index })
    }
  }



  build() {

    Scroll() {
      Flex({ direction: FlexDirection.Column }) {
        TabBarLayout({
          titleArr: $tabBarArray,
          offsetHeight: 56 + 60,
          colorChangeIndex: 1,
          bgChangeColor: ResManager.getDefaultColor(),
          fontChangeSelectedColor: "#BBDEFB",
          fontChangeNormalColor: "#FFFFFF",

                              customList: (item: CustomListItem) => {
            this.newsListView(item.index)


          },
          changeColor: (changeColor: boolean) => {
            this.needChange = changeColor;
          },
          tabSelected: (position: number, title: string) => {

            promptAction.showToast({
              message: `点击了第 ${position} 页面，标题为：${title}`,
              duration: 2000,
            });

          }
        })
      }

    }
  }
}