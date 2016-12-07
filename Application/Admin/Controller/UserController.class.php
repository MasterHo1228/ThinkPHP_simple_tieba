<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/12/1
 * Time: 11:19
 */

namespace Admin\Controller;
use Think\Controller;

class UserController extends Controller{
    public function userList(){
        if (D('AdminUser')->checkLogin()){
            $model = D('user');
            $data = $model->getAllUserList();
            if ($data){
                $this->ajaxReturn($data);
            }
        }
    }

    public function freeze(){
        if (IS_POST && D('AdminUser')->checkLogin()){
            $userID = I('post.userID/d');

            $model = D('user');
            if ($model->freezeUser($userID)){
                $data['freeze'] = 'true';
            } else {
                $data['freeze'] = 'false';
            }
            $this->ajaxReturn($data);
        }
    }

    public function unfreeze(){
        if (IS_POST && D('AdminUser')->checkLogin()){
            $userID = I('post.userID/d');
            $model = D('user');
            if ($model->unfreezeUser($userID)){
                $data['unfreeze'] = 'true';
            } else {
                $data['unfreeze'] = 'false';
            }
            $this->ajaxReturn($data);
        }
    }

    public function delete(){
        if (IS_POST && D('AdminUser')->checkLogin()){
            $userID = I('post.userID/d');
            $model = D('user');

            if ($model->removeUser($userID)){
                $data['deleteStatus'] = 'true';
            } else {
                $data['deleteStatus'] = 'false';
            }
            $this->ajaxReturn($data);
        } else {
            $data['deleteStatus'] = 'false';
            $this->ajaxReturn($data);
        }
    }
}