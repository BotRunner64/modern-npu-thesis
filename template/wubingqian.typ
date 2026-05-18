#import "/template.typ": (
  Assign, IfElseChain, Return, While, algorithm, capfig, capsubfig, captab, multicite, nwpu-thesis, zh
)

#show: nwpu-thesis.with(
  anonymous: false, // 是否开启盲审模式
  info: (
    title: ("基于数据驱动不确定性的", "主动三维重建研究"),
    author: "吴秉谦",
    major: "信息安全",
    supervisor: ("杨佳琪", ""),
    submit-date: (year: 2026, month: 6),
  ),
  abstract: (
    content: [
      听觉虚拟又可称为可听化，是近年来随着声学仿真技术的发展而出现的新概念，即通过对包含单个（或多个）声源的声场进行物理或数学建模，以达到模拟空间听音效果的目的。若考虑双耳效应，则可称为双耳听觉虚拟（Binaural Modeling）。

      ……
    ],
    keywords: ("听觉虚拟", "HRTF", "神经网络"),
  ),
  abstract-en: (
    content: [
      Virtual auditory technology is also called auralization. It is brought forward as a new concept with the development of acoustic simulation techniques in recent years and can be implemented by establishing the physical or mathematical models of a sound field to achieve sound effects simulation. If we consider the binaural effect, it can be called binaural virtual auditory.

      ……..
    ],
    keywords: ("virtual auditory", "HRTF", "neural network"),
  ),
  appendix: [
    附录内容……
  ],
  acknowledgement: [
    致谢内容……
  ],
  design-summary: [
    小结内容……
  ],
)

= 绪论

== 课题研究背景及意义

== 主动三维重建国内外研究现状

=== 基于传统几何表示的主动重建方法

=== 基于神经辐射场的主动重建方法

=== 基于三维高斯表示的主动重建方法

=== 数据驱动视角选择与不确定性估计方法

== 现有方法存在的问题

== 本文主要研究内容

== 论文结构安排

= 主动三维重建基础技术研究

== 三维重建任务概述

=== 三维重建的基本目标

=== 对象级重建与场景级重建

=== 稀疏视角重建中的主要困难

== 神经辐射场表示方法

=== NeRF 的场景表示思想

=== 体渲染过程与新视角合成

=== NeRF 在主动重建中的优势与局限

== 三维高斯表示与可微渲染

=== 三维高斯的参数化表示

=== 高斯投影、透明度合成与颜色渲染

=== 深度图渲染与几何信息表达

=== 3DGS 相比 NeRF 的效率优势

== 主动重建与下一最佳视角规划

=== 主动重建问题定义

=== 候选视角空间与采样策略

=== 下一最佳视角评价准则

== 不确定性量化方法

=== 几何空间中的不确定性建模

=== 图像渲染空间中的不确定性建模

=== 基于信息增益和 Fisher 信息的方法

=== 数据驱动不确定性估计方法

== 图像质量评价与重建误差度量

=== PSNR 指标

=== SSIM 指标

=== LPIPS 感知指标

== 实验数据集与评价指标

=== Objaverse 与 MaterialAnything 数据

=== Mip-NeRF360 场景数据

=== Map-free visual relocalization 数据

== 本章小结

= 基于数据驱动不确定性的主动三维重建系统框架

== 问题定义与任务流程

=== 输入输出定义

=== 主动视角选择目标

== 系统总体框架

== 初始视角采样与三维高斯重建

== 候选视角生成与渲染

=== 候选视角空间构建

=== 候选视角颜色图渲染

=== 候选视角深度图渲染

== 基于不确定性评分的视角选择

== 主动重建闭环流程

== 本章小结

= 不确定性评估模型设计与实现

== 数据驱动不确定性估计思想

== 颜色图不确定性预测分支

== 深度图不确定性预测分支

== 深度感知的不确定性融合策略

=== 单一模态不确定性估计的局限

=== 深度感知的不确定性加权

=== 深度不确定性重加权

=== 候选视角综合评分计算

== 训练数据构建与监督信号设计

=== 多视角数据渲染流程

=== 稀疏视角 3DGS 训练设置

=== 基于保留视角的误差监督

=== 基于 SSIM 的不确定性标签构造

== 扫描路径级不确定性扩展

=== 离散视角选择与连续扫描路径的差异

=== 路径候选生成与中间视角插值

=== 基于视频序列的不确定性预测

== 系统实现细节

=== 模型训练流程

=== 候选视角批量推理

=== 渲染结果缓存与效率优化

=== 代码工程结构与主要模块

== 本章小结

= 实验结果与分析

== 实验环境与参数设置

=== 硬件与软件环境

=== 数据集划分

=== 对比方法设置

=== 评价指标设置

== 对象级主动重建实验

=== 定量结果对比

=== 重建质量可视化分析

=== 最差视角质量分析

== 复杂材质对象重建实验

== 场景级主动重建实验

=== Mip-NeRF360 场景结果

=== 室内外场景泛化分析

== 消融实验

=== 仅颜色不确定性分支

=== 仅深度不确定性分支

=== 深度感知融合策略消融

== 可视化结果分析

=== 不确定性热力图分析

=== 候选视角选择分布

=== 重建结果对比图

=== 失败案例与原因分析

== 真实机器人扫描实验

=== 机器人平台与相机配置

=== 真实物体扫描流程

=== 机器人扫描结果分析

== 本章小结

= 总结与展望

== 研究工作总结

== 不足与未来展望
