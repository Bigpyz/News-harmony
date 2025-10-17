import http from '@ohos.net.http';
import { Constants, ContentType } from '../constants/Constants';
import { ResponseResult } from './ResponseResult';

// 定义请求参数类型
export type HttpParams = Map<string, string | number | boolean | object>;

/**
 * GET请求
 * @param url 请求地址
 * @returns 响应结果Promise
 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
    return httpRequest(url, http.RequestMethod.GET);
}

/**
 * POST请求
 * @param url 请求地址
 * @param params 请求参数
 * @returns 响应结果Promise
 */
export function httpRequestPost(url: string, params: HttpParams): Promise<ResponseResult> {
    return httpRequest(url, http.RequestMethod.POST, params);
}

/**
 * 获取HTML内容的GET请求
 * @param url 请求地址
 * @returns 响应结果Promise
 */
export function httpRequestGetHtml(url: string): Promise<ResponseResult> {
    const httpRequest = http.createHttp();
    const serverData = new ResponseResult();

    return httpRequest.request(url, {
        method: http.RequestMethod.GET,
        header: {
            'Content-Type': ContentType.JSON,
            'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.2 Mobile/15E148 Safari/621.1'
        },
    })
        .then((value: http.HttpResponse) => {
            if (value.responseCode === Constants.HTTP_CODE_200) {
                serverData.data = `${value.result}`;
                serverData.code = 'success';
                serverData.msg = value.header['set-cookie'] || '';
            } else {
                serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
            }
            return serverData;
        })
        .catch((error: Error) => {
            serverData.msg = `${$r('app.string.http_error_message')}: ${error.message}`;
            return serverData;
        })
        .finally(() => {
            // 销毁HTTP实例，避免内存泄漏
            httpRequest.destroy();
        });
}

/**
 * 通用HTTP请求函数
 * @param url 请求地址
 * @param method 请求方法
 * @param params 请求参数
 * @returns 响应结果Promise
 */
function httpRequest(
    url: string,
    method: http.RequestMethod,
    params?: HttpParams
): Promise<ResponseResult> {
    const httpRequest = http.createHttp();
    const serverData = new ResponseResult();

    // 处理请求参数
    let extraData: Record<string, string | number | boolean | object> | undefined = undefined;
    if (params) {
        extraData = {} as Record<string, string | number | boolean | object>;
        params.forEach((value: string | number | boolean | object, key: string) => {
            extraData![key] = value;
        });
    }

    return httpRequest.request(url, {
        method: method,
        header: {
            'Content-Type': ContentType.JSON,
        },
        extraData: extraData
    })
        .then((value: http.HttpResponse) => {
            if (value.responseCode === Constants.HTTP_CODE_200) {
                const result = `${value.result}`;
                const resultJson = JSON.parse(result) as ResponseResult;

                serverData.data = resultJson.data;
                serverData.code = 'success';
                serverData.msg = resultJson.msg;
                serverData.has_more = resultJson.has_more;
                serverData.return_count = resultJson.return_count;
                serverData.page_id = resultJson.page_id;
            } else {
                serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
            }
            return serverData;
        })
        .catch((error: Error) => {
            serverData.msg = `${$r('app.string.http_error_message')}: ${error.message}`;
            return serverData;
        })
        .finally(() => {
            // 销毁HTTP实例，避免内存泄漏
            httpRequest.destroy();
        });
}
