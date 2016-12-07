<?php
/**
 * Created by PhpStorm.
 * User: MasterHo
 * Date: 2016.12.01
 * Time: 0:07
 */

namespace Admin\Controller;
use Think\Controller;

class MainController extends Controller{
    public function main(){
        if (D('AdminUser')->checkLogin()){
            $this->display();
        } else {
            $this->error('非法操作！',U('Home/Index/chat'));
        }
    }
}