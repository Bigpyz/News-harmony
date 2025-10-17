import type { User } from '../User'
import type { UserRepository } from '../UserRepository'

export class GetCurrentUserUseCase {
  constructor(private readonly repo: UserRepository) {}
  execute(): User | undefined {
    return this.repo.getCurrentUser()
  }
}


