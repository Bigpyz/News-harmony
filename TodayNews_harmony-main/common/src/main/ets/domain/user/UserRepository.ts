import type { User } from './User'

export interface UserRepository {
  login(username: string, password: string): Promise<User>
  register(username: string, password: string): Promise<User>
  getCurrentUser(): User | undefined
  isLoggedIn(): boolean
  logout(): void
}


