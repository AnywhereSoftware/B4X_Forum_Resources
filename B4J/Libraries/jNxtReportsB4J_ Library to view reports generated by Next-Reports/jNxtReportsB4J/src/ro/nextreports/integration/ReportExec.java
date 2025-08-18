package ro.nextreports.integration;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Map;
import ro.nextreports.engine.Report;
import ro.nextreports.engine.ReportRunner;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.*;

@Version(1.0f)
//@Permissions(values={"android.permission.INTERNET"})
@ShortName("jNxtReportsB4J")




public class ReportExec { 
	OutputStream output=null;
    String filename = "";
        

	void runReport(Connection connection, Report report,  String repout, String repType, ArrayList inputlist)
			throws Exception {
	
		ReportRunner runner = new ReportRunner();
		runner.setConnection(connection);
		runner.setReport(report);
		runner.setQueryTimeout(60); // optional
                //runner.setParameterValues(ReportSupport.createParameterValues(mapData));
                runner.setParameterValues(ReportSupport.createParameterValues(inputlist));
                if (repType=="RTF") {
                    runner.setFormat(ReportRunner.RTF_FORMAT);
                    filename = repout + ".rtf";
                }else if (repType=="HTML") {
                     runner.setFormat(ReportRunner.HTML_FORMAT);       
                     filename = repout + ".html";
                        }else if (repType=="PDF") {
                     runner.setFormat(ReportRunner.PDF_FORMAT);       
                     filename = repout + ".pdf";
                        }else if (repType=="XLS") {
                     runner.setFormat(ReportRunner.EXCEL_FORMAT);       
                     filename = repout + ".xls";
                        }else if (repType=="XML") {
                     runner.setFormat(ReportRunner.XML_FORMAT);       
                     filename = repout + ".xml";
                        }else if (repType=="TXT") {
                     runner.setFormat(ReportRunner.TXT_FORMAT);       
                     filename = repout + ".txt";
                        }else if (repType=="CSV") {
                     runner.setFormat(ReportRunner.CSV_FORMAT);       
                     filename = repout + ".csv";
                        }
                
                //System.out.println(outlocation + File.separator + filename);
                output = new FileOutputStream(filename);
                
		runner.run(output);
	
	}

        public void reportPrepAndRun(ArrayList inputlist) {

                Connection connection = null;
                
                String inlocation, reportIn, reportOut, repType, driverclass, url;
                inlocation=inputlist.get(0).toString();
                reportIn=inputlist.get(1).toString();
               
                reportOut=inputlist.get(2).toString();
                
                repType=inputlist.get(3).toString();
                
                driverclass=inputlist.get(4).toString();
                
                url=inputlist.get(5).toString();
                
		try {
                        
                        
                        Report report = ReportSupport.loadReport(inlocation, reportIn);
			connection = ReportSupport.createConnection(driverclass, url);
                  
			//
                        runReport(connection, report, reportOut, repType, inputlist);
                        //
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ReportSupport.closeConnection(connection);
			ReportSupport.closeStream(output);
		}
}
}

	
	
	

