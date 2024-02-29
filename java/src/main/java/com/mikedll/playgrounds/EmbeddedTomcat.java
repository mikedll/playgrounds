package com.mikedll.playgrounds;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import java.io.File;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.net.URL;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.util.logging.LogManager;
import org.apache.juli.ClassLoaderLogManager;
import java.io.FileInputStream;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.Wrapper;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.startup.Tomcat.FixContextListener;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.javatuples.Pair;

public class EmbeddedTomcat {

  private int port = 8080;

  private final Tomcat tomcat;
  
  public EmbeddedTomcat() {
    this.tomcat = new Tomcat();
  }
  
  public static void main(String[] args) {
    System.out.println("Starting tomcat");
    EmbeddedTomcat et = new EmbeddedTomcat();
    et.prepare();
    et.start();
  }

  public void start() {
    // Create a default connector.
    this.tomcat.getConnector();

    System.out.println("Tomcat started on port: " + port);
    this.tomcat.getServer().await();
  }

  public void prepare() {
        
    File baseDir = createTempDir("tomcat");
    
    try {
      String configText =
        "handlers = java.util.logging.ConsoleHandler\n" +
        ".level = SEVERE\n";
      InputStream configStream = new ByteArrayInputStream(configText.getBytes());
      ClassLoaderLogManager.getLogManager().readConfiguration(configStream);
    } catch(FileNotFoundException ex) {
      throw new RuntimeException(ex);
    } catch(IOException ex) {
      throw new RuntimeException(ex);
    }
    
    tomcat.setBaseDir(baseDir.getAbsolutePath());
    tomcat.setPort(port);
    
    StandardContext ctx = new StandardContext();
    ctx.setPath("");
    ctx.setName("Default Context");
    ctx.addLifecycleListener(new FixContextListener());
    ctx.setParentClassLoader(EmbeddedTomcat.class.getClassLoader());

    // General content - use our servlet
    Wrapper defaultWrapper = ctx.createWrapper();
    defaultWrapper.setName("defaultWrapper");
    Servlet servlet = new Servlet();
    defaultWrapper.setServlet(servlet);    
    defaultWrapper.addInitParameter("debug", "0");
    defaultWrapper.setLoadOnStartup(1);
    ctx.addChild(defaultWrapper);

    ctx.addServletMappingDecoded("/", "defaultWrapper");

    this.tomcat.getHost().addChild(ctx);

    try {
      tomcat.start();
    } catch (LifecycleException ex) {
      System.out.println("LifecycleException: " + ex.getMessage());
    }
  }
  
  public class Servlet extends HttpServlet {  
  
    @Override
    protected final void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {
      res.getWriter().println("Here it is.");
      res.getWriter().close();
      
    }
  }

  /**
   * From org.springframework.boot.web.server.AbstractConfigurableWebServerFactory
   *
   * <p>Return the absolute temp dir for given web server.
   *
   * @param prefix server name
   * @return the temp dir for given server.
   */
  private final File createTempDir(String prefix) {
    try {
      File tempDir = Files.createTempDirectory(prefix + "." + this.port + ".").toFile();
      tempDir.deleteOnExit();
      return tempDir;
    } catch (IOException ex) {
      throw new RuntimeException(
          "Unable to create tempDir. java.io.tmpdir is set to "
              + System.getProperty("java.io.tmpdir"),
          ex);
    }
  }
}
