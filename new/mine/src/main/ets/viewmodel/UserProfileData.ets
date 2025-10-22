// 统一的用户资料模型与管理（单一 AppStorage 键：'userProfile'）

export interface UserProfile {
  username: string
  bio: string
  gender: string
  birthday: string // 与现有页面字段保持一致（展示年龄/生日）
  school: string
  occupation: string
  location: string
  age: string // 兼容旧逻辑
  avatar: Resource
}

const defaultProfile: UserProfile = {
  username: '大眼萌机器人',
  bio: '对未来的真正慷慨，是把一切都献给现在。',
  gender: '保密',
  birthday: '填写生日, 展示年龄',
  school: '填写学校, 发现校友',
  occupation: '填写职业, 介绍自己',
  location: '北京',
  age: '',
  avatar: $r('app.media.avatar')
}

export class UserProfileManager {
  // 克隆一个 UserProfile（避免对象展开语法）
  static cloneProfile(p: UserProfile): UserProfile {
    return {
      username: p.username,
      bio: p.bio,
      gender: p.gender,
      birthday: p.birthday,
      school: p.school,
      occupation: p.occupation,
      location: p.location,
      age: p.age,
      avatar: p.avatar
    }
  }

  static getDefaultProfile(): UserProfile {
    return UserProfileManager.cloneProfile(defaultProfile)
  }

  // 初始化或迁移到单一键
  static initAppStorage() {
    const existing = AppStorage.get('userProfile') as UserProfile | undefined
    if (!existing) {
      const migrated: UserProfile = {
        username: (AppStorage.get('username') as string) ?? defaultProfile.username,
        bio: (AppStorage.get('bio') as string) ?? defaultProfile.bio,
        gender: (AppStorage.get('gender') as string) ?? defaultProfile.gender,
        birthday: (AppStorage.get('birthday') as string) ?? defaultProfile.birthday,
        school: (AppStorage.get('school') as string) ?? defaultProfile.school,
        occupation: (AppStorage.get('occupation') as string) ?? defaultProfile.occupation,
        location: (AppStorage.get('location') as string) ?? defaultProfile.location,
        age: (AppStorage.get('age') as string) ?? defaultProfile.age,
        avatar: defaultProfile.avatar
      }
      AppStorage.setOrCreate('userProfile', migrated)
    } else {
      const e = existing as UserProfile
      const merged: UserProfile = {
        username: e.username ?? defaultProfile.username,
        bio: e.bio ?? defaultProfile.bio,
        gender: e.gender ?? defaultProfile.gender,
        birthday: e.birthday ?? defaultProfile.birthday,
        school: e.school ?? defaultProfile.school,
        occupation: e.occupation ?? defaultProfile.occupation,
        location: e.location ?? defaultProfile.location,
        age: e.age ?? defaultProfile.age,
        avatar: e.avatar ?? defaultProfile.avatar
      }
      AppStorage.set('userProfile', merged)
    }
  }

  static getProfile(): UserProfile {
    const p = AppStorage.get('userProfile') as UserProfile | undefined
    if (p) {
      return p
    }
    return UserProfileManager.getDefaultProfile()
  }

  static setProfile(profile: UserProfile) {
    AppStorage.set('userProfile', profile)
  }

  static updateUsername(username: string) {
    const p = UserProfileManager.getProfile()
    p.username = username
    UserProfileManager.setProfile(p)
  }

  static updateBio(bio: string) {
    const p = UserProfileManager.getProfile()
    p.bio = bio
    UserProfileManager.setProfile(p)
  }

  static updateGender(gender: string) {
    const p = UserProfileManager.getProfile()
    p.gender = gender
    UserProfileManager.setProfile(p)
  }

  static updateBirthday(birthday: string) {
    const p = UserProfileManager.getProfile()
    p.birthday = birthday
    UserProfileManager.setProfile(p)
  }

  static updateSchool(school: string) {
    const p = UserProfileManager.getProfile()
    p.school = school
    UserProfileManager.setProfile(p)
  }

  static updateOccupation(occupation: string) {
    const p = UserProfileManager.getProfile()
    p.occupation = occupation
    UserProfileManager.setProfile(p)
  }

  static updateLocation(location: string) {
    const p = UserProfileManager.getProfile()
    p.location = location
    UserProfileManager.setProfile(p)
  }

  static updateAge(age: string) {
    const p = UserProfileManager.getProfile()
    p.age = age
    UserProfileManager.setProfile(p)
  }

  static updateAvatar(avatar: Resource) {
    const p = UserProfileManager.getProfile()
    p.avatar = avatar
    UserProfileManager.setProfile(p)
  }

  // 计算资料完成度
  static calculateCompletionRate(profile?: UserProfile): number {
    const p: UserProfile = profile ? profile : UserProfileManager.getProfile()
    let completed = 0
    const total = 6
    if (p.username && p.username !== defaultProfile.username) completed++
    if (p.bio && p.bio !== defaultProfile.bio) completed++
    if (p.gender && p.gender !== defaultProfile.gender) completed++
    if (p.birthday && !p.birthday.includes('填写生日')) completed++
    if (p.school && !p.school.includes('填写学校')) completed++
    if (p.occupation && !p.occupation.includes('填写职业')) completed++
    return Math.round((completed / total) * 100)
  }

  static getAgeSchoolLabel(): string {
    const p = UserProfileManager.getProfile()
    if (p.age && p.school && !p.school.includes('填写学校')) {
      return `+添加年龄、学校标签`
    } else if (p.age) {
      return `+添加学校标签`
    } else if (p.school && !p.school.includes('填写学校')) {
      return `+添加年龄标签`
    } else {
      return `+添加年龄、学校标签`
    }
  }
}

// 初始化AppStorage
UserProfileManager.initAppStorage()

