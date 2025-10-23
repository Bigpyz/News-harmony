import { DataModel } from '../model/DataModel'
import NewsDataViewModel from '../viewmodel/NewsDataViewModel'
import systemTime from '@ohos.systemDateTime'
import { FailureLayout, LoadingLayout, RefreshPullView, ResponseResult } from 'common';
import { PageState } from 'common/src/main/ets/constants/Constants';
import { TopNewsView } from './TopNewsView';
import { MoreNewsView } from './MoreNewsView';
import { MiddleNewsView } from './MiddleNewsView';
import { LargeNewsView } from './LargeNewsView';
import router from '@ohos.router';


@Component
export default struct NewsDataList {
  @Watch('changeCategory') @Link categoryId: number;
  @Link searchKeyword: string; // 接收搜索关键词
  pageIndex: number = 1;
  @State dataList: Array<DataModel> = [];
  @State currentPage: number = 1;
  @State pageCount: number = 20;
  @State timeStamp: number = 0;
  @State count: number = 0;
  @State responseData: ResponseResult = new ResponseResult();
  @State aaa: string = '000';
  @State ccc: number = 0;
  scroller: Scroller = new Scroller();
  @State tipCount: number = 0;
  @State pageState: PageState = PageState.Loading;

  // 根据关键词过滤新闻列表
  getFilteredDataList(): Array<DataModel> {
    if (!this.searchKeyword || this.searchKeyword.trim() === '') {
      return this.dataList;
    }
    return this.dataList.filter(item =>
      item.title.toLowerCase().includes(this.searchKeyword.toLowerCase())
    );
  }

  // 重新开放所有分类的接口请求
  private isApiEnabled(): boolean {
    return true;
  }


  // 当分类ID发生变化时，触发新闻刷新
  changeCategory() {
    // 只有当当前选中的页面是自己时，才刷新数据
    if (this.categoryId === this.pageIndex) {
      this.refreshNewsData();
    }
  }

  // 页面首次出现时，加载新闻数据
  aboutToAppear() {
    this.refreshNewsData();
  }

  refreshNewsData() {

    return new Promise<string>((resolve, reject) => {
      // 禁用除“全部(0)”和“国内(2)”外的分类接口调用
      if (!this.isApiEnabled()) {
        this.pageState = PageState.Success;
        this.responseData = new ResponseResult();
        this.dataList = [];
        this.tipCount = 0;
        resolve('该分类已禁用接口调用');
        return;
      }

      NewsDataViewModel.getNewsList(this.currentPage, this.pageIndex)
        .then((data: ResponseResult) => {
          this.pageState = PageState.Success;
          this.responseData = data;
          this.dataList = data.data as Array<DataModel>;
          this.tipCount = this.dataList.length;
          resolve('刷新成功')
        }).catch(() => {
        resolve('')
      })

    })


  }

  loadMoreNewsData() {

    return new Promise<string>((resolve, reject) => {
      systemTime.getCurrentTime(false, (error, time) => {
        this.timeStamp = Math.trunc(time / 1000);
        NewsDataViewModel.getNewsList(this.currentPage, this.pageIndex, this.timeStamp)
          .then((value: ResponseResult) => {
            this.responseData = value;
            let temp = value.data as Array<DataModel>;
            this.dataList = this.dataList.concat(temp);
            resolve('刷新成功')
          }).catch(() => {
          resolve('')
        })
      })

    })
  }

  @Builder
  private getListView() {

    List({ scroller: this.scroller }) {
      ForEach(this.getFilteredDataList(), (item: DataModel) => {
        ListItem() {
          // 根据force_text_mode决定是否强制使用非视频组件
          if (item.force_text_mode) {
            if (item.more_mode) {
              MoreNewsView({ itemData: item }); // 三图
            } else if (item.middle_mode) {
              MiddleNewsView({ itemData: item }); // 右侧有图
            } else {
              TopNewsView({ itemData: item }); // 默认使用TopNewsView
            }
          } else {
            // 原有逻辑
            if (item.label) {
              TopNewsView({ itemData: item });
            } else if (item.more_mode) {
              MoreNewsView({ itemData: item });
            } else if (item.middle_mode) {
              MiddleNewsView({ itemData: item });
            } else if (item.large_mode) {
              LargeNewsView({ itemData: item });
            }
          }
          //
          {
            Text(item.title)
              .height(100)
          }

        }
        .onClick(()=>{
          router.pushUrl({url:"@bundle:com.news.today/home/ets/pages/DetailPage",params:item})

        })
      }, (item: DataModel) => JSON.stringify(item))

    }
    .backgroundColor(Color.White)

  }

  @Builder ListLayout() {

    RefreshPullView({
      dataCount: this.tipCount,
            onRefresh: (): Promise<string> => this.refreshNewsData(),
            onLoadMore: (): Promise<string> => this.loadMoreNewsData(),
      customList: () => {
        this.getListView()
      }

    })

  }

  build() {

    Column() {

      if (this.pageState === PageState.Loading) {
        // 加载页面
        LoadingLayout()

      } else if (this.pageState === PageState.Success) {

        Stack() {
          // 数据列表页面
          this.ListLayout()
        }

      } else {

        // 加载失败页面
        FailureLayout({ reloadAction: () => {
          this.loadMoreNewsData()
        } })
      }

    }

  }
}