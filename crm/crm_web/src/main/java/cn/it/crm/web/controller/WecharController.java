package cn.it.crm.web.controller;


import cn.it.crm.domain.Employee;
import cn.it.crm.service.IEmployeeService;
import cn.it.crm.service.shiro.EncryptPassword;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.HttpClient;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/wechart2")
public class WecharController {
    @Autowired
    private IEmployeeService employeeService;

    /**
     * 扫描二维码后，跳转到这个方法：
     * http://localhost/login/wechart?code=CODE&state=3d6be0a4035d839573b04816624a415e
     * 获取code，再通过code获取at
     *
     * @param request
     */
    @RequestMapping("/callback")
    public String callback(HttpServletRequest request) {
        System.out.println("888888888888");
        String code = request.getParameter("code");
        String state = request.getParameter("state");

        if (!StringUtils.isEmpty(code) && !StringUtils.isEmpty(state)) {

            //正确扫描二维码调整过来的：//通过code获取access_token:
            // 发一个请求：https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
            // https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxd853562a0548a7d0&secret=4a5d5615f93f24bdba2ba8534642dbb6&code=CODE&grant_type=authorization_code
            String getAtUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxd853562a0548a7d0&secret=4a5d5615f93f24bdba2ba8534642dbb6&code=CODE&grant_type=authorization_code";
            getAtUrl = getAtUrl.replace("CODE", code);
            //发送请求：HttpClient  专门发送http请求的工具类:

            try {
                String result = HttpClient.getResult(getAtUrl);

                // {"access_token":"23_NsRMqwgxblCwPfFng4fTBIhZBfURzOxb66-_-TSLqyzNYIuYCURjm_5J8GolR8Dt3W9Csh7byFY1Oos8zif3rg7g4Eu0Uja_TJRkGkznrpM","expires_in":7200,"refresh_token":"23_r3SZNOy0yvYDJjTRyVAtkonr_HcERCNyzVxWznngVQHp4ogStu4iXpwV4prR6eHTqT4EbN0nDlGly-WXmaVCybw0AwiRi4XDhuIb5NryG04","openid":"oa9wA0-60V_9liY2WUXrUsEAbChM","scope":"snsapi_login","unionid":"ovnCWw1GMq-CZzBUBfQiyGEkNscY"}
                System.out.println(result);

                //json的转换：fastjson 阿里巴巴
                JSONObject jsonObject = (JSONObject) JSON.parse(result);
                String at = (String) jsonObject.get("access_token");
                String openid = (String) jsonObject.get("openid");
                System.err.println(openid);

//                //通过at和openid获取用户信息：
//                String userinfoUrl ="https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
//                userinfoUrl=userinfoUrl.replace("ACCESS_TOKEN", at).replace("OPENID", openid);
//                String result1 = HttpClient.getResult(userinfoUrl);
                //TODO： 获取到微信号，要和用户进行绑定：
                // todo:如果微信号和用户绑定过：通过微信号查询员工表：只能查出一条记录：
                // TODO：第一次进来是没有绑定：

                Employee employee = employeeService.findByOpenid(openid);
                //以前已经绑定了：把微信号和头像返回页面：主页  以后业务：获取到微信号：通过数据得到这个微信号对应的员工信息：
                if (employee != null) {
                    SecurityUtils.getSubject().login(new UsernamePasswordToken(employee.getUsername(), employee.getUsername()));
                    ShiroUtil.setEmployee(employee);
                    return "main/main";
                } else {
                    //第一次进来：没有绑定：我就应该绑定：回到一个绑定页面：
                    System.out.println("没有绑定");
                    Employee employee2 = new Employee();
                    employee2.setOpenid(openid);
                    ShiroUtil.setEmployee(employee2);
                    //employeeService.update(employee1);
                    return "main/binding";
                }
            } catch (Exception e) {
                e.printStackTrace();
                return "main/main";
            }
        }
        return "main/main";
    }

}
