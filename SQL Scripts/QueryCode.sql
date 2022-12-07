-- Show all tables and explain how they are related to one another


-- basic retrieval query: for the title, origin, and epoch of the art objects that are from permament collections
SELECT ARTOBJECT.Title, ARTOBJECT.Origin, ARTOBJECT.Epoch FROM ARTOBJECT, PERMANENT WHERE PERMANENT.IDNum=ARTOBJECT.IDNum;

-- a retrieval query with ordered results: for the title and year of creation for all borrowed objects ordered in descending order
SELECT Title, CreationYear, Origin FROM ARTOBJECT, BORROWED WHERE ARTOBJECT.IDNum=BORROWED.IDNum ORDER BY CreationYear DESC;

-- a nested retrieval query: for the origin and epoch of all the distinctly different exhibition names in the database
SELECT DISTINCT Origin, Epoch FROM ARTOBJECT WHERE IDNum IN (SELECT ObjectIDNum FROM DISPLAYS WHERE ExbnName = 'The Tudors: Art and Majesty in Renaissance England' OR ExbnName = "Cubism and the Trompe l'Oeil Tradition"  OR ExbnName = 'Lives of the Gods: Divinity in Maya Art' OR ExbnName='Hear me Now: the Black Potters of Old Edgefield, South Carolina' OR ExbnName='Chroma: Ancient Sculpture in Color');

-- a retrieval query using joined tables: for the IDNumber, Contact Person, and Type of Collection of all borrowed collections
SELECT BORROWED.IDNum as 'ID Number', COLLECTION.ContactPerson as 'Name of Contact', COLLECTION.CollectionType as "Type of collection"FROM BORROWED LEFT OUTER JOIN COLLECTION ON COLLECTION.CollectionName = BORROWED.CollectionName;

-- An update operation with any necessary triggers

-- A deletion operation with any necessary triggers

