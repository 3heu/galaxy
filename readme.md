## 星河公链致力于打造一条真正可以商业落地的区块链公链


官网 http://www.3heu.com/ 

官方论坛 http://www.3heu.club:8008/

51cto https://blog.51cto.com/14267585 

新浪微博 https://weibo.com/7059045296/profile?topnav=1&wvr=6&is_all=1 


**目录结构说明**

.
├── abi：智能合约的abi接口文件
│   └── contracts
│       ├── galaxy.msig 
│       │   └── galaxy.msig.abi：多签名合约abi文件 
│       ├── galaxy.system
│       │   └── galaxy.system.abi：系统合约abi文件
│       ├── galaxy.system
│       │   └── galaxy.system.abi：系统合约abi文件
│       └── good
│           └── good.abi：点赞合约abi文件
├── bin：编译生成的二进制文件
│   ├── clgal
│   │   └── clgal：命令行执行文件 
│   ├── contracts
│   │   ├── galaxy-msig
│   │   │   ├── galaxy_msig：多签名合约执行文件 
│   │   │   └── msig.cfg：多签名合约配置文件
│   │   ├── galaxy-system
│   │   │   ├── galaxy_system：系统合约执行文件 
│   │   │   └── system.cfg：系统合约配置文件
│   │   ├── galaxy-token
│   │   │   ├── galaxy_token：token合约执行文件 
│   │   │   └── token.cfg：token合约配置文件
│   │   └── good
│   │       ├── good：点赞合约执行文件
│   │       └── good.cfg ：点赞合约配置文件
│   ├── kgald
│   │   └── kgald：钱包执行文件
│   └── nodgal
│       └── nodgal：node节点执行文件
├── cfg
│   └── genesis.json：多节点配置文件
├── deploy：多节点操作路径
│   ├── galaxy_deploy.sh：多节点部署脚本
│   └── galaxy_undeploy.sh：多节点卸载脚本
├── docker：docker镜像制作路径
│   ├── copybuild.sh：收集文件脚本  
│   ├── Dockerfile：镜像制作文件
│   └── galaxy_bulid.sh：镜像编译脚本
├── docs：操作文档路径
│   ├── galaxy单节点部署操作指南
│   │   └── galaxy单节点部署操作指南.md   
│   ├── galaxy多节点部署操作指南
│   │   └── galaxy多节点部署操作指南.md
│   └── galaxy镜像编译操作指南
│       └── galaxy镜像编译操作指南.md  
├── lib：galaxy运行库文件路径
│   ├── ice
│   │   └── libIce.so.3.7
│   └── sys
│       ├── libcrypto.so.1.1
│       └── libssl.so.1.1
├── readme.md：说明文档
└── startscript：node节点启动脚本 
    ├── start_nodgal10.sh
    ├── start_nodgal1.sh
    ├── start_nodgal2.sh
    ├── start_nodgal3.sh
    ├── start_nodgal4.sh
    ├── start_nodgal5.sh
    ├── start_nodgal6.sh
    ├── start_nodgal7.sh
    ├── start_nodgal8.sh
    └── start_nodgal9.sh

