export class hotListModel {
  index: number;
  color: string;
  bgColor: string;
  text: string;
  hotWord?: string;
  icon?: Resource;

  constructor(index: number, text: string, bgColor: string, color: string, icon?: Resource, hotWord?: string,) {
    this.index = index;
    this.icon = icon;
    this.bgColor = bgColor;
    this.text = text;
    this.hotWord = hotWord;
    this.color = color;
  }
}


const hotListData: Array<hotListModel> = [
  new hotListModel(0, "习近平对三农工作做出重要指示", 'ff0000', '#ff0000', $r('app.media.hot_sticky_Normal'), ""),
  new hotListModel(1, "甘肃积石山县4.1级地震", '#FFF2E9', '#FF731F', undefined, "新"),
  new hotListModel(2, "胡赛武装将袭击美国等红海护卫船只", '#FCEBED', '#EE3A3B', undefined, "热"),
  new hotListModel(3, "种出新的丰收希望", '', '', undefined, ""),
  new hotListModel(4, "气象专家：华北地区的寒冷很另类", '#E8F1FF', '#006AFE', undefined, "解读"),
  new hotListModel(5, "积石山6.2级地震已致135人遇难", '', '', undefined, ""),
  new hotListModel(6, "美国为何未能制止胡赛武装的行动", '#E8F1FF', '#006AFE', undefined, "解读"),
  new hotListModel(7, "援甘救援队吃兰州拉面老板拒收钱", '#FCEBED', '#EE3A3B', undefined, "热"),
  new hotListModel(8, "王毅：中菲关系已站在十字路口", '', '', undefined, ""),
  new hotListModel(9, "解清帅说如果是被丢弃就不认亲", '#FFF2E9', '#FF731F', undefined, "新"),
  new hotListModel(10, "女子8名亲戚在甘肃地震中遇难", '', '', undefined, "")
]



const secondData: Array<hotListModel> = [
  new hotListModel(1, "甘肃积石山县4.1级地震", '#FFF2E9', '#FF731F', undefined, "新"),
  new hotListModel(2, "胡赛武装将袭击美国等红海护卫船只", '#FCEBED', '#EE3A3B', undefined, "热"),
  new hotListModel(3, "种出新的丰收希望", '', '', undefined, ""),
  new hotListModel(4, "气象专家：华北地区的寒冷很另类", '#E8F1FF', '#006AFE', undefined, "解读"),
  new hotListModel(5, "积石山6.2级地震已致135人遇难", '', '', undefined, "")
]

export { hotListData,secondData }



export class LocalDataManager {

  private static localDataManager: LocalDataManager;


  static instance() {
    if (!LocalDataManager.localDataManager) {
      LocalDataManager.localDataManager = new LocalDataManager();
    }
    return LocalDataManager.localDataManager;
  }


  queryFirstList() {
    return hotListData;
  }
  querySecondList() {
    return secondData;
  }

}
