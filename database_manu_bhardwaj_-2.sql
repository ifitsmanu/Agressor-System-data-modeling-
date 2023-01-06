DROP DATABASE IF EXISTS aggressor_system;
CREATE DATABASE aggressor_system;
USE aggressor_system;

-- Function traducerAgent that accepts no parameters 
-- and returns an SQL formatted string that represents a traducer.

DROP FUNCTION IF EXISTS traducerAgent;
DELIMITER $$
Create function traducerAgent() 
RETURNS VARCHAR(100)
DETERMINISTIC  
BEGIN
DECLARE tid VARCHAR(20);
DECLARE ttype VARCHAR(20);
DECLARE tloc_x INT;
DECLARE tloc_y INT;
DECLARE tvalue INT;
DECLARE tlenthal INT;
DECLARE tstatus VARCHAR(20);
DECLARE tdurable DECIMAL(10,2);

DECLARE typevalue INT;
DECLARE availablevalue INT;
DECLARE tdurablevalue INT;
DECLARE part1 INT;
DECLARE part2 INT;
DECLARE q VARCHAR(100);

 

select FLOOR( RAND() * (3-1) + 1) into typevalue;
select FLOOR( RAND() * (3-1) + 1) into availablevalue;
select FLOOR( RAND() * (201-0) + 0) into tloc_x;
select FLOOR( RAND() * (201-0) + 0) into tloc_y;
select FLOOR( RAND() * (11-5) + 5) into tdurablevalue;
select FLOOR( RAND() * (6-0) + 0) into part1;
select FLOOR( RAND() * (101-0) + 100) into part2;



IF typevalue = 1 THEN
SET ttype='Medium';
ELSE
SET ttype='Heavy';
END IF; 

IF typevalue = 1 THEN
SET tvalue=10;
ELSE
SET tvalue=25;
END IF; 

IF typevalue = 1 THEN
SET tlenthal=100;
ELSE
SET tlenthal=300;
END IF; 

IF availablevalue = 1 THEN
SET tstatus='Available';
ELSE
SET tstatus='Not Available';
END IF; 

SET tdurable=(tlenthal*tdurablevalue)/100;
select CONCAT('TA-',part1,'-',part2) into tid;
select CONCAT('insert into traducer values(\'',tid,'\',\'',ttype,'\',',tloc_x,',',tloc_y,',',tvalue,',',tlenthal,',\'',tstatus,'\',',tdurable,')') into q;
return q;
END$$
DELIMITER ;


-- Function desciminatorAgent that accepts no parameters 
-- and returns an SQL formatted string that represents a discriminator.

DROP FUNCTION IF EXISTS desciminatorAgent;
DELIMITER $$
Create function desciminatorAgent()
RETURNS VARCHAR(100)
DETERMINISTIC  
BEGIN
DECLARE did VARCHAR(20);
DECLARE dtype VARCHAR(20);
DECLARE dloc_x INT;
DECLARE dloc_y INT;
DECLARE dvalue INT;
DECLARE dlenthal INT;
DECLARE dstatus VARCHAR(20);
DECLARE ddurable DECIMAL(10,2);

DECLARE typevalue INT;
DECLARE availablevalue INT;
DECLARE durablevalue INT;
DECLARE part1 INT;
DECLARE part2 INT;
DECLARE q VARCHAR(100);
 

select FLOOR( RAND() * (3-1) + 1) into typevalue;
select FLOOR( RAND() * (3-1) + 1) into availablevalue;
select FLOOR( RAND() * (901-400) + 400) into dloc_x;
select FLOOR( RAND() * (901-4) + 4) into dloc_y;
select FLOOR( RAND() * (11-5) + 5) into durablevalue;
select FLOOR( RAND() * (6-0) + 0) into part1;
select FLOOR( RAND() * (101-0) + 100) into part2;



IF typevalue = 1 THEN
SET dtype='Standard';
ELSE
SET dtype='Multi-Role';
END IF; 

IF typevalue = 1 THEN
SET dvalue=4;
ELSE
SET dvalue=7;
END IF; 

