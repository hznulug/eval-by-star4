<%@page import="java.util.ArrayList"%>
<%@page import="star4.eval.service.MaterialService"%>
<%@page import="star4.eval.bean.SupportingMaterial"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.SupportingMaterial.Doc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>佐证材料</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel='stylesheet' />
        <link href="css/supportingMaterial.css" rel="stylesheet">
        <script src="js/jquery-1.12.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <form action="" id="form1">
            <div class="box">
                <div class="container">
                    <div class="row page-hd">
                        <div class="page-hd-title">
                            <i class="fa fa-file-text"></i>
                            <h4 class="title-name">佐证材料</h4>
                        </div>
                        <div class="back-bt">
                            <a href="auditor.jsp" class="back-name">返回>></a>
                        </div>
                    </div>
                    <div class="row search">
                        <div class="col-md-2">
                            <section id="search-box"> <label for="search-input">
                                </label> <input id="search-input" class="search-input" type="text"
                                                placeholder="请输入工号/姓名/学年"\> </section>
                        </div>
                        <div class="col-md-1 search-bt-box">
                            <button type="button" class="btn btn-default search-bt">搜索</button>
                        </div>
                    </div>

                    <div class="row material-table">
                        <div class="col-md-4 student">
                            <table class="table table-hover student-table"
                                   id="supportingMaterialIdNameYear">
                                <tr>
                                    <td>工号</td>
                                    <td>姓名</td>
                                    <td>学年</td>
                                </tr>
                                <%
                                    // 查询所有 学号 姓名 学年
                                    MaterialService materialService = new MaterialService();//实例化
                                    List<SupportingMaterial> materials = materialService.findAll();//拿到教师列表
                                    SupportingMaterial material = new SupportingMaterial();
                                    String teacherId;//工号
                                    String teacherName;//姓名
                                    String academicYear;//学年
                                    for (SupportingMaterial temp : materials) {
                                        teacherId = temp.getTeacher_id();
                                        teacherName = temp.getTeacher_name();
                                        academicYear = temp.getAcademic_year();
                                        System.out.println(teacherId);
                                %>
                                <tr class="select">
                                    <td><%=teacherId%></td>
                                    <td><%=teacherName%></td>
                                    <td><%=academicYear%></td>
                                </tr>
                                <%
                                    }
                                %>

                            </table>
                        </div>

                        <div class="col-md-8 material">
                            <table class="table table-bordered">
                                <tr>
                                    <td>材料名称</td>
                                    <td>操作</td>
                                </tr>
                                <%
                                    boolean flag = false;
                                    int index=0;
                                    String indexStr=request.getParameter("index");
                                    if(indexStr!=null&&!indexStr.equals("")){
                                         index =Integer.parseInt(indexStr);
                                         material = materials.get(index-1);
                                         flag=true;
                                    }
                                    List<Doc> docs = flag ? material.getDocs() : materials.get(0).getDocs();

                                    for (Doc doc : docs) {
                                %>
                                <tr class="material-item">
                                    <td><%=doc.doc_name%></td>
                                    <td><i class="fa fa-eye" aria-hidden="true"></i> <i
                                            class="fa fa-download" aria-hidden="true"></i></td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script type="text/javascript">
            var orgBgColor = null;
            $('.select').click(function () {
                $('.select').css('background', '#fff');
                $(this).css('background', '#eee');
                $('.material-item').remove();
                // 获取点击的行中的数据
                var cell = document.getElementById("supportingMaterialIdNameYear").rows[this.rowIndex].cells;
                nowTeacherId = cell[0].innerHTML;
                nowTeacherName = cell[1].innerHTML;
                nowYear = cell[2].innerHTML;
                window.location = "supportingMaterial.jsp?index=" + this.rowIndex ;

            });

//            $('.select').hover(function () {
//                orgBgColor = $(this).css("background-color");
//                $(this).css('background-color', '#f5f5f5');
//            },function(){
//                $(this).css('background-color', orgBgColor);
//            });
        </script>
    </body>
</html>