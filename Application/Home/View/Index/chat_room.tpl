<!--Created by MasterHo on 2016/11/26 via IntelliJ IDEA.-->
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>简单版贴吧</title>
    <!-- Bootstrap Core CSS -->
    <link href="__PUBLIC__/css/bootstrap.min.css" rel="stylesheet">
    <link href="__PUBLIC__/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation" id="header-bar-container">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">简单版贴吧</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="#" id="btnRefresh" onclick="refreshChat()"><i class="fa fa-refresh fa-fw"></i> 刷新</a></li>
            </ul>
            <div class="nav navbar-nav navbar-btn navbar-left">
                <form class="navbar-form">
                    <div class="form-group">
                        <label class="navbar-link" for="cbAutoRefresh" id="isAutoRefresh">
                            <input type="checkbox" id="cbAutoRefresh">自动刷新
                        </label>
                    </div>
                </form>
            </div>
            <ul class="nav navbar-nav navbar-right">
                {{if isset($smarty.session.user)}}
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> {{$smarty.session.user.usrName}} <i
                                class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#" id="btnShowUserInfo"><i class="fa fa-user fa-fw"></i> 用户信息</a>
                        {{if isset($smarty.session.admin)}}
                        <li><a href="{{U('Admin/Main/main')}}"><i class="fa fa-angle-double-right fa-fw"></i> 切换到管理端</a>
                        {{/if}}
                        <li><a href="#" data-toggle="modal" data-target="#aboutWindow"><i class="fa fa-info fa-fw"></i>
                                关于</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#" id="btnLogout"><i class="fa fa-sign-out fa-fw"></i> 登出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
                {{else}}
                <li><a href="#" id="btnLogin" data-toggle="modal" data-target="#loginWindow">登录</a></li>
                <li><a href="#" id="btnRegister" data-toggle="modal" data-target="#registerWindow">注册</a></li>
                {{/if}}
            </ul>
            <!-- /.navbar-top-links -->
        </div>
    </div>
</nav>

<br/><br/>
<div class="container">
    <h3 class="page-header">简单版贴吧</h3>
    <button class="btn btn-primary btn-block" id="btnAddMsg">发送消息</button>
    <br/>
    <div id="divChattingMassages">

    </div>
</div>

<!-- 登录 -->
<div class="modal fade" id="loginWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">登录</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>账号</label>
                    <input type="text" class="form-control" id="usrName" name="usrName" placeholder="输入账号">
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" class="form-control" id="usrPasswd" name="usrPasswd" placeholder="输入密码">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnToLogin">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 注册 -->
<div class="modal fade" id="registerWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">注册</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" class="form-control regInput" id="newUsrName" name="newUsrName" placeholder="输入用户名">
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" class="form-control regInput" id="newUsrPasswd" name="newUsrPasswd" placeholder="输入密码">
                </div>
                <div class="form-group">
                    <label>确认密码</label>
                    <input type="password" class="form-control regInput" id="newUsrPasswdR" name="newUsrPasswdR" placeholder="再次输入密码">
                </div>
                <div class="form-group">
                    <label>性别</label>
                    <select class="form-control" id="newUsrGender" name="newUsrGender">
                        <option value="male">男</option>
                        <option value="female">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>E-Mail</label>
                    <input type="email" class="form-control" id="newUsrEmail regInput" name="newUsrEmail" placeholder="输入E-Mail">
                </div>
                <div class="form-group">
                    <label>签名</label>
                    <textarea class="form-control" id="newUsrSign regInput" name="newUsrSign"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnToRegister">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 发帖 窗口 -->
<div class="modal fade" id="addMsgWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">发送帖子</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <textarea class="form-control" id="textAddMsg" placeholder="输入消息内容" rows="5"></textarea>
                </div>
                <div class="form-group">
                    <label for="msgType">消息类型</label>
                    <select class="form-control" id="newMsgType" name="newMsgType">
                        <option value="0">捷报</option>
                        <option value="1" selected>普通</option>
                        <option value="2">重要</option>
                        <option value="3">紧急</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnToAddMsg">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 回复消息窗口 -->
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

<!-- 删除帖子提示框 -->
<div class="modal fade" id="alertDelWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
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

<!-- 自定义提示框 -->
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

