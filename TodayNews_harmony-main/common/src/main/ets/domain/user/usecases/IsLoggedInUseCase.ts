import type { UserRepository } from '../UserRepository'

export class IsLoggedInUseCase {
  constructor(private readonly repo: UserRepository) {}
  execute(): boolean {
    return this.repo.isLoggedIn()
  }
}


