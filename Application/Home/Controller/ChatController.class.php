<?php
/**
 * Created by PhpStorm.
 * User: MasterHo
 * Date: 2016.11.29
 * Time: 0:47
 */

namespace Home\Controller;
use Think\Controller;

class ChatController extends Controller{
    public function getAllMassage(){
        $model = M('ViewChat');
        $this->ajaxReturn($model->field('cID,cContent,cSendByUID,userName,cSendTime,cSendIP,cType,cIsReply,ReplyCID,cStatus')->select());
    }

    public function getAllReleaseMassage(){
        $model = M('ViewChat');
        $this->ajaxReturn($model->where("cStatus='1'")->field('cID,cContent,cSendByUID,userName,cSendTime,cType,cIsReply,ReplyCID')->select());
    }

    public function getSingalMassage(){
        if (IS_GET){
            $cID = I('get.cID');

            $model = M('ViewChat');
            $where['cID']=$cID;
            $where['cStatus']='1';
            $this->ajaxReturn($model->where($where)->field('cID,cContent,cSendByUID,userName,cSendTime,cSendIP,cType,cIsReply,ReplyCID')->find());
        }
    }

    public function add(){
        if (IS_POST && D('user')->checkLogin()){
            $userID = session('user.usrID');
            $content = I('post.msgContent/s');
            $type = I('post.msgType');
            $model = D('ChatRoom');

            if (!empty(I('post.isReply')) && !empty(I('post.replyCID'))){
                if ($model->addMessage($userID,$content,$type,I('post.isReply'),I('post.replyCID'))){
                    $data['addStatus'] = 'true';
                    $this->ajaxReturn($data);
                } else {
                    $data['addStatus'] = 'false';
                    $this->ajaxReturn($data);
                }
            } else {
                if ($model->addMessage($userID,$content,$type)){
                    $data['addStatus'] = 'true';
                    $this->ajaxReturn($data);
                } else {
                    $data['addStatus'] = 'false';
                    $this->ajaxReturn($data);
                }
            }
        }
    }

    public function delete(){
        if (IS_POST && D('user')->checkLogin()){
            $cID = I('post.cID/d');
            $model = D('ChatRoom');
            if ($model->deleteMessage($cID)){
                $data['deleteStatus'] = 'true';
            } else {
                $data['deleteStatus'] = 'false';
            }
            $this->ajaxReturn($data);
        }
    }
}