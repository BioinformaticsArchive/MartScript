/*
    Copyright (C) 2003 EBI, GRL

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
 */
 
package org.ensembl.mart.lib.config;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Object representing a URLLocation element in a DatasetConfigLocation element
 * of a MartRegistry.dtd compliant XML document.
 * 
 * @author <a href="mailto:dlondon@ebi.ac.uk">Darin London</a>
 * @author <a href="mailto:craig@ebi.ac.uk">Craig Melsopp</a>
 */
public class URLLocation extends MartLocationBase {

  private Logger logger = Logger.getLogger(URLLocation.class.getName());
  private final String URL_KEY = "url";
  private URL url;
  
  public URLLocation() {
    super();
    type = MartLocationBase.URL;
  }
 
  public URLLocation(String url, String name, String visibleString) throws ConfigurationException {
    super(name, visibleString, MartLocationBase.URL);
    setURL(url);
  }
  
	public URLLocation(URL url, String name, String visibleString) {
    super(name, visibleString, MartLocationBase.URL);
    setURL(url);
	}

	/**
   * Return the URL for this URLLocation
	 * @return URL
	 */
	public URL getUrl() {
    String urlS = getAttribute(URL_KEY);
    if ( url == null && ! ( urlS == null ) ) {
      try {
        url = new URL(urlS);
      } catch (MalformedURLException e) {
        if (logger.isLoggable(Level.INFO))
          logger.info("Could not parse url " + urlS + " to proper URL\n returning null\n" );
      }
    }
		return url;
	}

  public void setURL(String url) throws ConfigurationException {
    setAttribute(URL_KEY, url);
    
    try {
      this.url = new URL(url);
    } catch (MalformedURLException e) {
      throw new ConfigurationException("Could not parse " + url + " to a proper URL: " + e.getMessage(), e);
    }
  }
  
  public void setURL(URL url) {
    if (getAttribute(URL_KEY) == null)
      setAttribute(URL_KEY, url.toExternalForm());
    
    this.url = url;
  }
  
  public String toString() {
		StringBuffer buf = new StringBuffer();

		buf.append("[");
    buf.append(super.toString());
		buf.append("]");

		return buf.toString();
	}
  
  /**
	 * Allows Equality Comparisons manipulation of URLLocation objects
	 */
	public boolean equals(Object o) {
		return o instanceof URLLocation && hashCode() == o.hashCode();
	}
  
  /* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
     return super.hashCode();
	}
  
  
  
	/**
   * @return "name" attribute if set, otherwise defaults to url.toString()
	 * @see org.ensembl.mart.lib.config.MartLocation#getName()
	 */
	public String getName() {
    String name = super.getName();
    if ( name==null ) name = url.toString();
    return name; 
	}
}
