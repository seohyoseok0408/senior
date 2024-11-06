<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="quixnav">
    <div class="quixnav-scroll">
        <ul class="metismenu" id="menu">
            <li class="nav-label first">메인 메뉴</li>
            <!-- <li><a href="index.html"><i class="icon icon-single-04"></i><span class="nav-text">Dashboard</span></a>
            </li> -->
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-single-04"></i><span class="nav-text">Dashboard</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/index.html'/>">대시보드 1</a></li>
                    <li><a href="<c:url value='/index2.html'/>">Dashboard 2</a></li>
                </ul>
            </li>

            <li class="nav-label">Apps</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-app-store"></i><span class="nav-text">Apps</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/app-profile.html'/>">Profile</a></li>
                    <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Email</a>
                        <ul aria-expanded="false">
                            <li><a href="<c:url value='/email-compose.html'/>">Compose</a></li>
                            <li><a href="<c:url value='/email-inbox.html'/>">Inbox</a></li>
                            <li><a href="<c:url value='/email-read.html'/>">Read</a></li>
                        </ul>
                    </li>
                    <li><a href="<c:url value='/app-calender.html'/>">Calendar</a></li>
                </ul>
            </li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-chart-bar-33"></i><span class="nav-text">Charts</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/chart-flot.html'/>">Flot</a></li>
                    <li><a href="<c:url value='/chart-morris.html'/>">Morris</a></li>
                    <li><a href="<c:url value='/chart-chartjs.html'/>">Chartjs</a></li>
                    <li><a href="<c:url value='/chart-chartist.html'/>">Chartist</a></li>
                    <li><a href="<c:url value='/chart-sparkline.html'/>">Sparkline</a></li>
                    <li><a href="<c:url value='/chart-peity.html'/>">Peity</a></li>
                </ul>
            </li>
            <li class="nav-label">Components</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-world-2"></i><span class="nav-text">Bootstrap</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/ui-accordion.html'/>">Accordion</a></li>
                    <li><a href="<c:url value='/ui-alert.html'/>">Alert</a></li>
                    <li><a href="<c:url value='/ui-badge.html'/>">Badge</a></li>
                    <li><a href="<c:url value='/ui-button.html'/>">Button</a></li>
                    <li><a href="<c:url value='/ui-modal.html'/>">Modal</a></li>
                    <li><a href="<c:url value='/ui-button-group.html'/>">Button Group</a></li>
                    <li><a href="<c:url value='/ui-list-group.html'/>">List Group</a></li>
                    <li><a href="<c:url value='/ui-media-object mr-3.html'/>">Media Object</a></li>
                    <li><a href="<c:url value='/ui-card.html'/>">Cards</a></li>
                    <li><a href="<c:url value='/ui-carousel.html'/>">Carousel</a></li>
                    <li><a href="<c:url value='/ui-dropdown.html'/>">Dropdown</a></li>
                    <li><a href="<c:url value='/ui-popover.html'/>">Popover</a></li>
                    <li><a href="<c:url value='/ui-progressbar.html'/>">Progressbar</a></li>
                    <li><a href="<c:url value='/ui-tab.html'/>">Tab</a></li>
                    <li><a href="<c:url value='/ui-typography.html'/>">Typography</a></li>
                    <li><a href="<c:url value='/ui-pagination.html'/>">Pagination</a></li>
                    <li><a href="<c:url value='/ui-grid.html'/>">Grid</a></li>

                </ul>
            </li>

            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-plug"></i><span class="nav-text">Plugins</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/uc-select2.html'/>">Select 2</a></li>
                    <li><a href="<c:url value='/uc-nestable.html'/>">Nestedable</a></li>
                    <li><a href="<c:url value='/uc-noui-slider.html'/>">Noui Slider</a></li>
                    <li><a href="<c:url value='/uc-sweetalert.html'/>">Sweet Alert</a></li>
                    <li><a href="<c:url value='/uc-toastr.html'/>">Toastr</a></li>
                    <li><a href="<c:url value='/map-jqvmap.html'/>">Jqv Map</a></li>
                </ul>
            </li>
            <li><a href="widget-basic.html" aria-expanded="false"><i class="icon icon-globe-2"></i><span
                    class="nav-text">Widget</span></a></li>
            <li class="nav-label">Forms</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-form"></i><span class="nav-text">Forms</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/form-element.html'/>">Form Elements</a></li>
                    <li><a href="<c:url value='/form-wizard.html'/>">Wizard</a></li>
                    <li><a href="<c:url value='/form-editor-summernote.html'/>">Summernote</a></li>
                    <li><a href="form-pickers.html">Pickers</a></li>
                    <li><a href="form-validation-jquery.html">Jquery Validate</a></li>
                </ul>
            </li>
            <li class="nav-label">Table</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-layout-25"></i><span class="nav-text">Table</span></a>
                <ul aria-expanded="false">
                    <li><a href="table-bootstrap-basic.html">Bootstrap</a></li>
                    <li><a href="table-datatable-basic.html">Datatable</a></li>
                </ul>
            </li>

            <li class="nav-label">Extra</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i
                    class="icon icon-single-copy-06"></i><span class="nav-text">Pages</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/page-register.html'/>">Register</a></li>
                    <li><a href="<c:url value='/page-login.html'/>">Login</a></li>
                    <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Error</a>
                        <ul aria-expanded="false">
                            <li><a href="<c:url value='/page-error-400.html'/>">Error 400</a></li>
                            <li><a href="<c:url value='/page-error-403.html'/>">Error 403</a></li>
                            <li><a href="<c:url value='/page-error-404.html'/>">Error 404</a></li>
                            <li><a href="<c:url value='/page-error-500.html'/>">Error 500</a></li>
                            <li><a href="<c:url value='/page-error-503.html'/>">Error 503</a></li>
                        </ul>
                    </li>
                    <li><a href="<c:url value='/page-lock-screen.html'/>">Lock Screen</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>