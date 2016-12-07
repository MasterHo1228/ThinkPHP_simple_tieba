<?php
/**
 * Created by PhpStorm.
 * User: MasterHo
 * Date: 2016.11.28
 * Time: 20:55
 */

namespace Admin\Model;
use Think\Model;

class AdminUserModel extends Model{
    public function checkLogin(){
        $admin = session('admin');
        if (!empty($admin)){
            return true;
        } else {
            return false;
        }
    }

    public function CheckAccountFromLogin($userName,$password){
        $where['aName']=$userName;

        $tmp_Password=$this->where($where)->getField('aPassword');
        $tmp_salt=$this->where($where)->getField('aSalt');

        if(md5($password.$tmp_salt)==$tmp_Password){
            $UserID=$this->where($where)->getField('aID');

            $loginLog = M("AdminLoginLog");
            $data['adminID']=$UserID;
            $data['adminLoginTime']=date('Y-m-d H:i:s');
            $data['adminLoginIP']=I('server.REMOTE_ADDR/s');
            $loginLog->add($data);

            session('admin.usrID',$UserID);
            session('admin.usrName',$userName);

            session('user.usrID',1);
            session('user.usrName','AdminUser');

            return true;
        } else {
            return false;
        }
    }
}