import { httpRequestPost, HttpParams } from '../../utils/HttpUtil'
import type { User } from '../../domain/user/User'

export class UserRemoteDataSource {
  async login(username: string, password: string): Promise<User> {
    const params: HttpParams = new Map<string, string>()
    params.set('username', username)
    params.set('password', password)
    const res = await httpRequestPost('https://www.123.com/login', params)
    const data = res.data as { user?: User } | User
    return (data as { user?: User }).user ?? (data as User)
  }

  async register(username: string, password: string): Promise<User> {
    const params: HttpParams = new Map<string, string>()
    params.set('username', username)
    params.set('password', password)
    const res = await httpRequestPost('https://www.123.com/register', params)
    const data = res.data as { user?: User } | User
    return (data as { user?: User }).user ?? (data as User)
  }
}


