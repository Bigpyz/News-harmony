import type { UserRepository } from '../../domain/user/UserRepository'
import type { User } from '../../domain/user/User'
import { UserRemoteDataSource } from './UserRemoteDataSource'

export class UserRepositoryImpl implements UserRepository {
  private readonly remote: UserRemoteDataSource

  constructor(remote: UserRemoteDataSource = new UserRemoteDataSource()) {
    this.remote = remote
  }

  async login(username: string, password: string): Promise<User> {
    const user = await this.remote.login(username, password)
    AppStorage.SetOrCreate('currentUser', user as User)
    AppStorage.SetOrCreate('isLoggedIn', true)
    return user
  }

  async register(username: string, password: string): Promise<User> {
    const user = await this.remote.register(username, password)
    AppStorage.SetOrCreate('currentUser', user as User)
    AppStorage.SetOrCreate('isLoggedIn', true)
    return user
  }

  getCurrentUser(): User | undefined {
    return AppStorage.Get('currentUser') as User | undefined
  }

  isLoggedIn(): boolean {
    return (AppStorage.Get('isLoggedIn') as boolean) ?? false
  }

  logout(): void {
    AppStorage.SetOrCreate('currentUser', undefined)
    AppStorage.SetOrCreate('isLoggedIn', false)
  }
}
