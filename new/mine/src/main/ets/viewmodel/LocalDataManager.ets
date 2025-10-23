
export class LocalDataManager {

  private static localDataManager: LocalDataManager;


  static instance() {
    if (!LocalDataManager.localDataManager) {
      LocalDataManager.localDataManager = new LocalDataManager();
    }
    return LocalDataManager.localDataManager;
  }

}


