import { Question } from '../model/Question';
import { FileUtil } from '../utils/FileUtil';
import { Timer } from '../utils/Timer';
import { promptAction } from '@kit.ArkUI';

// 核心答题页
@Entry
@Component
struct QuizPage {
  @State currentQuestion: Question = {} as Question;
  @State selectedIndex: number = -1;
  @State elapsedTime: number = 0;
  private timer: Timer = new Timer();

  // 初始化加载题目
  aboutToAppear() {
    this.loadQuestion();
    this.startTimer();
  }

  // 从文件加载题目
  private loadQuestion() {
    try {
      const questions: Question[] = FileUtil.readJson('resources/rawfile/words.json');
      if (questions.length > 0) {
        this.currentQuestion = questions[0]; // 示例取第一题
      } else {
        console.error("题目数据为空");
      }
    } catch (error) {
      console.error("加载题目失败:", error);
    }
  }

  // 启动计时器
  private startTimer() {
    this.timer.start();
    setInterval(() => {
      this.elapsedTime = this.timer.getElapsedTime();
    }, 100);
  }

  // 处理选项选择（选中即提交）
  private onSelect(index: number) {
    this.selectedIndex = index;
    this.timer.pause();

    // 显示结果对话框
    promptAction.showDialog({
      title: index === this.currentQuestion.correctIndex ? '正确' : '错误',
      message: `耗时: ${this.elapsedTime.toFixed(1)}秒`,
      buttons: [{ text: '确定', color: '#FF6B35' }]
    });
  }

  build() {
    Column() {
      /* 上半部分：头像+单词卡片 */
      Row() {
        // 用户头像
        Image($r('app.media.avatar'))
          .width(50).height(50)
          .margin(10)

        // 单词卡片（带背景和第二种颜色）
        Text(this.currentQuestion.word)
          .fontSize(24)
          .backgroundColor('#FF6B35')  // 第二种颜色
          .backgroundImage($r('app.media.card_bg'))
          .padding(15)
      }

      /* 下半部分：选项列表 */
      List() {
        ForEach(this.currentQuestion.options, (option: string, index: number) => {
          ListItem() {
            Text(option)
              .fontSize(18)
              .backgroundColor(this.getOptionColor(index))
              .onClick(() => this.onSelect(index))
          }
        })
      }
      .layoutWeight(1)

      // 计时显示
      Text(`时间: ${this.elapsedTime.toFixed(1)}s`)
        .fontColor('#FF6B35')
    }
    .height('100%')
    .padding(20)
  }

  // 动态计算选项背景色
  private getOptionColor(index: number): string {
    if (this.selectedIndex < 0) {
      return '#FFFFFF';
    } // 未选择状态

    if (index === this.currentQuestion.correctIndex) {
      return '#E8F5E9'; // 正确答案背景
    } else if (index === this.selectedIndex) {
      return '#FFEBEE'; // 错误答案背景
    }
    return '#FFFFFF'; // 其他选项
  }
}