// # 计时器工具
/**
 * 高精度计时器（支持开始/暂停/重置）
 * 使用示例：
 * const timer = new Timer();
 * timer.start();  // 开始计时
 * timer.pause(); // 暂停计时
 * const time = timer.getElapsedTime(); // 获取耗时
 */
export class Timer {
  private startTime: number = 0;
  private accumulatedTime: number = 0;
  private isRunning: boolean = false;

  // 开始计时
  start(): void {
    if (!this.isRunning) {
      this.startTime = Date.now();
      this.isRunning = true;
    }
  }

  // 暂停计时
  pause(): void {
    if (this.isRunning) {
      this.accumulatedTime += Date.now() - this.startTime;
      this.isRunning = false;
    }
  }

  // 获取总耗时（秒）
  getElapsedTime(): number {
    let currentElapsed = 0;
    if (this.isRunning) {
      currentElapsed = Date.now() - this.startTime;
    }
    return (this.accumulatedTime + currentElapsed) / 1000;
  }

  // 重置计时器
  reset(): void {
    this.startTime = 0;
    this.accumulatedTime = 0;
    this.isRunning = false;
  }
}