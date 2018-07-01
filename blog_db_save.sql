-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: blog_db
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `博客设置信息`
--

DROP TABLE IF EXISTS `博客设置信息`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `博客设置信息` (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `site` varchar(32) NOT NULL,
  `theme` varchar(32) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `site` (`site`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `my_blog_blog_user_id_5a96e3e6_fk_my_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `博客设置信息`
--

LOCK TABLES `博客设置信息` WRITE;
/*!40000 ALTER TABLE `博客设置信息` DISABLE KEYS */;
INSERT INTO `博客设置信息` VALUES (1,'alex','alex','black',2);
/*!40000 ALTER TABLE `博客设置信息` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `文章`
--

DROP TABLE IF EXISTS `文章`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `文章` (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `comment_num` int(11) NOT NULL,
  `poll_num` int(11) NOT NULL,
  `read_num` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `site_cate_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  KEY `my_blog_article_blog_id_34aa8a95_fk_my_blog_blog_nid` (`blog_id`),
  KEY `my_blog_article_category_id_511be5a8_fk_my_blog_category_nid` (`category_id`),
  KEY `my_blog_article_site_cate_id_8aa5b193_fk_my_blog_s` (`site_cate_id`),
  CONSTRAINT `my_blog_article_blog_id_34aa8a95_fk_my_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `博客设置信息` (`nid`),
  CONSTRAINT `my_blog_article_category_id_511be5a8_fk_my_blog_category_nid` FOREIGN KEY (`category_id`) REFERENCES `自定义分类` (`nid`),
  CONSTRAINT `my_blog_article_site_cate_id_8aa5b193_fk_my_blog_s` FOREIGN KEY (`site_cate_id`) REFERENCES `网站详细分类` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `文章`
--

LOCK TABLES `文章` WRITE;
/*!40000 ALTER TABLE `文章` DISABLE KEYS */;
INSERT INTO `文章` VALUES (1,'兰亭集序','永和九年，岁在癸丑，暮春之初，会于会稽山阴之兰亭，修禊事也。群贤毕至，少长咸集。此地有崇山峻岭，茂林修竹；又有清流激湍，映带左右，引以为流觞曲水，列坐其次。虽无丝竹管弦之盛，一觞一咏，亦足以畅叙幽情。是日也，天朗气清，惠风和畅，仰观宇宙之大，俯察品类之盛，所以游目骋怀，足以极视听之娱，信可乐也。',26,30,20,'2018-07-01 22:39:10.446386',1,1,1),(2,'前赤壁赋','壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。少焉，月出于东山之上，徘徊于斗牛之间。白露横江，水光接天。纵一苇之所如，凌万顷之茫然。浩浩乎如冯虚御风，而不知其所止；飘飘乎如遗世独立，羽化而登仙。(冯 通：凭)',0,0,0,'2018-07-01 22:39:42.762429',1,1,1),(3,'程序员喜欢什么样的女生？','今天本来打算写一下activity与activity之间的数据传递的，但是在跟女朋友吵了一架之后，实在是没心情继续下了，索性删了刚才写的东西，重新开了这个话题。  我实在是搞不明白她天天脑子里面想的都是什么。。。刚才吵架的时候她说我已经好久没有好好坐下来听她说话了，但是在我的意识里面我天天除了敲代码脑子里就只剩下她了。对了，还有机遇。。。时时刻刻都在想着怎么去提高下技术？怎么去多赚点钱？我还能想什么？',1,0,0,'2018-07-01 22:42:28.638879',1,2,2),(5,'我作为开发者犯过的两次愚蠢的错误','我作为开发者犯过的两次愚蠢的错误',6,0,0,'2018-07-01 22:44:42.381551',1,2,2);
/*!40000 ALTER TABLE `文章` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `文章详情`
--

DROP TABLE IF EXISTS `文章详情`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `文章详情` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `article_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_id` (`article_id`),
  CONSTRAINT `my_blog_articledetail_article_id_0b3f017f_fk_my_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `文章` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `文章详情`
--

LOCK TABLES `文章详情` WRITE;
/*!40000 ALTER TABLE `文章详情` DISABLE KEYS */;
INSERT INTO `文章详情` VALUES (1,'永和九年，岁在癸丑，暮春之初，会于会稽山阴之兰亭，修禊事也。群贤毕至，少长咸集。此地有崇山峻岭，茂林修竹；又有清流激湍，映带左右，引以为流觞曲水，列坐其次。虽无丝竹管弦之盛，一觞一咏，亦足以畅叙幽情。是日也，天朗气清，惠风和畅，仰观宇宙之大，俯察品类之盛，所以游目骋怀，足以极视听之娱，信可乐也。\r\n\r\n　　夫人之相与，俯仰一世，或取诸怀抱，悟言一室之内；或因寄所托，放浪形骸之外。虽趣舍万殊，静躁不同，当其欣于所遇，暂得于己，快然自足，不知老之将至。及其所之既倦，情随事迁，感慨系之矣。向之所欣，俯仰之间，已为陈迹，犹不能不以之兴怀。况修短随化，终期于尽。古人云：“死生亦大矣。”岂不痛哉！(不知老之将至 一作：曾不知老之将至)\r\n\r\n　　每览昔人兴感之由，若合一契，未尝不临文嗟悼，不能喻之于怀。固知一死生为虚诞，齐彭殇为妄作。后之视今，亦犹今之视昔。悲夫！故列叙时人，录其所述，虽世殊事异，所以兴怀，其致一也。后之览者，亦将有感于斯文。',1),(2,'壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。少焉，月出于东山之上，徘徊于斗牛之间。白露横江，水光接天。纵一苇之所如，凌万顷之茫然。浩浩乎如冯虚御风，而不知其所止；飘飘乎如遗世独立，羽化而登仙。(冯 通：凭)\r\n\r\n　　于是饮酒乐甚，扣舷而歌之。歌曰：“桂棹兮兰桨，击空明兮溯流光。渺渺兮予怀，望美人兮天一方。”客有吹洞箫者，倚歌而和之。其声呜呜然，如怨如慕，如泣如诉；余音袅袅，不绝如缕。舞幽壑之潜蛟，泣孤舟之嫠妇。\r\n\r\n　　苏子愀然，正襟危坐，而问客曰：“何为其然也？”客曰：“‘月明星稀，乌鹊南飞。’此非曹孟德之诗乎？西望夏口，东望武昌，山川相缪，郁乎苍苍，此非孟德之困于周郎者乎？方其破荆州，下江陵，顺流而东也，舳舻千里，旌旗蔽空，酾酒临江，横槊赋诗，固一世之雄也，而今安在哉？况吾与子渔樵于江渚之上，侣鱼虾而友麋鹿，驾一叶之扁舟，举匏樽以相属。寄蜉蝣于天地，渺沧海之一粟。哀吾生之须臾，羡长 江之无穷。挟飞仙以遨游，抱明月而长终。知不可乎骤得，托遗响于悲风。”\r\n\r\n　　苏子曰：“客亦知夫水与月乎？逝者如斯，而未尝往也；盈虚者如彼，而卒莫消长也。盖将自其变者而观之，则天地曾不能以一瞬；自其不变者而观之，则物与我皆无尽也，而又何羡乎！且夫天地之间，物各有主，苟非吾之所有，虽一毫而莫取。惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色，取之无禁，用之不竭。是造物者之无尽藏也，而吾与子之所共适。”(共适 一作：共食)\r\n\r\n　　客喜而笑，洗盏更酌。肴核既尽，杯盘狼籍。相与枕藉乎舟中，不知东方之既白。',2),(3,'今天本来打算写一下activity与activity之间的数据传递的，但是在跟女朋友吵了一架之后，实在是没心情继续下了，索性删了刚才写的东西，重新开了这个话题。\r\n\r\n我实在是搞不明白她天天脑子里面想的都是什么。。。刚才吵架的时候她说我已经好久没有好好坐下来听她说话了，但是在我的意识里面我天天除了敲代码脑子里就只剩下她了。对了，还有机遇。。。时时刻刻都在想着怎么去提高下技术？怎么去多赚点钱？我还能想什么？\r\n\r\n每次一这么吵架我都很崩溃，很无奈，无语。。。难不成我天天在家什么也不干，就这样陪着她？那月底拿什么交房租？每天吃什么？喝什么？这些问题她都不想的么？\r\n\r\n回归正题，谈谈我的想法，我最想要一个什么样的女朋友。\r\n\r\n1.漂亮，能上我带出去，且能带回来的。我觉得只要不是丑的离谱，一般普通人足以满足这个条件吧。\r\n\r\n2.会做饭，虽然我也很喜欢做饭，但是我很喜欢女朋友给我做饭的感觉。心里满满的都是爱。\r\n\r\n3.性格可静可动，在我思考问题，敲代码的时候能安静下来。其他时间随意折腾。\r\n\r\n4，理解我，希望她能明白，我努力的工作，努力的敲代码，努力的去思考问题，不是说不在乎她，正是因为太在乎所以我要创造更好的生活条件去给她。不用羡慕别人想买什么就买什么。\r\n\r\n5.每次我看她不开心，我都会去哄。但是我不知道怎么去哄。所以我希望她在看到我去找她说话，逗她的时候能明白我就是在道歉，在哄她。\r\n\r\n6.不要犟，越犟越烦人。程序员都喜欢讲道理，要么if要么else.哪来那么多的条条道道。\r\n\r\n7.不要犟，越犟越烦人。程序员都喜欢讲道理，要么if要么else.哪来那么多的条条道道。\r\n\r\n8.不要犟，越犟越烦人。程序员都喜欢讲道理，要么if要么else.哪来那么多的条条道道。\r\n\r\n重要的事情说三遍。就这完了，我知道会有人该说，活该你屌丝一辈子，活该找不到女朋友。。。随便怎么说吧，随笔。随笔、想到啥就说啥。。。\r\n\r\n唉。。。越来越恐婚了。',3),(4,'分享自己犯错的经历至关重要，能让别人从中吸取经验教训，而且可能让他们工作起来更上手。我在这儿记录了几条自己最近犯的错。\r\n\r\n为什么有那么多生产数据库被误删？\r\n几个月之前，Reddit 上发了一篇文章，写的是一个入门级开发人员在上班第一天就误删了生产数据库。我们看到类似这种有人犯了特大的、不可磨灭的错误的文章，都不免心生畏惧。我们意识到自己并不是没可能犯那种错——大多数时候都是悬崖勒马。\r\n\r\n我在干第一份工作的时候，有一个高级数据库管理员在上班第一天就误删了生产数据库，这种例子简直比比皆是。工作团队用一周前旧的数据库备份帮他弥补了过失，让他保住了工作。如今十年过去了，都仍用这件事拿他开涮。\r\n\r\n今年年初有天早上，我被叫去调查一个客户生产中出现的问题。他们本来要针对一小部分用户进行产品的 β 测试，但是他们的网站首页突然什么都显示不出来了。我猜想可能是系统有 bug 或者有漏洞所致。\r\n\r\n我登录进生产机器，调出数据库，发现 articles 表是空的。OK，这证实了网页显示空白的情况。\r\n\r\n用户表里面还是有用户的，这就奇怪了，所以我们丢了所有的 articles，但起码他们的测试用户仍有他们的账号，我们可以解释说是这是个测试版，而且这种事情时有发生。\r\n\r\n接下来一会儿我就犯迷糊了。我记不清楚自己干了什么，我认为自己不会蠢到在控制台窗口输入了删除表中用户的指令，可情况就是这样——现在既没有 articles 表，也没有用户表。我呆坐着，感觉有点震惊。\r\n\r\n然后我的大脑高速运转，开始想办法修复问题。我真的删掉用户表了吗？是的。我们运行备份数据库了吗？没有。该怎么向客户解释呢？我不知道。\r\n\r\n我记得自己去找了项目经理，坐在她旁边解释事情发生的经过，articles 表中没有数据了，所以网站看上去是空的。哦对了，我还误删了用户表。现在他们需要重新邀请所有的用户——如果他们还能想清楚用户都有谁的话。哎呀。\r\n\r\n我回到自己的座位上，感觉深受挫败。\r\n\r\n但是我觉得事情有些蹊跷，我们怎么可能一开始就丢了所有的 articles 表呢？于是我继续深究下去，一方面是因为难以接受这个结果，一方面是想挽回颜面。之后过了一小会儿，我注意到了关键问题。\r\n\r\n服务器上还有另外 5 个数据库，其中一个的名字和我正在看的那个数据库的名字非常相似。\r\n\r\n我一检查，发现 articles 都在里面，用户表也完好无损。事实证明是因为配置发生变化，无意间让它变成了生产数据库，导致网站指向了全新的数据库。我在里面看到的那些用户呢？种子数据罢了。\r\n\r\n真是如释重负！一早上神经紧绷、胃酸翻涌，搞得我浑身不适，但好在我们“修复”了所有的数据，并且找到了问题真正的症结所在，没有提前宣布误删数据库的坏消息。\r\n\r\n这个小插曲让我们受益良多，最简单的一个就是：现在我们总是在给数据库做备份……这可能是我们开发人员最有效的胃药。\r\n\r\n总赶进度，却从来赶不上进度\r\n我最近所犯的另一个突出 错误没那么戏剧化，实际上是由一个个小错误最终累积造成了大麻烦。\r\n\r\n我们项目开发的一大挑战就是时间紧张（但也不全是？）\r\n\r\n第一次开会时，我们一致觉得项目需要的时间比我们能够拿出来的时间多了一倍。从项目一开始，截止日期就步步紧逼，所以我们三下五除二就通过了认证环节，以便进入客户真正关心的功能环节。\r\n\r\n我只是之前在一个单页 app 中落实了一次认证，但仍然没有彻底理解 app 各部分是如何协调的。\r\n\r\n尽己所能用最快的速度把 app 赶出来，就是大错特错，我漏掉了一些非常重要的东西：\r\n\r\n用户在登陆后，是通过 cookie 来加载的，但是我的 app 页面没有给加载提供等待时间，而是根据事件顺序来决定先后的，所以服务器会回复说你没有权限。这种错误很少见，而且很难再出现，因为大多数情况下事件都是按照正确的顺序来完成的。\r\n而且认证环节也从不检查用户令牌是否失效，如果你不经常访问网站，当发现了没法登上网站后，就需要注销登录再重新登进去。\r\n令牌应该在每次发起请求时都进行更新，但我从来都没有时间去理解这些规则。所以这里又产生了时间问题。如果我们一次同时发出几种请求，收到的回复取决于他们到来的顺序，那将来发送请求用到的令牌就是错的。\r\n我们卯足劲赶进度，但最终所用的时间还是要比给定的时间多一倍。区别就是我们开发出的 app 里面漏洞更多了，然后甚而要花更多的时间对漏洞进行追踪和修复。\r\n\r\n工作中的失误让我尴尬不已，在大家面前感到十分羞愧，因为我把一切都搞砸了。\r\n\r\n我要说一点：从那之后，我开始花时间学习认证机制，现在已经理解了 OAuth,、JWT、刷新令牌和失效。我仔细阅读了许多库里别人写的认证代码，而且建立了基于几种不同语言版本和框架的认证流程。\r\n\r\n失败是成功之母\r\n这是每次失败的经历给予我的启发。只要你愿意学习，几乎每次这样的经历都会让你从中受益。\r\n\r\n如果人能够从错误中吸取教训，那么就会有所进步。如果一个队员是第一次犯错，我尽量不会对他表现出不满态度，他们往往已经知道自己把事情搞糟了。\r\n\r\n但我也努力不去苛责那些总是犯错、屡教不改的人，他们也需要被同情。\r\n\r\n对待犯错，如果你能够做到这四点，那么就会不断进步：\r\n\r\n对曾经犯过的错误可以自嘲一番\r\n从中吸取经验教训\r\n在之后努力为自己正名\r\n和他人分享，让他人也能从中获益。\r\n关于犯错的宝贵价值，我留给你们一则名人轶事：20 世纪初期，IBM 的总裁托马斯·J·沃森遇到了一位因为多次决策错误让公司损失惨重的员工，当问及是否要开除这个员工时，沃森答道：\r\n\r\n“不，我刚刚花了 60 万美元培训了他，我怎么会让其他人雇佣他来获得他的经历呢？”\r\n\r\n你过去犯过哪些有意思的错？来一起分享吧！',5);
/*!40000 ALTER TABLE `文章详情` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户信息`
--

DROP TABLE IF EXISTS `用户信息`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `用户信息` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `avatar` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `telephone` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户信息`
--

LOCK TABLES `用户信息` WRITE;
/*!40000 ALTER TABLE `用户信息` DISABLE KEYS */;
INSERT INTO `用户信息` VALUES ('pbkdf2_sha256$36000$qaTJnHSnC4yT$6MaPEjOQuSweQAj8bVI6g+jU8RYQitIGOh5OaAoMGCw=','2018-07-01 22:34:39.732860',1,'admin','','','',1,1,'2018-07-01 22:33:33.935471',1,NULL,NULL,''),('pbkdf2_sha256$36000$Rl2TWYgr4ptX$WNVb06QuWqRJZ7Vaur+kvplZOhTTlM26DQo89PHC3X0=','2018-07-01 22:34:18.515144',0,'alex','','','1111@qq.com',0,1,'2018-07-01 22:34:11.029730',2,NULL,NULL,'user/2018/07/指针css样式.png'),('pbkdf2_sha256$36000$DihygLQCEHu0$eyx7xVV2eptohoWgwf0QxN+bhd/AbQhaQRODzWLypuY=','2018-07-01 22:55:12.476083',0,'bob','','','11@qq.com',0,1,'2018-07-01 22:54:29.333149',3,NULL,NULL,'user/2018/07/求职方式.png');
/*!40000 ALTER TABLE `用户信息` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户信息_groups`
--

DROP TABLE IF EXISTS `用户信息_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `用户信息_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `my_blog_userinfo_groups_userinfo_id_group_id_8f7343ef_uniq` (`userinfo_id`,`group_id`),
  KEY `my_blog_userinfo_groups_group_id_802d94d8_fk_auth_group_id` (`group_id`),
  CONSTRAINT `my_blog_userinfo_gro_userinfo_id_2faa2cb8_fk_my_blog_u` FOREIGN KEY (`userinfo_id`) REFERENCES `用户信息` (`nid`),
  CONSTRAINT `my_blog_userinfo_groups_group_id_802d94d8_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户信息_groups`
--

LOCK TABLES `用户信息_groups` WRITE;
/*!40000 ALTER TABLE `用户信息_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `用户信息_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户信息_user_permissions`
--

DROP TABLE IF EXISTS `用户信息_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `用户信息_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `my_blog_userinfo_user_pe_userinfo_id_permission_i_546260fa_uniq` (`userinfo_id`,`permission_id`),
  KEY `my_blog_userinfo_use_permission_id_3a8af6f8_fk_auth_perm` (`permission_id`),
  CONSTRAINT `my_blog_userinfo_use_permission_id_3a8af6f8_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `my_blog_userinfo_use_userinfo_id_3b1363cd_fk_my_blog_u` FOREIGN KEY (`userinfo_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户信息_user_permissions`
--

LOCK TABLES `用户信息_user_permissions` WRITE;
/*!40000 ALTER TABLE `用户信息_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `用户信息_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户点赞`
--

DROP TABLE IF EXISTS `用户点赞`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `用户点赞` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `my_blog_poll_user_id_article_id_e58fc740_uniq` (`user_id`,`article_id`),
  KEY `my_blog_poll_article_id_401e8785_fk_my_blog_article_nid` (`article_id`),
  CONSTRAINT `my_blog_poll_article_id_401e8785_fk_my_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `文章` (`nid`),
  CONSTRAINT `my_blog_poll_user_id_eb4d14cf_fk_my_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户点赞`
--

LOCK TABLES `用户点赞` WRITE;
/*!40000 ALTER TABLE `用户点赞` DISABLE KEYS */;
/*!40000 ALTER TABLE `用户点赞` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户评论`
--

DROP TABLE IF EXISTS `用户评论`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `用户评论` (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `poll_num` int(11) NOT NULL,
  `article_id` bigint(20) NOT NULL,
  `parent_id_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `my_blog_comment_article_id_fb24935c_fk_my_blog_article_nid` (`article_id`),
  KEY `my_blog_comment_parent_id_id_a44f20f5_fk_my_blog_comment_nid` (`parent_id_id`),
  KEY `my_blog_comment_user_id_221e0184_fk_my_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `my_blog_comment_article_id_fb24935c_fk_my_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `文章` (`nid`),
  CONSTRAINT `my_blog_comment_parent_id_id_a44f20f5_fk_my_blog_comment_nid` FOREIGN KEY (`parent_id_id`) REFERENCES `用户评论` (`nid`),
  CONSTRAINT `my_blog_comment_user_id_221e0184_fk_my_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户评论`
--

LOCK TABLES `用户评论` WRITE;
/*!40000 ALTER TABLE `用户评论` DISABLE KEYS */;
INSERT INTO `用户评论` VALUES (1,'千古奇文！','2018-07-01 22:45:44.837698',0,1,NULL,1),(2,'是的啊','2018-07-01 22:45:49.781131',0,1,1,1),(3,'我喜欢','2018-07-01 22:46:07.924243',0,1,NULL,1),(4,'我也是','2018-07-01 22:46:11.339780',0,1,3,1),(5,'哈哈','2018-07-01 22:53:38.354658',0,3,NULL,1),(6,'我的最爱','2018-07-01 22:55:22.164574',0,1,4,3),(7,'有眼光','2018-07-01 22:55:39.547804',0,1,6,1),(8,'写得好','2018-07-01 22:55:56.461653',0,5,NULL,3),(9,'是的啊','2018-07-01 22:56:10.137349',0,5,8,1),(10,'有个问题啊','2018-07-01 22:56:26.294569',0,5,NULL,1),(11,'啥问题','2018-07-01 22:56:36.872673',0,5,10,3),(12,'我发email你','2018-07-01 22:56:46.929831',0,5,11,1),(13,'等你消息','2018-07-01 22:56:53.866960',0,5,12,3);
/*!40000 ALTER TABLE `用户评论` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `网站文章分类`
--

DROP TABLE IF EXISTS `网站文章分类`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `网站文章分类` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `网站文章分类`
--

LOCK TABLES `网站文章分类` WRITE;
/*!40000 ALTER TABLE `网站文章分类` DISABLE KEYS */;
INSERT INTO `网站文章分类` VALUES (1,'文学'),(2,'互联网');
/*!40000 ALTER TABLE `网站文章分类` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `网站详细分类`
--

DROP TABLE IF EXISTS `网站详细分类`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `网站详细分类` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_blog_sitecatedetail_parent_id_d2c23233_fk_my_blog_sitecate_id` (`parent_id`),
  CONSTRAINT `my_blog_sitecatedetail_parent_id_d2c23233_fk_my_blog_sitecate_id` FOREIGN KEY (`parent_id`) REFERENCES `网站文章分类` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `网站详细分类`
--

LOCK TABLES `网站详细分类` WRITE;
/*!40000 ALTER TABLE `网站详细分类` DISABLE KEYS */;
INSERT INTO `网站详细分类` VALUES (1,'古文',1),(2,'职场',2);
/*!40000 ALTER TABLE `网站详细分类` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `自定义分类`
--

DROP TABLE IF EXISTS `自定义分类`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `自定义分类` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `my_blog_category_blog_id_eeba228e_fk_my_blog_blog_nid` (`blog_id`),
  CONSTRAINT `my_blog_category_blog_id_eeba228e_fk_my_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `博客设置信息` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `自定义分类`
--

LOCK TABLES `自定义分类` WRITE;
/*!40000 ALTER TABLE `自定义分类` DISABLE KEYS */;
INSERT INTO `自定义分类` VALUES (1,'古文',1),(2,'互联网',1);
/*!40000 ALTER TABLE `自定义分类` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add 用户信息',6,'add_userinfo'),(17,'Can change 用户信息',6,'change_userinfo'),(18,'Can delete 用户信息',6,'delete_userinfo'),(19,'Can add 文章',7,'add_article'),(20,'Can change 文章',7,'change_article'),(21,'Can delete 文章',7,'delete_article'),(22,'Can add 文章标签关系表',8,'add_article2tag'),(23,'Can change 文章标签关系表',8,'change_article2tag'),(24,'Can delete 文章标签关系表',8,'delete_article2tag'),(25,'Can add 文章详情',9,'add_articledetail'),(26,'Can change 文章详情',9,'change_articledetail'),(27,'Can delete 文章详情',9,'delete_articledetail'),(28,'Can add 博客',10,'add_blog'),(29,'Can change 博客',10,'change_blog'),(30,'Can delete 博客',10,'delete_blog'),(31,'Can add 自定义分类',11,'add_category'),(32,'Can change 自定义分类',11,'change_category'),(33,'Can delete 自定义分类',11,'delete_category'),(34,'Can add 评论',12,'add_comment'),(35,'Can change 评论',12,'change_comment'),(36,'Can delete 评论',12,'delete_comment'),(37,'Can add 评论点赞',13,'add_comment_poll'),(38,'Can change 评论点赞',13,'change_comment_poll'),(39,'Can delete 评论点赞',13,'delete_comment_poll'),(40,'Can add 文章点赞',14,'add_poll'),(41,'Can change 文章点赞',14,'change_poll'),(42,'Can delete 文章点赞',14,'delete_poll'),(43,'Can add 网站分类',15,'add_sitecate'),(44,'Can change 网站分类',15,'change_sitecate'),(45,'Can delete 网站分类',15,'delete_sitecate'),(46,'Can add 网站分类详情',16,'add_sitecatedetail'),(47,'Can change 网站分类详情',16,'change_sitecatedetail'),(48,'Can delete 网站分类详情',16,'delete_sitecatedetail'),(49,'Can add 标签',17,'add_tag'),(50,'Can change 标签',17,'change_tag'),(51,'Can delete 标签',17,'delete_tag'),(52,'Can add 用户粉丝',18,'add_userfans'),(53,'Can change 用户粉丝',18,'change_userfans'),(54,'Can delete 用户粉丝',18,'delete_userfans');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_my_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_my_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-07-01 22:37:54.325163','1','alex',1,'[{\"added\": {}}]',10,1),(2,'2018-07-01 22:38:42.511314','1','古文',1,'[{\"added\": {}}]',11,1),(3,'2018-07-01 22:39:02.896407','1','文学',1,'[{\"added\": {}}]',15,1),(4,'2018-07-01 22:39:07.559274','1','古文',1,'[{\"added\": {}}]',16,1),(5,'2018-07-01 22:39:10.447629','1','兰亭集序',1,'[{\"added\": {}}]',7,1),(6,'2018-07-01 22:39:42.763050','2','前赤壁赋',1,'[{\"added\": {}}]',7,1),(7,'2018-07-01 22:40:02.189828','1','兰亭集序',1,'[{\"added\": {}}]',9,1),(8,'2018-07-01 22:40:11.711272','2','前赤壁赋',1,'[{\"added\": {}}]',9,1),(9,'2018-07-01 22:42:14.777874','2','互联网',1,'[{\"added\": {}}]',11,1),(10,'2018-07-01 22:42:22.736573','2','互联网',1,'[{\"added\": {}}]',15,1),(11,'2018-07-01 22:42:26.907681','2','职场',1,'[{\"added\": {}}]',16,1),(12,'2018-07-01 22:42:28.639499','3','程序员喜欢什么样的女生？',1,'[{\"added\": {}}]',7,1),(13,'2018-07-01 22:42:42.757174','3','程序员喜欢什么样的女生？',1,'[{\"added\": {}}]',9,1),(14,'2018-07-01 22:43:24.652447','4','计算机专业太难不适合女生学？来看 N 多小姐姐的回应',1,'[{\"added\": {}}]',7,1),(15,'2018-07-01 22:44:24.150225','4','计算机专业太难不适合女生学？来看 N 多小姐姐的回应',3,'',7,1),(16,'2018-07-01 22:44:42.382173','5','我作为开发者犯过的两次愚蠢的错误',1,'[{\"added\": {}}]',7,1),(17,'2018-07-01 22:45:08.523156','4','我作为开发者犯过的两次愚蠢的错误',1,'[{\"added\": {}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(7,'my_blog','article'),(8,'my_blog','article2tag'),(9,'my_blog','articledetail'),(10,'my_blog','blog'),(11,'my_blog','category'),(12,'my_blog','comment'),(13,'my_blog','comment_poll'),(14,'my_blog','poll'),(15,'my_blog','sitecate'),(16,'my_blog','sitecatedetail'),(17,'my_blog','tag'),(18,'my_blog','userfans'),(6,'my_blog','userinfo'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-07-01 22:32:54.607111'),(2,'contenttypes','0002_remove_content_type_name','2018-07-01 22:32:54.735416'),(3,'auth','0001_initial','2018-07-01 22:32:55.176919'),(4,'auth','0002_alter_permission_name_max_length','2018-07-01 22:32:55.256223'),(5,'auth','0003_alter_user_email_max_length','2018-07-01 22:32:55.268020'),(6,'auth','0004_alter_user_username_opts','2018-07-01 22:32:55.278206'),(7,'auth','0005_alter_user_last_login_null','2018-07-01 22:32:55.289382'),(8,'auth','0006_require_contenttypes_0002','2018-07-01 22:32:55.293775'),(9,'auth','0007_alter_validators_add_error_messages','2018-07-01 22:32:55.304238'),(10,'auth','0008_alter_user_username_max_length','2018-07-01 22:32:55.315487'),(11,'my_blog','0001_initial','2018-07-01 22:32:58.451158'),(12,'admin','0001_initial','2018-07-01 22:32:58.678138'),(13,'admin','0002_logentry_remove_auto_add','2018-07-01 22:32:58.698418'),(14,'my_blog','0002_auto_20180630_1935','2018-07-01 22:32:58.946745'),(15,'sessions','0001_initial','2018-07-01 22:32:59.008376');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('037ghncfep6j1u362juy0bztialszauk','N2ZhOGNhYTc4MGEyNDEwYTE2ZTQyN2M0ZWQxZDdiNjY3N2YwYTliZDp7InZhbGlkX2NvZGUiOiJTTGRmM3YiLCJfYXV0aF91c2VyX2lkIjoiMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjFmZmMwOTZjMjgwZjJlZTdlMTI3OWQwODM4OWQxZmMzYWIzZWRmNCJ9','2018-07-15 22:55:12.481051'),('76sszxfz6ochgk7l2nrc87v5vbvekoy8','NDRkN2IzMjAyNTk3NzUzZTQ0OGUzM2RiZWJhNzZjNjE2Y2NhMTIyNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYmJmM2E3YThhYmRjOGNiOTZlZjE3Y2ViYWI1NWEyNWZjNTU0NDEwIn0=','2018-07-15 22:34:39.740932');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_blog_article2tag`
--

DROP TABLE IF EXISTS `my_blog_article2tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_blog_article2tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `my_blog_article2tag_article_id_tag_id_c08ce6a8_uniq` (`article_id`,`tag_id`),
  KEY `my_blog_article2tag_tag_id_9936de4f_fk_my_blog_tag_nid` (`tag_id`),
  CONSTRAINT `my_blog_article2tag_article_id_e6dd5709_fk_my_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `文章` (`nid`),
  CONSTRAINT `my_blog_article2tag_tag_id_9936de4f_fk_my_blog_tag_nid` FOREIGN KEY (`tag_id`) REFERENCES `my_blog_tag` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_blog_article2tag`
--

LOCK TABLES `my_blog_article2tag` WRITE;
/*!40000 ALTER TABLE `my_blog_article2tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_blog_article2tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_blog_comment_poll`
--

DROP TABLE IF EXISTS `my_blog_comment_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_blog_comment_poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) NOT NULL,
  `poll_user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `my_blog_comment_poll_poll_user_id_comment_id_aef96ade_uniq` (`poll_user_id`,`comment_id`),
  KEY `my_blog_comment_poll_comment_id_7c80b17a_fk_my_blog_comment_nid` (`comment_id`),
  CONSTRAINT `my_blog_comment_poll_comment_id_7c80b17a_fk_my_blog_comment_nid` FOREIGN KEY (`comment_id`) REFERENCES `用户评论` (`nid`),
  CONSTRAINT `my_blog_comment_poll_poll_user_id_93f2cfe6_fk_my_blog_u` FOREIGN KEY (`poll_user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_blog_comment_poll`
--

LOCK TABLES `my_blog_comment_poll` WRITE;
/*!40000 ALTER TABLE `my_blog_comment_poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_blog_comment_poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_blog_tag`
--

DROP TABLE IF EXISTS `my_blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_blog_tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `my_blog_tag_blog_id_e40afe8e_fk_my_blog_blog_nid` (`blog_id`),
  CONSTRAINT `my_blog_tag_blog_id_e40afe8e_fk_my_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `博客设置信息` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_blog_tag`
--

LOCK TABLES `my_blog_tag` WRITE;
/*!40000 ALTER TABLE `my_blog_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_blog_userfans`
--

DROP TABLE IF EXISTS `my_blog_userfans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_blog_userfans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_blog_userfans_follower_id_8d4e6b06_fk_my_blog_userinfo_nid` (`follower_id`),
  KEY `my_blog_userfans_user_id_1fb27d72_fk_my_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `my_blog_userfans_follower_id_8d4e6b06_fk_my_blog_userinfo_nid` FOREIGN KEY (`follower_id`) REFERENCES `用户信息` (`nid`),
  CONSTRAINT `my_blog_userfans_user_id_1fb27d72_fk_my_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `用户信息` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_blog_userfans`
--

LOCK TABLES `my_blog_userfans` WRITE;
/*!40000 ALTER TABLE `my_blog_userfans` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_blog_userfans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-01 22:57:54
