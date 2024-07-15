CREATE TABLE `postagem` (
   `idPostagem` int(1000) NOT NULL AUTO_INCREMENT,
   `idUsuarioPostagem` int NOT NULL,
   `textoPostagem` varchar(10000) NOT NULL,
   `arquivoPostagem1` varchar(300),
   `arquivoPostagem2` varchar(300),
   `arquivoPostagem3` varchar(300),
   `arquivoPostagem4` varchar(300),
   `ativo` int(11),
   PRIMARY KEY (`idPostagem`)
   
 );
 
