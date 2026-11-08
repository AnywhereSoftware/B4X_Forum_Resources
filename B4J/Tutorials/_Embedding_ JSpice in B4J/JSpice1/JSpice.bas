B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
'	Private spice As JavaObject
	Dim nativeMe As JavaObject
End Sub

'initialize the JSPICE object
Public Sub Initialize
'	spice.InitializeStatic("org.knowm.jspice.JSpice")
	nativeMe = Me

End Sub

'simulate the circuit
'a valid netlist needs to be passed for simulation purposes
Public Sub Simulate (Netlist As JavaObject)

'	spice.RunMethod("simulate", Array(Netlist))
	nativeMe.RunMethod("simulate", Array(Netlist))
	
End Sub

'call back from the inline Java code with the result of simulation as a String
'it will call sub jspice_result in Main and pass the String result to it so that the values can be used in the B4J UI
Public Sub jspicecallback(mystring As String)
'	Log("IN THE CALLBACK")

'	Log("mystring = " & mystring)
	CallSubDelayed2(Main,"jspice_result", mystring)
	Sleep(1000)

End Sub

#if Java


import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;

import org.knowm.configuration.ConfigurationException;
import org.knowm.configuration.ConfigurationFactory;
import org.knowm.configuration.YamlConfigurationFactory;
import org.knowm.configuration.provider.ConfigurationSourceProvider;
import org.knowm.configuration.provider.FileConfigurationSourceProvider;
import org.knowm.configuration.provider.ResourceConfigurationSourceProvider;
import org.knowm.jackson.Jackson;
import org.knowm.jspice.netlist.Netlist;
import org.knowm.jspice.netlist.spice.SPICENetlistBuilder;
import org.knowm.jspice.simulate.SimulationConfig;
import org.knowm.jspice.simulate.SimulationPlotter;
import org.knowm.jspice.simulate.SimulationResult;
import org.knowm.jspice.simulate.dcoperatingpoint.DCOPConfig;
import org.knowm.jspice.simulate.dcoperatingpoint.DCOperatingPoint;
import org.knowm.jspice.simulate.dcoperatingpoint.DCOperatingPointResult;
import org.knowm.jspice.simulate.dcsweep.DCSweep;
import org.knowm.jspice.simulate.dcsweep.DCSweepConfig;
import org.knowm.jspice.simulate.transientanalysis.TransientAnalysis;
import org.knowm.jspice.simulate.transientanalysis.TransientConfig;
import org.knowm.validation.BaseValidator;

//public class JSpice {

  private static boolean isFromCommandline = false;
  private static String outFormat = "";
  private static String fileName = "";

/*
  public static void main(String[] args) throws IOException, ConfigurationException {

    if (args.length == 0) {
      System.out.println("Proper Usage is: java -jar jspice <filename>");
      System.exit(0);
    }
    isFromCommandline = true;
    fileName = args[0];
    simulate(args[0]);

  }
  
  */

  public SimulationResult simulate(String fileName) throws IOException, ConfigurationException {

    Netlist netlist = null;

    // SPICE Netlist, must end in `.cir`
    if (fileName.endsWith(".cir")) {

      //      System.out.println("...............Executing netList.... " + fileName);

      try {
        netlist = SPICENetlistBuilder.buildFromSPICENetlist(fileName, new FileConfigurationSourceProvider());
      } catch (FileNotFoundException e) {
        // could not load from file, try from resources (for testing purposes usually)
        netlist = SPICENetlistBuilder.buildFromSPICENetlist(fileName, new ResourceConfigurationSourceProvider());
      }

      // YAML file
    } else {

      ConfigurationFactory<Netlist> yamlConfigurationFactory = new YamlConfigurationFactory<Netlist>(Netlist.class, BaseValidator.newValidator(),
          Jackson.newObjectMapper(), "");

      ConfigurationSourceProvider provider = new FileConfigurationSourceProvider();

      netlist = yamlConfigurationFactory.build(provider, fileName);
    }

    // 3. Run it  
    //    System.out.println("netList: \n" + netlist);

    return simulate(netlist);
  }

