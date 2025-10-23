class CategoryTitleViewModel {

  // static readonly TabBars_DEFAULT_NEWS_TYPES: Array<NewsTypeBean> = [
  //   { id: 0, name: '全部' },
  //   { id: 1, name: '国内' },
  //   { id: 2, name: '国际' },
  //   { id: 3, name: '娱乐' },
  //   { id: 4, name: '军事' },
  //   { id: 5, name: '体育' },
  //   { id: 6, name: '科技' },
  static readonly TabBars_DEFAULT_NEWS_TYPES: Array<string> = [
    '全部',
    '热榜',
    '国内',
    '国际',
    '娱乐',
    '体育',
    '军事',
    '科技',
    '财经',
    '游戏',
    '汽车',
    '健康'
  ];


  // getDefaultCategoryList():NewsTypeBean[]{
  //
  //   return CategoryTitleViewModel.TabBars_DEFAULT_NEWS_TYPES;
  // }

  getDefaultCategoryList(): string[] {

    return CategoryTitleViewModel.TabBars_DEFAULT_NEWS_TYPES;
  }
}


export class NewsTypeBean {
  id: number = 0;
  name: ResourceStr = '';
}


let categoryTitleViewModel = new CategoryTitleViewModel();

export default categoryTitleViewModel as CategoryTitleViewModel;