package ro.nextreports.integration;

import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import ro.nextreports.engine.Report;
import ro.nextreports.engine.util.LoadReportException;
import ro.nextreports.engine.util.ReportUtil;


/**
 * @author Decebal Suiu
 */
public class ReportSupport {

           
    protected static Report loadReport(String inlocation, String repin) throws FileNotFoundException, LoadReportException {
    	String file = inlocation + File.separator + repin +".report";;    	        
        Report report = ReportUtil.loadReport(new FileInputStream(file));
        // copy report images if any to directory where exported file is generated : works for HTML export
        // for PDF, RTF & EXCEL export the directory where we copy images must be in the CLASSPATH!
        copyImages(report, inlocation, ".");
        return report;    	
    }


    protected static Connection createConnection(String driverclass, String url) throws ClassNotFoundException, SQLException {
    	 Class.forName(driverclass);
        // System.out.println("Connect to '" + url + "'");
        return DriverManager.getConnection(url);
    }

    protected static Map<String, Object> createParameterValues(ArrayList inputlist) {
        
        Map<String, Object> parameterValues = new HashMap<String, Object>();
        int listsize;
        listsize=inputlist.size();
        if (inputlist.size()>6) {
        for(int i=6; i<listsize-1; i=i+2){
            
            parameterValues.put(inputlist.get(i).toString(),inputlist.get(i+1));
         }
        }
        
        return parameterValues;
    	
    }

    protected static void closeConnection(Connection connection) {
        if (connection == null) {
            return;
        }

        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected static void closeStream(Closeable stream) {
        if (stream == null) {
            return;
        }
        try {
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // This method copies report images to a directory
    //          this must be the directory where the exported report is generated : HTML
    //          this must any folder taht is in the project classpath : PDF, EXCEL, RTF    
    protected static void copyImages(Report report, String from, String to) {
        try {
            List<String> images = ReportUtil.getStaticImages(report);
            File destination = new File(to);
            for (String image : images) {
                File f = new File(from + File.separator + image);
                if (f.exists()) {
                    FileUtil.copyToDir(f, destination);
                }
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
