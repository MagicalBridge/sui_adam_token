/// Adam Token - 一个基于 Sui 区块链的简单代币实现
module adam_token::adam_token {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::url::{Self, Url};

    /// Adam 代币结构体
    public struct ADAM_TOKEN has drop {}

    /// 代币初始化函数
    fun init(witness: ADAM_TOKEN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<ADAM_TOKEN>(
            witness,
            2,                              // decimals 小数位数
            b"ADAM",                        // symbol 代币符号
            b"Adam Token",                  // name 代币名称
            b"Adam is a simple token for demonstration purposes on Sui blockchain", // description
            option::some<Url>(url::new_unsafe_from_bytes(b"https://example.com/adam-token-icon.png")), // icon_url
            ctx
        );
        
        // 将铸造权限转移给部署者
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        // 将元数据设为公共共享对象
        transfer::public_share_object(metadata);
    }

    /// 铸造新的 Adam 代币
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<ADAM_TOKEN>, 
        amount: u64, 
        recipient: address, 
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    /// 销毁 Adam 代币
    public entry fun burn(treasury_cap: &mut TreasuryCap<ADAM_TOKEN>, coin: Coin<ADAM_TOKEN>) {
        coin::burn(treasury_cap, coin);
    }

    #[test_only]
    /// 测试用的初始化函数
    public fun test_init(ctx: &mut TxContext) {
        init(ADAM_TOKEN {}, ctx)
    }
} 