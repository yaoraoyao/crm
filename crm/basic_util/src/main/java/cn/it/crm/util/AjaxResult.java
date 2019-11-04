package cn.it.crm.util;

public class AjaxResult {
    private Boolean success =true;
    private String msg = "操作成功";
    private Object result;

    public static AjaxResult Me (){
        return new AjaxResult();
    }

    public Boolean getSuccess() {
        return success;
    }

    public AjaxResult setSuccess(Boolean success) {
        this.success = success;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public AjaxResult setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public Object getResult() {
        return result;
    }

    public AjaxResult setResult(Object result) {
        this.result = result;
        return this;
    }
}