//***********************************************************************************************
	public String myresult;
	
	public String getMyResult() {
		return myresult;
	} 

  public SimulationResult simulate(Netlist netlist) {
  	//BA.Log("IN SIMULATE");
	myresult = "";

    SimulationConfig simulationConfig = netlist.getSimulationConfig();

    if (simulationConfig == null || simulationConfig instanceof DCOPConfig) {

	//BA.Log("HERE 1");
      DCOperatingPointResult dcOpResult = new DCOperatingPoint(netlist).run();
      if (isFromCommandline) {

      } else {
        //System.out.println(dcOpResult.toString());
		
		//BA.Log("HERE 2");
		myresult = dcOpResult.toString();
		ba.raiseEventFromUI(this, "jspicecallback", new Object[] {myresult});
      }
      return null;

    } else if (simulationConfig instanceof DCSweepConfig) {

      DCSweepConfig dcSweepConfig = (DCSweepConfig) simulationConfig;

      // run DC sweep
      DCSweep dcSweep = new DCSweep(netlist);
      dcSweep.addSweepConfig(dcSweepConfig);
      SimulationResult simulationResult = dcSweep.run(dcSweepConfig.getObserveID());
      if (isFromCommandline) {

      } else {
	  	myresult = simulationResult.toString();
		ba.raiseEventFromUI(this, "jspicecallback", new Object[] {myresult});
        //System.out.println(simulationResult.toString());
        //SimulationPlotter.plot(simulationResult, new String[]{dcSweepConfig.getObserveID()});
      }
      return simulationResult;

    } else if (simulationConfig instanceof TransientConfig) {

      TransientConfig simulationConfigTransient = (TransientConfig) simulationConfig;

      // run TransientAnalysis
      TransientAnalysis transientAnalysis = new TransientAnalysis(netlist, simulationConfigTransient);
      SimulationResult simulationResult = transientAnalysis.run();

      if (isFromCommandline) {

        String format = netlist.getResultsFormat();
        System.out.println("Results format: " + format);

        // check the requested format of the results file
        if (format.startsWith("RAW") || format.startsWith("raw")) {

          // Raw format found so get the results filename passed on the .PRINT line of the netlist
          String resFilename = netlist.getResultsFile();

          // output as SPICE Raw
          System.out.println("...............Writing simulation results to.........." + resFilename);
          String xyceRawString = simulationResult.toXyceRawString(netlist.getSourceFile());
          System.out.println(xyceRawString);
          try (PrintStream out = new PrintStream(new FileOutputStream(resFilename))) {
            out.print(xyceRawString);
          } catch (FileNotFoundException e) {
            e.printStackTrace();
          }
        } else {
          // output as Xyce STD
          String xyceString = simulationResult.toXyceString();
          System.out.println(xyceString = simulationResult.toXyceString());
          try (PrintStream out = new PrintStream(new FileOutputStream(fileName + ".out"))) {
            System.out.println("...............Writing simulation results to.........." + fileName + ".out");

            //try (PrintStream out = new PrintStream(new FileOutputStream(resFilename))) {
            out.print(xyceString);
          } catch (FileNotFoundException e) {
            e.printStackTrace();
          }
        }
        //        SimulationPlotter.plotTransientInOutCurve("I/V Curve", simulationResult, "V(Vmr)", "I(MR1)");
      } else {

        //System.out.println(simulationResult.toString());
        //        System.out.println(simulationResult.toXyceString());

        // plot
        //        SimulationPlotter.plotAll(simulationResult);
        //        SimulationPlotter.plot(simulationResult, "V(y)");
        //        SimulationPlotter.plot(simulationResult, "R(MR2_X1)", "R(MR1_X1)");
      }
      return simulationResult;

    } else {
      return null;
    }
  }
//}


#End If

