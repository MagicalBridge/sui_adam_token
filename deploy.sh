#!/bin/bash

# Adam Token 部署脚本
echo "🚀 开始部署 Adam Token..."

# 检查 Sui 是否已安装
if ! command -v sui &> /dev/null; then
    echo "❌ 错误：未找到 Sui CLI，请先安装 Sui"
    echo "安装方法：https://docs.sui.io/build/install"
    exit 1
fi

# 检查网络连接
echo "📡 检查网络配置..."
sui client envs

# 构建项目
echo "🔨 构建项目..."
sui move build

if [ $? -ne 0 ]; then
    echo "❌ 构建失败，请检查代码"
    exit 1
fi

# 部署到测试网
echo "🌐 部署到 Sui 测试网..."
DEPLOY_RESULT=$(sui client publish --gas-budget 100000000)

if [ $? -eq 0 ]; then
    echo "✅ 部署成功！"
    echo "📄 部署结果："
    echo "$DEPLOY_RESULT"
    
    # 提取 Package ID
    PACKAGE_ID=$(echo "$DEPLOY_RESULT" | grep -o '"0x[a-f0-9]\{64\}"' | head -1 | tr -d '"')
    echo ""
    echo "📦 Package ID: $PACKAGE_ID"
    echo "🎉 Adam Token 已成功部署到 Sui 测试网！"
else
    echo "❌ 部署失败"
    exit 1
fi 