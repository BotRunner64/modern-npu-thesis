# 西北工业大学学位论文 `modern-npu-thesis`
[![CI](https://github.com/1195343015/modern-npu-thesis/actions/workflows/test.yml/badge.svg)](https://github.com/1195343015/modern-npu-thesis/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> This project provides a Typst thesis template for Northwestern Polytechnical University.

西北工业大学本硕博毕业论文（设计）的 Typst 模板，能够简洁、快速、持续生成 PDF 格式的毕业论文。

> 如果你想使用 LaTeX 版本，请参考 [nwputhesis](https://github.com/1195343015/nwputhesis)。

## 优势与特性

- **语法简洁**：上手难度与 Markdown 相当，无需记忆繁琐的命令。
- **极速编译**：采用增量编译，长文档不影响编译速度。
- **环境搭建简单**：即开即用，无需配置数G的开发环境。支持现代编程语言特性（变量、函数、包管理等）。

### 使用方法

#### 方式一：直接克隆仓库（推荐）

1. 克隆本仓库。
2. 使用 VS Code 打开项目，并安装 [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) 插件。
3. 打开项目后：
   修改 [template/graduate.typ](template/graduate.typ) 可编辑研究生论文，
   修改 [template/bachelor.typ](template/bachelor.typ) 可编辑本科生论文。

#### 方式二：使用 Tinymist 的 Template Gallery

> 这种方式可能无法获取到模板的最新版本。

1. 安装 VS Code 并安装 [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) 插件。
2. 按下 `Ctrl + Shift + P` 打开命令界面，输入 `Typst: Show available Typst templates (gallery)`，打开 Tinymist 提供的 Template Gallery。
3. 在 Template Gallery 中找到 `modern-npu-thesis`，点击 `+` 号创建对应的论文模板。
4. 打开生成的项目后：
   修改 [template/graduate.typ](template/graduate.typ) 可编辑研究生论文，
   修改 [template/bachelor.typ](template/bachelor.typ) 可编辑本科生论文。

仓库已提供工作区配置 [.vscode/settings.json](.vscode/settings.json)，会为 Tinymist 默认追加 `--font-path fonts`，因此在不同系统下都会优先使用仓库内自带的 Windows 字体文件。

### 参考文献格式

本模板的参考文献功能以 [`gb7714-bilingual`](https://github.com/pku-typst/gb7714-bilingual) 为基础，并针对西北工业大学本科、研究生论文格式要求做了少量微调。用户通常只需要维护 [template/bib](template/bib) 目录下的 BibTeX 文件，模板会自动处理文献引用和参考文献列表。

目前 `gb7714-bilingual` 包仍有一些细节问题会影响个别文献类型的输出效果，相关问题已向上游作者提交 issue。待上游修复发布后，模板会尽快同步调整。

### 模板更新迁移指南

如果你已经基于本仓库开始写论文，后续想同步模板更新，通常只需要：

1. 保留你自己的 [template](template) 目录。
2. 用新版本仓库中的其他文件替换当前项目内对应文件。

> 本模板基于 [modern-nju-thesis](https://github.com/nju-lug/modern-nju-thesis) 开发，设计过程中还参考了 [pkuthss-typst](https://github.com/pku-typst/pkuthss-typst) 的实现。
> 
## License

MIT License

Copyright (c) 2024 OrangeX4

Copyright (c) 2026 Jiayi Yan
