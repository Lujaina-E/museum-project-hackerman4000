DROP DATABASE IF EXISTS ARTMUSEUM;
CREATE DATABASE ARTMUSEUM; 
USE ARTMUSEUM;

DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST (
	ArtistName		varchar(35) not null,
	DateBorn		varchar(10) not null,
	DateDied		varchar(10),
	OriginCountry	varchar(20),
    Epoch			varchar(30),  
    ArtistDescr 	varchar(300) not null,
    MainStyle		varchar(35) not null,
	primary key (ArtistName) 
);

INSERT INTO ARTIST(ArtistName, DateBorn, DateDied, OriginCountry, Epoch, ArtistDescr, MainStyle)
VALUES
('Hans Holbein', '1497','1543','Germany','Renaissance','He is considered one of the greatest portraitists of the 16th century. He also produced religious art and satire.','portrait'),
('Quentin Metsys the Younger', '1543','1589','England','Ornate Baroque','One of several of his countrymen active as artists of the Tudor court in the reign of Elizabeth I of England.','portraits'),
('Lunéville','unknown','unknown','France','Renaissance','Local artists in this region producedart that would later get donated','scenic'),
('District Pottery', 'unknown', 'unknown','France','Renaissance','a district in which an office was set up to display pottery projects', 'pottery'),
('John Hallo' ,'unknown','unknown','Roman','Greek/Roman','unknown','Roman/Greek'),
('Pompolous', 'unknown','unknown','Greece','Greek/Roman','Details about this artist are very scarce. He was a servant of the state.','Roman/Greek'),
('Mexican Artist','unknown','unknown','unknown','unknown','unknown','unknown'),
('Remedios Varo','12/16/1908','10/08/1963','Spain','Eclectic Modern','María de los Remedios Alicia Rodriga Varo y Uranga was a Spanish-born Mexican surrealist artist','Surreal Art'),
('Paolo Caliari','1528','04/19/1588','Italy','Renaissance','Known as Paolo Veronese, he was an Italian Renaissance painter based in Venice, known for extremely large history paintings of religion and mythology.','Portrait'),
('Jakob Blanck', '11/10/1906','12/23/1974','USA','Eclectic',"Jacob Nathaniel Blanck was an American bibliographer, editor, and children's writer.",'modern'),
('Faeq Hassan','1914','01/11/1992','Iraq','contemporary','An iraqi painter noted for founding several art groups.','iraqi modern'),
('Guillaume Ier','03/22/1797', '03/09/1988','Germany','Eclectic', 'He was a student under the german school in the 19th century.', 'Modern'),
('School of France','unknown', 'unknown','France',NULL,'Students in the school who trained with the arts.','classical'),
('pharaonic servants','unknown','unknown','Egypt','Egyptian','Servants of the state carved and built statues,','war-oriented');



DROP TABLE IF EXISTS ARTOBJECT;
CREATE TABLE ARTOBJECT (
	IDNum			integer	not null,
	Epoch			varchar(20),     
	Origin			varchar(15),
    CreationYear	varchar(15),
    Title 			varchar(45),
    ItemDescription	varchar(400),
    ArtType			varchar(15),
    Style 			varchar(15),
    Material		varchar(15),
    Height			integer,  -- cm
    Weight			integer, -- pounds
    DrawnOn			varchar(15), 
    PaintType		varchar(15),
    ArtistName		varchar(35),
    OtherType		varchar(20),
	primary key(IDNum),
	foreign key (ArtistName) references ARTIST(ArtistName)    
);

