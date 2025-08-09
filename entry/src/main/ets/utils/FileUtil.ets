// 文件工具：utils/FileUtil.ets
import fs from '@ohos.file.fs';

/**
 * 文件操作工具类
 * 注意：需要配置ohos.permission.READ_MEDIA权限
 */
export class FileUtil {
  /**
   * 读取JSON文件
   * @param path 文件路径（如：'resources/rawfile/words.json'）
   */
  static readJson(path: string): any {
    try {
      const context = getContext();
      const file = fs.openSync(context.resourceManager.getRawFile(path));
      const content = fs.readSync(file.fd);
      fs.closeSync(file.fd);
      return JSON.parse(content);
    } catch (error) {
      console.error("读取文件失败:", error);
      return null;
    }
  }
}