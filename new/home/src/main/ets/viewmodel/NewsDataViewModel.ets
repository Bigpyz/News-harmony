
import { Constants, httpRequestGet, httpRequestJuheGet, ResponseResult } from 'common';
import { DataModel, ImageList } from '../model/DataModel';
import { httpRequestGetHtml } from 'common/src/main/ets/utils/HttpUtil';

// Define a type for the news items from Juhe API
interface JuheNewsItem {
  uniquekey: string;
  title: string;
  date: string;
  category: string;
  author_name: string;
  url: string;
  thumbnail_pic_s: string;
  thumbnail_pic_s02: string;
  thumbnail_pic_s03: string;
  is_content: string;
}

// Define a type for the content response from Juhe API
interface JuheContentData {
  content: string;
}




class NewsDataViewModel {


  getNewsList(currentPage: number, categoryId: number, timeStamp?: number): Promise<ResponseResult> {
    return new Promise(async (resolve: Function, reject: Function) => {
      // 使用聚合数据API
      let url = `${Constants.JUHE_SERVER}/${Constants.JUHE_NEWS_LIST}`;

      // 构建请求参数
      const params = new Map<string, string | number | boolean | object>();
      params.set('type', this.getCategoryType(categoryId));
      params.set('page', currentPage);
      params.set('page_size', 20);
      params.set('is_filter', 1); // 只返回有内容详情的新闻

      httpRequestJuheGet(url, params).then((data: ResponseResult) => {
        if (data.code === Constants.SERVER_CODE_SUCCESS) {
          // 转换数据格式以适配现有组件
          const convertedData = this.convertJuheDataToDataModel(data.data as JuheNewsItem[], currentPage);
          data.data = convertedData;
          resolve(data);
        } else {
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {

        reject($r('app.string.http_error_message'));
      });
    });
  }

  /**
   * 根据分类ID获取聚合数据API的分类类型
   */
  private getCategoryType(categoryId: number): string {
    const categoryMap: Record<number, string> = {
      0: 'top',      // 全部
      // 1: '热榜' (特殊处理，不在此映射)
      2: 'guonei',   // 国内
      3: 'guoji',    // 国际
      4: 'yule',     // 娱乐
      5: 'tiyu',     // 体育
      6: 'junshi',   // 军事
      7: 'keji',     // 科技
      8: 'caijing',  // 财经
      9: 'youxi',    // 游戏
      10: 'qiche',    // 汽车
      11: 'jiankang' // 健康
    };
    return categoryMap[categoryId] || 'top';
  }

  /**
   * 将聚合数据API返回的数据转换为DataModel格式
   */
  private convertJuheDataToDataModel(juheData: JuheNewsItem[], currentPage: number): DataModel[] {
    if (!juheData || !Array.isArray(juheData)) {
      return [];
    }

    return juheData.map((item: JuheNewsItem, index: number) => {
      const dataModel = new DataModel();

      // 聚合数据API字段映射
      dataModel.uniquekey = item.uniquekey || '';
      dataModel.title = item.title || '';
      dataModel.date = item.date || '';
      dataModel.category = item.category || '';
      dataModel.author_name = item.author_name || '';
      dataModel.url = item.url || '';
      dataModel.thumbnail_pic_s = item.thumbnail_pic_s || '';
      dataModel.thumbnail_pic_s02 = item.thumbnail_pic_s02 || '';
      dataModel.thumbnail_pic_s03 = item.thumbnail_pic_s03 || '';
      dataModel.is_content = item.is_content || '';

      // 映射到原有字段以兼容现有组件
      dataModel.media_name = item.author_name || '';
      dataModel.datetime = item.date || '';
      dataModel.item_id = item.uniquekey || '';
      dataModel.article_url = item.url || '';
      dataModel.image_url = item.thumbnail_pic_s || '';
      dataModel.large_image_url = item.thumbnail_pic_s || '';

      // 前五条新闻强制设置为非视频模式
      const globalIndex = (currentPage - 1) * 20 + index;
      if (globalIndex < 5) {
        dataModel.force_text_mode = true;
        dataModel.large_mode = false;
        dataModel.has_video = false;
        dataModel.has_mp4_video = 0;
        dataModel.has_m3u8_video = 0;

        // 根据图片数量决定展示模式
        if (item.thumbnail_pic_s03) {
          dataModel.more_mode = true; // 三图模式
          dataModel.image_list = [
            { url: item.thumbnail_pic_s, width: '100', height: 100 },
            { url: item.thumbnail_pic_s02, width: '100', height: 100 },
            { url: item.thumbnail_pic_s03, width: '100', height: 100 }
          ];
        } else if (item.thumbnail_pic_s) {
          dataModel.middle_mode = true; // 右侧有图模式
        }
      } else {
        // 第六条及以后的新闻可以正常展示
        if (item.thumbnail_pic_s03) {
          dataModel.more_mode = true;
          dataModel.image_list = [
            { url: item.thumbnail_pic_s, width: '100', height: 100 },
            { url: item.thumbnail_pic_s02, width: '100', height: 100 },
            { url: item.thumbnail_pic_s03, width: '100', height: 100 }
          ];
        } else if (item.thumbnail_pic_s) {
          dataModel.middle_mode = true;
        }
      }

      return dataModel;
    });
  }




  getArticleHtmlData(articleId: string): Promise<ResponseResult> {
    return new Promise(async (resolve: Function, reject: Function) => {
      // 使用聚合数据新闻详情API
      let url = `${Constants.JUHE_SERVER}/${Constants.JUHE_NEWS_CONTENT}`;

      const params = new Map<string, string | number | boolean | object>();
      params.set('uniquekey', articleId);

      httpRequestJuheGet(url, params).then((data: ResponseResult) => {
        if (data.code === Constants.SERVER_CODE_SUCCESS) {
          // 转换聚合数据API的响应格式
          const convertedData = this.convertJuheContentData(data.data as JuheContentData);
          data.data = convertedData;
          resolve(data);
        } else {
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        reject($r('app.string.http_error_message'));
      });
    });
  }

  /**
   * 转换聚合数据新闻详情API的响应数据
   */
  private convertJuheContentData(juheContentData: JuheContentData): string {
    if (!juheContentData) {
      return '';
    }

    // 聚合数据API返回的是包含content字段的对象
    return juheContentData.content || '';
  }



}


let newsDataViewModel = new NewsDataViewModel();

export default newsDataViewModel as NewsDataViewModel;