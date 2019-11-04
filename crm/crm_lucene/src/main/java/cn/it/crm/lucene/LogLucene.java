package cn.it.crm.lucene;


import cn.it.crm.domain.SystemLog;
import cn.it.crm.query.SystemLogQuery;
import cn.it.crm.util.PageList;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.locks.ReentrantLock;


public class LogLucene {
    private IndexWriter indexWriter;
    private IndexReader indexReader;
    private static LogLucene instance = new LogLucene();
    private ReentrantLock reentrantLock = new ReentrantLock();

    private LogLucene(){}

    public static LogLucene getInstance(){
        return instance;
    }

    public void save(SystemLog log) throws Exception{
        Document document = new Document();
        document.add(new StringField("opUser", log.getOpUser(), Field.Store.YES));
        document.add(new StringField("opTime", log.getOpTimeStr(), Field.Store.YES));
        document.add(new StringField("opIp", log.getOpIp(), Field.Store.YES));
        document.add(new TextField("function", log.getFunction(), Field.Store.YES));
        document.add(new TextField("params", log.getParams(), Field.Store.YES));
        initIndexWriter(log.getTenantId());
        indexWriter.addDocument(document);
        indexWriter.commit();
        if (reentrantLock.isLocked()) {
            reentrantLock.unlock();
        }
        indexWriter.close();
//        if (reentrantLock.isLocked()) {
//            reentrantLock.unlock();
//        }
    }

    public PageList<SystemLog> query(SystemLogQuery systemLogQuery) throws Exception{
        IKAnalyzer ikAnalyzer = new IKAnalyzer();
        QueryParser queryParser =
                new MultiFieldQueryParser(new String[] { "opUser", "opTime", "opIp", "function", "params" }
                ,ikAnalyzer);
        Query query = queryParser.parse(systemLogQuery.getStr());
        initIndexReader(systemLogQuery.getTenantId());
        IndexSearcher searcher = new IndexSearcher(indexReader);

        TopDocs topDocs = searcher.search(query, systemLogQuery.getPageNum() * systemLogQuery.getPageSize());
        long totalHits = topDocs.totalHits;
        ArrayList<SystemLog> systemLogs = new ArrayList<>();
        ScoreDoc[] scoreDocs = topDocs.scoreDocs;
        Integer end = systemLogQuery.getPageNum() * systemLogQuery.getPageSize();
        Integer begin = (systemLogQuery.getPageNum()-1) * systemLogQuery.getPageSize();
        if(end > totalHits){
            end = (int) totalHits;
        }
        for (int i = begin; i < end; i++) {
            ScoreDoc scoreDoc = scoreDocs[i];
            int docID = scoreDoc.doc;
            Document doc = indexReader.document(docID);
            SystemLog systemLog = new SystemLog();
            systemLog.setOpUser(lighterStr(ikAnalyzer, query,doc.get("opUser"), "opUser", doc));
            systemLog.setOpIp(lighterStr(ikAnalyzer, query,doc.get("opIp"), "opIp", doc));
            systemLog.setFunction(lighterStr(ikAnalyzer, query,doc.get("function"), "function", doc));
            systemLog.setParams(lighterStr(ikAnalyzer, query,doc.get("params"), "params", doc));
            systemLog.setOpTimeStr(lighterStr(ikAnalyzer, query,doc.get("opTime"), "opTime", doc));
            systemLogs.add(systemLog);
            System.out.println(systemLog);
        }
        indexReader.close();

        return new PageList<>(totalHits, systemLogs);
    }

    private void initIndexWriter(Long tenantId) throws Exception{
        File log = new File("/log/"+tenantId);
        if (!log.exists()){
            log.mkdirs();
        }
        reentrantLock.lock();
        indexWriter = new IndexWriter(FSDirectory.open(log.toPath()),new IndexWriterConfig(new IKAnalyzer()));
    }

    private void initIndexReader(Long tenantId) throws Exception{
        File log = new File("/log/"+tenantId);
        if (!log.exists()){
            log.mkdirs();
        }
        //1、创建一个Director对象，指定索引库的位置
        Directory directory = FSDirectory.open(log.toPath());
        //2、创建一个IndexReader对象
        indexReader = DirectoryReader.open(directory);
    }
    

    private String lighterStr(Analyzer a, Query query, String txt, String filename, Document doc){
        String str = null;
        try {
            QueryScorer scorer = new QueryScorer(query);
            Formatter fragmenter = new SimpleHTMLFormatter("<span style='color:red'>", "</span>");
            Highlighter lighter = new Highlighter(fragmenter, scorer);
            str = lighter.getBestFragment(a, filename, txt);
        } catch (IOException e) {
            e.printStackTrace();
        }catch (InvalidTokenOffsetsException e) {
            e.printStackTrace();
        }
        return str != null ? str : doc.get(filename)!= null ? doc.get(filename) : "";
    }
}
