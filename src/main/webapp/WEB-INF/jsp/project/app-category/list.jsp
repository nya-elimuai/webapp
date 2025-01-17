<content:title>
    <fmt:message key="app.categories" /> (${fn:length(project.appCategories)})
</content:title>

<content:section cssId="appCategoryListPage">
    <div class="section row sortable" style="padding-right: 2em;" data-listurl="/list">
        <p class="nosort">
            <fmt:message key="to.add.new.content.click.the.button.below" />
        </p>
        
        <c:forEach var="appCategory" items="${project.appCategories}">
            <div class="col s12 card-panel appCategory" data-id="${appCategory.id}" 
                    style="padding: 1em;">
                
                <a class="editLink right" href="<spring:url value='/project/${project.id}/app-category/edit/${appCategory.id}' />"><span class="material-icons" style="vertical-align: bottom;">edit</span> <fmt:message key="edit" /></a>
                
                <a href="<spring:url value='/project/${project.id}/app-category/${appCategory.id}/app-group/list' />">
                    <h5><c:out value="${appCategory.name}" /></h5>
                </a>
                
                <c:if test="${not empty appCategory.backgroundColor}">
                    <div class="divider" 
                         style="background-color: rgb(${appCategory.backgroundColor}); height: 1em; margin-right: -1em; margin-left: -1em;">
                    </div>
                </c:if>
                
                <%-- List AppGroups --%>
                <div class="appGroupsSortable sortable" data-listurl="/${appCategory.id}/app-group/list">
                    <c:forEach var="appGroup" items="${appCategory.appGroups}">
                <c:choose>
                    <c:when test="${not empty appCategory.backgroundColor}">
                        <div style="padding: 1em; margin: 1em; background-color: rgba(${appCategory.backgroundColor}, 0.2);"
                            data-id="${appGroup.id}">
                    </c:when>
                    <c:otherwise>
                        <div style="padding: 1em; margin: 1em; background-color: #FAFAFA;"
                            data-id="${appGroup.id}">
                    </c:otherwise>
                </c:choose>
                            <%-- List Applications --%>
                            <div class="appsSortable sortable" data-listurl="/${appCategory.id}/app-group/${appGroup.id}/app/list">
                            <c:forEach var="application" items="${appGroup.applications}">
                                <a style="margin: 0.3em;" href="<spring:url value='/project/${project.id}/app-category/${appCategory.id}/app-group/${appGroup.id}/app/${application.id}/edit' />" title="${application.packageName}"
                                    data-id="${application.id}">
                                    ${application.packageName}
                                </a>
                            </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
        <script type="text/javascript">
            var sortable=function(){"use strict";function d(e,t,n){if(void 0===n)return e&&e.h5s&&e.h5s.data&&e.h5s.data[t];e.h5s=e.h5s||{},e.h5s.data=e.h5s.data||{},e.h5s.data[t]=n}function u(e,t){if(!(e instanceof NodeList||e instanceof HTMLCollection||e instanceof Array))throw new Error("You must provide a nodeList/HTMLCollection/Array of elements to be filtered.");return"string"!=typeof t?Array.from(e):Array.from(e).filter(function(e){return 1===e.nodeType&&e.matches(t)})}var p=new Map,t=function(){function e(){this._config=new Map,this._placeholder=void 0,this._data=new Map}return Object.defineProperty(e.prototype,"config",{get:function(){var n={};return this._config.forEach(function(e,t){n[t]=e}),n},set:function(e){if("object"!=typeof e)throw new Error("You must provide a valid configuration object to the config setter.");var t=Object.assign({},e);this._config=new Map(Object.entries(t))},enumerable:!0,configurable:!0}),e.prototype.setConfig=function(e,t){if(!this._config.has(e))throw new Error("Trying to set invalid configuration item: "+e);this._config.set(e,t)},e.prototype.getConfig=function(e){if(!this._config.has(e))throw new Error("Invalid configuration item requested: "+e);return this._config.get(e)},Object.defineProperty(e.prototype,"placeholder",{get:function(){return this._placeholder},set:function(e){if(!(e instanceof HTMLElement)&&null!==e)throw new Error("A placeholder must be an html element or null.");this._placeholder=e},enumerable:!0,configurable:!0}),e.prototype.setData=function(e,t){if("string"!=typeof e)throw new Error("The key must be a string.");this._data.set(e,t)},e.prototype.getData=function(e){if("string"!=typeof e)throw new Error("The key must be a string.");return this._data.get(e)},e.prototype.deleteData=function(e){if("string"!=typeof e)throw new Error("The key must be a string.");return this._data.delete(e)},e}();function m(e){if(!(e instanceof HTMLElement))throw new Error("Please provide a sortable to the store function.");return p.has(e)||p.set(e,new t),p.get(e)}function g(e,t,n){if(e instanceof Array)for(var r=0;r<e.length;++r)g(e[r],t,n);else e.addEventListener(t,n),m(e).setData("event"+t,n)}function l(e,t){if(e instanceof Array)for(var n=0;n<e.length;++n)l(e[n],t);else e.removeEventListener(t,m(e).getData("event"+t)),m(e).deleteData("event"+t)}function h(e,t,n){if(e instanceof Array)for(var r=0;r<e.length;++r)h(e[r],t,n);else e.setAttribute(t,n)}function s(e,t){if(e instanceof Array)for(var n=0;n<e.length;++n)s(e[n],t);else e.removeAttribute(t)}function v(e){if(!e.parentElement||0===e.getClientRects().length)throw new Error("target element must be part of the dom");var t=e.getClientRects()[0];return{left:t.left+window.scrollX,right:t.right+window.scrollX,top:t.top+window.scrollY,bottom:t.bottom+window.scrollY}}function y(e,t){if(!(e instanceof HTMLElement&&(t instanceof NodeList||t instanceof HTMLCollection||t instanceof Array)))throw new Error("You must provide an element and a list of elements.");return Array.from(t).indexOf(e)}function E(e){if(!(e instanceof HTMLElement))throw new Error("Element is not a node element.");return null!==e.parentNode}var n=function(e,t,n){if(!(e instanceof HTMLElement&&e.parentElement instanceof HTMLElement))throw new Error("target and element must be a node");e.parentElement.insertBefore(t,"before"===n?e:e.nextElementSibling)},b=function(e,t){return n(e,t,"before")},w=function(e,t){return n(e,t,"after")};function T(e){if(!(e instanceof HTMLElement))throw new Error("You must provide a valid dom element");var n=window.getComputedStyle(e);return["height","padding-top","padding-bottom"].map(function(e){var t=parseInt(n.getPropertyValue(e),10);return isNaN(t)?0:t}).reduce(function(e,t){return e+t})}function c(e,t){if(!(e instanceof Array))throw new Error("You must provide a Array of HTMLElements to be filtered.");return"string"!=typeof t?e:e.filter(function(e){return e.querySelector(t)instanceof HTMLElement}).map(function(e){return e.querySelector(t)})}var C=function(e,t,n){return{element:e,posX:n.pageX-t.left,posY:n.pageY-t.top}};function L(e,t){if(!0===e.isSortable){var n=m(e).getConfig("acceptFrom");if(null!==n&&!1!==n&&"string"!=typeof n)throw new Error('HTML5Sortable: Wrong argument, "acceptFrom" must be "null", "false", or a valid selector string.');if(null!==n)return!1!==n&&0<n.split(",").filter(function(e){return 0<e.length&&t.matches(e)}).length;if(e===t)return!0;if(void 0!==m(e).getConfig("connectWith")&&null!==m(e).getConfig("connectWith"))return m(e).getConfig("connectWith")===m(t).getConfig("connectWith")}return!1}var M,x,D,A,H,I,S,Y={items:null,connectWith:null,disableIEFix:null,acceptFrom:null,copy:!1,placeholder:null,placeholderClass:"sortable-placeholder",draggingClass:"sortable-dragging",hoverClass:!1,debounce:0,throttleTime:100,maxItems:0,itemSerializer:void 0,containerSerializer:void 0,customDragImage:null};function _(e,t){if("string"==typeof m(e).getConfig("hoverClass")){var o=m(e).getConfig("hoverClass").split(" ");!0===t?(g(e,"mousemove",function(r,o){var i=this;if(void 0===o&&(o=250),"function"!=typeof r)throw new Error("You must provide a function as the first argument for throttle.");if("number"!=typeof o)throw new Error("You must provide a number as the second argument for throttle.");var a=null;return function(){for(var e=[],t=0;t<arguments.length;t++)e[t-0]=arguments[t];var n=Date.now();(null===a||o<=n-a)&&(a=n,r.apply(i,e))}}(function(r){0===r.buttons&&u(e.children,m(e).getConfig("items")).forEach(function(e){var t,n;e!==r.target?(t=e.classList).remove.apply(t,o):(n=e.classList).add.apply(n,o)})},m(e).getConfig("throttleTime"))),g(e,"mouseleave",function(){u(e.children,m(e).getConfig("items")).forEach(function(e){var t;(t=e.classList).remove.apply(t,o)})})):(l(e,"mousemove"),l(e,"mouseleave"))}}var f=function(e){l(e,"dragstart"),l(e,"dragend"),l(e,"dragover"),l(e,"dragenter"),l(e,"drop"),l(e,"mouseenter"),l(e,"mouseleave")},O=function(e,t){var n=e;return!0===m(t).getConfig("copy")&&(h(n=e.cloneNode(!0),"aria-copied","true"),e.parentElement.appendChild(n),n.style.display="none",n.oldDisplay=e.style.display),n};function F(e){for(;!0!==e.isSortable;)e=e.parentElement;return e}function W(e,t){var n=d(e,"opts"),r=u(e.children,n.items).filter(function(e){return e.contains(t)});return 0<r.length?r[0]:t}var r=function(e){var t,n,r,o=d(e,"opts")||{},i=u(e.children,o.items),a=c(i,o.handle);l(e,"dragover"),l(e,"dragenter"),l(e,"drop"),(n=t=e).h5s&&delete n.h5s.data,s(t,"aria-dropeffect"),l(a,"mousedown"),f(i),s(r=i,"aria-grabbed"),s(r,"aria-copied"),s(r,"draggable"),s(r,"role")},j=function(e){var t=d(e,"opts"),n=u(e.children,t.items),r=c(n,t.handle);(h(e,"aria-dropeffect","move"),d(e,"_disabled","false"),h(r,"draggable","true"),!1===t.disableIEFix)&&("function"==typeof(document||window.document).createElement("span").dragDrop&&g(r,"mousedown",function(){if(-1!==n.indexOf(this))this.dragDrop();else{for(var e=this.parentElement;-1===n.indexOf(e);)e=e.parentElement;e.dragDrop()}}))},z=function(e){var t=d(e,"opts"),n=u(e.children,t.items),r=c(n,t.handle);d(e,"_disabled","false"),f(n),l(r,"mousedown"),l(e,"dragover"),l(e,"dragenter"),l(e,"drop")};function N(e,f){var c=String(f);return f=Object.assign({connectWith:null,acceptFrom:null,copy:!1,placeholder:null,disableIEFix:null,placeholderClass:"sortable-placeholder",draggingClass:"sortable-dragging",hoverClass:!1,debounce:0,maxItems:0,itemSerializer:void 0,containerSerializer:void 0,customDragImage:null,items:null},"object"==typeof f?f:{}),"string"==typeof e&&(e=document.querySelectorAll(e)),e instanceof HTMLElement&&(e=[e]),e=Array.prototype.slice.call(e),/serialize/.test(c)?e.map(function(e){var t=d(e,"opts");return function(t,n,e){if(void 0===n&&(n=function(e,t){return e}),void 0===e&&(e=function(e){return e}),!(t instanceof HTMLElement)||1==!t.isSortable)throw new Error("You need to provide a sortableContainer to be serialized.");if("function"!=typeof n||"function"!=typeof e)throw new Error("You need to provide a valid serializer for items and the container.");var r=d(t,"opts").items,o=u(t.children,r),i=o.map(function(e){return{parent:t,node:e,html:e.outerHTML,index:y(e,o)}});return{container:e({node:t,itemCount:i.length}),items:i.map(function(e){return n(e,t)})}}(e,t.itemSerializer,t.containerSerializer)}):(e.forEach(function(s){if(/enable|disable|destroy/.test(c))return N[c](s);["connectWith","disableIEFix"].forEach(function(e){f.hasOwnProperty(e)&&null!==f[e]&&console.warn('HTML5Sortable: You are using the deprecated configuration "'+e+'". This will be removed in an upcoming version, make sure to migrate to the new options when updating.')}),f=Object.assign({},Y,f),m(s).config=f,f=d(s,"opts")||f,d(s,"opts",f),s.isSortable=!0,z(s);var e,t=u(s.children,f.items);if(null!==f.placeholder&&void 0!==f.placeholder){var n=document.createElement(s.tagName);n.innerHTML=f.placeholder,e=n.children[0]}m(s).placeholder=function(e,t,n){if(void 0===n&&(n="sortable-placeholder"),!(e instanceof HTMLElement))throw new Error("You must provide a valid element as a sortable.");if(!(t instanceof HTMLElement)&&void 0!==t)throw new Error("You must provide a valid element as a placeholder or set ot to undefined.");return void 0===t&&(["UL","OL"].includes(e.tagName)?t=document.createElement("li"):["TABLE","TBODY"].includes(e.tagName)?(t=document.createElement("tr")).innerHTML='<td colspan="100"></td>':t=document.createElement("div")),"string"==typeof n&&(r=t.classList).add.apply(r,n.split(" ")),t;var r}(s,e,f.placeholderClass),d(s,"items",f.items),f.acceptFrom?d(s,"acceptFrom",f.acceptFrom):f.connectWith&&d(s,"connectWith",f.connectWith),j(s),h(t,"role","option"),h(t,"aria-grabbed","false"),_(s,!0),g(s,"dragstart",function(e){if(!0!==e.target.isSortable&&(e.stopImmediatePropagation(),(!f.handle||e.target.matches(f.handle))&&"false"!==e.target.getAttribute("draggable"))){var t=F(e.target),n=W(t,e.target);I=u(t.children,f.items),A=I.indexOf(n),H=y(n,t.children),D=t,function(e,t,n){if(!(e instanceof Event))throw new Error("setDragImage requires a DragEvent as the first argument.");if(!(t instanceof HTMLElement))throw new Error("setDragImage requires the dragged element as the second argument.");if(n||(n=C),e.dataTransfer&&e.dataTransfer.setDragImage){var r=n(t,v(t),e);if(!(r.element instanceof HTMLElement)||"number"!=typeof r.posX||"number"!=typeof r.posY)throw new Error("The customDragImage function you provided must return and object with the properties element[string], posX[integer], posY[integer].");e.dataTransfer.effectAllowed="copyMove",e.dataTransfer.setData("text/plain",e.target.id),e.dataTransfer.setDragImage(r.element,r.posX,r.posY)}}(e,n,f.customDragImage),x=T(n),n.classList.add(f.draggingClass),h(M=O(n,t),"aria-grabbed","true"),t.dispatchEvent(new CustomEvent("sortstart",{detail:{origin:{elementIndex:H,index:A,container:D},item:M}}))}}),g(s,"dragenter",function(e){if(!0!==e.target.isSortable){var t=F(e.target);S=u(t.children,d(t,"items")).filter(function(e){return e!==m(s).placeholder})}}),g(s,"dragend",function(e){if(M){M.classList.remove(f.draggingClass),h(M,"aria-grabbed","false"),"true"===M.getAttribute("aria-copied")&&"true"!==d(M,"dropped")&&M.remove(),M.style.display=M.oldDisplay,delete M.oldDisplay;var t=Array.from(p.values()).map(function(e){return e.placeholder}).filter(function(e){return e instanceof HTMLElement}).filter(E)[0];t&&t.remove(),s.dispatchEvent(new CustomEvent("sortstop",{detail:{origin:{elementIndex:H,index:A,container:D},item:M}})),x=M=null}}),g(s,"drop",function(e){if(L(s,M.parentElement)){e.preventDefault(),e.stopPropagation(),d(M,"dropped","true");var t=Array.from(p.values()).map(function(e){return e.placeholder}).filter(function(e){return e instanceof HTMLElement}).filter(E)[0];w(t,M),t.remove(),s.dispatchEvent(new CustomEvent("sortstop",{detail:{origin:{elementIndex:H,index:A,container:D},item:M}}));var n=m(s).placeholder,r=u(D.children,f.items).filter(function(e){return e!==n}),o=!0===this.isSortable?this:this.parentElement,i=u(o.children,d(o,"items")).filter(function(e){return e!==n}),a=y(M,Array.from(M.parentElement.children).filter(function(e){return e!==n})),l=y(M,i);H===a&&D===o||s.dispatchEvent(new CustomEvent("sortupdate",{detail:{origin:{elementIndex:H,index:A,container:D,itemsBeforeUpdate:I,items:r},destination:{index:l,elementIndex:a,container:o,itemsBeforeUpdate:S,items:i},item:M}}))}});var r,o,i,a=(r=function(t,e,n){if(M)if(f.forcePlaceholderSize&&(m(t).placeholder.style.height=x+"px"),-1<Array.from(t.children).indexOf(e)){var r=T(e),o=y(m(t).placeholder,e.parentElement.children),i=y(e,e.parentElement.children);if(x<r){var a=r-x,l=v(e).top;if(o<i&&n<l)return;if(i<o&&l+r-a<n)return}void 0===M.oldDisplay&&(M.oldDisplay=M.style.display),"none"!==M.style.display&&(M.style.display="none");var s=!1;try{s=v(e).top+e.offsetHeight/2<=n}catch(e){s=o<i}s?w(e,m(t).placeholder):b(e,m(t).placeholder),Array.from(p.values()).filter(function(e){return void 0!==e.placeholder}).forEach(function(e){e.placeholder!==m(t).placeholder&&e.placeholder.remove()})}else{var c=Array.from(p.values()).filter(function(e){return void 0!==e.placeholder}).map(function(e){return e.placeholder});-1!==c.indexOf(e)||t!==e||u(e.children,f.items).length||(c.forEach(function(e){return e.remove()}),e.appendChild(m(t).placeholder))}},void 0===(o=f.debounce)&&(o=0),function(){for(var e=[],t=0;t<arguments.length;t++)e[t-0]=arguments[t];clearTimeout(i),i=setTimeout(function(){r.apply(void 0,e)},o)}),l=function(e){var t=e.target,n=!0===t.isSortable?t:F(t);if(t=W(n,t),M&&L(n,M.parentElement)&&"true"!==d(n,"_disabled")){var r=d(n,"opts");parseInt(r.maxItems)&&u(n.children,d(n,"items")).length>=parseInt(r.maxItems)&&M.parentElement!==n||(e.preventDefault(),e.stopPropagation(),e.dataTransfer.dropEffect=!0===m(n).getConfig("copy")?"copy":"move",a(n,t,e.pageY))}};g(t.concat(s),"dragover",l),g(t.concat(s),"dragenter",l)}),e)}return N.destroy=function(e){r(e)},N.enable=function(e){j(e)},N.disable=function(e){var t,n,r;n=d(t=e,"opts"),r=c(u(t.children,n.items),n.handle),h(t,"aria-dropeffect","none"),d(t,"_disabled","true"),h(r,"draggable","false"),l(r,"mousedown")},N}();
        </script>
        <script type="text/javascript">
            var sortableFunc = function(el){
                el.addEventListener('sortupdate', function(e){
                    var itemIds = [];
                    console.log(e);
                    e.detail.destination.items.forEach(function(el){
                        var id = $(el).data('id');
                        if (id !== undefined)
                            itemIds.push(id);
                    });

                    $.ajax({
                        type: "POST",
                        url: "/project/${project.id}/app-category" + $(e.target).data('listurl'),
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(itemIds)
                    });

                    if ($(e.target).data('listurl') !== $(e.detail.origin.container).data('listurl')) {
                        itemIds = [];
                        e.detail.origin.items.forEach(function(el){
                            var id = $(el).data('id');
                            if (id !== undefined)
                                itemIds.push(id);
                        });

                        $.ajax({
                            type: "POST",
                            url: "/project/${project.id}/app-category" + $(e.detail.origin.container).data('listurl'),
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(itemIds)
                        });
                    }
                });
            }
            sortable('.section.row.sortable', {
                items: ':not(.nosort)',
                placeholder: '<div class="sortable-placeholder">&nbsp;</div>',
                forcePlaceholderSize: true,
            }).forEach(sortableFunc);
            sortable('.appGroupsSortable.sortable', {
                items: ':not(.nosort)',
                placeholder: '<div class="sortable-placeholder">&nbsp;</div>',
                forcePlaceholderSize: true,
                acceptFrom: '.appGroupsSortable'
            }).forEach(sortableFunc);
            sortable('.appsSortable.sortable', {
                items: ':not(.nosort)',
                placeholder: '<div class="sortable-placeholder">&nbsp;</div>',
                forcePlaceholderSize: true,
                acceptFrom: '.appsSortable'
            }).forEach(sortableFunc);
        </script>
    </div>
    
    <div class="fixed-action-btn" style="bottom: 2em; right: 2em;">
        <a href="<spring:url value='/project/${project.id}/app-category/create' />" class="btn-floating btn-large deep-purple lighten-1 tooltipped" data-position="left" data-delay="50" data-tooltip="<fmt:message key="add.app.category" />"><i class="material-icons">add</i></a>
    </div>
</content:section>

<c:if test="${not empty project.appCategories}">
    <content:aside>
        <h5 class="center"><fmt:message key="app.collections" /></h5>

        <table class="bordered highlight">
            <thead>
                <th><fmt:message key="name" /></th>
                <th><fmt:message key="app.categories" /></th>
            </thead>
            <tbody>
                <c:forEach var="appCollection" items="${appCollections}">
                    <tr class="appCollection">
                        <td>
                            <a href="<spring:url value='/project/${project.id}/app-collection/edit/${appCollection.id}' />">
                                <c:out value="${appCollection.name}" />
                            </a>
                        </td>
                        <td>
                            ${fn:length(appCollection.appCategories)}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p></p>

        <a href="<spring:url value='/project/${project.id}/app-collection/create' />" class="btn waves-effect grey lighten-5 waves-grey grey-text">
            <fmt:message key="add.app.collection" />
        </a>
    </content:aside>
</c:if>
