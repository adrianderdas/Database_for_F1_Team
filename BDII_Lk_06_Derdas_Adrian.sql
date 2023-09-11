
CLEAR SCREEN;
--
set linesize 250;
set pagesize 200;
--
show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

--------------------------------
--  SEQUENCE w1_SEQ1
--------------------------------
DROP SEQUENCE w1_SEQ1;

CREATE SEQUENCE w1_SEQ1
	INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
	
--------------------------------
--  SEQUENCE w2_SEQ1
--------------------------------
DROP SEQUENCE w2_SEQ1;

CREATE SEQUENCE w2_SEQ1
	INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

	
-- ---------------------------------------------------------------------- --
-- ----------------------#            		      #---------------------- --
-- ----------------------# 		 GENERATORY       #---------------------- --
-- ----------------------#                        #---------------------- --
-- ---------------------------------------------------------------------- --
 
--------------------------------
--  PAKIETY PKG_GENERATOR -- API
--------------------------------
CREATE or REPLACE PACKAGE PKG_GENERATOR
IS
	-- Generuje ucznia, kierunek oraz dane do tabel stopien pierwszy i stopien drugi
	PROCEDURE pGENERATOR_w1_BOL_SER(ile IN NUMBER);
	
	-- Generuje dane do tabel: plan zajec, grupa studencka i semestr
	PROCEDURE pGENERATOR_w2_BOL_SER(ile IN NUMBER);

	type Tvarchar is varray(256) of varchar2(255);
	
	
END PKG_GENERATOR;
/ 


--------------------------------
 --  PAKIETY PKG_GENERATOR -- BODY
