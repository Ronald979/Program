import random

QUESTIONS = {
    "coding": [
        "雙指針與滑動視窗題型各選 1 題",
        "以 Hash/Dictionary 解一題字串題",
        "以 DFS/BFS 解一題圖論題",
    ],
    "sql": [
        "寫 1 題 JOIN",
        "寫 1 題 CTE 或 window function",
    ],
    "behavior": [
        "用 STAR 敘述一次挑戰案例",
        "用 STAR 敘述一次你主動修正的案例",
    ],
}


def pick_daily_plan(seed=42):
    random.seed(seed)
    plan = {
        "coding": random.choice(QUESTIONS["coding"]),
        "sql": random.choice(QUESTIONS["sql"]),
        "behavior": random.choice(QUESTIONS["behavior"]),
    }
    return plan


if __name__ == "__main__":
    plan = pick_daily_plan()
    print("今日學習建議：")
    for k, v in plan.items():
        print(f"- {k}: {v}")
