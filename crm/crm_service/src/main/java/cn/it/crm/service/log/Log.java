package cn.it.crm.service.log;

import cn.it.crm.domain.Employee;
import cn.it.crm.domain.SystemLog;
import cn.it.crm.lucene.LogLucene;
import cn.it.crm.service.shiro.ShiroUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Date;

@Aspect
@Component
public class Log {

    @Around("@annotation(cn.it.crm.util.Operation)")
    public Object log(ProceedingJoinPoint joinPoint) throws Throwable{
        System.out.println("hahahahahaha");
        Object result = joinPoint.proceed();
        SystemLog systemLog = new SystemLog();

        Employee employee = ShiroUtil.getEmployee();

        if (employee != null) {
            systemLog.setParams(getParams(joinPoint.getArgs()));
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Method method = signature.getMethod();
            systemLog.setFunction(method.getName());
            systemLog.setOpTime(new Date());
            systemLog.setOpIp(ShiroUtil.getIp());
            systemLog.setTenantId(employee.getTenant_id());
            systemLog.setOpUser(employee.getUsername());
            LogLucene.getInstance().save(systemLog);
        }

        return result;
    }

    private String getParams(Object[] args){
        StringBuilder sb = new StringBuilder("");
        for (Object arg : args) {
            sb.append(arg.toString().replaceAll("[^,{]+?'null',?", "") + ",");
        }
        String str = sb.toString();
        if(str.endsWith(",")){
            str = str.substring(0, str.length()-1);
        }
        return str;
    }
}
