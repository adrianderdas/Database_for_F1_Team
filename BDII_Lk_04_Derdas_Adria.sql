

CLEAR SCREEN;
--

SET LINESIZE 450;
SET PAGESIZE 300;

-- Nagrywanie konunikatów z buforu ekranowego do pliku
SPOOL "C:\Users\Adrian\Desktop\SQL_TEST\BDII_Lk_03_Derdas_Adrian_1.out.txt"

show user;


SET SERVEROUTPUT ON;

alter session set 
	nls_date_format = 'YYYY-MM-DD';

--
select sysdate from dual;
--

--------------------------------
--  PAKIETY w1_PKG_DML -- API
--------------------------------
CREATE or REPLACE PACKAGE w1_PKG_DML
IS
	PRAGMA SERIALLY_REUSABLE;
	--
	--
	SUBTYPE t_ID IS w1_PODZESPOLY.POD_ID%TYPE;
	--
	SUBTYPE t_SER IS w1_SERWIS%ROWTYPE;
	SUBTYPE t_PRA IS w1_PRACOW_SERW%ROWTYPE;
	SUBTYPE t_PRO IS w1_PRODUCENCI%ROWTYPE;
	SUBTYPE t_POD IS w1_PODZESPOŁY%ROWTYPE;
	--
	--
	TYPE TkolIDs IS VARRAY(3) OF t_ID;
	--
	--
	CURSOR cursorSER(inSER_Id in w1_SERWIS.SER_Id%TYPE) RETURN t_SER;
	--				 
	CURSOR cursorPRA(inPRA_PESEL in w1_PRACOW_SERW.PRA_Pesel%TYPE) RETURN t_PRA;
	--
	CURSOR cursorPRO(inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE) RETURN t_PRO;
	--
	--
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs;
	--
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs;
	--
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Data_zatrudnienia in w1_PRACOW_SERW.PRA_Data_zatrudnienia%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs;
	--
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Data_zatrudnienia in w1_PRACOW_SERW.PRA_Data_zatrudnienia%TYPE,
		inPRA_Umowa in w1_PRACOW_SERW.PRA_Umowa%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs;
	--
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE
	);
	--
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPRO_Kraj in w1_PRODUCENCI.PRO_Kraj%TYPE,
		inPRO_Uwagi in w1_PRODUCENCI.PRO_Uwagi%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	);
	--
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	);
	--
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPRO_Kraj in w1_PRODUCENCI.PRO_Kraj%TYPE,
		inPRO_Uwagi in w1_PRODUCENCI.PRO_Uwagi%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	);
	
END w1_PKG_DML;
/


