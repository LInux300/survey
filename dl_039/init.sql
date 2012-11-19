-- phpMyAdmin SQL Dump
-- version 2.11.3deb1ubuntu1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 02, 2009 at 10:32 AM
-- Server version: 5.0.51
-- PHP Version: 5.2.4-2ubuntu5.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `production_quiz_detske-labyrinty`
--
CREATE DATABASE `production_quiz_detske-labyrinty` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `production_quiz_detske-labyrinty`;

-- --------------------------------------------------------

--
-- Table structure for table `anketas`
--

CREATE TABLE IF NOT EXISTS `anketas` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `status_id` int(11) NOT NULL default '0',
  `published_at` datetime default NULL,
  `description` text collate utf8_unicode_ci,
  `key_word` varchar(100) collate utf8_unicode_ci default NULL,
  `mark_total` int(11) NOT NULL default '0',
  `votes_total` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

--
-- Dumping data for table `anketas`
--


-- --------------------------------------------------------

--
-- Table structure for table `anketas_questions`
--

CREATE TABLE IF NOT EXISTS `anketas_questions` (
  `question_id` int(11) NOT NULL,
  `anketa_id` int(11) NOT NULL,
  KEY `fk_bk_questions` (`question_id`),
  KEY `fk_bk_polls` (`anketa_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `anketas_questions`
--


-- --------------------------------------------------------

--
-- Table structure for table `hodnocenis`
--

CREATE TABLE IF NOT EXISTS `hodnocenis` (
  `id` int(11) NOT NULL auto_increment,
  `znamka` int(11) default '0',
  `user_id` int(11) default '0',
  `user_body` varchar(255) collate utf8_unicode_ci default NULL,
  `anketa_id` int(11) default '0',
  `question_id` int(11) default '0',
  `session_id` int(11) default '0',
  `podpis` varchar(255) collate utf8_unicode_ci default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  `hodnota_odpovedi` varchar(250) collate utf8_unicode_ci default NULL,
  `hodnota_spravne` varchar(3) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=383 ;

--
-- Dumping data for table `hodnocenis`
--


-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL auto_increment,
  `position` int(11) default '0',
  `question` varchar(255) collate utf8_unicode_ci default NULL,
  `answer` varchar(255) collate utf8_unicode_ci default NULL,
  `yes` tinyint(1) default '0',
  `mark_total` int(11) default '1',
  `votes_total` int(11) default '1',
  `pocet_odpovedi` int(3) default '0',
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=111 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `position`, `question`, `answer`, `yes`, `mark_total`, `votes_total`, `pocet_odpovedi`, `updated_at`, `created_at`) VALUES
(37, 0, 'Tvá e-mailová adresa?', '', 0, 1, 1, 0, '2009-01-02 14:30:08', '2009-01-02 14:30:08'),
(34, 0, 'Ve kterém DÚ, DD nebo VÚ žiješ?', '', 0, 1, 1, 0, '2009-01-02 14:29:01', '2009-01-02 14:29:01'),
(35, 0, 'Jak se Ti líbí název domény "detske-labyrinty.cz" pro portál, určený mj. jako "rozcestník" dětem ve složité životní situaci a dětem v ústavní výchově? Je podle Tebe doména výstižná vzhledem k tématu?', '', 0, 1, 1, 0, '2009-01-02 14:29:45', '2009-01-02 14:29:45'),
(36, 0, 'Jak se Vám líbí název domény "detske-labyrinty.cz" pro portál, určený mj. jako "rozcestník" dětem ve složité životní situaci a dětem v ústavní výchově? Je podle Vás doména výstižná vzhledem k tématu?', '', 0, 1, 1, 0, '2009-01-02 14:29:57', '2009-01-02 14:29:57'),
(38, 0, 'Kolik je Ti let?', '', 0, 1, 1, 0, '2009-01-02 14:30:17', '2009-01-02 14:30:17'),
(39, 0, 'Myslíš, že by všechny DÚ, DD a VÚ měly mít vlastní webové stránky?', '', 0, 1, 1, 0, '2009-01-02 14:30:26', '2009-01-02 14:30:26'),
(40, 0, 'Co by na nich podle Tebe mělo být především?', '', 0, 1, 1, 0, '2009-01-02 14:30:35', '2009-01-02 14:30:35'),
(41, 0, 'Máš v DÚ, DD nebo VÚ dostatečný přístup k internetu?', '', 0, 1, 1, 0, '2009-01-02 14:30:49', '2009-01-02 14:30:49'),
(42, 0, 'Myslíš si, že umíš s internetem dostatečně dobře zacházet?', '', 0, 1, 1, 0, '2009-01-02 14:31:00', '2009-01-02 14:31:00'),
(43, 0, 'Když potřebuješ v práci s internetemporadit, je ve Tvé blízkosti někdo takový?', '', 0, 1, 1, 0, '2009-01-02 14:31:13', '2009-01-02 14:31:13'),
(44, 0, 'K čemu nejčastěji používáš internet?', '', 0, 1, 1, 0, '2009-01-02 14:31:28', '2009-01-02 14:31:28'),
(45, 0, 'Ocenil(a) by jsi na portálu, určeném mj. i pro děti v DÚ, DD a VÚ možnost zakládat si vlastní blogy, galerie a účastnit se tematických diskusních fór?', '', 0, 1, 1, 0, '2009-01-02 14:31:41', '2009-01-02 14:31:41'),
(46, 0, 'Uvítal(a) by jsi na portálu přehledné odkazy na jiné DD a VÚ a jejich webové stránky s informacemi o dění v nich?', '', 0, 1, 1, 0, '2009-01-02 14:31:54', '2009-01-02 14:31:54'),
(47, 0, 'Měly by podle tebe mít na portálu místo i rozhovory a reportáže ze života dětí v DD a VÚ?', '', 0, 1, 1, 0, '2009-01-02 14:32:07', '2009-01-02 14:32:07'),
(48, 0, 'Ocenil(a) by jsi na portálu oddíl „Co dělat když?“, nabízející informace, rady a programy zaměřené na praktický život nejen po odchodu z DD nebo VÚ?', '', 0, 1, 1, 0, '2009-01-02 14:32:19', '2009-01-02 14:32:19'),
(49, 0, 'Je pro Tebe obtížné snadno kontaktovat Tvého kurátora nebo jiné sociální pracovníky?', '', 0, 0, 0, 0, '2009-01-02 14:33:00', '2009-01-02 14:33:00'),
(50, 0, 'Jsou pro Tebe Tvá práva a povinnosti neznámým tématem?', '', 0, 1, 1, 0, '2009-01-02 14:33:10', '2009-01-02 14:33:10'),
(51, 0, 'Myslíš, že by děti, které DD nebo VÚ už v minulosti opustily uvítaly možnost dohledat na portále kontakty na bývalé kamarády nebo zaměstnance DD nebo VÚ, kteří už jsou rovněž někde jinde?', '', 0, 1, 1, 0, '2009-01-02 14:33:21', '2009-01-02 14:33:21'),
(52, 0, 'Zadejte prosím název nebo jen typ Vašeho pracoviště (zaměstnavatele) – Všechny údaje jsou výhradně pro potřebu zpracování statistiky a zůstanou absolutně neveřejné:', '', 0, 1, 1, 0, '2009-01-02 14:33:34', '2009-01-02 14:33:34'),
(53, 0, 'Pracovní zařazení . vyber:', '', 0, 1, 1, 0, '2009-01-02 14:33:46', '2009-01-02 14:33:46'),
(54, 0, 'Délka Vaší praxe v Ústavní výchově?', '', 0, 1, 1, 0, '2009-01-02 14:33:57', '2009-01-02 14:33:57'),
(55, 0, 'Vaše e-mailová adresa? (žádoucí, ale ne nutná)', '', 0, 1, 1, 0, '2009-01-02 14:34:07', '2009-01-02 14:34:07'),
(56, 0, 'Uvítali by jste jednotný interní informační a komunikační databázový systém v počítačích vaší instituce, který by byl současně schopen síťového propojení s ostatními zařízeními pro výkon ústavní a ochranné výchovy?', '', 0, 1, 1, 0, '2009-01-02 14:34:16', '2009-01-02 14:34:16'),
(57, 0, 'Uvítali by jste, pokud by v rámci našeho projektu byly pro Vaše zařízení podle Vašich požadavků více méně zdarma vytvořeny Vaše vlastní webové stránky (DÚ, DD, VÚ) včetně zaškolení v jejich jednoduché obsluze?', '', 0, 1, 1, 0, '2009-01-02 14:34:32', '2009-01-02 14:34:32'),
(58, 0, 'Je podle Vás smysluplné vytvoření maximálně komplexní "pětiresortní" databáze všech pracovišť a programů v ČR podle regionů, které se tématu práce s ohroženými a rizikovými dětmi a mládeží věnují? ', '', 0, 1, 1, 0, '2009-01-02 14:35:18', '2009-01-02 14:35:18'),
(59, 0, 'Ocenili by jste na portálu sekci „Burza tipů, zkušeností a nápadů nejen pro volnočasové akce pro děti v ÚV“? Jde o snahu vytvořit databázi inspirativních akcí a zkušeností, osvědčených v jiných zařízeních.', '', 0, 1, 1, 0, '2009-01-02 14:35:26', '2009-01-02 14:35:26'),
(60, 0, 'Může být pro Vaši práci přínosné mít rychle k dispozici informace, kontakty a reference o nabídkách grantových projektů a programů neziskových organizací ve Vašem regionu, které mohou Vaši práci s dětmi doplnit a s nimiž lze efektivně spolupracovat?', '', 0, 1, 1, 0, '2009-01-02 14:35:37', '2009-01-02 14:35:37'),
(61, 0, 'Cítíte potřebu, že je z Vašeho pohledu skutečně o čem profesně a zejména otevřeně diskutovat v tematicky členěných diskusních fórech a blozích, a to jak anonymně, tak adresně?', '', 0, 1, 1, 0, '2009-01-02 14:35:47', '2009-01-02 14:35:47'),
(62, 0, 'Může se podle Vás stát portál zdrojem konkrétních informací z reálného prostředí pro "vylaďování" komplexního systému péče o cílovou skupinu ohrožených a rizikových dětí a mládeže ze strany meziresortní koordinační skupiny, ustavené na MPSV?', '', 0, 1, 1, 0, '2009-01-02 14:36:00', '2009-01-02 14:36:00'),
(63, 0, 'Je podle Vás třeba posílit prvek skutečně integrované spolupráce pětiresortního systému péče o ohrožené a rizikové děti a mládež? Cítíte potřebu vyjasnění kompetencí a zkvalitnění spolupráce s dalšími souvisejícími resorty? ', '', 0, 1, 1, 0, '2009-01-02 14:36:11', '2009-01-02 14:36:11'),
(64, 0, 'Může být pro Vás v práci přínosná možnost vyjadřovat se k reálným tématům kvality spolupráce s orgány OSPOD, PČR, zdravotnickými pracovišti, PMS a jinými zařízeními pro výkon ÚV a OV?', '', 0, 1, 1, 0, '2009-01-02 14:36:19', '2009-01-02 14:36:19'),
(65, 0, 'Chcete být čerstvě informováni nejen o mediálním dění, týkajícím se ústavní výchovy a souvisejících tématech? Chcete být informováni o aktivitách v roce 2008 ustavené meziresortní koordinační skupiny, věnující se tématu transformace systému péče?', '', 0, 0, 0, 0, '2009-01-02 14:36:34', '2009-01-02 14:36:34'),
(66, 0, 'Využili by jste možnosti nabízet na portálu akademickým a výzkumným pracovištím ke zpracování skutečně „živá“ témata, vzešlá z Vašich praktických zkušeností a postřehů?', '', 0, 1, 1, 0, '2009-01-02 14:36:47', '2009-01-02 14:36:47'),
(67, 0, 'Využili by jste na portálu ucelenou nabídku vzdělávání a supervizí pro odborný personál v ústavní výchově?', '', 0, 1, 1, 0, '2009-01-02 14:36:57', '2009-01-02 14:36:57'),
(68, 0, 'Jak se Vám líbí název domény "detske-labyrinty.cz" pro portál, určený mj. jako "rozcestník" dětem ve složité životní situaci a dětem v ústavní výchově? Je podle Vás doména výstižná vzhledem k tématu?', '', 0, 1, 1, 0, '2009-01-02 14:37:06', '2009-01-02 14:37:06'),
(69, 0, 'Myslíte si, že bude portál využívaný dětmi v ÚV a OV v sekci, jim určené?', '', 0, 1, 1, 0, '2009-01-02 14:37:23', '2009-01-02 14:37:23'),
(70, 0, 'Myslíte si, že bude portál využívaný širokou veřejností, rodiči a dětmi tápajícími často v tom, kam se obrátit pro radu a pomoc?', '', 0, 1, 1, 0, '2009-01-02 14:37:35', '2009-01-02 14:37:35'),
(71, 0, 'Je prezentace našeho záměru v přiložených souborech srozumitelná a dostatečně informativní?', '', 0, 1, 1, 0, '2009-01-02 14:38:39', '2009-01-02 14:38:39'),
(72, 0, 'Může Vám portál nějak jinak pomoci ve Vaší práci? Jak?', '', 0, 1, 1, 0, '2009-01-02 14:38:48', '2009-01-02 14:38:48'),
(73, 0, 'Může Vám portál pomoci ve Vašich rodičovských dilematech a nejistotách? Jak?', '', 0, 1, 1, 0, '2009-01-02 14:38:57', '2009-01-02 14:38:57'),
(74, 0, 'Ocenili by jste možnost otevření rodičovských, tematicky členěných diskusních fór a chatu, týkajícího se specifické rodičovské problematiky rizikového chování svých dětí a jejich problémů? Skutečně v tom nejste sami.', '', 0, 1, 1, 0, '2009-01-02 14:39:05', '2009-01-02 14:39:05'),
(75, 0, 'Může být pro Vás pomocí mít lehce dostupnou nabídku všech konkrétních specializovaných pracovišť a jejich programů, kam se můžete ve Vašem regionu obrátit a současně mít možnost srovnání kvality jejich služeb podle dřívějších referencí jiných klientů?', '', 0, 1, 1, 0, '2009-01-02 14:39:15', '2009-01-02 14:39:15'),
(76, 0, 'Myslíte si, že by rodiče dětí, umístěných v dětských domovech a výchovných ústavech ocenili existenci funkčních a skutečně informativních webových stránek těchto zařízení a měli tak lepší přehled o tamním dění? ', '', 0, 1, 1, 0, '2009-01-02 14:39:29', '2009-01-02 14:39:29'),
(77, 0, 'Chybí Vám odborně zaštítěný zastřešující internetový zdroj informací, zkušeností a odkazů, týkajících se rizik, ohrožujících děti a dospívající?', '', 0, 1, 1, 0, '2009-01-02 14:39:40', '2009-01-02 14:39:40'),
(78, 0, 'Jakékoliv specifické dotazy, potřeby, požadavky na portál, náměty a komentáře zasílejte e-mailem členům vývojového týmu na adresu kurdiovskydum@volny.cz. Chceme znát Vaše potřeby.', '', 0, 1, 1, 0, '2009-01-02 14:39:52', '2009-01-02 14:39:52'),
(79, 0, 'Jakékoliv jiné dotazy, potřeby, požadavky na systém, náměty a komentáře zasílej e-mailem členům vývojového týmu na adresu kurdiovskydum@volny.cz. Chceme znát tvé potřeby.', '', 0, 1, 1, 0, '2009-01-02 14:40:01', '2009-01-02 14:40:01'),
(80, 0, 'Na jakou školu chodíš?', '', 0, 1, 1, 0, '2009-01-02 14:40:11', '2009-01-02 14:40:11'),
(81, 0, ' 	edituj  	\r\nUvítal(a) by jsi jeden ucelený internetový portál, kdy by jsi snadno a rychle našel/našla kontakt na místa a lidi, na které se můžeš obrátit, pokud budeš mít ty nebo někdo jiný problémy se šikanou, s drogami, s osamělostí, s násilím v rodině,', '', 0, 1, 1, 0, '2009-01-02 14:40:22', '2009-01-02 14:40:22'),
(82, 0, 'Jak se Ti líbí název domény „dětské-labyrinty.cz“ a jak je podle tebe výstižný ve snaze pomoci ti ve tvých nejasnostech, pochybnostech a problémech?', '', 0, 1, 1, 0, '2009-01-02 14:40:52', '2009-01-02 14:40:52'),
(83, 0, 'Víš, co by se mohlo reálně stát, když z jakéhokoliv důvodu přestaneš chodit do školy, budeš bývat přes noc mimo domov, budeš experimentovat s drogami nebo alkoholem?', '', 0, 1, 1, 0, '2009-01-02 14:41:02', '2009-01-02 14:41:02'),
(84, 0, 'Víš, kam se obrátit, kdyby ses z nějakého závažného nebo jiného důvodu rozhodneš odejít z domova?', '', 0, 1, 1, 0, '2009-01-02 14:41:11', '2009-01-02 14:41:11'),
(85, 0, 'Jak dlouho pracujete v oboru?', '', 0, 1, 1, 0, '2009-01-02 14:41:28', '2009-01-02 14:41:28'),
(86, 0, 'Ocenil(a) by jste, pokud by všechny DÚ, DD a VÚ v ČR disponovaly svými kvalitními a funkčními webovými stránkami?', '', 0, 1, 1, 0, '2009-01-02 14:41:39', '2009-01-02 14:41:39'),
(87, 0, 'Může být pro Vaši práci přínosné mít rychle k dispozici informace, kontakty a reference o nabídkách grantových projektů a programů neziskových organizací ve Vašem regionu, které mohou Vaši práci s dětmi doplnit a s nimiž lze efektivně spolupracovat?', '', 0, 1, 1, 0, '2009-01-02 14:41:50', '2009-01-02 14:41:50'),
(88, 0, 'Myslíte si, že je z Vašeho pohledu skutečně o čem profesně a zejména otevřeně diskutovat v tematicky členěných diskusních fórech a blozích, a to jak anonymně, tak adresně?', '', 0, 1, 1, 0, '2009-01-02 14:42:02', '2009-01-02 14:42:02'),
(89, 0, 'Využili by jste na portálu snadno dostupnou ucelenou nabídku informace o možnostech vzdělávání a zejména supervizí pro odborníky v pomáhajících profesích?', '', 0, 1, 1, 0, '2009-01-02 14:42:11', '2009-01-02 14:42:11'),
(90, 0, 'Typ Vašeho školského zařízení?', '', 0, 1, 1, 0, '2009-01-02 14:42:20', '2009-01-02 14:42:20'),
(91, 0, 'Vaše pracovní zařazení?', '', 0, 1, 1, 0, '2009-01-02 14:42:29', '2009-01-02 14:42:29'),
(92, 0, 'Délka Vaší praxe?', '', 0, 2, 2, 0, '2009-01-02 14:42:37', '2009-01-02 14:42:37'),
(93, 0, 'Vnímáte nedostatek informací a kontaktů na odborná pracoviště, která Vám mohou pomoci a mohou Vaši pedagogickou práci doplnit a efektivně spolupracovat?', '', 0, 1, 1, 0, '2009-01-02 14:42:46', '2009-01-02 14:42:46'),
(94, 0, 'Cítíte potřebu takové cesty spolupráce hledat?', '', 0, 1, 1, 0, '2009-01-02 14:42:58', '2009-01-02 14:42:58'),
(95, 0, 'Vnímáte kvalitu práce výchovného poradce na Vaší škole jako efektivní a smysluplnou?', '', 0, 1, 1, 0, '2009-01-02 14:43:08', '2009-01-02 14:43:08'),
(96, 0, 'Pokud máte na škole školního psychologa, jak jste spokojeni s jeho prací?', '', 0, 1, 1, 0, '2009-01-02 14:43:17', '2009-01-02 14:43:17'),
(97, 0, 'Ocenili by jste na portálu sekci „Burza tipů, zkušeností a nápadů pro výchovně vzdělávací práci s dětmi“? Jde o snahu vytvořit databázi inspirativních akcí a zkušeností kolegů z jiných škol, osvědčených na jejich pracovištích.', '', 0, 1, 1, 0, '2009-01-02 14:43:26', '2009-01-02 14:43:26'),
(98, 0, 'Myslíte si, že je z Vašeho pohledu skutečně o čem profesně a zejména otevřeně diskutovat v tematicky členěných diskusních fórech a blozích, a to jak anonymně, tak adresně? A to na témata Vám dobře známých specifik výchovně vzdělávací práce ve školách.', '', 0, 1, 1, 0, '2009-01-02 14:43:37', '2009-01-02 14:43:37'),
(99, 0, 'Uvítali by jste snadno dosažitelnou nabídku supervizního servisu Vaší práce? ', '', 0, 1, 1, 0, '2009-01-02 14:43:48', '2009-01-02 14:43:48'),
(100, 0, 'Využili by jste dostupnější přehledné nabídky existujících programů na posílení motivace a týmové spolupráce pedagogů na školách?', '', 0, 1, 1, 0, '2009-01-02 14:43:57', '2009-01-02 14:43:57'),
(101, 0, 'Ocenili by jste celorepublikový registr neziskových organizací, které se zabývají stejným tématem jako Vy v zájmu možností vzájemné spolupráce a inspirace?', '', 0, 1, 1, 0, '2009-01-02 14:44:12', '2009-01-02 14:44:12'),
(102, 0, 'Ocenili by jste na portálu sekci, v níž by zejména ústavní zařízení typu DD a VÚ mohla inzerovat svou poptávku po specifických službách, které poskytujete?', '', 0, 1, 1, 0, '2009-01-02 14:44:32', '2009-01-02 14:44:32'),
(103, 0, 'Uvítali by jste na zastřešujícím portálu centrální registr všech odborných pracovišť a programů pro každý region v ČR, jejichž nabídky můžete využít, spolupracovat s nimi a svou výchovně vzdělávací práci tak obohatit? A to s referencemi.', '', 0, 1, 1, 0, '2009-01-02 14:44:43', '2009-01-02 14:44:43'),
(104, 0, 'Uvítali by jste na portálu prostor, určený pro inzerci specifické poptávky ústavních zařízení náhradní výchovy (DÚM, DD, VÚ) po službách, které nabízíte?', '', 0, 1, 1, 0, '2009-01-02 14:44:52', '2009-01-02 14:44:52'),
(105, 0, 'Mohla by pro Vás být přínosem ucelená databáze neziskových organizací v ČR, kategorizovaná podle zaměření činnosti?', '', 0, 1, 1, 0, '2009-01-02 14:45:03', '2009-01-02 14:45:03'),
(106, 0, 'Název Vaší organizace?', '', 0, 1, 1, 0, '2009-01-02 14:45:12', '2009-01-02 14:45:12'),
(107, 0, 'Jste ve své činnosti zaměření na cílovou skupinu ohrožených a rizikových dětí a mládeže?', '', 0, 1, 1, 0, '2009-01-02 14:45:24', '2009-01-02 14:45:24'),
(108, 0, 'Jak staré máte dítě nebo děti?', '', 0, 1, 1, 0, '2009-01-02 14:45:39', '2009-01-02 14:45:39'),
(109, 0, 'Ocenili by jste své ústavní webové stránky v grafickém formátu obdobném jako je www.dum-brno.cz?', '', 0, 1, 1, 0, '2009-01-02 14:45:49', '2009-01-02 14:45:49'),
(110, 0, 'Chtěli by jste své ústavní webové stránky v obdobném rozsahu a obsahu jako www.dum-brno.cz ? V textovém poli uveďte Vaše specifické náměty nebo požadavky.', '', 0, 1, 1, 0, '2009-01-02 14:45:58', '2009-01-02 14:45:58');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Administrator'),
(10, 'Moderator'),
(11, 'Supplier'),
(12, 'Editor');

-- --------------------------------------------------------

--
-- Table structure for table `roles_users`
--

CREATE TABLE IF NOT EXISTS `roles_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `roles_users`
--

INSERT INTO `roles_users` (`role_id`, `user_id`) VALUES
(1, 1),
(7, 1),
(10, 1),
(12, 1),
(11, 1),
(12, 36),
(1, 36);

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20081029211224'),
('20081101182950'),
('20081101183848'),
('20081101184034'),
('20081129140251');

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `key_word` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`, `key_word`) VALUES
(6, 'Pro sociální pracovníky(ice)', ''),
(5, 'Pro učitele(lky)', ''),
(7, 'Pro rodiče', ''),
(8, 'Pro neziskové organizace', ''),
(9, 'Pro děti žijící mimo rodinu', ''),
(10, 'Pro odborníky v ústavní a ochranné výchově', ''),
(11, 'Pro děti a dospívající mimo ústavní výchovu', ''),
(12, 'Pro akademická pracoviště', ''),
(13, 'Pro ostatní', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(64) character set utf8 collate utf8_unicode_ci NOT NULL,
  `email` varchar(128) character set utf8 collate utf8_unicode_ci NOT NULL,
  `hashed_password` varchar(64) character set utf8 collate utf8_unicode_ci default NULL,
  `enabled` tinyint(1) NOT NULL default '1',
  `profile` text character set utf8 collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `last_login_at` datetime default NULL,
  `posts_count` int(11) default '0',
  `name` varchar(100) character set utf8 collate utf8_unicode_ci default NULL,
  `phone` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `address` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `city` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `postcode` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `country` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `ic` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `dic` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_email` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_phone` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_fax` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_address` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_city` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_postcode` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `company_country` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `code` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `pw_reset_code` varchar(40) character set utf8 collate utf8_unicode_ci default NULL,
  `last_activity` varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  `last_activity_at` datetime default NULL,
  `inhomeservice_id` int(11) default NULL,
  `orders_count` int(11) default '1',
  `orders_total` float default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_users_on_username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=46 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `hashed_password`, `enabled`, `profile`, `created_at`, `updated_at`, `last_login_at`, `posts_count`, `name`, `phone`, `address`, `city`, `postcode`, `country`, `company`, `ic`, `dic`, `company_email`, `company_phone`, `company_fax`, `company_address`, `company_city`, `company_postcode`, `company_country`, `code`, `pw_reset_code`, `last_activity`, `last_activity_at`, `inhomeservice_id`, `orders_count`, `orders_total`) VALUES
(1, 'Admin', 'admin@insystem.cz', 'c1c224b03cd9bc7b6a86d77f5dace40191766c485cd55dc48caf9ac873335d6f', 1, 'site administrator', '2007-12-05 15:17:38', '2008-07-25 15:26:38', NULL, 11, 'name22333', '3333333', 'address2233', 'city', 'postcode', 'Czech Republic', 'company', '2342314', '2342314', 'emailfirma@fjkl.jkl', '32423', '42342', 'addres22222222', 'city sidlo', '32423', 'Czech Republic', NULL, NULL, 'Posted in the forum', '2008-07-16 17:02:37', 2, 13, 18010.5),
(36, 'kurdiovskydum@volny.cz', 'kurdiovskydum@volny.cz', '24aa6fff59beec3695dd3d63dc7471b225fe891cbff608377fbc061e1dd5c02e', 1, 'kurdiovskydum@volny.cz', '2008-12-07 17:57:45', '2008-12-07 17:57:45', NULL, 0, 'Eda Kurdiovský', '723915210', 'Adresa 12', 'Brno', '60200', 'Česká republika', '', '', '', '', '', '', '', '', '', 'Česká republika', NULL, NULL, NULL, NULL, NULL, 1, NULL);
