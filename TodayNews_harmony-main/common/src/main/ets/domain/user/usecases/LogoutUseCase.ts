import type { UserRepository } from '../UserRepository'

export class LogoutUseCase {
  constructor(private readonly repo: UserRepository) {}
  execute(): void {
    this.repo.logout()
  }
}