<!-- 用户信息 -->
<div class="modal fade" id="showInfoWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">账号信息</h4>
            </div>
            <div class="modal-body">
                <p>用户名：<span id="infoUserName"></span></p>
                <p>性别：<span id="infoUserGender"></span></p>
                <p>签名：<span id="infoUserSign"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
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
                <p>简单版贴吧平台</p>
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
<script language="JavaScript">
    var isLogin = '{{$isLogin}}';
    {{if isset($smarty.session.user.usrID)}}
    var loginUID = '{{$smarty.session.user.usrID}}';
    {{else}}
    var loginUID = '';
    {{/if}}
    var replyCID;
    var refreshKey;
    var delCID;

    function refreshChat() {
        $("#divChattingMassages").empty();

        $.getJSON("{{U('Chat/getAllReleaseMassage')}}", function (data) {
            $.each(data, function (i, item) {
                var msgStyle;
                var message;
                var msgContent = item.ccontent;
                var cUID = item.csendbyuid;
                var delBtn = 'none';
                if (cUID == loginUID) {
                    delBtn = 'block';
                }
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
                        url: "{{U('Chat/getSingalMassage')}}" + "?cID=" + replyCID,
                        dataType: 'json',
                        success: function (data) {
                            if (data == null) {
                                message =
                                    "<div class='panel " + msgStyle + "'>" +
                                    "<div class='panel-heading'>" +
                                    "<div class='panel-title pull-left'>" + userName + "&nbsp;<small>" + item.csendtime + "</small>" + "</div>" +
                                    "<button class='btn btn-xs btn-danger pull-right btnDel' value='" + item.cid + "' style='display: " + delBtn + "'>删除</button>" +
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
                                    "<button class='btn btn-xs btn-danger pull-right btnDel' value='" + item.cid + "' style='display: " + delBtn + "'>删除</button>" +
                                    "<button class='btn btn-xs btn-default pull-right btnReply' value='" + item.cid + "'>回复</button>" +
                                    "<div class='clearfix'></div>" +
                                    "</div>" +
                                    "<div class='panel-body'>" +
                                    "<pre>" + originUserName + '：' + data.ccontent + "</pre>" + msgContent + "</div>" +
                                    "</div>";
                            }
                            $("#divChattingMassages").append(message);
                        }
                    });
                } else {
                    message =
                        "<div class='panel " + msgStyle + "'>" +
                        "<div class='panel-heading'>" +
                        "<div class='panel-title pull-left'>" + userName + "&nbsp;<small>" + item.csendtime + "</small>" + "</div>" +
                        "<button class='btn btn-xs btn-danger pull-right btnDel' value='" + item.cid + "' style='display: " + delBtn + "'>删除</button>" +
                        "<button class='btn btn-xs btn-default pull-right btnReply' value='" + item.cid + "'>回复</button>" +
                        "<div class='clearfix'></div>" +
                        "</div>" +
                        "<div class='panel-body'>" + msgContent + "</div>" +
                        "</div>";
                    $("#divChattingMassages").append(message);
                }
            });
        });
    }

    $(function () {
        refreshChat();

        $("#btnLogin").click(function () {
            $.getJSON("{{U('User/login')}}", function (data) {
                if (data.login == 'true') {
                    window.location.reload();
                }
            });
        });

        $("#btnToLogin").click(function () {
            var usrName = $("#usrName").val();
            var usrPasswd = $("#usrPasswd").val();

            if (usrName != '' && usrPasswd != '') {
                $.ajax({
                    url: "{{U('User/login')}}",
                    type: 'post',
                    data: {
                        usrName: usrName,
                        usrPasswd: usrPasswd
                    },
                    dataType: 'json',
                    success: function (data) {
                        $("#loginWindow").modal('hide');
                        if (data.login == 'true') {
                            $("#btnToLogin").modal('hide');
                            if (data.isAdmin == 'true') {
                                $("#alertHintContent").empty().append("Welcome back！");
                                $("#btnReload").attr('value', 'admin');
                            } else if (data.isAdmin == 'false') {
                                $("#alertHintContent").empty().append("登录成功！");
                                $("#btnReload").attr('value', 'reload');
                            }
                            $("#alertHint").modal('show');
                        } else if (data.login == 'false') {
                                var exHint='';
                                switch (data.error){
                                    case 'freeze':
                                        exHint='抱歉，您的账号已被封禁！';
                                        $("#btnReload").attr('value', 'reload');
                                        break;
                                    default:
                                        exHint='用户名或密码错误';
                                        break;
                                }
                            $("#alertHintContent").empty().append(exHint+" 登录失败！");
                            $("#alertHint").modal('show');
                        }
                    }
                });
            }
        });

        $("#btnToRegister").click(function () {
            var usrName = $("#newUsrName").val();
            var usrPasswd = $("#newUsrPasswd").val();
            var usrPasswdR = $("#newUsrPasswdR").val();
            var usrGender = $("#newUsrGender").val();
            var usrEmail = $("#newUsrEmail").val();
            var usrSign = $("#newUsrSign").val();

            if (usrName==''){
                $("#alertHintContent").empty().append("亲 用户名是必须要填的喔~~");
                $("#btnReload").attr('value', '');
                $("#alertHint").modal('show');
            } else if (usrPasswd != usrPasswdR){
                $("#alertHintContent").empty().append("两次输入的密码不一致！");
                $("#btnReload").attr('value', '');
                $("#alertHint").modal('show');
            } else if (usrPasswd=='' || usrPasswdR==''){
                $("#alertHintContent").empty().append("请输入账号的密码并确认~");
                $("#btnReload").attr('value', '');
                $("#alertHint").modal('show');
            } else {
                $.ajax({
                    url:"{{U('Home/User/register')}}",
                    type:'post',
                    data:{
                        usrName:usrName,
                        usrPasswd:usrPasswd,
                        usrGender:usrGender,
                        usrEmail:usrEmail,
                        usrSign:usrSign
                    },
                    dataType:'json',
                    success:function (data) {
                        if (data.register=='false' && data.error!=''){
                            var errorInfo;
                            switch (data.error){
                                case 'userExists':errorInfo='用户名已存在！';break;
                                default:errorInfo=data.error;break;
                            }
                            $("#alertHintContent").empty().append("注册失败！\n"+errorInfo);
                            $("#alertHint").modal('show');
                        } else if (data.register=='true'){
                            $("#registerWindow").modal('hide');
                            $("#alertHintContent").empty().append("注册成功！点击确定立刻登录~");
                            $(".regInput").val('');
                            $("#btnReload").attr('value', 'login');
                        }
                        $("#alertHint").modal('show');
                    }
                });
            }
        });

        $("#btnReload").click(function () {
            $("#alertHint").modal('hide');

            switch ($(this).attr('value')) {
                case 'reload':
                    window.location.reload();
                    break;
                case 'admin':
                    window.location.href="{{U('Admin/Main/main')}}";
                    break;
                case 'login':
                    $("#loginWindow").modal('show');
                    break;
                case 'refresh':
                    replyCID='';
                    delCID='';
                    refreshChat();
                    break;
            }
        });

        $("#btnLogout").click(function () {
            $.ajax({
                url: "{{U('Home/Index/logout')}}",
                dataType: 'json',
                success: function (data) {
                    if (data.status == 'ok') {
                        $("#alertHintContent").empty().append("登出成功！");
                        $("#btnReload").attr('value', 'reload');
                        $("#alertHint").modal('show');
                    }
                }
            });
        });

        $("#isAutoRefresh").click(function () {
            if ($("#cbAutoRefresh").prop("checked") == true) {
                refreshKey = self.setInterval(refreshChat, 15000);
            } else if ($("#cbAutoRefresh").prop("checked") == false) {
                clearInterval(refreshKey);
            }
        });

        $("#btnAddMsg").click(function () {
            if (isLogin == 'false') {
                $("#alertHintContent").empty().append("请先登录再进行评论吧~");
                $("#btnReload").attr('value', 'login');
                $("#alertHint").modal('show');
            } else if (isLogin == 'true') {
                $("#addMsgWindow").modal('show');
            }
        });

        $("#btnToAddMsg").click(function () {
            var msgContent = $("#textAddMsg").val();
            var msgType = $("#newMsgType").val();
            if (msgContent != '') {
                $.ajax({
                    url: "{{U('Home/Chat/add')}}",
                    type: 'post',
                    data: {
                        msgContent: msgContent,
                        msgType: msgType
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data.addStatus == 'true') {
                            $("#addMsgWindow").modal('hide');
                            $("#alertHintContent").empty().append("发布成功！");
                            $("#textAddMsg").val('');
                        } else if (data.addStatus == 'false') {
                            $("#alertHintContent").empty().append("发布失败！");
                        }
                        $("#btnReload").attr('value', 'refresh');
                        $("#alertHint").modal('show');
                    }
                });
            } else {
                $("#alertHintContent").empty().append("请填写帖子内容！");
                $("#alertHint").modal('show');
            }
        });

        $("#divChattingMassages").delegate('.btnReply', 'click', function () {
            if (isLogin == 'false') {
                $("#alertHintContent").empty().append("请先登录再进行评论吧~");
                $("#btnReload").attr('value', 'login');
                $("#alertHint").modal('show');
            } else if (isLogin == 'true') {
                replyCID = $(this).attr('value');
                $("#replyMsgWindow").modal('show');
            }
        });

        $("#divChattingMassages").delegate('.btnDel', 'click', function () {
            if (isLogin == 'false') {
                $("#alertHintContent").empty().append("不不不。。。这样子不好呦~");
            } else if (isLogin == 'true') {
                delCID = $(this).attr('value');
            }
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

        $("#btnToDelC").click(function () {
            if (delCID != "" && loginUID != '') {
                $.ajax({
                    url: "{{U('Home/Chat/delete')}}",
                    type: 'post',
                    data:{cID:delCID},
                    dataType: 'json',
                    success: function (data) {
                        if (data.deleteStatus == 'true') {
                            $("#alertDelWindow").modal('hide');
                            $("#alertHintContent").empty().append("删除成功！");
                        } else if (data.deleteStatus == 'false') {
                            $("#alertDelWindow").modal('hide');
                            $("#alertHintContent").empty().append("删除失败！");
                        }
                        $("#btnReload").attr('value', 'refresh');
                        $("#alertHint").modal('show');
                    }
                })
            }
        });

        $("#btnShowUserInfo").click(function () {
            $.getJSON("{{U('Home/User/info')}}", function (data) {
                $("#infoUserName").empty().append(data.uname);
                switch (data.ugender){
                    case 'male':$("#infoUserGender").empty().append('男');break;
                    case 'female':$("#infoUserGender").empty().append('女');break;
                }
                $("#infoUserSign").empty().append(data.usign);

                $("#showInfoWindow").modal('show');
            });
        });
    })
</script>
</html>