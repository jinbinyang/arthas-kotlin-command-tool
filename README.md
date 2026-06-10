# Arthas Kotlin Command Tool v2

这是重做版，核心逻辑都在一个 `index.html` 里，避免旧版出现的脚本缓存和局部 UI 不同步问题。

## 启动

在 Finder 里双击：

```text
/Users/yangjinbin/workspace/workspace/arthas-kotlin-command-tool-v2/Start Arthas Kotlin Tool v2.command
```

默认地址：

```text
http://127.0.0.1:8766/index.html?v=v2-20260610-1
```

保持启动脚本打开的终端窗口不要关闭；关闭窗口会停止本地服务。

## 交互

- 优先用命令区顶部的下拉框切换命令。
- 也可以点击下面的 radio 命令卡片。
- 左侧 `::` 手柄用于拖拽排序。
- 每次切换都会同步更新顶部预览、完整命令、解释、参数表和 Kotlin 注意点。

## 命中失败排查

如果 Arthas 返回 `Affect(class count: 0 , method count: 0)`，表示当前 JVM 没匹配到这个 `class-pattern`，不一定是 `watch` 语法错。

这时先复制页面里的「未命中排查 / 预检命令」，重点看：

```bash
sc -d '*SimpleClassName*'
sm -d '*SimpleClassName*' '*methodName*'
```

确认真实 JVM 类名和方法名后，再把候选类名填回 `class-pattern` 运行 `watch` / `trace`。

## 关于 `-m`

工具默认不再生成 `-m`。有些 Arthas 场景下 `-m 1` 会导致匹配过紧，表现为去掉 `-m` 后才能正常命中。

只有确认需要限制匹配类数量时，再勾选页面里的「启用 -m 最大匹配类数限制」。
