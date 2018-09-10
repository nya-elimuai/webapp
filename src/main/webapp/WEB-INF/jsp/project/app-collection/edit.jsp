<content:title>
    <fmt:message key="edit.app.collection" />
</content:title>

<content:section cssId="appCollectionEditPage">
    <h4><content:gettitle /></h4>
    
    <div class="card-panel">
        <form:form modelAttribute="appCollection">
            <tag:formErrors modelAttribute="appCollection" />
            
            <form:hidden path="project" value="${project.id}" />

            <div class="row">
                <div class="input-field col s12">
                    <form:label path="name" cssErrorClass="error"><fmt:message key='name' /></form:label>
                    <form:input path="name" cssErrorClass="error" />
                </div>
                
                <div class="input-field col s12">
                    <c:forEach var="allProject" items="${projects}">
                        <!-- Check if anything inside this project is used, in that case we want to default it to open -->
                        <c:set var="isUsed" value="false" />
                        <c:forEach var="appCategory" items="${allProject.appCategories}">
                            <c:if test="${!isUsed}">
                                <c:forEach var="appCollectionAppCategory" items="${appCollection.appCategories}">
                                    <c:if test="${appCollectionAppCategory.id == appCategory.id}">
                                        <c:set var="isUsed" value="true" />
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>


                        <br /><details <c:if test="${isUsed}">open="open"</c:if>>
                            <summary style="cursor: pointer;"><c:out value="${allProject.name}" /></summary>
                            <c:forEach var="appCategory" items="${allProject.appCategories}">
                                <c:set var="isChecked" value="false" />
                                <c:forEach var="appCollectionAppCategory" items="${appCollection.appCategories}">
                                    <c:if test="${appCollectionAppCategory.id == appCategory.id}">
                                        <c:set var="isChecked" value="true" />
                                    </c:if>
                                </c:forEach>

                                <input type="checkbox" name="appCategories" id="appCategory_${appCategory.id}" value="${appCategory.id}"
                                       <c:if test="${isChecked}">checked="checked"</c:if> />
                                <label for="appCategory_${appCategory.id}">
                                    <c:out value="${appCategory.name}" />
                                </label><br />
                            </c:forEach>
                        </details>
                    </c:forEach>
                </div>
            </div>
            <br />
            
            <button id="submitButton" class="btn deep-purple lighten-1 waves-effect waves-light" type="submit">
                <fmt:message key="edit" /> <i class="material-icons right">send</i>
            </button>
        </form:form>
    </div>
</content:section>

<content:aside>
    <h5 class="center"><fmt:message key="licenses" /></h5>

    <table class="bordered highlight">
        <thead>
            <th><fmt:message key="email" /> • <fmt:message key="license.number" /></th>
        </thead>
        <tbody>
            <c:forEach var="license" items="${licenses}">
                <tr class="license">
                    <td>
                        <a href="<spring:url value='/project/${project.id}/app-collection/${appCollection.id}/license/edit/${license.id}' />">
                            <c:out value="${license.licenseEmail}" /> • <c:out value="${license.licenseNumber}" />
                        </a><br />
                        <c:out value="${license.firstName}" />&nbsp;<c:out value="${license.lastName}" />
                        <c:if test="${not empty license.organization}">
                            (<c:out value="${license.organization}" />)
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <p></p>

    <a href="<spring:url value='/project/${project.id}/app-collection/${appCollection.id}/license/create' />" class="btn waves-effect grey lighten-5 waves-grey grey-text">
        <fmt:message key="add.license" />
    </a>
</content:aside>
