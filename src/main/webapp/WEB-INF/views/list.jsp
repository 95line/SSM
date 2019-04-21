<%--
  Created by IntelliJ IDEA.
  User: jifubiao
  Date: 2019/4/17
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%--<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->--%>
    <%--<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>--%>
    <%--<!-- Bootstrap -->--%>
    <%--<link href="${APP_PATH}/static/bootstrap/css/bootstrap.css" rel="stylesheet">--%>
    <%--<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->--%>
    <%--<script src="${APP_PATH}/static/bootstrap/js/npm.js"></script>--%>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

</head>

<body>
    <!-- 显示页面 -->
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM--CURD</h1>
            </div>
        </div>
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
        <!-- 表格 -->
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <td class="active">员工编号</td>
                    <td class="success">员工姓名</td>
                    <td class="warning">电子邮箱</td>
                    <td class="danger">性别</td>
                    <td class="info">部门</td>
                    <td class="success">操作</td>
                </tr>

                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td class=>${emp.empId}</td>
                        <td class=>${emp.empName}</td>
                        <td class=>${emp.empEmail}</td>
                        <td class=>${emp.gender == "M"?"男":"女"}</td>
                        <td class=>${emp.department.deptName}</td>
                        <td class=>
                            <button type="button" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil">编辑</span>
                            </button>
                            <button type="button" class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>


            </table>
        </div>

        <!-- 分页 -->
        <div class="row">
            <div class="col-md-6">
                <!-- 分页信息 -->
                当前${pageInfo.pageNum}页，总${pageInfo.pages}页，总记录${pageInfo.total}条
            </div>
            <div class="col-md-6">
                <!-- 页码按钮 -->
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.pageNum == 1}">
                            <li class="disabled">
                                <a href="#">首页</a>
                            </li>
                            <li class="disabled">
                                <a href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != 1}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=1">首页</a>
                            </li>
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num  == pageInfo.pageNum}">
                                <li class="active">
                                    <a href="#">${page_Num}</a>
                                </li>
                            </c:if>
                            <c:if test="${page_Num  != pageInfo.pageNum}">
                                <li>
                                    <a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.pageNum == pageInfo.pages}">
                            <li class="disabled">
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled">
                                <a href="#">尾页</a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != pageInfo.pages}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a>
                            </li>
                        </c:if>


                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
