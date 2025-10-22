import type { UserRepository } from '../../domain/user/UserRepository'
import type { User } from '../../domain/user/User'
import { UserLocalDataSource } from './UserLocalDataSource'

export class UserRepositoryImpl implements UserRepository {
  private readonly local: UserLocalDataSource

  constructor(local: UserLocalDataSource = new UserLocalDataSource()) {
    this.local = local
  }

  async login(username: string, password: string): Promise<User> {
    const user = await this.local.login(username, password)
    AppStorage.SetOrCreate('currentUser', user as User)
    AppStorage.SetOrCreate('isLoggedIn', true)
    return user
  }

  async register(username: string, password: string): Promise<User> {
    const user = await this.local.register(username, password)
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
