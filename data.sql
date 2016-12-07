CREATE DATABASE IF NOT EXISTS dbChattingRoom CHARACTER SET utf8mb4;
USE dbChattingRoom;

CREATE TABLE IF NOT EXISTS admin_user(
  aID INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  aName VARCHAR(20) NOT NULL UNIQUE ,
  aPassword VARCHAR(32) NOT NULL ,
  aSalt CHAR(4) NOT NULL
);

CREATE TABLE IF NOT EXISTS admin_login_log(
  adminID INT UNSIGNED NOT NULL ,
  adminLoginTime DATETIME NOT NULL ,
  adminLoginIP VARCHAR(35) NOT NULL ,
  CONSTRAINT FK_adminID FOREIGN KEY (adminID) REFERENCES admin_user(aID)
);

CREATE TABLE IF NOT EXISTS user(
  uID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  uName VARCHAR(20) NOT NULL UNIQUE ,
  uPassword VARCHAR(32) NOT NULL ,
  uGender ENUM('male','female'),
  uEmail VARCHAR(30),
  uSign TEXT,
  uPic TEXT,
  uStatus ENUM('0','1') NOT NULL DEFAULT '1'
);

CREATE TABLE IF NOT EXISTS chat_room(
  cID BIGINT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  cContent TEXT NOT NULL ,
  cSendTime DATETIME NOT NULL ,
  cSendIP VARCHAR(35) NOT NULL ,
  cType ENUM('0','1','2','3') NOT NULL DEFAULT '1',
  cSendByUID BIGINT UNSIGNED NOT NULL ,
  cIsReply ENUM('0','1') DEFAULT '0',
  ReplyCID BIGINT UNSIGNED,
  cStatus ENUM('0','1') DEFAULT '1',
  CONSTRAINT FK_SendByUID FOREIGN KEY (cSendByUID) REFERENCES user(uID) ON DELETE NO ACTION
);

CREATE VIEW view_chat AS
  SELECT
    a.cID,
    a.cContent,
    a.cSendByUID,
    b.uName AS 'userName',
    a.cSendTime,
    a.cSendIP,
    a.cType,
    a.cIsReply,
    a.ReplyCID,
    a.cStatus
  FROM chat_room a,
    user b
  WHERE a.cSendByUID=b.uID;

INSERT INTO admin_user SET aName='admin',aPassword=MD5('123456msho'),aSalt='msho';

INSERT INTO user SET uID='1',uName='AdminUser',uPassword=MD5('A12C3r4bg5a86m1s5g0');
INSERT INTO user SET uName='Demo1',uPassword=MD5('123456+.');