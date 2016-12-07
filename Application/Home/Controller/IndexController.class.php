<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function chat(){
        $isLogin = 'false';
        if (D('user')->checkLogin()){
            $isLogin = 'true';
        }
        $this->assign('isLogin',$isLogin);
        $this->display('chat_room');
    }

    public function logout(){
        session(null);
        session_destroy();
        $data['status']='ok';
        $this->ajaxReturn($data);
    }
}