IF typevalue = 1 THEN
SET dlenthal=10;
ELSE
SET dlenthal=12;
END IF; 

IF availablevalue = 1 THEN
SET dstatus='Available';
ELSE
SET dstatus='Not Available';
END IF; 

SET ddurable=(dlenthal*durablevalue)/100;
select CONCAT('DA-',part1,'-',part2) into did;
select CONCAT('insert into discriminator values(\'',did,'\',\'',dtype,'\',',dloc_x,',',dloc_y,',',dvalue,',',dlenthal,',\'',dstatus,'\',',ddurable,')') into q; 
return q;
END$$
DELIMITER ;


-- Function resourceBuilder that accepts no parameters and returns 
-- an SQL formatted string that represents a resource.

DROP FUNCTION IF EXISTS resourceBuilder;
DELIMITER $$
Create function resourceBuilder()
RETURNS VARCHAR(100)
DETERMINISTIC  
BEGIN
DECLARE rid VARCHAR(20);
DECLARE rtype VARCHAR(20);
DECLARE rloc_x INT;
DECLARE rloc_y INT;
DECLARE rvalue INT;
DECLARE rstatus VARCHAR(20);
DECLARE rprotect DECIMAL(10,2);

DECLARE typevalue INT;
DECLARE statusvalue INT;
DECLARE part1 INT;
DECLARE part2 INT;
DECLARE q VARCHAR(100);

 

select FLOOR( RAND() * (4-1) + 1) into typevalue;
select FLOOR( RAND() * (3-1) + 1) into statusvalue;
select FLOOR( RAND() * (951-700) + 700) into rloc_x;
select FLOOR( RAND() * (951-700) + 700) into rloc_y;
select FLOOR( RAND() * (6-0) + 0) into part1;
select FLOOR( RAND() * (101-0) + 100) into part2;

IF typevalue = 1 THEN
SET rtype='TAC';
ELSEIF typevalue = 2 THEN
SET rtype='OP';
ELSE
SET rtype='STRAT';
END IF; 

IF typevalue = 1 THEN
select FLOOR( RAND() * (151-10) + 10) into rvalue;
ELSEIF typevalue = 2 THEN
select FLOOR( RAND() * (301-75) + 75) into rvalue;
ELSE
select FLOOR( RAND() * (501-250) + 250) into rvalue;
END IF; 


IF statusvalue = 1 THEN
SET rstatus='Active';
ELSE
SET rstatus='Dormant';
END IF; 

IF typevalue = 1 THEN
 IF statusvalue= 1 THEN
   select FLOOR( RAND() * (301-100) + 100) into rprotect;
 ELSE
   select FLOOR( RAND() * (151-50) + 50) into rprotect; 
 END IF;
ELSEIF typevalue = 2 THEN
IF statusvalue= 1 THEN
   select FLOOR( RAND() * (1001-750) + 750) into rprotect;
 ELSE
   select FLOOR( RAND() * (151-50) + 50) into rprotect; 
 END IF;
ELSE
IF statusvalue= 1 THEN
   select FLOOR( RAND() * (2501-3000) + 3000) into rprotect;
 ELSE
   select FLOOR( RAND() * (151-50) + 50) into rprotect; 
 END IF;
END IF; 


select CONCAT('R-',part1,'#',part2) into rid;
select CONCAT('insert into resource values(\'',rid,'\',\'',rtype,'\',',rloc_x,',',rloc_y,',',rvalue,',\'',rstatus,'\',',rprotect,')') into q; 
return q;
END$$
DELIMITER ;


-- Create the stored procedure buildAggressor that builds the 
-- database aggressor_system

DROP PROCEDURE IF EXISTS buildAggressor;
DELIMITER $$
Create procedure buildAggressor()
BEGIN

DROP TABLE IF EXISTS traducer;
create table traducer
(TID varchar(20) primary key,
TType enum('Medium','Heavy'),
TLoc_X int,
TLoc_Y int,
TValue int,
TLethal int,
TStatus enum('Available','Not Available'),
TDurable decimal(10,2));

