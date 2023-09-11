
--------------------------------
 --  PAKIETY PKG_RANDOM -- API
 --------------------------------
CREATE OR REPLACE 
PACKAGE PKG_RANDOM
IS
	
   ---------------------------
	-- F_BERNOULLI
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_BERNOULLI
	RETURN NUMBER;
	
	---------------------------
	-- F_WYKLADNICZY
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_WYKLADNICZY(x IN NUMBER)
	RETURN NUMBER;
	
	---------------------------
	-- F_CAUCHEGO
	--
	--RETURN NUMBER
	---------------------------
	FUNCTION F_CAUCHEGO
	RETURN NUMBER;	
  
	---------------------------
	-- F_TROJKAT
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_TROJKAT(x IN NUMBER)
	RETURN NUMBER;
	
	---------------------------
	-- F_RANDOM_NUMBER
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_RANDOM_NUMBER(in_min NUMBER, in_max NUMBER)
	RETURN NUMBER;
	
	---------------------------
	-- F_RANDOM_VARCHAR2
	--
	-- RETURN VARCHAR2
	---------------------------
	FUNCTION F_RANDOM_VARCHAR2(x IN NUMBER)
	RETURN VARCHAR2;
	
	---------------------------
	-- F_RANDOM_DATE
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_RANDOM_DATE
	RETURN NUMBER;
	
END PKG_RANDOM;
/



--------------------------------
 --  PAKIETY PKG_RANDOM -- BODY
 --------------------------------
CREATE OR REPLACE 
PACKAGE BODY PKG_RANDOM
IS
	
   ---------------------------
	-- F_BERNOULLI
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_BERNOULLI
	RETURN NUMBER
	IS 
	WYNIK NUMBER;
	BEGIN 
		WYNIK := MOD(ABS(DBMS_RANDOM.RANDOM()),2);
		
		RETURN WYNIK;
	END F_BERNOULLI;
	
	---------------------------
	-- F_WYKLADNICZY
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_WYKLADNICZY(x IN NUMBER)
	RETURN NUMBER
	IS
		lambda NUMBER;
		b NUMBER;
		WYNIK NUMBER;
	BEGIN
		LAMBDA := 1.0;
		b := 5.0;
		IF (x < lambda) THEN
			WYNIK := 0;
		ELSE IF (x >= lambda) THEN 
			WYNIK := (1.0/b)*exp((lambda-x)/b);
		END IF; 
		END IF; 
		
		RETURN WYNIK;
	END;
	
	---------------------------
	-- F_CAUCHEGO
	--
	--RETURN NUMBER
	---------------------------
	FUNCTION F_CAUCHEGO
	RETURN NUMBER
	IS
		x1 NUMBER;
		x2 NUMBER;
		g NUMBER;
		pi NUMBER;
	BEGIN
		x1 := 5.0;
		x2 := round(DBMS_RANDOM.VALUE(0,5));
		g := 1.0;
		pi := 3.14;
		
		RETURN (1.0/(pi*g*POWER((1+((x1-x2)/g)),2)));
	END;
  
	---------------------------
	-- F_TROJKAT
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_TROJKAT(x IN NUMBER)
	RETURN NUMBER
	IS
		a NUMBER;
		b NUMBER;
		c NUMBER;
		WYNIK NUMBER;
	BEGIN
		a := 0.0;
		b := 10.0;
		c := 7.0;
		IF (x <= c and x >= a) THEN
			WYNIK := ((2*(x-a))/((b-a)*(c-a)));
			
		ELSE IF (c <= x and b >= x) THEN
			WYNIK := ((2*(x-b)/((b-a)*(b-c))));
			
		END IF; 
		END IF; 
		
		RETURN WYNIK;
	END;
	
	---------------------------
	-- F_RANDOM_NUMBER
	--
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_RANDOM_NUMBER(in_min NUMBER, in_max NUMBER)
	RETURN NUMBER
	IS
	BEGIN
		RETURN ROUND(DBMS_RANDOM.VALUE(in_min,in_max));
	END;
	
	---------------------------
	-- F_RANDOM_VARCHAR2
	--
	-- RETURN VARCHAR2
	---------------------------
	FUNCTION F_RANDOM_VARCHAR2(x IN NUMBER)
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN DBMS_RANDOM.STRING('x',x);
	END;
  
	---------------------------
	-- F_RANDOM_DATE
	-- RETURN NUMBER
	---------------------------
	FUNCTION F_RANDOM_DATE
	RETURN NUMBER
	IS
		wynik NUMBER;
		rok NUMBER;
		miesiac NUMBER;
		miesiac_var varchar(2);
		dzien NUMBER;
		dzien_var varchar(2);

	BEGIN
		rok := Pkg_Random.F_RANDOM_NUMBER(1950,2020);
		miesiac := Pkg_Random.F_RANDOM_NUMBER(1,12);
		
		IF miesiac = 2 and mod(rok,4) = 0 THEN 
			dzien := Pkg_Random.F_RANDOM_NUMBER(1,29);
			
		ELSE IF miesiac = 2 and mod(rok,4) <> 0 THEN 
			dzien := Pkg_Random.F_RANDOM_NUMBER(1,28);
			
		ELSE IF miesiac in (1, 3, 5, 7, 8, 10, 12) THEN
			dzien := Pkg_Random.F_RANDOM_NUMBER(1,31);
			
		ELSE IF miesiac in (4, 6, 9, 11) THEN
			dzien := Pkg_Random.F_RANDOM_NUMBER(1,30);
		
		ELSE
			DBMS_OUTPUT.PUT_LINE('Err! Wystapil blad.');
		
		END IF;
		END IF;
		END IF;
		END IF;
		
		IF dzien <= 9 THEN
			dzien_var := to_char('0'||dzien);
		ELSE 
			dzien_var := to_char(dzien);
		END IF;
		
		IF miesiac <= 9 THEN
			miesiac_var := to_char('0'||miesiac);
		ELSE 
			miesiac_var := to_char(miesiac);
		END IF;
		
		wynik := to_number(rok||miesiac_var||dzien_var);
		
		RETURN wynik;
	END F_RANDOM_DATE;
	  
 END PKG_RANDOM;