INSERT INTO ARTOBJECT(IDNum, Epoch, Origin, CreationYear, Title, ItemDescription, ArtType, Style, Material, Height, Weight, DrawnOn, PaintType, ArtistName, OtherType)
VALUES
('29746','Renaissance','England','1537','Henry VIII','It is one of the most iconic images of Henry and is one of the most famous portraits of any English or British monarch.','Painting','Portrait',NULL,NULL,NULL,'panel','oil','Hans Holbein', NULL),
('21111', 'Renaissance', 'England', '1583', 'Elizabeth I ("The Sieve Portrait")', 'They depict Elizabeth carrying a sieve, thus associating her with the Roman Vestal Virgin, Tuccia. The sieve is also an emblem of wisdom and discernment.', 'Painting', 'Portrait', NULL, NULL, NULL, 'canvas', 'oil', 'Quentin Metsys the Younger', NULL),
('70082','Spanish Colonial', 'Cuba', '1760', 'Tray', 'The trompe l’oeil motif of a print attached to wood planking by nails or sealing wax became so popular that during the second half of the eighteenth century many factories imitated it on tableware.', 'Other', 'Utility',NULL, NULL, NULL, NULL, NULL, 'Lunéville', 'Earthenware'),
('41292','American Colonial', 'USA', '1860', 'Face Jug', 'A face jug is a jug pottery that depicts a face.', 'Other', 'Utility', NULL, NULL, NULL, NULL, NULL, 'District Pottery', 'Drinkware'),
('99209','Archaic', 'Greece', '2600 BCE', 'Marble Head', 'This head provides the clearest evidence of painted decoration among the Museum’s collection of Cycladic sculptures.', 'Sculpture', 'honorary', 'marble', '7', '1', NULL, NULL, 'John Hallo' ,NULL),
('99998','Greek', 'Greece', '775 BCE', 'Bronze Head', 'Large inlaid eyes enhanced the appearance of this griffin head, a decorative attachments for a cauldron dedicated to Olympia.', 'Sculpture','Bronzes', 'Bronze', '26', '1', NULL, NULL, 'Pompolous', NULL),
('56744','Mayan', 'Mexico','800','Pendant','The objects’ imagery reflected the identity and status of the wearer, often linking that person with divine power.','Statue','Jewelry','Jade','8','2',NULL, NULL,'Mexican Artist',NULL),
('56733','Mayan','Mexico','680','Deity Figure','It portrays the patron god of Pax, one of the months of the Maya calendar.','Statue','Figure','Jade','9','3',NULL,NULL,'Remedios Varo',NULL),
-- insert borrowed below
('92866','Renaissance','France','1550','Les Noces de Cana','Pour le réfectoire des bénédictins de San Giorgio Maggiore à Venise ; prélevé en 1797 ; transporté au Louvre en 1798.','Painting','Scene',NULL,NULL,NULL,'canvas','oil','Paolo Caliari',NULL),
('11938','Renaissance','France','1675','Coffee Box','An openwork coffee box composed of 5 panels with large decorations.','Other','Utilities',NULL, NULL, NULL, NULL, NULL, 'Jakob Blanck', 'Box'),
('53920','Arab','Iraq','1064','Stele','Inscribed stele whose top is decorated with a sculpted relief.','Other','Broken Figure',NULL,NULL,NULL,NULL,NULL,'Faeq Hassan','Antique'),
('92511','Renaissance','France','1802','Restrained Horse','A horse restrained by a groom.','Sculpture','Scenic','Marble','156','5000',NULL,NULL,'Guillaume Ier',NULL),
('38529','Renaissance','France','1972','The Cheating Ace',NULL,'Painting','Scenic',NULL,NULL,NULL,'canvas','oil','School of France',NULL),
('77092','Pharaonic','Egypt',NULL,'Sphinx of Tanis','royal sphinx (lying, nemes hairstyle, uraeus, straight false beard)','Statue','Figure','Limestone','240','5550',NULL,NULL,'pharaonic servants',NULL);


DROP TABLE IF EXISTS PERMANENT;
CREATE TABLE PERMANENT (
	IDNum 			integer not null,
	ItemStatus		varchar(10) not null,
	ItemCost		integer not null,  -- in dollars
	DateAcquired	varchar(10),
	primary key (IDNum), 
	foreign key (IDNum) references ARTOBJECT(IDNum)
);

INSERT INTO PERMANENT(IDNum, ItemStatus, ItemCost, DateAcquired)
VALUES
('29746','display','30000','01/01/2000'),
('21111', 'archive', '1500', '12/11/2005'),
('70082','display', '740','08/11/2005'),
('41292','archive', '1000','08/11/2001'),
('99209','display', '999', '12/05/2005'),
('99998','display', '472', '12/11/2005'),
('56744','archive', '9222','12/11/2005'),
('56733','display','6295','09/12/1998');

