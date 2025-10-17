import type { User } from '../User'
import type { UserRepository } from '../UserRepository'

export class RegisterUseCase {
  constructor(private readonly repo: UserRepository) {}
  execute(username: string, password: string): Promise<User> {
    return this.repo.register(username, password)
  }
}


