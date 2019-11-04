package cn.it.crm.service.shiro;

import org.apache.shiro.crypto.hash.SimpleHash;

public class EncryptPassword {
    private static final String ALGORITHM_NAME = "MD5";
    private static final String SALT = "cn.it.crm";
    private static final int HASH_ITERATIONS = 10;

    public static String encrypt(String password){
        return  new SimpleHash(ALGORITHM_NAME, password, SALT, HASH_ITERATIONS).toString();
    }
}