DROP TABLE IF EXISTS discriminator;
create table discriminator
(DID varchar(20) primary key,
DType enum('Standard','Multi-Role'),
DLoc_X int,
DLoc_Y int,
DValue int,
DLethal int,
DStatus enum('Available','Not Available'),
DDurable decimal(10,2)
);

DROP TABLE IF EXISTS resource;
create table resource
(RID varchar(20) primary key,
RType enum('TAC','OP','STRAT'),
RLoc_X int,
RLoc_Y int,
RValue int,
RStatus enum('Active','Dormant'),
RProtech decimal(10,2)
);


END$$
DELIMITER ;


DROP FUNCTION IF EXISTS stringSplitter_t;
DELIMITER $$
Create function stringSplitter_t(A VARCHAR(100))
RETURNS JSON
DETERMINISTIC
BEGIN
DECLARE S VARCHAR(100);
DECLARE S_1 VARCHAR(100);
DECLARE S_2 VARCHAR(100);
DECLARE S_3 VARCHAR(100);
DECLARE S_4 VARCHAR(100);
DECLARE S_5 VARCHAR(100);
DECLARE S_6 VARCHAR(100);
DECLARE S_7 VARCHAR(100);
DECLARE S_8 VARCHAR(100);
DECLARE J JSON;
SET S=REPLACE(A,'insert into traducer values(','');
SET S=REPLACE(S,')','');
SET S_1=SUBSTRING_INDEX(S,',',1);
SET S_2=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',2),',',-1);
SET S_3=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',3),',',-1);
SET S_4=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',4),',',-1);
SET S_5=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',5),',',-1);
SET S_6=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',6),',',-1);
SET S_7=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',7),',',-1);
SET S_8=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',8),',',-1);

SET J=JSON_ARRAY(S_1,S_2,S_3,S_4,S_5,S_6,S_7,S_8);
RETURN J;
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS stringSplitter_d;
DELIMITER $$
Create function stringSplitter_d(A VARCHAR(100))
RETURNS JSON
DETERMINISTIC
BEGIN
DECLARE S VARCHAR(100);
DECLARE S_1 VARCHAR(100);
DECLARE S_2 VARCHAR(100);
DECLARE S_3 VARCHAR(100);
DECLARE S_4 VARCHAR(100);
DECLARE S_5 VARCHAR(100);
DECLARE S_6 VARCHAR(100);
DECLARE S_7 VARCHAR(100);
DECLARE S_8 VARCHAR(100);
DECLARE J JSON;
SET S=REPLACE(A,'insert into discriminator values(','');
SET S=REPLACE(S,')','');
SET S_1=SUBSTRING_INDEX(S,',',1);
SET S_2=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',2),',',-1);
SET S_3=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',3),',',-1);
SET S_4=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',4),',',-1);
SET S_5=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',5),',',-1);
SET S_6=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',6),',',-1);
SET S_7=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',7),',',-1);
SET S_8=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',8),',',-1);

SET J=JSON_ARRAY(S_1,S_2,S_3,S_4,S_5,S_6,S_7,S_8);
RETURN J;
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS stringSplitter_r;
DELIMITER $$
Create function stringSplitter_r(A VARCHAR(100))
RETURNS JSON
DETERMINISTIC
BEGIN
DECLARE S VARCHAR(100);
DECLARE S_1 VARCHAR(100);
DECLARE S_2 VARCHAR(100);
DECLARE S_3 VARCHAR(100);
DECLARE S_4 VARCHAR(100);
DECLARE S_5 VARCHAR(100);
DECLARE S_6 VARCHAR(100);
DECLARE S_7 VARCHAR(100);
DECLARE J JSON;
SET S=REPLACE(A,'insert into resource values(','');
SET S=REPLACE(S,')','');
SET S_1=SUBSTRING_INDEX(S,',',1);
SET S_2=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',2),',',-1);
SET S_3=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',3),',',-1);
SET S_4=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',4),',',-1);
SET S_5=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',5),',',-1);
SET S_6=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',6),',',-1);
SET S_7=SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',7),',',-1);

