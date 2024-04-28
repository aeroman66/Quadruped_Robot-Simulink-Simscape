Name: QuadrupedRobot_Simulink
Description: 本项目旨在帮助你初步了解足式机器人控制中一些重要的基本概念以及基本方法。MATLAB 实时文档中的过程进行了大量简化，如需深入了解还需学习文档中给出的参考资料。
并且受限于作者能力，最终的实现效果并不理想，仅作入门了解使用。
![[实现机体运动学.png]]
## 目录

- [上手指南](#上手指南)
  - [开发前的配置要求](#开发前的配置要求)
  - [安装步骤](#安装步骤)
- [文件目录说明](#文件目录说明)
- [如何利用该项目](#如何利用该项目)
- [项目不足](#项目不足)
### 上手指南
###### 开发前的配置要求
1. MATLAB（实测可在 2023b 及 2024a 上运行，更早版本未知）
2. 并需安装以下辅助功能。
	在第一次运行仿真前将目录中的 slprj 文件夹删除，否则可能会编译失败。
![[工具包.png]]
###### **安装步骤**
解压即用

```sh
git clone https://github.com/aeroman66/Quadruped_Robot-Simulink-Simscape.git
```

### 文件目录说明
1. Inverted_Pendulum 文件夹可以帮你初步了解 simulink simscape 的工作流。内有采用 LQR 和 MPC 的两个示例。
	1. LQR 示例：先运行 startUp.m 脚本，再运行 Car_Pole.slx 仿真。
	2. MPC 示例：先运行 Inverted_Pendulum.mlx 实时脚本，再运行 Cart_Pole_MPC_doc.slx 仿真。
2. QR_control 内是四足的 simulink 仿真
	1. 先运行 QR_MPCcontrol.mlx 脚本，再运行 MarchMPC.slx 仿真。
	2. QR_MPCcontrol.mlx 脚本计算出的矩阵会打印在同目录下的 LesMatrices.txt 中，如有参数更新需把矩阵复制到 MarchMPC.slx 中的相应位置。
	3. others 中的仿真分别对应——“机身运动学控制”、“单腿仿真”、“腿部轨迹跟踪仿真”，有需要可以看看。
```
Filetree
.
├── Inverted_Pendulum
│   ├── Cart_Pole_LQR
│   │   ├── Car_Pole.slx
│   │   ├── Car_Pole.slx.original
│   │   ├── Car_Pole.slxc
│   │   ├── LQRControl.m
│   │   ├── cartPoleLQR.m
│   │   ├── slprj
│   │   └── startUp.m
│   └── Cart_Pole_MPC
│       ├── Cart_Pole_MPC_doc.slx
│       ├── Cart_Pole_MPC_doc.slx.r2023b
│       ├── Cart_Pole_MPC_doc.slxc
│       ├── Inv_Pendulum_modeling.mlx
│       ├── Inverted_Pendulum.mlx
│       ├── signal.mat
│       ├── slprj
│       └── 文档
│           ├── Inv_Pendulum_modeling.pdf
│           └── Inverted_Pendulum.pdf
├── QR_control
│   ├── Body_modeling.mlx
│   ├── Leg_modeling.mlx
│   ├── LesMatrices.txt    # 矩阵在这！！！
│   ├── MarchMPC.slx
│   ├── MarchMPC.slx.r2023b
│   ├── MarchMPC.slxc
│   ├── QR_MPCcontrol.mlx
│   ├── docs
│   │   ├── Body_modeling.pdf
│   │   ├── Leg_modeling.pdf
│   │   └── QR_MPCcontrol.pdf
│   ├── others
│   │   ├── WholeBody.slx
│   │   ├── leg.slx
│   │   └── legTra.slx
│   └── slprj
├── README.md
└── demonstration
    ├── MPC 倒立摆.mov
    ├── 踏步.mov
    ├── 位姿演示.mov
    ├── 机身坐标系.png
    └── 腿部坐标系.png
```
### 如何利用该项目
该项目提供了一种无需过多代码基础就可初步了解四足机器人控制流程的方法。
- 推荐从单腿仿真开始了解 simulink & simscape（simscape 搭建 & simulink 模块间互动方法）
- 搭建四足前先理解 MPC 倒立摆的原理以及实现方法，四足机身控制基本就是它的延拓。
- 根据 "WholeBody.slx","BodyDynamic.slx","MarchMPC.slx"，的顺序理解四足控制，它们分别是“机身运动学”“机身动力学”“带步态的机身动力学”
该项目是作者自己从 0 开始探索的结果，这也就意味着中间省去了很多过程。最开始为了实验作者搭建了很多仿真，最后汇总进该项目的只是其中比较具有代表性的结果。所以为了更好的理解，推荐大家自己实现一遍。用 MATLAB 已经极大的降低了对 coding 的要求了，还是比较方便的。
![[过程.png]]
### 项目不足
1. MPC 控制器对于姿态没有很好的控制效果，原因是作者在实现时对于姿态的相关知识还不是十分了解。
2. 只有原地步态，并且踏步次数过多后机器人就会失去平衡。原因有两点：
	1. 姿态控制不行
	2. 没有触地检测，导致摆动状态与支撑状态切换时足端大部分时间都没有与地面接触
	3. 不想写移动了 :-(
以上的不足在你使用该项目时会深有体会。