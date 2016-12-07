<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/12/1
 * Time: 11:21
 */

namespace Admin\Model;
use Think\Model;

class UserModel extends Model {
    public function getAllUserList(){
        return $this->where("uName<>'AdminUser'")->field('uID,uName,uGender,uEmail,uStatus')->select();
    }

    public function freezeUser($userID){
        if (isset($userID)){
            return $this->where('uID='.$userID)->setField('uStatus','0');
        } else {
            return false;
        }
    }

    public function unfreezeUser($userID){
        if (isset($userID)){
            return $this->where('uID='.$userID)->setField('uStatus','1');
        } else {
            return false;
        }
    }

    public function removeUser($userID){
        if (isset($userID)){
            return $this->where('uID='.$userID)->delete();
        } else {
            return false;
        }
    }
}