SET J=JSON_ARRAY(S_1,S_2,S_3,S_4,S_5,S_6,S_7);
RETURN J;
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS quoteStripper;
DELIMITER $$
Create function quoteStripper(S VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE NS VARCHAR(20);
SET NS = REPLACE(REPLACE(S,"'",''),'"','');
RETURN NS;
END$$
DELIMITER ;


-- Create the stored procedure aggressorPopulator that accepts the 
-- number of traducer records, discriminator records, and resource 
-- records and populates the database aggressor_system.

DROP PROCEDURE IF EXISTS aggressorPopulator;
DELIMITER $$
Create procedure aggressorPopulator(IN tn int,IN dn int,IN rn int)
BEGIN
DECLARE counter INT DEFAULT 1;
DECLARE tq VARCHAR(100);
DECLARE dq VARCHAR(100);
DECLARE rq VARCHAR(100);

DECLARE tj JSON;
DECLARE dj JSON;
DECLARE rj JSON;


WHILE counter <= tn DO
select traducerAgent() into tq;
select stringSplitter_t(tq) into tj;
insert into traducer values(quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',0,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',1,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',2,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',3,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',4,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',5,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',6,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(tj,CONCAT('$[',7,']')))));
SET counter = counter + 1;
END WHILE;

SET counter = 1;
WHILE counter <= dn DO
select desciminatorAgent() into dq;
select stringSplitter_d(dq) into dj;
insert into discriminator values(quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',0,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',1,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',2,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',3,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',4,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',5,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',6,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(dj,CONCAT('$[',7,']')))));
SET counter = counter + 1;
END WHILE;

SET counter = 1;
WHILE counter <= rn DO
select resourceBuilder() into rq;
select stringSplitter_r(rq) into rj;
insert into resource values(quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',0,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',1,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',2,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',3,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',4,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',5,']')))),quoteStripper(JSON_UNQUOTE(JSON_EXTRACT(rj,CONCAT('$[',6,']')))));
SET counter = counter + 1;
END WHILE;


END$$
DELIMITER ; 



CALL buildAggressor();
CALL aggressorPopulator(3,3,3);

-- Modify your build_aggressor to remove the primary keys
-- from the aggressor_system database.

DROP PROCEDURE IF EXISTS buildAggressor;
DELIMITER $$
Create procedure buildAggressor()
BEGIN

DROP TABLE IF EXISTS traducer;
create table traducer
(TID varchar(20),
TType enum('Medium','Heavy'),
TLoc_X int,
TLoc_Y int,
TValue int,
TLethal int,
TStatus enum('Available','Not Available'),
TDurable decimal(10,2));

DROP TABLE IF EXISTS discriminator;
create table discriminator
(DID varchar(20),
DType enum('Standard','Multi-Role'),
DLoc_X int,
DLoc_Y int,
DValue int,
DLethal int,
DStatus enum('Available','Not Available'),
DDurable decimal(10,2)
);

DROP TABLE IF EXISTS resource;
create table resource
(RID varchar(20),
RType enum('TAC','OP','STRAT'),
RLoc_X int,
RLoc_Y int,
RValue int,
RStatus enum('Active','Dormant'),
RProtech decimal(10,2)
);


END$$
DELIMITER ;



CALL buildAggressor();

CALL aggressorPopulator(100,100,25);


-- stored procedure TD_analysis that accepts no parameters and 
-- produces the analysis of the traducer and discriminator records

DROP PROCEDURE IF EXISTS TD_analysis;
DELIMITER $$
Create procedure TD_analysis()
BEGIN

DECLARE tid VARCHAR(20);
DECLARE ttype VARCHAR(20);
DECLARE tloc_x INT;
DECLARE tloc_y INT;
DECLARE tvalue INT;
DECLARE tlenthal INT;
DECLARE tstatus VARCHAR(20);
DECLARE tdurable DECIMAL(10,2);
DECLARE tresult varchar(1000);

