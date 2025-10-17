import type { User } from '../User'
import type { UserRepository } from '../UserRepository'

export class LoginUseCase {
  constructor(private readonly repo: UserRepository) {}
  execute(username: string, password: string): Promise<User> {
    return this.repo.login(username, password)
  }
}


