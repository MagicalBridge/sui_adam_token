# Adam Token - Sui 区块链代币项目

一个基于 Sui 区块链的简单代币实现，代币名称为 Adam。

## 📁 项目结构

```
sui_adam_token/
├── Move.toml              # 项目配置文件
├── sources/
│   └── adam_token.move    # Adam 代币智能合约
├── deploy.sh              # 部署脚本
└── README.md              # 项目说明
```

## 🛠 前置要求

在开始之前，请确保你已经安装了以下工具：

1. **Sui CLI**: [安装说明](https://docs.sui.io/build/install)
2. **Git**: 用于版本控制

## 🚀 快速开始

### 1. 安装 Sui CLI

```bash
# macOS 用户
brew install sui

# 或者使用 cargo 安装
cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui
```

### 2. 配置 Sui 环境

```bash
# 初始化 Sui 配置
sui client

# 切换到测试网
sui client switch --env testnet

# 创建新地址（如果没有的话）
sui client new-address ed25519

# 从水龙头获取测试 SUI 代币
sui client faucet
```

### 3. 构建项目

```bash
# 构建 Move 合约
sui move build
```

### 4. 部署代币

```bash
# 使用提供的部署脚本
./deploy.sh

# 或者手动部署
sui client publish --gas-budget 100000000
```

## 💰 代币信息

- **名称**: Adam Token
- **符号**: ADAM
- **小数位数**: 2
- **描述**: Adam is a simple token for demonstration purposes on Sui blockchain

## 📋 合约功能

### 主要功能

1. **铸造代币**: 只有拥有 TreasuryCap 的地址可以铸造新代币
2. **销毁代币**: 销毁指定数量的代币
3. **转账**: 标准的代币转账功能

### 关键函数

```move
// 铸造代币
public entry fun mint(
    treasury_cap: &mut TreasuryCap<ADAM_TOKEN>, 
    amount: u64, 
    recipient: address, 
    ctx: &mut TxContext
)

// 销毁代币
public entry fun burn(
    treasury_cap: &mut TreasuryCap<ADAM_TOKEN>, 
    coin: Coin<ADAM_TOKEN>
)
```

## 🎯 部署后操作

### 铸造代币

部署成功后，你会获得一个 TreasuryCap 对象，使用它来铸造代币：

```bash
# 铸造 1000 个 Adam 代币给指定地址
sui client call \
  --package <PACKAGE_ID> \
  --module adam_token \
  --function mint \
  --args <TREASURY_CAP_ID> 100000 <RECIPIENT_ADDRESS> \
  --gas-budget 10000000
```

### 查看代币余额

```bash
# 查看地址的所有代币
sui client gas

# 查看特定类型的代币
sui client objects --address <ADDRESS>
```

## 🧪 测试

```bash
# 运行测试
sui move test
```

## 📄 许可证

此项目仅用于学习和演示目的。

## 🤝 贡献

欢迎提交 issue 和 pull request 来改进这个项目！

## 📞 支持

如果你在使用过程中遇到问题，可以：

1. 查看 [Sui 官方文档](https://docs.sui.io/)
2. 加入 [Sui Discord](https://discord.gg/sui)
3. 在 GitHub 上提交 issue

---

🎉 祝你使用愉快！ 