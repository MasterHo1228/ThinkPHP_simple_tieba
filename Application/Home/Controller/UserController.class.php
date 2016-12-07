<?php
/**
 * Created by IntelliJ IDEA.
 * User: MasterHo
 * Date: 2016.11.28
 * Time: 19:38
 */
namespace Home\Controller;
use Think\Controller;

class UserController extends Controller{
    public function login(){
        $userModel = D('user');
        $adminUserModel = D('Admin/AdminUser');
        if ($userModel->checkLogin()){
            $data['isLogin'] = 'true';
            $data['isAdmin'] = 'false';
            $this->ajaxReturn($data);
            return true;
        } elseif ($adminUserModel->checkLogin()){
            $data['login'] = 'true';
            $data['isAdmin'] = 'true';
            $this->ajaxReturn($data);
            return true;
        } else {
            if (IS_POST){
                $userName=I('post.usrName');
                $password=I('post.usrPasswd');
                if ($userName != 'AdminUser'){
                    $check = $userModel->CheckAccountFromLogin($userName,$password);
                    if (!empty($check['error'])){
                        switch ($check['error']){
                            case 'freeze':
                                $data['login'] = 'false';
                                $data['error'] = 'freeze';
                                break;
                        }
                        $this->ajaxReturn($data);
                        return false;
                    } else {
                        if ($userModel->CheckAccountFromLogin($userName,$password)){
                            $data['login'] = 'true';
                            $data['isAdmin'] = 'false';
                            $this->ajaxReturn($data);
                            return true;
                        } else {
                            if ($adminUserModel->CheckAccountFromLogin($userName,$password)){
                                $data['login'] = 'true';
                                $data['isAdmin'] = 'true';
                                $this->ajaxReturn($data);
                                return true;
                            } else {
                                $data['login'] = 'false';
                                $this->ajaxReturn($data);
                                return false;
                            }
                        }
                    }
                } else {
                    $data['login'] = 'false';
                    $this->ajaxReturn($data);
                    return false;
                }
            } else {
                $data['login'] = 'false';
                $this->ajaxReturn($data);
                return false;
            }
        }
    }

    public function info(){
        if (D('user')->checkLogin()){
            $userID = session('user.usrID');

            $userModel = D('user');
            if ($userModel->getCurrentInfo($userID)){
                $data = $userModel->getCurrentInfo($userID);
                $this->ajaxReturn($data);
            }
        }
    }

    public function register(){
        if (IS_POST){
            $userName = I('post.usrName/s');
            $userPassword = md5(I('post.usrPasswd/s'));
            $userGender = I('post.usrGender');
            $userEmail = I('post.usrEmail/s');
            $userSign = I('post.usrSign/s');

            $model = D('user');
            $rs = $model->addAccount($userName,$userPassword,$userGender,$userEmail,$userSign);
            if (isset($rs['error'])){
                $returnData['register'] = 'false';
                $returnData['error'] = $rs['error'];
            } else {
                if ($rs){
                    $returnData['register'] = 'true';
                } else {
                    $returnData['register'] = 'false';
                }
            }
            $this->ajaxReturn($returnData);
        } else {
            $returnData['register'] = 'false';
            $returnData['error'] = 'illegal';
            $this->ajaxReturn($returnData);
        }
    }
}