import http from '@ohos.net.http';

export interface ApiResponse<T> {
  code: number;
  message: string;
  data: T;
}

export class HttpService {
  private static instance: HttpService;
  private baseUrl: string = 'http://117.72.48.167:8023';

  private constructor() {}

  static getInstance(): HttpService {
    if (!HttpService.instance) {
      HttpService.instance = new HttpService();
    }
    return HttpService.instance;
  }

  /**
   * 发送GET请求
   * @param endpoint 接口路径
   * @returns Promise<T>
   */
  async get<T>(endpoint: string): Promise<ApiResponse<T>> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      
      httpRequest.request(this.baseUrl + endpoint, {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }).then((response) => {
        if (response.responseCode === 200) {
          try {
            const result: ApiResponse<T> = JSON.parse(response.result as string);
            resolve(result);
          } catch (error) {
            reject(new Error('解析响应数据失败'));
          }
        } else {
          reject(new Error(`请求失败，状态码: ${response.responseCode}`));
        }
      }).catch((error: Error) => {
        reject(error);
      }).finally(() => {
        httpRequest.destroy();
      });
    });
  }

  /**
   * 发送POST请求
   * @param endpoint 接口路径
   * @param data 请求数据
   * @returns Promise<T>
   */
  async post<T>(endpoint: string, data: Record<string, Object | string | number | boolean>): Promise<ApiResponse<T>> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      
      httpRequest.request(this.baseUrl + endpoint, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(data)
      }).then((response) => {
        if (response.responseCode === 200) {
          try {
            const result: ApiResponse<T> = JSON.parse(response.result as string);
            resolve(result);
          } catch (error) {
            reject(new Error('解析响应数据失败'));
          }
        } else {
          reject(new Error(`请求失败，状态码: ${response.responseCode}`));
        }
      }).catch((error: Error) => {
        reject(error);
      }).finally(() => {
        httpRequest.destroy();
      });
    });
  }
}
