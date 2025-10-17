import type { User } from '../../domain/user/User'
import { UserRepositoryImpl } from '../../data/user/UserRepositoryImpl'
import { LoginUseCase } from '../../domain/user/usecases/LoginUseCase'
import { RegisterUseCase } from '../../domain/user/usecases/RegisterUseCase'
import { GetCurrentUserUseCase } from '../../domain/user/usecases/GetCurrentUserUseCase'
import { IsLoggedInUseCase } from '../../domain/user/usecases/IsLoggedInUseCase'
import { LogoutUseCase } from '../../domain/user/usecases/LogoutUseCase'

export class UserStore {
  private readonly loginUseCase: LoginUseCase
  private readonly registerUseCase: RegisterUseCase
  private readonly getCurrentUserUseCase: GetCurrentUserUseCase
  private readonly isLoggedInUseCase: IsLoggedInUseCase
  private readonly logoutUseCase: LogoutUseCase

  constructor() {
    const repo = new UserRepositoryImpl()
    this.loginUseCase = new LoginUseCase(repo)
    this.registerUseCase = new RegisterUseCase(repo)
    this.getCurrentUserUseCase = new GetCurrentUserUseCase(repo)
    this.isLoggedInUseCase = new IsLoggedInUseCase(repo)
    this.logoutUseCase = new LogoutUseCase(repo)
  }

  async login(username: string, password: string): Promise<User> {
    return this.loginUseCase.execute(username, password)
  }

  async register(username: string, password: string): Promise<User> {
    return this.registerUseCase.execute(username, password)
  }

  getCurrentUser(): User | undefined {
    return this.getCurrentUserUseCase.execute()
  }

  isLoggedIn(): boolean {
    return this.isLoggedInUseCase.execute()
  }

  logout(): void {
    this.logoutUseCase.execute()
  }
}
