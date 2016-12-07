<!--Created by MasterHo on 2016.11.30 via IntelliJ IDEA.-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>简单型贴吧--管理端</title>
    <!-- Bootstrap Core CSS -->
    <link href="__PUBLIC__/css/bootstrap.min.css" rel="stylesheet">
    <link href="__PUBLIC__/css/font-awesome.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="__PUBLIC__/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <!-- DataTables Responsive CSS -->
    <link href="__PUBLIC__/css/responsive.bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default" role="navigation" id="header-bar-container">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">简单版贴吧<small>(管理端)</small></a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="#" id="btnRefresh" onclick="refreshChat()"><i class="fa fa-refresh fa-fw"></i> 刷新</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> {{$smarty.session.admin.usrName}} <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="{{U('Home/Index/chat')}}"><i class="fa fa-angle-double-left fa-fw"></i> 返回到主页</a>
                        <li><a href="#" data-toggle="modal" data-target="#aboutWindow"><i class="fa fa-info fa-fw"></i>关于</a></li>
                        <li class="divider"></li>
                        <li><a href="#" id="btnLogout"><i class="fa fa-sign-out fa-fw"></i> 登出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->
        </div>
    </div>
</nav>

<div class="container">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#messages" role="tab" data-toggle="tab">帖子</a></li>
        <li role="presentation"><a href="#users" role="tab" data-toggle="tab">用户</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="messages">

        </div>
        <div role="tabpanel" class="tab-pane fade" id="users">
            <table width="100%" class="table table-striped table-bordered table-hover" id="userList">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>性别</th>
                    <th>E-Mail</th>
                    <th>账号状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="userListT">

                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 回复帖子窗口 -->
<div class="modal fade" id="replyMsgWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">回复信息</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <textarea class="form-control" id="textReplyMsg" placeholder="输入消息内容" rows="5"></textarea>
                </div>
                <div class="form-group">
                    <label for="msgType">消息类型</label>
                    <select class="form-control" id="replyMsgType" name="replyMsgType">
                        <option value="0">捷报</option>
                        <option value="1" selected>普通</option>
                        <option value="2">重要</option>
                        <option value="3">紧急</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnToReplyMsg">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 删除帖子提示 -->
<div class="modal fade" id="alertDelCWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">删除帖子</h4>
            </div>
            <div class="modal-body">确定要删除该帖子了吗？</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnToDelC">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 封禁用户提示 -->
<div class="modal fade" id="alertFreezeUWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">封禁用户</h4>
            </div>
            <div class="modal-body">确定封禁该用户？</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnToFrzU">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 解封用户提示 -->
<div class="modal fade" id="alertUnFreezeUWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">解封用户</h4>
            </div>
            <div class="modal-body">解封用户？</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnToUnFrzU">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 删除用户提示 -->
<div class="modal fade" id="alertDelUWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">删除用户</h4>
            </div>
            <div class="modal-body">确定要删除该用户了吗？</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnToDelU">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 自定义提示 -->
<div class="modal fade" id="alertHint" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">提示</h4>
            </div>
            <div class="modal-body" id="alertHintContent"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnReload">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 关于 -->
<div class="modal fade" id="aboutWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">关于</h4>
            </div>
            <div class="modal-body">
                <p>简单版贴吧平台<small>(管理端)</small></p>
                <p>Version:V1.0 Alpha</p>
                <p>作者：MasterHo1228</p>
                <p>My Websites:</p>
                <p><i class="fa fa-weibo fa-fw"></i> <a href="http://weibo.com/206068829/" target="_blank">http://weibo.com/206068829/</a>
                </p>
                <p><i class="fa fa-github fa-fw"></i> <a href="https://github.com/MasterHo1228" target="_blank">https://github.com/MasterHo1228</a>
                </p>
                <p><i class="fa fa-qq fa-fw"></i> 1157609142</p>
                <p><i class="fa fa-wechat fa-fw"></i> MasterHo1228</p>
                <p>个人网站:<a href="http://masterho1228.top" target="_blank">http://masterho1228.top</a></p>
                <br/>
                <p>基于ThinkPHP via Smarty+Bootstrap制作~<img
                        src="http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b6/doge_org.gif"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

