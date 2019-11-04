package cn.it.crm.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 用来生成随机单号
 */
public class NumberUtil {

    //获取订单单号
    public static String getOrder(){
        //格式化当前时间
        SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String strDate = sfDate.format(new Date());
        //得到strDate17位时间如：20170411094039080
        //为了防止高并发重复,再获取3个随机数
        String random = getRandom620(3);
        //最后得到20位订单编号。
        return strDate + random;
    }

    //获取合同单号
    public static String getContract(){
        //样式：XSDL-20190911-32658
        //格式化当前时间
        SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMddHH");
        String strDate = sfDate.format(new Date());
        //为了防止高并发重复,再获取4个随机数
        String random = getRandom620(4);
        //最后得到合同编号。
        return "YJCM" + "-"+strDate+"-" + random;

    }

    //获取保修单号
    public static String getRepair(){
        //样式：XSDL-20190911-32658

        //格式化当前时间
        SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMddHH");
        String strDate = sfDate.format(new Date());
        //为了防止高并发重复,再获取4个随机数
        String random = getRandom620(4);
        //最后得到合同编号。
        return "YCKZ" + "-"+strDate+"-" + random;

    }

    public static String getRandom620(Integer length) {
        String result = "";
        Random rand = new Random();
        int n = 20;
        if (null != length && length > 0) {
            n = length;
        }
        int randInt = 0;
        for (int i = 0; i < n; i++) {
            randInt = rand.nextInt(10);
            result += randInt;
        }
        return result;
    }
}
