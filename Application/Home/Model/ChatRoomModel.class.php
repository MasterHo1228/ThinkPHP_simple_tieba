<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/11/29
 * Time: 14:40
 */

namespace Home\Model;
use Think\Model;


class ChatRoomModel extends Model{
    public function addMessage($userID,$content,$type,$isReply,$replyCID){
        if (isset($userID) && isset($content) && isset($type)){
            $data['cContent'] = $content;
            $data['cSendTime'] = date('Y-m-d H:i:s');
            $data['cSendIP'] = I('server.REMOTE_ADDR');
            $data['cType'] = $type;
            $data['cSendByUID'] = $userID;
            $data['cSendByUID'] = $userID;
            if (isset($isReply) && isset($replyCID)){
                $data['cIsReply'] = $isReply;
                $data['ReplyCID'] = $replyCID;
            }

            return $this->add($data);
        } else {
            return false;
        }
    }

    public function deleteMessage($cID){
        $userID = session('user.usrID');
        $currentC = $this->where("cID=$cID")->field('cSendByUID')->find();
        if ($currentC['csendbyuid'] == $userID || $userID==1){
            return $this->where("cID=$cID")->delete();
        } else {
            return false;
        }
    }
}