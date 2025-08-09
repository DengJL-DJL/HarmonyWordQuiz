// 题目数据模型
export interface Question {
  correctIndex: number;
  id: number;           // 题目ID
  word: string;         // 英文单词
  translation: string;  // 正确答案
  options: string[];    // 选项数组（包含正确答案）
  difficulty: number;   // 难度等级1-5
}

// 用户答题记录
export interface AnswerRecord {
  questionId: number;   // 关联题目ID
  selectedOption: string; // 用户选择
  isCorrect: boolean;   // 是否正确
  timeSpent: number;    // 耗时(秒)
}