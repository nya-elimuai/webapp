package org.literacyapp.rest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RestController;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/rest")
public class FallbackController {
    
    private Logger logger = Logger.getLogger(getClass());
    
    @RequestMapping
    public String handleRequest() {
        logger.info("handleRequest");
        
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("error", "URL not found. See /rest/documentation");
        
        return jsonObject.toString();
    }
}