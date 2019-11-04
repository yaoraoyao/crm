package cn.it.crm.util;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class HttpClient {

    public static String getResult(String getAtUrl) throws IOException {

        CloseableHttpClient httpClient = HttpClientBuilder.create().build();

        HttpGet httpGet = new HttpGet(getAtUrl);

        CloseableHttpResponse response = httpClient.execute(httpGet);

        HttpEntity entity = response.getEntity();

        String result = EntityUtils.toString(entity);
        return result;
    }
}
