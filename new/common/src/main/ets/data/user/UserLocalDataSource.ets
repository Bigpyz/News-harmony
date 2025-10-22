import type { User } from '../../domain/user/User'
import preferences from '@ohos.data.preferences'

export class UserLocalDataSource {
  private static readonly PREFERENCES_NAME = 'user_preferences'
  private static readonly USERS_KEY = 'registered_users'
  
  private async getPreferences(): Promise<preferences.Preferences> {
    const context = getContext()
    return await preferences.getPreferences(context, UserLocalDataSource.PREFERENCES_NAME)
  }

  private async getRegisteredUsers(): Promise<Map<string, User>> {
    const prefs = await this.getPreferences()
    const usersJson = await prefs.get(UserLocalDataSource.USERS_KEY, '{}') as string
    const usersObj: Record<string, User> = JSON.parse(usersJson)
    const usersMap = new Map<string, User>()

    const entries = Object.entries<User>(usersObj)
    for (let i = 0; i < entries.length; i++) {
      const username: string = entries[i][0]
      const userData: User = entries[i][1]
      usersMap.set(username, userData)
    }

    return usersMap
  }

  private async saveRegisteredUsers(users: Map<string, User>): Promise<void> {
    const prefs = await this.getPreferences()
    const usersObj: Record<string, User> = {}

    const entries = users.entries()
    for (const entry of entries) {
      const username: string = entry[0]
      const userData: User = entry[1]
      usersObj[username] = userData
    }

    await prefs.put(UserLocalDataSource.USERS_KEY, JSON.stringify(usersObj))
    await prefs.flush()
  }

  async login(username: string, password: string): Promise<User> {
    const users = await this.getRegisteredUsers()
    const user = users.get(username)
    
    if (!user) {
      throw new Error('用户不存在')
    }
    
    if (user.password !== password) {
      throw new Error('密码错误')
    }
    
    // Return user without password for security
    const userWithoutPassword: User = {
      username: user.username,
      password: '',
      follow: user.follow,
      fans: user.fans,
      likes: user.likes,
      signature: user.signature
    }
    return userWithoutPassword
  }

  async register(username: string, password: string): Promise<User> {
    const users = await this.getRegisteredUsers()
    
    if (users.has(username)) {
      throw new Error('用户名已存在')
    }
    
    const newUser: User = {
      username,
      password,
      follow: 0,
      fans: 0,
      likes: 0,
      signature: '这个人很懒，什么都没有留下'
    }
    
    users.set(username, newUser)
    await this.saveRegisteredUsers(users)
    
    // Return user without password for security
    const userWithoutPassword: User = {
      username: newUser.username,
      password: '',
      follow: newUser.follow,
      fans: newUser.fans,
      likes: newUser.likes,
      signature: newUser.signature
    }
    return userWithoutPassword
  }

  async userExists(username: string): Promise<boolean> {
    const users = await this.getRegisteredUsers()
    return users.has(username)
  }
}
