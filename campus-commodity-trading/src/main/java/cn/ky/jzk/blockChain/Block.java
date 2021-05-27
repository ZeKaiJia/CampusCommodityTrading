package cn.ky.jzk.blockChain;

import cn.ky.jzk.util.StringUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 区块
 * Block
 *
 * @author kevin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Block {

    /**
     * 数据
     * The Data.
     */
    private String data;
    /**
     * 哈希值
     * The Hash.
     */
    public String hash;
    /**
     * 上一块哈希值
     * The Previous Hash.
     */
    public String previousHash;
    /**
     * 时间戳
     * The TimeStamp.
     */
    private long timeStamp;
    /**
     * 一次性值
     * The Nonce.
     */
    private int nonce;

    public Block(String data,String previousHash ) {
        this.data = data;
        this.previousHash = previousHash;
        this.timeStamp = System.currentTimeMillis();
        this.hash = calculateHash();
    }

    public String calculateHash() {
        return StringUtil.applySha256(
                previousHash +
                        Long.toString(timeStamp) +
                        Integer.toString(nonce) +
                        data
        );
    }

    public void mineBlock(int difficulty) {
        String target = new String(new char[difficulty]).replace('\0', '0');
        while(!hash.substring( 0, difficulty).equals(target)) {
            nonce ++;
            hash = calculateHash();
        }
        System.out.println("Block Mined!!! : " + hash);
    }
}