CREATE or REPLACE PACKAGE BODY w1_PKG_DML
IS
	PRAGMA SERIALLY_REUSABLE;
	--
	--
	CURSOR cursorSER(inSER_Id in w1_SERWIS.SER_Id%TYPE) RETURN t_SER
	IS 
	SELECT * FROM w1_SERWIS
	WHERE inSER_Id = SER_Id;
	--				 
	CURSOR cursorPRA(inPRA_PESEL in w1_PRACOW_SERW.PRA_Pesel%TYPE) RETURN t_PRA
	IS 
	SELECT * FROM w1_PRACOW_SERW
	WHERE inPRA_PESEL = PRA_PESEL;
	--
	CURSOR cursorPRO(inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE) RETURN t_PRO
	IS 
	SELECT * FROM w1_PRODUCENCI
	WHERE inPRO_Nazwa_producenta = PRO_Nazwa_producenta;
	--
	CURSOR cursorPOD(inPRO_Nazwa in w1_PODZESPOŁY.PRO_Nazwa%TYPE) RETURN t_POD
	IS 
	SELECT * FROM w1_PODZESPOŁY
	WHERE inPRO_Nazwa = PRO_Nazwa;
	--
	--
	--------------------------------
	--- FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS
	--- UWAGA! Egzemplarz 1
	--------------------------------
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs
	IS		
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRACOW_SERW t_PRA := NULL;
	--
	BBB_Id_curr t_ID;
	
	BEGIN
		--
		IF NOT cursorSER%ISOPEN THEN
			OPEN cursorSER(inSER_Id);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorSER!');
			--
			LOOP
			FETCH cursorSER INTO SERWIS;
			--
			EXIT WHEN cursorSER%NOTFOUND 
				 or cursorSER%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorSER%ISOPEN THEN 
			CLOSE cursorSER; 
		END IF;
		--
		--
		IF NOT cursorPRA%ISOPEN THEN
			OPEN cursorPRA(inPRA_PESEL);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRA!');
			--
			LOOP
			FETCH cursorPRA INTO PRACOW_SERW;
			--
			EXIT WHEN cursorPRA%NOTFOUND 
				 or cursorPRA%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorPRA%ISOPEN THEN 
			CLOSE cursorPRA; 
		END IF;
		--
		
		IF SERWIS.SER_ID IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('Taki serwis nie istnieje!');
			
			OUT_IDs := TkolIDs(0,0,0);
			ROLLBACK;
			
		ELSE IF SERWIS.SER_ID IS NOT NULL THEN
		
			IF PRACOW_SERW.PRA_ID IS NULL THEN
				DBMS_OUTPUT.PUT_LINE('Taki pracownik nie istnieje!');
				
				OUT_IDs := TkolIDs(0,0,0);
				ROLLBACK;
			
			ELSE IF PRACOW_SERW.PRA_ID IS NOT NULL THEN
				
				INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
				VALUES (SERWIS.SER_ID,PRACOW_SERW.PRA_ID) 
				RETURNING BBB_ID into BBB_Id_curr;
				
				OUT_IDs := TkolIDs(SERWIS.SER_ID,PRACOW_SERW.PRA_ID,BBB_Id_curr);
				COMMIT;
			
			END IF;
			END IF;
		END IF;
		END IF;
	
	RETURN OUT_IDs;
	
	EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w f_W1_INSERT_PRACOWNIK_SERWIS - Egzemplarz 1!');		
		
	END f_W1_INSERT_PRACOWNIK_SERWIS;
	
	--------------------------------
	--- FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS
	--- UWAGA! Egzemplarz 2
	--------------------------------
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs
	IS		
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRACOW_SERW t_PRA := NULL;
	--
	BBB_Id_curr t_ID;
	PRA_Id_curr t_ID;
	SER_Id_curr t_ID;
	--
	BEGIN
		--
		IF NOT cursorPRA%ISOPEN THEN
			OPEN cursorPRA(inPRA_PESEL);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRA!');
			--
			LOOP
			FETCH cursorPRA INTO PRACOW_SERW;
			--
			EXIT WHEN cursorPRA%NOTFOUND 
				 or cursorPRA%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorPRA%ISOPEN THEN 
			CLOSE cursorPRA; 
		END IF;
		--
		--
		INSERT INTO w1_SERWIS(SER_MIASTO,SER_UWAGI)
		VALUES (inSER_MIASTO,inSER_UWAGI)
		RETURNING SER_Id INTO SER_Id_curr;
		
		IF PRACOW_SERW.PRA_ID IS NULL THEN
			
			INSERT INTO w1_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_PESEL)
			VALUES (inPRA_IMIE,inPRA_NAZWISKO,inPRA_PESEL)
			RETURNING PRA_Id INTO PRA_Id_curr;
			
				IF SQL%FOUND THEN
				
					INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
					VALUES (SER_Id_curr,PRA_Id_curr) 
					RETURNING BBB_ID into BBB_Id_curr;
				
					OUT_IDs := TkolIDs(SER_Id_curr,PRA_Id_curr,BBB_Id_curr);
					COMMIT;
					
				END IF;
			
		ELSE IF PRACOW_SERW.PRA_ID IS NOT NULL THEN
				
			INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
			VALUES (SER_Id_curr,PRACOW_SERW.PRA_ID) 
			RETURNING BBB_ID into BBB_Id_curr;
			
			OUT_IDs := TkolIDs(SER_Id_curr,PRACOW_SERW.PRA_ID,BBB_Id_curr);
			COMMIT;
			
		END IF;
		END IF;
	
	RETURN OUT_IDs;
	
	EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w f_W1_INSERT_PRACOWNIK_SERWIS - Egzemplarz 2!');		
		
	END f_W1_INSERT_PRACOWNIK_SERWIS;
	
	--------------------------------
	--- FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS
	--- UWAGA! Egzemplarz 3
	--------------------------------
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Data_zatrudnienia in w1_PRACOW_SERW.PRA_Data_zatrudnienia%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs
	IS		
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRACOW_SERW t_PRA := NULL;
	--
	BBB_Id_curr t_ID;
	PRA_Id_curr t_ID;
	SER_Id_curr t_ID;
	--
	BEGIN
		--
		IF NOT cursorPRA%ISOPEN THEN
			OPEN cursorPRA(inPRA_PESEL);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRA!');
			--
			LOOP
			FETCH cursorPRA INTO PRACOW_SERW;
			--
			EXIT WHEN cursorPRA%NOTFOUND 
				 or cursorPRA%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorPRA%ISOPEN THEN 
			CLOSE cursorPRA; 
		END IF;
		--
		--
		INSERT INTO w1_SERWIS(SER_MIASTO,SER_UWAGI)
		VALUES (inSER_MIASTO,inSER_UWAGI)
		RETURNING SER_Id INTO SER_Id_curr;
		
		IF PRACOW_SERW.PRA_ID IS NULL THEN
			
			INSERT INTO w1_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA,PRA_PESEL)
			VALUES (inPRA_IMIE,inPRA_NAZWISKO,inPRA_DATA_ZATRUDNIENIA,inPRA_PESEL)
			RETURNING PRA_Id INTO PRA_Id_curr;
			
				IF SQL%FOUND THEN
				
					INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
					VALUES (SER_Id_curr,PRA_Id_curr) 
					RETURNING BBB_ID into BBB_Id_curr;
				
					OUT_IDs := TkolIDs(SERWIS.SER_ID,PRA_Id_curr,BBB_Id_curr);
					COMMIT;
					
				END IF;
			
		ELSE IF PRACOW_SERW.PRA_ID IS NOT NULL THEN
				
			INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
			VALUES (SER_Id_curr,PRACOW_SERW.PRA_ID) 
			RETURNING BBB_ID into BBB_Id_curr;
			
			OUT_IDs := TkolIDs(SER_Id_curr,PRACOW_SERW.PRA_ID,BBB_Id_curr);
			COMMIT;
			
		END IF;
		END IF;
	
	RETURN OUT_IDs;
	RETURN OUT_IDs;
	
	EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w f_W1_INSERT_PRACOWNIK_SERWIS - Egzemplarz 3!');		
		
	END f_W1_INSERT_PRACOWNIK_SERWIS;
	
	--------------------------------
	--- FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS
	--- UWAGA! Egzemplarz 4
	--------------------------------
	FUNCTION f_W1_INSERT_PRACOWNIK_SERWIS(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRA_Imie in w1_PRACOW_SERW.PRA_Imie%TYPE,
		inPRA_Nazwisko in w1_PRACOW_SERW.PRA_Nazwisko%TYPE,
		inPRA_Data_zatrudnienia in w1_PRACOW_SERW.PRA_Data_zatrudnienia%TYPE,
		inPRA_Umowa in w1_PRACOW_SERW.PRA_Umowa%TYPE,
		inPRA_Pesel in w1_PRACOW_SERW.PRA_Pesel%TYPE
	) RETURN TkolIDs
	IS		
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRACOW_SERW t_PRA := NULL;
	--
	BBB_Id_curr t_ID;
	PRA_Id_curr t_ID;
	SER_Id_curr t_ID;
	--
	BEGIN
		--
		IF NOT cursorPRA%ISOPEN THEN
			OPEN cursorPRA(inPRA_PESEL);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRA!');
			--
			LOOP
			FETCH cursorPRA INTO PRACOW_SERW;
			--
			EXIT WHEN cursorPRA%NOTFOUND 
				 or cursorPRA%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorPRA%ISOPEN THEN 
			CLOSE cursorPRA; 
		END IF;
		--
		--
		INSERT INTO w1_SERWIS(SER_MIASTO,SER_UWAGI)
		VALUES (inSER_MIASTO,inSER_UWAGI)
		RETURNING SER_Id INTO SER_Id_curr;
		
		IF PRACOW_SERW.PRA_ID IS NULL THEN
			
			INSERT INTO w1_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA,PRA_UMOWA,PRA_PESEL)
			VALUES (inPRA_IMIE,inPRA_NAZWISKO,inPRA_DATA_ZATRUDNIENIA,inPRA_UMOWA,inPRA_PESEL)
			RETURNING PRA_Id INTO PRA_Id_curr;
			
				IF SQL%FOUND THEN
				
					INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
					VALUES (SER_Id_curr,PRA_Id_curr) 
					RETURNING BBB_ID into BBB_Id_curr;
				
					OUT_IDs := TkolIDs(SERWIS.SER_ID,PRA_Id_curr,BBB_Id_curr);
					COMMIT;
					
				END IF;
			
		ELSE IF PRACOW_SERW.PRA_ID IS NOT NULL THEN
				
			INSERT INTO w1_BBB_PRA_SER(SER_ID,PRA_ID)
			VALUES (SER_Id_curr,PRACOW_SERW.PRA_ID) 
			RETURNING BBB_ID into BBB_Id_curr;
			
			OUT_IDs := TkolIDs(SER_Id_curr,PRACOW_SERW.PRA_ID,BBB_Id_curr);
			COMMIT;
			
		END IF;
		END IF;
	
	RETURN OUT_IDs;
	
	EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w f_W1_INSERT_PRACOWNIK_SERWIS - Egzemplarz 4!');		
		
	END f_W1_INSERT_PRACOWNIK_SERWIS;	

	--------------------------------
	--- PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI
	--- UWAGA! Egzemplarz 1
	--------------------------------
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE
	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRODUCENCI t_PRO := NULL;
	--
	SER_Id_curr t_ID;
	POD_Id_curr t_ID;
	PRO_Id_curr t_ID;
	--
	OUT_IDs TkolIDs;
	--
	BEGIN
	--
		IF NOT cursorSER%ISOPEN THEN
			OPEN cursorSER(inSER_Id);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorSER!');
			--
			LOOP
			FETCH cursorSER INTO SERWIS;
			--
			EXIT WHEN cursorSER%NOTFOUND 
				 or cursorSER%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorSER%ISOPEN THEN 
			CLOSE cursorSER; 
		END IF;
		--
		--
		IF NOT cursorPRO%ISOPEN THEN
			OPEN cursorPRO(inPRO_Nazwa_producenta);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRO!');
			--
			LOOP
			FETCH cursorPRO INTO PRODUCENCI;
			--
			EXIT WHEN cursorPRO%NOTFOUND 
				 or cursorPRO%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		--
		IF SERWIS.SER_ID IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('Taki serwis nie istnieje!');
			
			ROLLBACK;
		
		ELSE IF SERWIS.SER_ID IS NOT NULL THEN
			
				IF PRODUCENCI.PRO_ID IS NULL THEN
					
					INSERT INTO W1_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL)
					VALUES (INPRO_NAZWA_PRODUCENTA,INPRO_ROK_ZALOZENIA)
					RETURNING PRO_Id INTO PRO_Id_curr;
					
					IF SQL%FOUND THEN
						INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA)
						VALUES (PRO_Id_curr,SERWIS.SER_ID,inPOD_Nazwa)
						RETURNING PRO_Id INTO PRO_Id_curr;
						
						COMMIT;
						
					END IF;
			
				ELSE IF PRODUCENCI.PRO_ID IS NOT NULL THEN
					
					INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA)
					VALUES (PRODUCENCI.PRO_ID,SERWIS.SER_ID,inPOD_Nazwa)
					RETURNING PRO_Id INTO PRO_Id_curr;
					
					COMMIT

				END IF;
				END IF;
			END IF;
			END IF;
		END IF;
		END IF;
		
		EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w P_W1_PODZESPOŁY_PRODUCENCI - Egzemplarz 1!');		
		
	END P_W1_PODZESPOŁY_PRODUCENCI;
	
	--------------------------------
	--- PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI
	--- UWAGA! Egzemplarz 2
	--------------------------------
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Id in w1_SERWIS.SER_Id%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPRO_Kraj in w1_PRODUCENCI.PRO_Kraj%TYPE,
		inPRO_Uwagi in w1_PRODUCENCI.PRO_Uwagi%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRODUCENCI t_PRO := NULL;
	--
	SER_Id_curr t_ID;
	PRO_Id_curr t_ID;
	--
	OUT_IDs TkolIDs;
	--
	BEGIN
	--
		IF NOT cursorSER%ISOPEN THEN
			OPEN cursorSER(inSER_Id);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorSER!');
			--
			LOOP
			FETCH cursorSER INTO SERWIS;
			--
			EXIT WHEN cursorSER%NOTFOUND 
				 or cursorSER%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		IF cursorSER%ISOPEN THEN 
			CLOSE cursorSER; 
		END IF;
		--
		--
		IF NOT cursorPRO%ISOPEN THEN
			OPEN cursorPRO(inPRO_Nazwa_producenta);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRO!');
			--
			LOOP
			FETCH cursorPRO INTO PRODUCENCI;
			--
			EXIT WHEN cursorPRO%NOTFOUND 
				 or cursorPRO%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		--
		IF SERWIS.SER_ID IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('Taki serwis nie istnieje!');
			
			ROLLBACK;
		
		ELSE IF SERWIS.SER_ID IS NOT NULL THEN
			
				IF PRODUCENCI.PRO_ID IS NULL THEN
					
					INSERT INTO W1_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,PRO_KRAJ,PRO_UWAGI)
					VALUES (INPRO_NAZWA_PRODUCENTA,INPRO_ROK_ZALOZENIA,inPRO_Kraj,inPRO_Uwagi)
					RETURNING PRO_Id INTO PRO_Id_curr;
					
					IF SQL%FOUND THEN
						INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA,POD_PRZEZNACZENIE)
						VALUES (PRO_Id_curr,SERWIS.SER_ID,inPOD_Nazwa,inPOD_Przeznaczenie)
						RETURNING PRO_Id INTO PRO_Id_curr;
						
						COMMIT;
						
					END IF;
			
				ELSE IF PRODUCENCI.PRO_ID IS NOT NULL THEN
					
					INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA,POD_PRZEZNACZENIE)
					VALUES (PRODUCENCI.PRO_ID,SERWIS.SER_ID,inPOD_Nazwa,inPOD_Przeznaczenie)
					RETURNING PRO_Id INTO PRO_Id_curr;
					
					COMMIT

				END IF;
				END IF;
			END IF;
			END IF;
		END IF;
		END IF;
		
		EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w P_W1_PODZESPOŁY_PRODUCENCI - Egzemplarz 2!');		
		
	END P_W1_PODZESPOŁY_PRODUCENCI;
	
	--------------------------------
	--- PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI
	--- UWAGA! Egzemplarz 3
	--------------------------------
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRODUCENCI t_PRO := NULL;
	--
	SER_Id_curr t_ID;
	PRO_Id_curr t_ID;
	--
	OUT_IDs TkolIDs;
	--
	BEGIN
	--
		--
		--
		IF NOT cursorPRO%ISOPEN THEN
			OPEN cursorPRO(inPRO_Nazwa_producenta);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRO!');
			--
			LOOP
			FETCH cursorPRO INTO PRODUCENCI;
			--
			EXIT WHEN cursorPRO%NOTFOUND 
				 or cursorPRO%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		--
			INSERT INTO w1_SERWIS(SER_MIASTO,SER_UWAGI)
			VALUES (inSER_MIASTO, inSER_UWAGI)
			RETURNING SER_Id INTO SER_Id_curr;
					
			IF SQL%FOUND AND PRODUCENCI.PRO_ID IS NULL THEN
				
				INSERT INTO W1_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,POD_PRZEZNACZENIE)
				VALUES (INPRO_NAZWA_PRODUCENTA,INPRO_ROK_ZALOZENIA,inPOD_Przeznaczenie)
				RETURNING PRO_Id INTO PRO_Id_curr;
					
				IF SQL%FOUND THEN
					INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA)
					VALUES (PRO_Id_curr,SERWIS.SER_ID,inPOD_Nazwa)
					RETURNING PRO_Id INTO PRO_Id_curr;
						
					COMMIT;
						
				END IF;
			
			ELSE IF SQL%FOUND AND PRODUCENCI.PRO_ID IS NOT NULL THEN
					
				INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA,POD_PRZEZNACZENIE)
				VALUES (PRODUCENCI.PRO_ID,SERWIS.SER_ID,inPOD_Nazwa,inPOD_Przeznaczenie)
				RETURNING PRO_Id INTO PRO_Id_curr;
					
				COMMIT

			END IF;
			END IF;
		END IF;
		END IF;
		
		EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w P_W1_PODZESPOŁY_PRODUCENCI - Egzemplarz 3!');		
		
	END P_W1_PODZESPOŁY_PRODUCENCI;
	
	--------------------------------
	--- PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI
	--- UWAGA! Egzemplarz 4
	--------------------------------
	PROCEDURE P_W1_PODZESPOŁY_PRODUCENCI(
		inSER_Miasto in w1_SERWIS.SER_Miasto%TYPE,
		inSER_Uwagi in w1_SERWIS.SER_Uwagi%TYPE,
		inPRO_Nazwa_producenta in w1_PRODUCENCI.PRO_Nazwa_producenta%TYPE,
		inPRO_Rok_zalozenia in w1_PRODUCENCI.PRO_Rok_zalozenia%TYPE,
		inPRO_Kraj in w1_PRODUCENCI.PRO_Kraj%TYPE,
		inPRO_Uwagi in w1_PRODUCENCI.PRO_Uwagi%TYPE,
		inPOD_Nazwa in w1_PODZESPOŁY.POD_Nazwa%TYPE,
		inPOD_Przeznaczenie in w1_PODZESPOŁY.POD_Przeznaczenie%TYPE
	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	SERWIS t_SER := NULL;
	PRODUCENCI t_PRO := NULL;
	--
	SER_Id_curr t_ID;
	PRO_Id_curr t_ID;
	--
	OUT_IDs TkolIDs;
	--
	BEGIN
	--
		--
		--
		IF NOT cursorPRO%ISOPEN THEN
			OPEN cursorPRO(inPRO_Nazwa_producenta);
			--
			DBMS_OUTPUT.PUT_LINE('Otwarto cursorPRO!');
			--
			LOOP
			FETCH cursorPRO INTO PRODUCENCI;
			--
			EXIT WHEN cursorPRO%NOTFOUND 
				 or cursorPRO%ROWCOUNT < 1;	
			END LOOP;
		END IF;
		--
		--
			INSERT INTO w1_SERWIS(SER_MIASTO,SER_UWAGI)
			VALUES (inSER_MIASTO, inSER_UWAGI)
			RETURNING SER_Id INTO SER_Id_curr;
					
			IF SQL%FOUND AND PRODUCENCI.PRO_ID IS NULL THEN
				
				INSERT INTO W1_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,PRO_KRAJ,PRO_UWAGI)
				VALUES (INPRO_NAZWA_PRODUCENTA,INPRO_ROK_ZALOZENIA,inPRO_Kraj,inPRO_Uwagi)
				RETURNING PRO_Id INTO PRO_Id_curr;
					
				IF SQL%FOUND THEN
					INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA,POD_PRZEZNACZENIE)
					VALUES (PRO_Id_curr,SERWIS.SER_ID,inPOD_Nazwa,inPOD_Przeznaczenie)
					RETURNING PRO_Id INTO PRO_Id_curr;
						
					COMMIT;
						
				END IF;
			 
			ELSE IF SQL%FOUND AND PRODUCENCI.PRO_ID IS NOT NULL THEN
					
				INSERT INTO w1_PODZESPOLY(PRO_ID,SER_ID,POD_NAZWA,POD_PRZEZNACZENIE)
				VALUES (PRODUCENCI.PRO_ID,SERWIS.SER_ID,inPOD_Nazwa,inPOD_Przeznaczenie)
				RETURNING PRO_Id INTO PRO_Id_curr;
					
				COMMIT;

			END IF;
			END IF;
		END IF;
		END IF;
		
		EXCEPTION
		WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Wykryto błąd: '||SQLCODE||'->ERROR->'||SQLERRM);
		DBMS_OUTPUT.PUT_LINE('Błąd w P_W1_PODZESPOŁY_PRODUCENCI - Egzemplarz 4!');		
		
	END P_W1_PODZESPOŁY_PRODUCENCI;
	
END w1_PKG_DML;
/