--------------------------------
CREATE or REPLACE PACKAGE BODY PKG_GENERATOR
IS

	PROCEDURE pGENERATOR_w1_BOL_SER(ile IN number)
	IS

		type Tvarchar is varray(256) of varchar2(255);
		--
		lista_miasta Tvarchar := Tvarchar('Warszawa','Krakow','Lodz','Wroclaw','Poznan','Gdansk','Szczecin',
											'Bydgoszcz','Lublin','Bialystok','Katowice','Gdynia','Czestochowa','Radom','Torun','Sosnowiec',
											'Rzeszow','Kielce','Gliwice','Olsztyn','Zabrze','Bielsko-Biala','Bytom','Zielona Gora','Rybnik',
											'Ruda slaska','Opole','Tychy','Gorzow Wielkopolski','Elblag','Dabrowa Gornicza','Plock','Walbrzych',
											'Wloclawek','Tarnow','Chorzow','Koszalin','Kalisz','Legnica','Grudziadz','Jaworzno','Slupsk',
											'Lubin','Ostrow Wielkopolski','Suwalki','Stargard','Gniezno','Ostrowiec swietokrzyski','Siemianowice slaskie',
											'Glogow','Pabianice','Leszno','Zory','Zamosc','Pruszkow','Lomza');
	
		lista_marka Tvarchar := Tvarchar('Audi','BMW','Citroen','Dacia','Fiat','Ford','Hyundai','Kia','Mercedes','Nissan','Opel','Peugeot','Renault','SEAT',
											'Skoda','Toyota','Volkswagen','Volvo','Abarth','Alfa Romeo','Alpina','Alpine','Bentley','Cupra',
											'Dodge','DS','Ferrari','Fuso','Honda','Isuzu','Iveco','Jaguar','Jeep','Land Rover','LEVC',
											'Lexus','MAN','Maserati','Mazda','McLaren','MINI','Mitsubishi','Porsche','RAM',
											'Smart','SsangYong','Subaru','Suzuki','Tesla');
	
		lista_typ_baterii Tvarchar := Tvarchar('litowo-jonowe (Li-Ion)','litowo-niklowo-kobaltowo-manganowe (NMC)','litowo-niklowo-kobaltowo-aluminiowe (NCA)',
											'litowo-żelazowo-fosforanowe (LFP)','litowo-manganowe (LMO)');
	
		
		lista_zasieg Tvarchar := Tvarchar('338 / 437','213 / 330','180 / 321','440 / 610','305 / 484','289 / 455','276 / 452','270 / 385',
											'231 / 329','408 / 464','316 / 395','340 / 390 / 510','430 / 567','351 / 426 / 549');
		--
		--
		index_miasta number;
		index_marka number;
		index_typ_baterii number;
		index_zasieg number;
		--
		vMIASTA w1_SERWIS.SER_MIASTO%TYPE;
		vMARKA w1_BOLIDY_SPALINOWE.BSP_MARKA%TYPE;
		vTYP_BATERII w1_BOLIDY_ELEKTRYCZNE.BEL_TYP_BATERII%TYPE;
		vZASIEG w1_BOLIDY_ELEKTRYCZNE.BEL_ZASIEG%TYPE;
		vPOJEMNOSC_SILNIKA w1_BOLIDY_SPALINOWE.BSP_POJEMNOSC_SILNIKA%TYPE;
		vMOC w1_BOLIDY_SPALINOWE.BSP_MOC_SILNIKA%TYPE;
		vPRO_NAZWA w1_PRODUCENCI.PRO_NAZWA%TYPE;
		vPOD_NAZWA w1_PODZESPOLY.POD_NAZWA%TYPE;
		vROK_ZAL w1_PRODUCENCI.PRO_ROK_ZAL%TYPE;
		--
		vN Number;
		--
		BSP_ID_curr w1_BOLIDY_SPALINOWE.BSP_ID%TYPE
		BEL_ID_curr w1_BOLIDY_ELEKTRYCZNE.BEL_ID%TYPE
		CCC_ID_curr w1_CCC_BOL_SER.CCC_ID%TYPE
		SER_ID_curr w1_SERWIS.SER_ID%TYPE
		PRO_ID_curr w1_PRODUCENCI.PRO_ID%TYPE
		POD_ID_curr w1_PODZESPOLY.POD_ID%TYPE
		--
		--
		BEGIN
		DBMS_RANDOM.INITIALIZE(123456);

		FOR VAR_I IN 1 .. ILE
		LOOP
		
			index_miasta := PKG_RANDOM.F_RANDOM_NUMBER(1,lista_miasta.COUNT); 
			index_marka := PKG_RANDOM.F_RANDOM_NUMBER(1,lista_marka.COUNT); 
			index_typ_baterii := PKG_RANDOM.F_RANDOM_NUMBER(1,lista_typ_baterii.COUNT); 
			index_zasieg := PKG_RANDOM.F_RANDOM_NUMBER(1,lista_zasieg.COUNT); 
			
			vMIASTA := lista_miasta(index_miasta);
			vMARKA := lista_marka(index_marka);
			vTYP_BATERII := lista_typ_baterii(index_typ_baterii);
			vZASIEG := lista_zasieg(index_zasieg);
			vPOJEMNOSC_SILNIKA := to_char(PKG_RANDOM.F_RANDOM_NUMBER(100,200))||' KM';
			vMOC := to_char(PKG_RANDOM.F_RANDOM_NUMBER(1,6));
			vPRO_NAZWA := PKG_RANDOM.F_RANDOM_VARCHAR2(10)||to_char(w1_SEQ1.nextval);
			vPOD_NAZWA := PKG_RANDOM.F_RANDOM_VARCHAR2(10)||to_char(w1_SEQ1.nextval);
			vROK_ZAL := PKG_RANDOM.F_RANDOM_NUMBER(1950,2020);
			--
			vN := PKG_RANDOM.F_BERNOULLI;
			--
			--
			
			INSERT INTO w1_SERWIS(SER_MIASTO) VALUES (vMIASTA)
			RETURNING SER_Id INTO SER_Id_curr;
			
			IF SQL%FOUND AND vN = 0 THEN
				INSERT INTO W1_BOLIDY_ELEKTRYCZNE(BEL_MARKA,BEL_TYP_BATERII,BEL_ZASIEG)
				VALUES (vMARKA,vTYP_BATERII,vZASIEG)
				RETURNING BEL_ID INTO BEL_ID_curr;
				
				IF SQL%FOUND THEN 
					INSERT INTO W1_CCC_BOL_SER(SER_ID,BSP_ID)
					VALUES (SER_Id_curr,BEL_ID_curr); 	
					
				COMMIT;
				
				END IF;
				
			ELSE IF SQL%FOUND AND vN = 1 THEN
				INSERT INTO W1_BOLIDY_SPALINOWE(BSP_MARKA,BSP_POJEMNOSC_SILNIKA,BSP_MOC_SILNIKA)
				VALUES (vMARKA,vPOJEMNOSC_SILNIKA,vMOC)
				RETURNING BSP_ID INTO BSP_ID_curr;
				
				IF SQL%FOUND THEN 
					INSERT INTO W1_CCC_BOL_SER(SER_ID,BSP_ID)
					VALUES (SER_Id_curr,BSP_ID_curr); 	
					
				COMMIT;
				
				END IF;
				
				INSERT INTO W1_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,PRO_KRAJ)
				VALUES (vPRO_NAZWA,vROK_ZAL,'Polska')
				RETURNING PRO_ID INTO PRO_ID_curr;
				
				IF SQL%FOUND THEN
					INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA)
					VALUES (PRO_Id_curr,SER_Id_curr,vPOD_NAZWA);
					
					COMMIT;
				
				END IF;
				
		
			END IF;
			END IF;
			
			
		
		END LOOP;
		--
		--
	EXCEPTION
		WHEN VALUE_ERROR THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w1_BOL_SER: EXCEPTION VALUE_ERROR');		
			ROLLBACK; 
		WHEN INVALID_NUMBER THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w1_BOL_SER: EXCEPTION INVALID_NUMBER');		
			ROLLBACK; 
		WHEN OTHERS THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w1_BOL_SER: '||SQLERRM);	
			ROLLBACK; 	
	END;
	
	
	
	PROCEDURE pGENERATOR_w2_BOL_SER(ile IN number)
	IS

		type Tvarchar is varray(256) of varchar2(255);
		--
		lista_miasta Tvarchar := Tvarchar('Warszawa','Krakow','Lodz','Wroclaw','Poznan','Gdansk','Szczecin',
											'Bydgoszcz','Lublin','Bialystok','Katowice','Gdynia','Czestochowa','Radom','Torun','Sosnowiec',
											'Rzeszow','Kielce','Gliwice','Olsztyn','Zabrze','Bielsko-Biala','Bytom','Zielona Gora','Rybnik',
											'Ruda slaska','Opole','Tychy','Gorzow Wielkopolski','Elblag','Dabrowa Gornicza','Plock','Walbrzych',
											'Wloclawek','Tarnow','Chorzow','Koszalin','Kalisz','Legnica','Grudziadz','Jaworzno','Slupsk',
											'Lubin','Ostrow Wielkopolski','Suwalki','Stargard','Gniezno','Ostrowiec swietokrzyski','Siemianowice slaskie',
											'Glogow','Pabianice','Leszno','Zory','Zamosc','Pruszkow','Lomza');
	
		lista_marka Tvarchar := Tvarchar('Audi','BMW','Citroen','Dacia','Fiat','Ford','Hyundai','Kia','Mercedes','Nissan','Opel','Peugeot','Renault','SEAT',
											'Skoda','Toyota','Volkswagen','Volvo','Abarth','Alfa Romeo','Alpina','Alpine','Bentley','Cupra',
											'Dodge','DS','Ferrari','Fuso','Honda','Isuzu','Iveco','Jaguar','Jeep','Land Rover','LEVC',
											'Lexus','MAN','Maserati','Mazda','McLaren','MINI','Mitsubishi','Porsche','RAM',
											'Smart','SsangYong','Subaru','Suzuki','Tesla');
	
		lista_typ_baterii Tvarchar := Tvarchar('litowo-jonowe (Li-Ion)','litowo-niklowo-kobaltowo-manganowe (NMC)','litowo-niklowo-kobaltowo-aluminiowe (NCA)',
											'litowo-żelazowo-fosforanowe (LFP)','litowo-manganowe (LMO)');
	
		
		lista_zasieg Tvarchar := Tvarchar('338 / 437','213 / 330','180 / 321','440 / 610','305 / 484','289 / 455','276 / 452','270 / 385',
											'231 / 329','408 / 464','316 / 395','340 / 390 / 510','430 / 567','351 / 426 / 549');
		--
		--
		index_miasta number;
		index_marka number;
		index_typ_baterii number;
		index_zasieg number;
		--
		vMIASTA w2_SERWIS.SER_MIASTO%TYPE;
		vMARKA w2_BOLIDY.BOL_MARKA%TYPE;
		vTYP_BATERII w2_BOLIDY.BOL_TYP_BATERII%TYPE;
		vZASIEG w2_BOLIDY.BOL_ZASIEG%TYPE;
		vPOJEMNOSC_SILNIKA w2_BOLIDY.BOL_POJEMNOSC_SILNIKA%TYPE;
		vMOC w2_BOLIDY.BOL_MOC_SILNIKA%TYPE;
		vPRO_NAZWA w2_PRODUCENCI.PRO_NAZWA%TYPE;
		vPOD_NAZWA w2_PODZESPOLY.POD_NAZWA%TYPE;
		vROK_ZAL w2_PRODUCENCI.PRO_ROK_ZAL%TYPE;
		--
		vN Number;
		--
		BOL_ID_curr w2_BOLIDY.BOL_ID%TYPE
		CCC_ID_curr w2_CCC_BOL_SER.CCC_ID%TYPE
		SER_ID_curr w2_SERWIS.SER_ID%TYPE
		PRO_ID_curr w2_PRODUCENCI.PRO_ID%TYPE
		POD_ID_curr w2_PODZESPOLY.POD_ID%TYPE
		--
		--
		BEGIN
		DBMS_RANDOM.INITIALIZE(123456);

		FOR VAR_I IN 1 .. ILE
		LOOP
		
			index_miasta := round(PKG_RANDOM.F_RANDOM_NUMBER(1,lista_miasta.COUNT)); 
			index_marka := round(PKG_RANDOM.F_RANDOM_NUMBER(1,lista_marka.COUNT)); 
			index_typ_baterii := round(PKG_RANDOM.F_RANDOM_NUMBER(1,lista_typ_baterii.COUNT)); 
			index_zasieg := round(PKG_RANDOM.F_RANDOM_NUMBER(1,lista_zasieg.COUNT)); 
			
			vMIASTA := lista_miasta(index_miasta);
			vMARKA := lista_marka(index_marka);
			vTYP_BATERII := lista_typ_baterii(index_typ_baterii);
			vZASIEG := lista_zasieg(index_zasieg);
			vPOJEMNOSC_SILNIKA := to_char(PKG_RANDOM.F_RANDOM_NUMBER(100,200))||' KM';
			vMOC := to_char(PKG_RANDOM.F_RANDOM_NUMBER(1,6));
			vPRO_NAZWA := PKG_RANDOM.F_RANDOM_VARCHAR2(10)||to_char(w2_SEQ1.nextval);
			vPOD_NAZWA := PKG_RANDOM.F_RANDOM_VARCHAR2(10)||to_char(w2_SEQ1.nextval);
			vROK_ZAL := PKG_RANDOM.F_RANDOM_NUMBER(1950,2020);
			--
			vN := PKG_RANDO.F_BERNOULLI;
			--
			--
			
			INSERT INTO w2_SERWIS(SER_MIASTO) VALUES (vMIASTA)
			RETURNING SER_Id INTO SER_Id_curr;
			
			IF SQL%FOUND AND vN = 0 THEN
				INSERT INTO W2_BOLIDY(BOL_MARKA,BOL_TYP_BATERII,BOL_ZASIEG)
				VALUES (vMARKA,vTYP_BATERII,vZASIEG)
				RETURNING BOL_ID INTO BOL_ID_curr;
				
				IF SQL%FOUND THEN 
					INSERT INTO W2_CCC_BOL_SER(SER_ID,BSP_ID)
					VALUES (SER_Id_curr,BOL_ID_curr); 	
					
				COMMIT;
				
				END IF;
				
			ELSE IF SQL%FOUND AND vN = 1 THEN
				INSERT INTO w2_BOLIDY(BOL_MARKA,BOL_POJEMNOSC_SILNIKA,BOL_MOC_SILNIKA)
				VALUES (vMARKA,vPOJEMNOSC_SILNIKA,vMOC)
				RETURNING BOL_ID INTO BOL_ID_curr;
				
				IF SQL%FOUND THEN 
					INSERT INTO W2_CCC_BOL_SER(SER_ID,BSP_ID)
					VALUES (SER_Id_curr,BOL_ID_curr); 	
					
				COMMIT;
				
				END IF;
				
				INSERT INTO w2_BOLIDY(BOL_MARKA,BOL_TYP_BATERII,BOL_ZASIEG)
				VALUES (vPRO_NAZWA,vROK_ZAL,'Polska')
				RETURNING PRO_ID INTO PRO_ID_curr;
				
				IF SQL%FOUND AND vN = 1 THEN
					INSERT INTO w2_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA)
					VALUES (PRO_Id_curr,SER_Id_curr,vPOD_NAZWA);
					
					COMMIT;
				
				END IF;
			END IF;
			END IF;		
		END LOOP;
		--
		--
	EXCEPTION
		WHEN VALUE_ERROR THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w2_BOL_SER: EXCEPTION VALUE_ERROR');		
			ROLLBACK; 
		WHEN INVALID_NUMBER THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w2_BOL_SER: EXCEPTION INVALID_NUMBER');		
			ROLLBACK; 
		WHEN OTHERS THEN
			dbms_output.put_line(chr(10)||'pGENERATOR_w2_BOL_SER: '||SQLERRM);	
			ROLLBACK; 	
	END;
	
		

END PKG_GENERATOR;
/