DROP TABLE IF EXISTS COLLECTION;
CREATE TABLE COLLECTION (
	CollectionName	varchar(30) not null,
	CollectionType	varchar(15) not null,
	ClctDescription varchar(400),
	Address			varchar(60) not null,
    Phone			bigint,  -- is syntax for this correct or not?
    ContactPerson	varchar(20) not null,
	primary key (CollectionName)
);

INSERT INTO COLLECTION(CollectionName, CollectionType, ClctDescription, Address, Phone, ContactPerson)
VALUES
('Insights to the French','Historical', 'Take a dive into the renaissance history through a selection of french pieces.', '6 rue de Fürstenberg, 75006 Paris', '8359296', 'Alexander Sway'), 
('Around the World','Historical', NULL, '6 rue de Fürstenberg, 75006 Paris','8359296', 'John Smith'),
('Ancient Egypt Now','Historical', NULL,'6 rue de Fürstenberg, 75006 Paris','8359296','Iola Madd'),
('Mayan History','Historical', NULL,'6 rue de Fürstenberg, 75006 Paris','8359296','Madilyn Hauss');

DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED (
	IDNum			integer not null,
	DateBorrowed	varchar(10) not null,
	DateReturned	varchar(10),
	CollectionName	varchar(30),
	primary key (IDNum),
	foreign key (IDNum) references ARTOBJECT(IDNum), 
    foreign key (CollectionName) references COLLECTION(CollectionName)
);

INSERT INTO BORROWED(IDNum, DateBorrowed, DateReturned, CollectionName)
VALUES
('92866','01/01/2000','09/01/2000','Insights to the French'),
('11938','01/01/2020','01/31/2022','Insights to the French'),
('53920','01/01/2022',NULL,'Around the World'),
('92511','12/01/2021','12/30/2022','Insights to the French'),
('38529','06/23/2005',NULL,'Insights to the French'),
('77092','08/01/2004','01/01/2006','Ancient Egypt Now');


DROP TABLE IF EXISTS EXHIBITION;
CREATE TABLE EXHIBITION (
	ExbnName		varchar(100) not null,
	StartDate		varchar(10) not null,
	EndDate			varchar(10),
	primary key (ExbnName)
);

INSERT INTO EXHIBITION(ExbnName, StartDate, EndDate)
VALUES
('The Tudors: Art and Majesty in Renaissance England','10/10/2022','01/08/2023'),
("Cubism and the Trompe l'Oeil Tradition",'10/20/2022','01/23/2023'),
('Hear me Now: the Black Potters of Old Edgefield, South Carolina','09/09/2022','02/05/2023'),
('Chroma: Ancient Sculpture in Color','07/05/2022','03/26/2023'),
('Lives of the Gods: Divinity in Maya Art','11/21/2022','04/2/2023');


DROP TABLE IF EXISTS DISPLAYS;
CREATE TABLE DISPLAYS (
	ObjectIDNum		integer not null,
	ExbnName		varchar(100) not null,
	primary key (ObjectIDNum), 
	foreign key (ObjectIDNum) references ARTOBJECT(IDNum), 
	foreign key (ExbnName) references EXHIBITION(ExbnName)
    
);

INSERT INTO DISPLAYS(ObjectIDNum, ExbnName)
VALUES
('29746', 'The Tudors: Art and Majesty in Renaissance England'),
('21111', 'The Tudors: Art and Majesty in Renaissance England'),
('70082',"Cubism and the Trompe l'Oeil Tradition"),
('41292','Hear me Now: the Black Potters of Old Edgefield, South Carolina'),
('99209','Chroma: Ancient Sculpture in Color'),
('99998','Chroma: Ancient Sculpture in Color'),
('56744','Lives of the Gods: Divinity in Maya Art'),
('56733','Lives of the Gods: Divinity in Maya Art');
