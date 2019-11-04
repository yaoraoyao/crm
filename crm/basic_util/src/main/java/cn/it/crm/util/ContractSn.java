package cn.it.crm.util;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 根据时间随机生成合同编号
 */
public class ContractSn {
    public static String getSn() {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String str = format.format(new Date());
        NumberFormat nf = NumberFormat.getInstance();
        //设置是否使用分组
        nf.setGroupingUsed(false);
        //设置最大整数位数
        nf.setMaximumIntegerDigits(9);
        //设置最小整数位数
        nf.setMinimumIntegerDigits(9);
        Random random1 = new Random(System.currentTimeMillis());
        long aLong = random1.nextLong();
        String countStr=str+"CRM"+nf.format(aLong);
        return countStr;
    }
}
