# GitHub Release 摘要查询要先看结构再取值

**日期**: 2026-01-13 
**影响**: 为了拿 SHA256 走了下载大文件和错误 jq 过滤两条弯路 
**发现人**: 用户

## 问题

查询 GitHub Release 的 SHA256 时，没有先看完整返回结构，一边下载安装包本地算 hash，一边又写出了漏掉 `digest` 的 jq 过滤器。

## 现象

错误路径通常长这样：

```bash
curl -s "https://api.github.com/repos/{owner}/{repo}/releases/latest" | jq '{name, size, browser_download_url}'
```

这个过滤器漏掉了 `digest`。如果进一步去下载安装包再本地计算 SHA256，会额外浪费时间和带宽。

## 根因

错误假设有两个：

1. GitHub Release API 不直接提供摘要。
2. 不看完整 JSON 结构也能一次写对 jq 过滤器。

实际约束是 GitHub Release API 已经提供 `assets[].digest`，而 jq 过滤必须建立在先验结构确认之上。

## 修复

先看完整结构，再读取需要的字段：

```bash
curl -s "https://api.github.com/repos/{owner}/{repo}/releases/latest" | jq '.assets[0]'
curl -s "https://api.github.com/repos/{owner}/{repo}/releases/latest" | jq '.assets[0].digest'
```

返回值形如 `sha256:xxxxxx`，直接可用。

## 预防

- GitHub Release 相关摘要优先查 API，不下载文件硬算。
- 写 jq 过滤器前，先用 `.` 或具体路径查看完整结构。
- 过滤结果缺字段时，先回到原始 JSON 验证，不靠猜测补字段。