DECLARE cnt_tavailable INTEGER DEFAULT 0;
DECLARE cnt_tnotavailable INTEGER DEFAULT 0;
DECLARE cnt_tmedium INTEGER DEFAULT 0;
DECLARE cnt_theavies INTEGER DEFAULT 0;
DECLARE cnt_tavailablemedium INTEGER DEFAULT 0;
DECLARE cnt_tnotavailablemedium INTEGER DEFAULT 0;
DECLARE cnt_tavailableheavies INTEGER DEFAULT 0;
DECLARE cnt_tnotavailableheavies INTEGER DEFAULT 0;
DECLARE cnt_tavailablevalue INTEGER DEFAULT 0;
DECLARE cnt_tnotavailablevalue INTEGER DEFAULT 0;
DECLARE cnt_tvaluemedium INTEGER DEFAULT 0;
DECLARE cnt_tvalueheavies INTEGER DEFAULT 0;
DECLARE tpercentage DECIMAL(10,2);







DECLARE did VARCHAR(20);
DECLARE dtype VARCHAR(20);
DECLARE dloc_x INT;
DECLARE dloc_y INT;
DECLARE dvalue INT;
DECLARE dlenthal INT;
DECLARE dstatus VARCHAR(20);
DECLARE ddurable DECIMAL(10,2);
DECLARE finished INTEGER DEFAULT 0;


DECLARE cnt_davailable INTEGER DEFAULT 0;
DECLARE cnt_dnotavailable INTEGER DEFAULT 0;
DECLARE cnt_dstandard INTEGER DEFAULT 0;
DECLARE cnt_dmultirole INTEGER DEFAULT 0;
DECLARE cnt_davailablestandard INTEGER DEFAULT 0;
DECLARE cnt_dnotavailablestandard INTEGER DEFAULT 0;
DECLARE cnt_davailablemultirole INTEGER DEFAULT 0;
DECLARE cnt_dnotavailablemultirole INTEGER DEFAULT 0;
DECLARE cnt_davailablevalue INTEGER DEFAULT 0;
DECLARE cnt_dnotavailablevalue INTEGER DEFAULT 0;
DECLARE cnt_dvaluestandard INTEGER DEFAULT 0;
DECLARE cnt_dvaluemultirole INTEGER DEFAULT 0;
DECLARE dpercentage DECIMAL(10,2);



DECLARE cur_traducer CURSOR FOR select *from traducer;
DECLARE cur_discriminator CURSOR FOR select *from discriminator;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;


OPEN cur_traducer;

tdata:LOOP

FETCH cur_traducer into tid,ttype,tloc_x,tloc_y,tvalue,tlenthal,tstatus,tdurable;
IF finished = 1 THEN 
LEAVE tdata;
END IF; 
IF ttype='Medium' THEN
 SET cnt_tmedium=cnt_tmedium+1;
 
 IF tstatus='Available' THEN
 SET cnt_tavailable=cnt_tavailable+1;
 SET cnt_tavailablemedium=cnt_tavailablemedium+1;
 SET cnt_tavailablevalue=cnt_tavailablevalue+tvalue;
 SET cnt_tvaluemedium=cnt_tvaluemedium+tvalue;

 ELSE
 SET cnt_tnotavailable=cnt_tnotavailable+1;
 SET cnt_tnotavailablemedium=cnt_tnotavailablemedium+1;
 SET cnt_tnotavailablevalue=cnt_tnotavailablevalue+tvalue;
 END IF;
ELSE
 SET cnt_theavies=cnt_theavies+1;

 IF tstatus='Available' THEN
 SET cnt_tavailable=cnt_tavailable+1;
 SET cnt_tavailableheavies=cnt_tavailableheavies+1;
 SET cnt_tavailablevalue=cnt_tavailablevalue+tvalue;
 SET cnt_tvalueheavies=cnt_tvalueheavies+tvalue;

 ELSE
 SET cnt_tnotavailable=cnt_tnotavailable+1;
 SET cnt_tnotavailableheavies=cnt_tnotavailableheavies+1;
 SET cnt_tnotavailablevalue=cnt_tnotavailablevalue+tvalue;
 END IF;
END IF;



END LOOP tdata; 
CLOSE cur_traducer;

