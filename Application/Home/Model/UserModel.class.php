<?php
/**
 * Created by IntelliJ IDEA.
 * User: MasterHo
 * Date: 2016/11/27
 * Time: 21:57
 */
namespace Home\Model;
use Think\Model;

class UserModel extends Model{
    public function checkLogin(){
        $user = session('user');
        if (!empty($user)){
            return true;
        } else {
            return false;
        }
    }

    public function CheckAccountFromLogin($userName,$password){
        $where['uName']=$userName;
        $status = $this->where($where)->getField('uStatus');
        if ($status=='0'){
            return array('error'=>'freeze');
        } else {
            $tmp_Password=$this->where($where)->getField('uPassword');
            if(md5($password)==$tmp_Password){
                $userID=$this->where($where)->getField('uID');

                session('user.usrID',$userID);
                session('user.usrName',$userName);
                return true;
            } else {
                return false;
            }
        }
    }

    public function getCurrentInfo($id){
        $where = 'uID='.$id;
        return $this->where($where)->field('uName,uGender,uEmail,uSign,uPic')->find();
    }

    public function addAccount($userName,$userPassword,$userGender,$userEmail,$userSign){
        if (!empty($userName) && !empty($userPassword)){
            $checkExist = $this->where("uName='$userName'")->find();
            if (!$checkExist){
                $data['uName'] = $userName;
                $data['uPassword'] = $userPassword;
                $data['uGender'] = $userGender;
                $data['uEmail'] = $userEmail;
                $data['uSign'] = $userSign;

                return $this->add($data);
            } else {
                return array('error'=>'userExists');
            }
        } else {
            return array('error'=>'empty');
        }
    }
}