package ai.elimu.web.project.app;

import ai.elimu.dao.project.AppCategoryDao;
import ai.elimu.dao.project.AppGroupDao;
import ai.elimu.dao.project.ProjectDao;
import ai.elimu.model.project.AppCategory;
import ai.elimu.model.project.AppGroup;
import ai.elimu.model.admin.Application;
import ai.elimu.model.project.Project;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import ai.elimu.rest.service.project.ProjectJsonService;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/project/{projectId}/app-category/{appCategoryId}/app-group/{appGroupId}/app")
public class AppListController {
    
    private final Logger logger = Logger.getLogger(getClass());
    
    @Autowired
    private ProjectDao projectDao;
    
    @Autowired
    private AppCategoryDao appCategoryDao;
    
    @Autowired
    private AppGroupDao appGroupDao;

    @Autowired
    private ProjectJsonService projectJsonService;
    
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String handlRequest(
            Model model,
            @PathVariable Long projectId,
            @PathVariable Long appCategoryId,
            @PathVariable Long appGroupId,
            HttpSession session
    ) {
    	logger.info("handleRequest");
        
        logger.info("projectId: " + projectId);
        Project project = projectDao.read(projectId);
        model.addAttribute("project", project);
        
        logger.info("appCategoryId: " + appCategoryId);
        AppCategory appCategory = appCategoryDao.read(appCategoryId);
        model.addAttribute("appCategory", appCategory);
        
        logger.info("appGroupId: " + appGroupId);
        AppGroup appGroup = appGroupDao.read(appGroupId);
        model.addAttribute("appGroup", appGroup);
        
        return "project/app/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public String handlePost(
            HttpSession session,
            @PathVariable Long projectId,
            @PathVariable Long appCategoryId,
            @PathVariable Long appGroupId,
            @RequestBody List<Long> idArray,
            Model model
    ) {
        logger.info("handlePost");

        AppGroup appGroup = appGroupDao.read(appGroupId);

        List<Application> applications = appGroup.getApplications();

        Collections.sort(applications, new Comparator<Application>(){
            @Override
            public int compare(Application a, Application b) {
                return idArray.indexOf(a.getId()) - idArray.indexOf(b.getId());
            }
        });

        appGroup.setApplications(applications);
        appGroupDao.update(appGroup);
        projectJsonService.refreshApplicationsInAppCollection();

        return "ok";
    }
}
