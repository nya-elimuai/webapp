package ai.elimu.web.project.app_group;

import ai.elimu.dao.project.AppCategoryDao;
import ai.elimu.dao.project.AppGroupDao;
import ai.elimu.dao.project.ProjectDao;
import ai.elimu.model.project.AppCategory;
import ai.elimu.model.project.AppGroup;
import ai.elimu.model.project.Project;
import ai.elimu.rest.service.project.ProjectJsonService;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/project/{projectId}/app-category/{appCategoryId}/app-group")
public class AppGroupListController {
    
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
            HttpSession session
    ) {
    	logger.info("handleRequest");
        
        logger.info("projectId: " + projectId);
        Project project = projectDao.read(projectId);
        model.addAttribute("project", project);
        
        logger.info("appCategoryId: " + appCategoryId);
        AppCategory appCategory = appCategoryDao.read(appCategoryId);
        model.addAttribute("appCategory", appCategory);
        
        return "project/app-group/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public String handlePost(
            HttpSession session,
            @PathVariable Long projectId,
            @PathVariable Long appCategoryId,
            @RequestBody List<Long> idArray,
            Model model
    ) {
        logger.info("handlePost");

        AppCategory appCategory = appCategoryDao.read(appCategoryId);

        List<AppGroup> appGroups = appCategory.getAppGroups();

        // Check if there are additions/removals (move between groups)
        if (appGroups.size() != idArray.size()) {
            List<Long> groupIds = new ArrayList();
            for (AppGroup appGroup : new ArrayList<AppGroup>(appGroups)) {
                groupIds.add(appGroup.getId());
                if (!idArray.contains(appGroup.getId())) {
                    appGroups.remove(appGroup);
                }
            }
            for (Long groupId : idArray) {
                if (!groupIds.contains(groupId)) {
                    AppGroup appGroup = appGroupDao.read(groupId);
                    appGroup.setAppCategory(appCategory);
                    appGroupDao.update(appGroup);
                    appGroups.add(appGroup);
                }
            }
        }
        //

        Collections.sort(appGroups, new Comparator<AppGroup>(){
            @Override
            public int compare(AppGroup a, AppGroup b) {
                return idArray.indexOf(a.getId()) - idArray.indexOf(b.getId());
            }
        });

        appCategory.setAppGroups(appGroups);
        appCategoryDao.update(appCategory);
        projectJsonService.refreshApplicationsInAppCollection();

        return "ok";
    }
}