SET tpercentage=(cnt_tavailable/(cnt_tavailable+cnt_tnotavailable))*100;
SET tresult='TRADUCER ANALYSIS\n';
SET tresult=CONCAT(tresult,'Available:',cnt_tavailable,' Not Available:',cnt_tnotavailable,'\n');
SET tresult=CONCAT(tresult,'Total Medium:',cnt_tmedium,' Total Heavies:',cnt_theavies,'\n');
SET tresult=CONCAT(tresult,'Total Available Medium:',cnt_tavailablemedium,' Total Available Heavies:',cnt_tavailableheavies,'\n');
SET tresult=CONCAT(tresult,'Total Not Available Medium:',cnt_tnotavailablemedium,' Total Not Available Heavies:',cnt_tnotavailableheavies,'\n');
SET tresult=CONCAT(tresult,'Total Value Available:',cnt_tavailablevalue,' Total Value Not Available',cnt_tnotavailablevalue,'\n');
SET tresult=CONCAT(tresult,'Total Value Available Medium:',cnt_tvaluemedium,' Total Value Available Heavies:',cnt_tvalueheavies,'\n');
SET tresult=CONCAT(tresult,'Availability Percentage:',tpercentage,'\n');



set finished=0;


OPEN cur_discriminator;

ddata:LOOP

FETCH cur_discriminator into did,dtype,dloc_x,dloc_y,dvalue,dlenthal,dstatus,ddurable;
IF finished = 1 THEN 
LEAVE ddata;
END IF; 

IF dtype='Standard' THEN
 SET cnt_dstandard=cnt_dstandard+1;
 
 IF dstatus='Available' THEN
 SET cnt_davailable=cnt_davailable+1;
 SET cnt_davailablestandard=cnt_davailablestandard+1;
 SET cnt_davailablevalue=cnt_davailablevalue+dvalue;
 SET cnt_dvaluestandard=cnt_dvaluestandard+tvalue;

 ELSE
 SET cnt_dnotavailable=cnt_dnotavailable+1;
 SET cnt_dnotavailablestandard=cnt_dnotavailablestandard+1;
 SET cnt_dnotavailablevalue=cnt_dnotavailablevalue+dvalue;

 END IF;
ELSE
 SET cnt_dmultirole=cnt_dmultirole+1;
 IF dstatus='Available' THEN
 SET cnt_davailable=cnt_davailable+1;
 SET cnt_davailablemultirole=cnt_davailablemultirole+1;
  SET cnt_davailablevalue=cnt_davailablevalue+tvalue;
SET cnt_dvaluemultirole=cnt_dvaluemultirole+tvalue;
 ELSE
 SET cnt_dnotavailable=cnt_dnotavailable+1;
 SET cnt_dnotavailablemultirole=cnt_dnotavailablemultirole+1;
 SET cnt_dnotavailablevalue=cnt_dnotavailablevalue+tvalue;
 END IF;
END IF;


END LOOP ddata; 
CLOSE cur_discriminator;

SET dpercentage=(cnt_davailable/(cnt_davailable+cnt_dnotavailable))*100;


SET tresult=CONCAT(tresult,'DISCRIMINATOR','\n');
SET tresult=CONCAT(tresult,'Available:',cnt_davailable,' Not Available:',cnt_dnotavailable,'\n');
SET tresult=CONCAT(tresult,'Total Standard:',cnt_dstandard,' Total Multi-Role:',cnt_dmultirole,'\n');
SET tresult=CONCAT(tresult,'Total Available Standard:',cnt_davailablestandard,' Total Available Multi-Role:',cnt_davailablemultirole,'\n');
SET tresult=CONCAT(tresult,'Total Not Available Standard:',cnt_dnotavailablestandard,' Total Not Available Multi-Role:',cnt_dnotavailablemultirole,'\n');
SET tresult=CONCAT(tresult,'Total Value Available:',cnt_davailablevalue,' Total Value Not Available:',cnt_dnotavailablevalue,'\n');
SET tresult=CONCAT(tresult,'Total Value Available Standard:',cnt_dvaluestandard,' Total Value Available Multi-Role:',cnt_dvaluemultirole,'\n');
SET tresult=CONCAT(tresult,'Availability Percentage:',dpercentage,'\n');

select tresult  as 'Result';


END$$
DELIMITER ;

CALL TD_analysis;