</body>
<!-- jQuery -->
<script src="__PUBLIC__/js/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="__PUBLIC__/js/bootstrap.min.js"></script>

<script src="__PUBLIC__/js/jquery.dataTables.min.js"></script>
<script src="__PUBLIC__/js/dataTables.bootstrap.min.js"></script>
<script src="__PUBLIC__/js/dataTables.responsive.min.js"></script>

<script language="JavaScript">
    var replyCID,freezeUID,unfreezeUID,delUID,delCID;

    function refreshChat() {
        var userTable;
        $("#messages").empty();

        $.getJSON("{{U('Home/Chat/getAllMassage')}}", function (data) {
            $.each(data, function (i, item) {
                var msgStyle;
                var message;
                var msgContent = item.ccontent;
                var userName;

                switch (item.ctype) {
                    case "0":
                        msgStyle = "panel-success";
                        break;
                    case "1":
                        msgStyle = "panel-primary";
                        break;
                    case "2":
                        msgStyle = "panel-warning";
                        break;
                    case "3":
                        msgStyle = "panel-danger";
                        break;
                }


                switch (item.username){
                    case 'AdminUser':userName = '管理员';break;
                    default:userName = item.username;
                }

                if (item.cisreply == "1") {
                    replyCID = item.replycid;
                    $.ajax({
                        url: "{{U('Home/Chat/getSingalMassage')}}" + "?cID=" + replyCID,
                        dataType: 'json',
                        success: function (data) {
                            if (data == null) {
                                message =
                                    "<div class='panel " + msgStyle + "'>" +
                                    "<div class='panel-heading'>" +
                                    "<div class='panel-title pull-left'>" + userName + "&nbsp;<small>" + item.csendtime + "</small>" + "</div>" +
                                    "<button class='btn btn-xs btn-danger pull-right btnDelC' value='" + item.cid + "' data-toggle='modal' data-target='#alertDelCWindow'>删除</button>" +
                                    "<button class='btn btn-xs btn-default pull-right btnReply' value='" + item.cid + "'>回复</button>" +
                                    "<div class='clearfix'></div>" +
                                    "</div>" +
                                    "<div class='panel-body'>" +
                                    "<pre>" + "没有找到原文信息或原文已被删除！" + "</pre>" + msgContent + "</div>" +
                                    "</div>";
                            } else {
                                var originUserName;
                                switch (data.username){
                                    case 'AdminUser':originUserName = '管理员';break;
                                    default:originUserName = data.username;
                                }

                                message =
                                    "<div class='panel " + msgStyle + "'>" +
                                    "<div class='panel-heading'>" +
                                    "<div class='panel-title pull-left'>" + userName + "&nbsp;<small>" + item.csendtime + "</small>" + "</div>" +
                                    "<button class='btn btn-xs btn-danger pull-right btnDelC' value='" + item.cid + "' data-toggle='modal' data-target='#alertDelCWindow'>删除</button>" +
                                    "<button class='btn btn-xs btn-default pull-right btnReply' value='" + item.cid + "'>回复</button>" +
                                    "<div class='clearfix'></div>" +
                                    "</div>" +
                                    "<div class='panel-body'>" +
                                    "<pre>" + originUserName + '：' + data.ccontent + "</pre>" + msgContent + "</div>" +
                                    "</div>";
                            }
                            $("#messages").append(message);
                        }
                    });
                } else {
                    message =
                        "<div class='panel " + msgStyle + "'>" +
                        "<div class='panel-heading'>" +
                        "<div class='panel-title pull-left'>" + userName + "&nbsp;<small>" + item.csendtime + "</small>" + "</div>" +
                        "<button class='btn btn-xs btn-danger pull-right btnDelC' value='" + item.cid + "' data-toggle='modal' data-target='#alertDelCWindow'>删除</button>" +
                        "<button class='btn btn-xs btn-default pull-right btnReply' value='" + item.cid + "'>回复</button>" +
                        "<div class='clearfix'></div>" +
                        "</div>" +
                        "<div class='panel-body'>" + msgContent + "</div>" +
                        "</div>";
                    $("#messages").append(message);
                }
            });
        });

        $.getJSON("{{U('Admin/User/userList')}}", function (data) {
            $("#userListT").empty();
            $.each(data, function (i, item) {
                var userStatus;
                var userGender;
                var freezeStyle = 'none';
                var unfreezeStyle = 'none';
                switch (item.ustatus){
                    case '1':
                        userStatus='正常';
                        freezeStyle='block';
                        break;
                    case '0':
                        userStatus='封禁';
                        unfreezeStyle='block';
                        break;
                }

                switch (item.ugender){
                    case 'male':userGender='男';break;
                    case 'female':userGender='女';break;
                }

                var userRow =
                    "<tr>" +
                        "<td>"+item.uid+"</td>"+
                        "<td>"+item.uname+"</td>"+
                        "<td>"+userGender+"</td>"+
                        "<td>"+item.uemail+"</td>"+
                        "<td>"+userStatus+"</td>"+
                        "<td>"+
                            "<button class='btn btn-xs btn-warning btnFreezeUser' style='display: "+freezeStyle+"' value='"+item.uid+"' data-toggle='modal' data-target='#alertFreezeUWindow'>封禁</button>" +
                            "<button class='btn btn-xs btn-success btnUnFreezeUser' style='display: "+unfreezeStyle+"' value='"+item.uid+"' data-toggle='modal' data-target='#alertUnFreezeUWindow'>解封</button>" +
                            "<button class='btn btn-xs btn-danger btnDelUser' value='"+item.uid+"' data-toggle='modal' data-target='#alertDelUWindow'>删除</button>"+
                        "</td>"+
                    "</tr>";
                $("#userListT").append(userRow);
            });
            userTable = $('#userList').dataTable({
                retrieve: true,
                responsive: true,
                sPaginationType : "full_numbers",
                oLanguage : {
                    sLengthMenu: "每页显示 _MENU_ 条记录",
                    sInfo: "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                    sInfoEmpty: "没有数据",
                    sInfoFiltered: "(从 _MAX_ 条数据中检索)",
                    sZeroRecords: "没有检索到数据",
                    sSearch: "搜索:",
                    oPaginate: {
                        sFirst: "首页",
                        sPrevious: "前一页",
                        sNext: "后一页",
                        sLast: "尾页"
                    }
                }
            });
        });
    }


    $(function () {
        refreshChat();

        $("#btnLogout").click(function () {
            $.ajax({
                url: "{{U('Home/Index/logout')}}",
                dataType: 'json',
                success: function (data) {
                    if (data.status == 'ok') {
                        $("#alertHintContent").empty().append("登出成功！");
                        $("#btnReload").attr('value', 'exit');
                        $("#alertHint").modal('show');
                    }
                }
            });
        });

        $("#btnReload").click(function () {
            $("#alertHint").modal('hide');

            switch ($(this).attr('value')) {
                case 'reload':
                    window.location.reload();
                    break;
                case 'refresh':
                    replyCID='';
                    freezeUID='';
                    unfreezeUID='';
                    delUID='';
                    delCID='';
                    refreshChat();
                    break;
                case 'exit':
                    window.location.href="{{U('Home/Index/chat')}}";
                    break;
            }
        });

        $("#userListT").delegate('.btnFreezeUser', 'click', function () {
            freezeUID = $(this).attr('value');
        });
        $("#userListT").delegate('.btnUnFreezeUser', 'click', function () {
            unfreezeUID = $(this).attr('value');
        });

        $("#userListT").delegate('.btnDelUser', 'click', function () {
            delUID = $(this).attr('value');
        });

        $("#messages").delegate('.btnReply', 'click', function () {
            replyCID = $(this).attr('value');
            $("#replyMsgWindow").modal('show');
        });

        $("#messages").delegate('.btnDelC', 'click', function () {
            delCID = $(this).attr('value');
            $("#alertDelWindow").modal('show');
        });

        $("#btnToReplyMsg").click(function () {
            var msgContent = $("#textReplyMsg").val();
            var msgType = $("#replyMsgType").val();
            if (msgContent != '' && replyCID != '') {
                $.ajax({
                    url: "{{U('Home/Chat/add')}}",
                    type: 'post',
                    data: {
                        msgContent: msgContent,
                        msgType: msgType,
                        isReply: '1',
                        replyCID: replyCID
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data.addStatus == 'true') {
                            $("#replyMsgWindow").modal('hide');
                            $("#alertHintContent").empty().append("回复成功！");
                            $("#textReplyMsg").val('');
                        } else if (data.addStatus == 'false') {
                            $("#alertHintContent").empty().append("发布失败！");
                        }
                        $("#btnReload").attr('value', 'refresh');
                        $("#alertHint").modal('show');
                    }
                });
            } else {
                $("#alertHintContent").empty().append("请填写回复帖子的内容！");
                $("#alertHint").modal('show');
            }
        });

        $("#btnToFrzU").click(function () {
            if (freezeUID!=''){
                $.ajax({
                    url:"{{U('Admin/User/freeze')}}",
                    type:'post',
                    data:{userID:freezeUID},
                    dataType:'json',
                    success:function (data) {
                        $("#alertFreezeUWindow").modal('hide');
                        $("#btnReload").attr('value', 'refresh');
                        if (data.freeze=='true'){
                            $("#alertHintContent").empty().append("用户已封禁！");
                        } else if (data.freeze=='false') {
                            $("#alertHintContent").empty().append("操作失败！");
                        }
                        $("#alertHint").modal('show');
                    }
                })
            }
        });

        $("#btnToUnFrzU").click(function () {
            if (unfreezeUID!=''){
                $.ajax({
                    url:"{{U('Admin/User/unfreeze')}}",
                    type:'post',
                    data:{userID:unfreezeUID},
                    dataType:'json',
                    success:function (data) {
                        $("#alertUnFreezeUWindow").modal('hide');
                        $("#btnReload").attr('value', 'refresh');
                        if (data.unfreeze=='true'){
                            $("#alertHintContent").empty().append("用户已解封！");
                        } else if (data.unfreeze=='false') {
                            $("#alertHintContent").empty().append("操作失败！");
                        }
                        $("#alertHint").modal('show');
                    }
                })
            }
        });

        $("#btnToDelU").click(function () {
            if (delUID != "") {
                $.ajax({
                    url: "{{U('Admin/User/delete')}}",
                    type: 'post',
                    data:{userID:delUID},
                    dataType: 'json',
                    success: function (data) {
                        if (data.deleteStatus == 'true') {
                            $("#alertDelUWindow").modal('hide');
                            $("#alertHintContent").empty().append("删除成功！");
                        } else if (data.deleteStatus == 'false') {
                            $("#alertDelUWindow").modal('hide');
                            $("#alertHintContent").empty().append("删除失败！");
                        }
                        $("#btnReload").attr('value', 'refresh');
                        $("#alertHint").modal('show');
                    }
                })
            }
        });

        $("#btnToDelC").click(function () {
            if (delCID != "") {
                $.ajax({
                    url: "{{U('Home/Chat/delete')}}",
                    type: 'post',
                    data:{cID:delCID},
                    dataType: 'json',
                    success: function (data) {
                        $("#alertDelCWindow").modal('hide');
                        if (data.deleteStatus == 'true') {
                            $("#alertHintContent").empty().append("删除成功！");
                        } else if (data.deleteStatus == 'false') {
                            $("#alertHintContent").empty().append("删除失败！");
                        }
                        $("#btnReload").attr('value', 'refresh');
                        $("#alertHint").modal('show');
                    }
                })
            }
        });
    })
</script>
</html>