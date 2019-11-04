package cn.it.crm.util;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Retention(RUNTIME)
@Target(METHOD)
@Inherited
public @interface Operation {
    /**
     * 操作名称
     * @return
     */
    Execute execute() default Execute.FIND;
}
