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
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

</head>

<body>
<!-- 新增模态框-->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工信息新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputEmpName" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">电子邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="empEmail" class="form-control" id="inputEmail" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gener_add_input1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gener_add_input2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="departmentId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改模态框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">员工信息修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="updateEmpName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">电子邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="empEmail" class="form-control" id="updateEmail">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gener_update1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gener_update2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="departmentId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button type="button" class="btn btn-primary" id="addBtn">新增</button>
            <button type="button" class="btn btn-danger" id="delBtn">删除</button>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <table class="table table-hover" id="empss_table">
            <thead>
                <tr>
                    <td>
                        <input type="checkbox" id="check_all" />全选
                    </td>
                    <td class="active">员工编号</td>
                    <td class="success">员工姓名</td>
                    <td class="warning">电子邮箱</td>
                    <td class="danger">性别</td>
                    <td class="info">部门</td>
                    <td class="success">操作</td>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

    <!-- 分页 -->
    <div class="row">
        <div class="col-md-6" id="page_info">

        </div>

        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>

<script type="text/javascript">

    //总记录数
    var totalRecord,currentPage;
    //页面加载完成后，直接发送ajax请求，要到分页数据
    $(function () {
        //显示首页信息
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/empss",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //解析并显示员工数据
                build_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页条
                build_page_nav(result);
            }
        })
    }

    //解析并显示员工数据
    function build_table(result) {
        $("#empss_table tbody").empty();
        //获取list数据
        var empss = result.extend.pageInfo.list;
        $.each(empss,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empEmailTd = $("<td></td>").append(item.empEmail);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("delete-id",item.empId);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empEmailTd)
                            .append(genderTd).append(deptNameTd)
                            .append(editBtn).append(delBtn)
                             .appendTo("#empss_table tbody");
        })
    }

    //解析并显示分页信息
    function build_page_info(result) {
        $("#page_info").empty();
        $("#page_info").append("当前"+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages+"页，总记录"+result.extend.pageInfo.total+"条");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析并显示分页条
    function build_page_nav(result) {
        $("#page_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        $("#page_nav").append(navEle);

    }

    //点击新增按钮，弹出模态框
    $("#addBtn").click(function () {
        reset_form($("#addModal form"));
        //1。发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#addModal select");
        //2.弹出模态框
        $("#addModal").modal({
                backdrop:"static"
        });
    });

    function reset_form(ele) {
        $(ele)[0].reset();

        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/getDepts",
            type:"get",
            success:function (result) {
                //console.log(result);
                $.each(result.extend.depts,function () {
                    //console.log(this.deptName);
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    $(ele).append(optionEle);
                })
            }
        })

    }

    //检查新增的用户名是否可用
    $("#inputEmpName").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100) {
                    show_validate_msg($("#inputEmpName"),"success","用户名可用");
                    $("#emp_save").attr("ajax_checkUser","success");
                }else{
                    show_validate_msg($("#inputEmpName"),"error",result.extend.va_msg);
                    $("#emp_save").attr("ajax_checkUser","error");
                }
            }
        })
    })

    //点击保存按钮
    $("#emp_save").click(function () {
        //校验数据
        if (!validate_add_form()){
            return false;
        }

        //当用户名不可用时，不能进行保存
        if ($("#emp_save").attr("ajax_checkUser") == "error") {
            return false;
        }

        //alert($("#addModal form").serialize());
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#addModal form").serialize(),
            success:function (result) {
                 if (result.code == 100){
                    //alert(result.msg);
                    //关闭模态框
                    $("#addModal").modal('hide');
                    //显示最后一页最新的数据
                    to_page(totalRecord);
                } else{
                    //显示失败信息
                    if (undefined != result.extend.errorFields.empEmail){
                        show_validate_msg($("#inputEmail"),"error",result.extend.errorFields.empEmail);
                    }
                    if (undefined != result.extend.errorFields.empName){
                        show_validate_msg($("#inputEmpName"),"error",result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    function validate_add_form() {
        // var empName = $("#inputEmpName").val();
        // var regName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)/;
        // if (!regName.test(empName)) {
        //     //alert("用户名为6-16位的英文，汉字，数字的组合")
        //     show_validate_msg($("#inputEmpName"),"error","用户名为6-16位的英文，汉字，数字的组合");
        //     // $("#inputEmpName").parent().addClass("has_error");
        //     // $("#inputEmpName").next().text("用户名为6-16位的英文，汉字，数字的组合");
        //     return false;
        // }else{
        //     show_validate_msg($("#inputEmpName"),"success","用户名符合规范");
        //     // $("#inputEmpName").parent().addClass("has_success");
        //     // $("#inputEmpName").next().text("用户名符合规范");
        //
        // }

        var empEmail = $("#inputEmail").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(empEmail)){
            //alert("邮箱格式不正确！");
            show_validate_msg($("#inputEmail"),"error","邮箱格式不正确！");
            // $("#inputEmail").parent().addClass("has_error");
            // $("#inputEmail").next().text("邮箱格式不正确！");
            return false;
        }else{
            show_validate_msg($("#inputEmail"),"success","邮箱格式符合规范！");
            // $("#inputEmail").parent().addClass("has_success");
            // $("#inputEmail").next().text("邮箱格式符合规范！");

        }

        return true;
    }

    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next().removeClass("has-success has-error");
        if(status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else{
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //编辑按钮添加事件
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        //1。发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#updateModal select");

        //查询返现员工信息
        getEmpById($(this).attr("edit-id"));
        //2.弹出模态框
        $("#updateModal").modal({
            backdrop:"static"
        });

    })
    
    function getEmpById(id) {
        $.ajax({
            url:"${APP_PATH}/empss/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData = result.extend.employee;
                $("#updateEmpName").val(empData.empName);
                $("#updateEmail").val(empData.empEmail);
                $("#updateModal input[name=gender]").val([empData.gender]);
                $("#updateModal select").val([empData.departmentId]);
            }
        });
    }

    //修改员工信息保存
    $("#emp_update").click(function () {
        //检查邮箱输入是否合法
        var empEmail = $("#updateEmail").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(empEmail)){
            //alert("邮箱格式不正确！");
            show_validate_msg($("#updateEmail"),"error","邮箱格式不正确！");
            return false;
        }else{
            show_validate_msg($("#updateEmail"),"success","邮箱格式符合规范！");

        }

        $.ajax({
            url:"${APP_PATH}/empss/"+$(".edit_btn").attr("edit-id"),
            type:"PUT",
            data:$("#updateModal form").serialize(),
            success:function (result) {
                console.log(result);
                //关闭模态框
                $("#updateModal").modal('hide');
                //显示最后一页最新的数据
                to_page(currentPage);
            }
        })

    })

    //单个删除按钮
    $(document).on("click",".delete_btn",function () {
        var delEmpName = $(this).parent("tr").find("td:eq(2)").text();

        if(confirm("确认删除【"+delEmpName+"】这条记录吗？")){
            $.ajax({
                url:"${APP_PATH}/empss/"+$(this).attr("delete-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    //全选/全不选
    $("#check_all").click(function () {

        $(".check_item").prop("checked",$(this).prop("checked"));

    });

    $(document).on("click",".check_item",function () {
       var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //批量删除
    $("#delBtn").click(function () {

        var deleteEmpNames = "";
        var deleteEmpId = "";
        $.each($(".check_item:checked"),function () {
            deleteEmpNames += $(this).parents("tr").find("td:eq(2)").text() +",";
            deleteEmpId += $(this).parents("tr").find("td:eq(1)").text() +"-";
           // alert(deleteEmpNames);

        });
        deleteEmpNames = deleteEmpNames.substring(0,deleteEmpNames.length-1);
        deleteEmpId = deleteEmpId.substring(0,deleteEmpId.length-1);
        //lert(deleteEmpId);

        if(confirm("确认删除【"+deleteEmpNames+"】这条记录吗？")){
            $.ajax({
                url:"${APP_PATH}/empss/"+deleteEmpId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })

</script>
</body>
</html>
