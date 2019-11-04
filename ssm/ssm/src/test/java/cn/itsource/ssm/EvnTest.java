package cn.itsource.ssm;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class EvnTest {


    /**
     * spring环境测试：
     *
     * @throws Exception
     */
    public static void main(String[] args) {
        //1:获取上下文
        ApplicationContext applicationContext= new ClassPathXmlApplicationContext("spring.xml");
        //2：：获取bean
        String[] beanDefinitionNames = applicationContext.getBeanDefinitionNames();
        for (String beanDefinitionName : beanDefinitionNames) {
            System.out.println(beanDefinitionName);
        }

    }
}
