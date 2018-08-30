package ai.elimu.web.project.app_category;

import ai.elimu.dao.project.AppCollectionDao;
import ai.elimu.dao.project.ProjectDao;
import ai.elimu.model.project.AppCollection;
import ai.elimu.model.project.AppCategory;
import ai.elimu.model.project.Project;
import ai.elimu.rest.service.project.ProjectJsonService;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/project/{projectId}/app-category")
public class AppCategoryListController {
    
    private final Logger logger = Logger.getLogger(getClass());
    
    @Autowired
    private ProjectDao projectDao;
    
    @Autowired
    private AppCollectionDao appCollectionDao;

    @Autowired
    private ProjectJsonService projectJsonService;
    
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String handlRequest(Model model, @PathVariable Long projectId, HttpSession session) {
    	logger.info("handleRequest");
        
        logger.info("projectId: " + projectId);
        Project project = projectDao.read(projectId);
        model.addAttribute("project", project);
        
        List<AppCollection> appCollections = appCollectionDao.readAll(project);
        model.addAttribute("appCollections", appCollections);
        
        return "project/app-category/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public String handlePost(
            HttpSession session,
            @PathVariable Long projectId,
            @RequestBody List<Long> idArray,
            Model model
    ) {
        logger.info("handlePost");

        // Update project appCategories
        Project project = projectDao.read(projectId);
        List<AppCategory> appCategories = project.getAppCategories();

        Collections.sort(appCategories, new Comparator<AppCategory>(){
            @Override
            public int compare(AppCategory a, AppCategory b) {
                return idArray.indexOf(a.getId()) - idArray.indexOf(b.getId());
            }
        });

        project.setAppCategories(appCategories);
        projectDao.update(project);

        // Update appCollection appCategories
        List<AppCollection> appCollections = appCollectionDao.readAll(project);
        for (AppCollection appCollection : appCollections) {
            appCategories = appCollection.getAppCategories();

            Collections.sort(appCategories, new Comparator<AppCategory>(){
                @Override
                public int compare(AppCategory a, AppCategory b) {
                    return idArray.indexOf(a.getId()) - idArray.indexOf(b.getId());
                }
            });

            appCollection.setAppCategories(appCategories);
            appCollectionDao.update(appCollection);
        }

        projectJsonService.refreshApplicationsInAppCollection();

        return "ok";
    }
}