/


	---------------------------
	-- F_BERNOULLI
	--
	-- RETURN NUMBER
	---------------------------
	DECLARE
		TYPE LISTA_WYNIK IS VARRAY(10) OF VARCHAR2(255);
		LISTA LISTA_WYNIK;
	BEGIN
		for i in 1 .. 10
		LOOP
			DBMS_OUTPUT.PUT_LINE(PKG_RANDOM.F_BERNOULLI);	
			LISTA := LISTA_WYNIK(PKG_RANDOM.F_BERNOULLI);
		end loop;
	END;
	/
/*
	1
	0
	0
	0
	1
	0
	1
	1
	0
	1
*/
	
	---------------------------
	-- F_WYKLADNICZY
	--
	-- RETURN NUMBER
	---------------------------
	DECLARE
		TYPE LISTA_WYNIK IS VARRAY(10) OF VARCHAR2(255);
		LISTA LISTA_WYNIK;
	BEGIN
		for i in 1 .. 10
		LOOP
			DBMS_OUTPUT.PUT_LINE(PKG_RANDOM.F_WYKLADNICZY(i));	
			LISTA := LISTA_WYNIK(PKG_RANDOM.F_WYKLADNICZY(i));
		end loop;
	END;
	/
/*
	,2
	,1637461506155963717339871017238078848711
	,1340640092071278601488865850295652143874
	,109762327218805286525691783446513575065
	,0898657928234443182860204770031125591881
	,0735758882342884643191047540322921734891
	,060238842382440419328995521416644491994
	,0493193927883212953879722479667535266128
	,0403793035989310816970358535286699525718
	,0330597776443173076593609440864428096388
*/
	
	---------------------------
	-- F_CAUCHEGO
	--
	--RETURN NUMBER
	---------------------------
	DECLARE
		TYPE LISTA_WYNIK IS VARRAY(10) OF VARCHAR2(255);
		LISTA LISTA_WYNIK;
	BEGIN
		for i in 1 .. 10
		LOOP
			DBMS_OUTPUT.PUT_LINE(PKG_RANDOM.F_CAUCHEGO);	
			LISTA := LISTA_WYNIK(PKG_RANDOM.F_CAUCHEGO);
		end loop;
	END;
	/
/*
	,008846426043878273177636234961075725406936
	,012738853503184713375796178343949044586
	,0353857041755130927105449398443029016277
	,012738853503184713375796178343949044586
	,3184713375796178343949044585987261146497
	,0796178343949044585987261146496815286624
	,0796178343949044585987261146496815286624
	,0353857041755130927105449398443029016277
	,008846426043878273177636234961075725406936
	,0796178343949044585987261146496815286624
*/
	
	---------------------------
	-- F_TROJKAT
	--
	-- RETURN NUMBER
	---------------------------
	DECLARE
		TYPE LISTA_WYNIK IS VARRAY(10) OF VARCHAR2(255);
		LISTA LISTA_WYNIK;
	BEGIN
		for i in 1 .. 10
		LOOP
			DBMS_OUTPUT.PUT_LINE(PKG_RANDOM.F_TROJKAT(i));	
			LISTA := LISTA_WYNIK(PKG_RANDOM.F_TROJKAT(i));
		end loop;
	END;
	/
/*
	,0285714285714285714285714285714285714286
	,0571428571428571428571428571428571428571
	,0857142857142857142857142857142857142857
	,1142857142857142857142857142857142857143
	,1428571428571428571428571428571428571429
	,1714285714285714285714285714285714285714
	,2
	-,1333333333333333333333333333333333333333
	-,0666666666666666666666666666666666666667
	0
*/
	