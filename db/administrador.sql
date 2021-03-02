--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.15
-- Dumped by pg_dump version 9.4.15
-- Started on 2021-03-02 16:19:00 -04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11861)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 886941)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ciudad (
    nombre character varying(35) NOT NULL,
    pais character varying(4) NOT NULL,
    provincia character varying(32) NOT NULL,
    poblacion integer,
    longitud real,
    latitud real
);


ALTER TABLE ciudad OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 887226)
-- Name: encuesta_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE encuesta_detalle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE encuesta_detalle_id_seq OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 887224)
-- Name: encuesta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE encuesta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE encuesta_id_seq OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 886944)
-- Name: encuestas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuestas (
    id integer DEFAULT nextval('encuesta_id_seq'::regclass) NOT NULL,
    fecha timestamp(6) with time zone NOT NULL,
    id_usuarios integer NOT NULL,
    pais character varying(32),
    estado character varying(32),
    ciudad character varying(35),
    codigo character varying(4),
    intensidad character varying(4)
);


ALTER TABLE encuestas OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 886947)
-- Name: encuestas_detalles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuestas_detalles (
    id integer DEFAULT nextval('encuesta_detalle_id_seq'::regclass) NOT NULL,
    id_encuestas integer NOT NULL,
    id_intensidades integer NOT NULL,
    id_preguntas integer NOT NULL
);


ALTER TABLE encuestas_detalles OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 887221)
-- Name: intensidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE intensidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE intensidades_id_seq OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 886950)
-- Name: intensidades; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE intensidades (
    id integer DEFAULT nextval('intensidades_id_seq'::regclass) NOT NULL,
    nombre character varying(10) NOT NULL,
    valor integer NOT NULL
);


ALTER TABLE intensidades OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 886953)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pais (
    nombre character varying(32) NOT NULL,
    codigo character varying(4) DEFAULT ''::character varying NOT NULL,
    capital character varying(35) DEFAULT NULL::character varying,
    provincia character varying(32) DEFAULT NULL::character varying,
    area integer,
    poblacion integer
);


ALTER TABLE pais OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 886959)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permisos (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE permisos OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 886962)
-- Name: permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permisos_id_seq OWNER TO postgres;

--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 179
-- Name: permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permisos_id_seq OWNED BY permisos.id;


--
-- TOC entry 180 (class 1259 OID 886964)
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas (
    nombre character varying(500) NOT NULL,
    orden integer,
    id integer NOT NULL
);


ALTER TABLE preguntas OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 887199)
-- Name: preguntas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE preguntas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE preguntas_id_seq OWNER TO postgres;

--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 192
-- Name: preguntas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE preguntas_id_seq OWNED BY preguntas.id;


--
-- TOC entry 191 (class 1259 OID 887108)
-- Name: preguntas_intensidades; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE preguntas_intensidades (
    id integer NOT NULL,
    id_preguntas integer,
    id_intensidades integer
);


ALTER TABLE preguntas_intensidades OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 887106)
-- Name: preguntas_intensidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE preguntas_intensidades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE preguntas_intensidades_id_seq OWNER TO postgres;

--
-- TOC entry 2165 (class 0 OID 0)
-- Dependencies: 190
-- Name: preguntas_intensidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE preguntas_intensidades_id_seq OWNED BY preguntas_intensidades.id;


--
-- TOC entry 181 (class 1259 OID 886970)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincia (
    nombre character varying(32) NOT NULL,
    pais character varying(4) NOT NULL,
    poblacion integer,
    area integer,
    capital character varying(35) DEFAULT NULL::character varying,
    cap_prov character varying(32) DEFAULT NULL::character varying
);


ALTER TABLE provincia OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 886975)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE roles OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 886978)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_id_seq OWNER TO postgres;

--
-- TOC entry 2166 (class 0 OID 0)
-- Dependencies: 183
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- TOC entry 184 (class 1259 OID 886980)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_permisos (
    id integer NOT NULL,
    id_roles integer,
    id_permisos integer
);


ALTER TABLE roles_permisos OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 886983)
-- Name: roles_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_permisos_id_seq OWNER TO postgres;

--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 185
-- Name: roles_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roles_permisos_id_seq OWNED BY roles_permisos.id;


--
-- TOC entry 186 (class 1259 OID 886985)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    id integer NOT NULL,
    nombre character varying(100),
    apellido character varying(100),
    foto character varying(1000),
    direccion text,
    telefono character varying(100),
    correo character varying(100),
    password character varying(500),
    activo boolean,
    codigo_activacion character varying(100)
);


ALTER TABLE usuarios OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 886991)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_id_seq OWNED BY usuarios.id;


--
-- TOC entry 188 (class 1259 OID 886993)
-- Name: usuarios_roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios_roles (
    id integer NOT NULL,
    id_roles integer,
    id_usuarios integer
);


ALTER TABLE usuarios_roles OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 886996)
-- Name: usuarios_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuarios_roles_id_seq OWNER TO postgres;

--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 189
-- Name: usuarios_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_roles_id_seq OWNED BY usuarios_roles.id;


--
-- TOC entry 1959 (class 2604 OID 886998)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permisos ALTER COLUMN id SET DEFAULT nextval('permisos_id_seq'::regclass);


--
-- TOC entry 1960 (class 2604 OID 887201)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preguntas ALTER COLUMN id SET DEFAULT nextval('preguntas_id_seq'::regclass);


--
-- TOC entry 1967 (class 2604 OID 887111)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preguntas_intensidades ALTER COLUMN id SET DEFAULT nextval('preguntas_intensidades_id_seq'::regclass);


--
-- TOC entry 1963 (class 2604 OID 886999)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- TOC entry 1964 (class 2604 OID 887000)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_permisos ALTER COLUMN id SET DEFAULT nextval('roles_permisos_id_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 887001)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN id SET DEFAULT nextval('usuarios_id_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 887002)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_roles ALTER COLUMN id SET DEFAULT nextval('usuarios_roles_id_seq'::regclass);


--
-- TOC entry 2132 (class 0 OID 886941)
-- Dependencies: 173
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ciudad (nombre, pais, provincia, poblacion, longitud, latitud) FROM stdin;
Luxembourg	L	Luxembourg	76600	6.07999992	49.4000015
Monaco	MC	Monaco	1234	7.19999981	43.7000008
San Marino	RSM	San Marino	4416	12.1999998	43.5
Armenia	CO	Quindio	220303	\N	\N
Kuwait	KWT	Kuwait	167768	47.2999992	29.2999992
Singapore	SGP	Singapore	2558000	103.833	1.29999995
Liberia	CR	Guanacaste	36400	\N	\N
Djibouti	DJI	Djibouti	\N	43.0999985	11.5
Tirane	AL	Albania	192000	10.6999998	46.2000008
Athens	GR	Greece	885737	23.7166996	37.9667015
Skopje	MK	Macedonia	\N	\N	\N
Belgrade	YU	Serbia and Montenegro	1407073	20.4666996	44.7999992
Paris	F	Ile de France	2152423	2.48333001	48.8167
Madrid	E	Madrid	3041101	-3.68333006	40.4166985
Vienna	A	Vienna	1583000	16.3666992	48.25
Berlin	D	Berlin	3472009	13.3000002	52.4500008
Budapest	H	Budapest (munic.)	2016000	19.0333004	47.5167007
Rome	I	Lazio	2791354	12.6000004	41.7999992
Vaduz	FL	Liechtenstein	27714	9.30000019	47.0800018
Bratislava	SK	Slovakia	\N	\N	\N
Ljubljana	SLO	Slovenia	\N	\N	\N
Minsk	BY	Belarus	1540000	27.5499992	53.9000015
Riga	LV	Latvia	900000	14.1000004	57
Vilnius	LT	Lithuania	566000	25.2999992	54.4000015
Warsaw	PL	Warszwaskie	1655000	21.0333004	52.2167015
Kiev	UA	Kyyivska	2616000	30.5	50.4500008
Moscow	R	Moskva	8717000	37.6666985	55.7667007
Brussels	B	Brabant	951580	4.3499999	50.7999992
Amsterdam	NL	Noord Holland	1101407	4.91666985	52.3833008
Sarajevo	BIH	Bosnia and Herzegovina	\N	\N	\N
Zagreb	HR	Croatia	\N	\N	\N
Sofia	BG	Bulgaria	1300000	23.3332996	42.7000008
Ankara	TR	Ankara	2782200	32.8833008	39.9500008
Copenhagen	DK	Denmark	1358540	12.5500002	55.6833
Tallinn	EW	Estonia	478000	25	59.2999992
Helsinki	SF	Uusimaa	487428	24.9500008	60.1666985
Oslo	N	Oslo	449337	10.7333002	59.9333
Stockholm	S	Stockholm	711119	18.0667	59.3499985
Reykjavik	IS	Iceland	84000	21.9333	64.1333008
Dublin	IRL	Ireland	502337	-6.3499999	53.3666992
Valletta	M	Malta	9302	14.1999998	35.0800018
Chisinau	MD	Moldova	663000	28.1000004	47.2000008
Lisbon	P	Lisbon	807937	-9.13333035	38.7167015
Kabul	AFG	Afghanistan	892000	69.1999969	34.5833015
Tehran	IR	Tehran	6750043	51.4166985	35.6833
Tashkent	UZB	Toshkent	2106000	69.3000031	41.3333015
Yerevan	ARM	Armenia	1200000	44.4000015	40.0999985
Tbilisi	GE	Georgia	1200000	44.7999992	41.7167015
Baku	AZ	Azerbaijan	1740000	49.5	40.2999992
Manama	BRN	Bahrain	145000	50.5	26
Rangoon	MYA	Yangon	2513000	96.1500015	16.7833004
New Delhi	IND	Delhi	7206704	77.1999969	28.5832996
Thimphu	BHT	Bhutan	20000	90	27
Kuala Lumpur	MAL	Fed. Terr. of Kuala Lumpur	1145075	101.699997	3.11666989
Vientiane	LAO	Laos	377409	102.449997	18
Bangkok	THA	Thailand	5876000	100.5	13.7333002
Phnom Penh	K	Cambodia	400000	104.849998	11.5500002
Hanoi	VN	Vietnam	3056146	105.866997	21.0333004
Bishkek	KGZ	Kyrgyzstan	630000	74.5	42.4000015
Ulaanbaatar	MNG	Mongolia	479500	107	48
Kathmandu	NEP	Nepal	393494	85.25	27.4500008
Nicosia	CY	Cyprus	161100	33.2000008	35.4000015
Jerusalem	IL	Central	468900	35.2167015	31.7833004
Cairo	ET	El Qahira (munic.)	6053000	31.3332996	29.8666992
Baghdad	IRQ	Baghdad	4478000	44.4000015	33.3333015
Amman	JOR	Jordan	777500	35.9500008	31.9500008
Riyadh	SA	Saudi Arabia	1250000	46.7000008	24.6499996
Damascus	SYR	Syria	1500000	36.3333015	33.5
Beirut	RL	Lebanon	702000	35.4667015	33.9000015
Tokyo	J	Tokyo	7843000	139.766998	35.6833
Male	MV	Maldives	46334	72	2
Muscat	OM	Oman	30000	58.5	23.5
Sanaa	YE	Yemen	427185	44.1100006	15.21
Manila	RP	Philippines	1655000	120.983002	14.5832996
Doha	Q	Qatar	217294	51	25
Colombo	CL	Sri Lanka	643000	79.8666992	6.9000001
Colombo	BR	Parana	153583	\N	\N
Taipei	RC	Taiwan	2626138	121.516998	25.0333004
Nassau	BS	Bahamas	140000	-77.3499985	25.0832996
Bridgetown	BDS	Barbados	10000	-59.4000015	13.1000004
Belmopan	BZ	Belize	3000	-88.5	17.1000004
Guatemala City	GCA	Guatemala	823301	-90.5167007	14.6167002
Mexico City	MEX	Distrito Federal	9815795	-99.1999969	19.3999996
Hamilton	CDN	Ontario	318499	-79.9000015	43.2667007
Managua	NIC	Nicaragua	1195000	-86.25	12.1667004
Panama City	PA	Panama	594800	-79.5500031	8.96667004
Havana	C	Ciudad de la Habana	2241000	-82.3499985	23.1333008
Roseau	WD	Dominica	11000	-61.2999992	15.1999998
Port-au-Prince	RH	Haiti	800000	-72.1999969	18.3999996
Tegucigalpa	HCA	Francisco Morazan	670100	-87.2166977	14.1000004
Kingston	GB	Surrey	\N	\N	\N
Kingston	JA	Jamaica	101000	-76.5	18
Kingston	AUS	Norfolk Island	\N	\N	\N
Plymouth	GB	Devon	255800	\N	\N
Bogota	CO	Santa Fe de Bogota, DC	5237635	-74.0832977	4.5999999
Basseterre	KN	Saint Kitts and Nevis	14700	-62.2999992	17
Castries	WL	Saint Lucia	49000	-60.5	14
Kingstown	WV	Saint Vincent and the Grenadines	33694	-61.0999985	13.1000004
Port-of-Spain	TT	Trinidad and Tobago	150000	-61.2000008	10.3999996
Suva	FJI	Fiji	69481	178	-19
Tarawa	KIR	Kiribati	2100	175	0
Majuro	MH	Marshall Islands	7600	170	10
Kolonia	FSM	Micronesia	5500	168	10
Noumea	NCA	New Caledonia	\N	\N	\N
Wellington	NZ	New Zealand	352030	174.766998	-41.2832985
Koror	PAL	Palau	7685	135	8
Honiara	SLB	Solomon Islands	26000	160	-10
Nukualofa	TO	Tonga	28899	175	20
Funafuti	TUV	Tuvalu	2120	178	-8
Port-Vila	VU	Vanuatu	15759	167	-18
Apia	WS	Western Samoa	36000	-171	-12
Buenos Aires	RA	Distrito Federal	2988006	-58.4832993	-34.5833015
La Paz	MEX	Baja California Sur	137641	-100.5	24.1000004
La Paz	HCA	La Paz	\N	\N	\N
La Paz	BOL	Bolivia	953400	-68.1500015	-16.5
Brasilia	BR	Distrito Federal	1817001	-47.9166985	-15.8667002
Santiago	PA	Veraguas	61000	\N	\N
Santiago	RCH	Chile	4318000	-70.6999969	-33.4500008
Asuncion	PY	Paraguay	729307	-57.2999992	-25.5
Montevideo	ROU	Uruguay	1247000	-56.2167015	-34.8499985
Lima	PE	Lima	6321173	-77.0500031	-12.0832996
Cayenne	FGU	French Guiana	38155	-52.4500008	4.93333006
Georgetown	GUY	Guyana	170000	-58.2000008	6.83333015
Paramaribo	SME	Suriname	150000	-55.1500015	5.81666994
Caracas	YV	Distrito Federal	1822465	-66.9332962	10.5
Quito	EC	Ecuador	1200000	-78.5333023	-0.216666996
Algiers	DZ	Algeria	1507241	30.0499992	36.7667007
Tripoli	LAR	Libya	\N	22.2999992	37.2999992
Bamako	RMM	Mali	\N	-7.5999999	12.3000002
Nouakchott	RIM	Mauritania	\N	-16	18
Niamey	RN	Niger	\N	2.0999999	13.1999998
Tunis	TN	Tunisia	\N	10.1999998	36.7832985
Luanda	ANG	Luanda	\N	13.1999998	-8.60000038
Brazzaville	RCB	Congo	\N	15.25	-4.25
Windhoek	NAM	Namibia	\N	17.2000008	-22.2999992
Porto-Novo	BEN	Benin	\N	2.4000001	6.30000019
Ouagadougou	BF	Burkina Faso	\N	-2	12
Abuja	WAN	Nigeria	\N	\N	\N
Lome	RT	Togo	\N	1.10000002	6.0999999
Gaborone	RB	Botswana	\N	25.6000004	-24.5
Harare	ZW	Zimbabwe	\N	31.2000008	-17.5
Yamoussoukro	CI	Cote dIvoire	\N	\N	\N
Accra	GH	Ghana	867459	-0.200000003	5.55000019
Bujumbura	BI	Burundi	\N	29	-4
Kigali	RWA	Rwanda	\N	29.6000004	-1.60000002
Dar es Salaam	EAT	Daressalam	1360850	39.2999992	-6.83333015
Bangui	RCA	Central African Republic	\N	18.5	4.30000019
NDjamena	TCH	Chad	\N	15	12
Malabo	GQ	Equatorial Guinea	33000	9	4
Libreville	G	Gabon	\N	9.30000019	0.300000012
Praia	CV	Cape Verde	\N	-23	16
Khartoum	SUD	al Khartum	924505	32.5499992	15.6167002
Moroni	COM	Comoros	\N	43	-12
Conakry	RG	Guinea	\N	-13.5	9.30000019
Monrovia	LB	Liberia	\N	-10.8000002	6.30000019
Asmara	ER	Eritrea	\N	38.9166985	15.2833004
Addis Ababa	ETH	Ethiopia	2316400	38.75	9
Mogadishu	SP	Somalia	\N	45.2999992	2.20000005
Nairobi	EAK	Nairobi	2000000	36.7999992	-1.26666999
Banjul	WAG	Gambia	\N	14	13.5
Dakar	SN	Dakar	1382000	-17.4832993	14.6999998
Bissau	GNB	Guinea-Bissau	\N	-15.5	11.5
Freetown	WAL	Sierra Leone	\N	13.1000004	8.19999981
Kampala	EAU	Uganda	\N	32.2999992	0.200000003
Maseru	LS	Lesotho	75000	27.2999992	-29.2000008
Lilongwe	MW	Malawi	\N	34	-14
Mbabane	SD	Swaziland	\N	31.1000004	-25
Victoria	CDN	British Columbia	263180	-123.317001	48.4166985
Victoria	SY	Seychelles	\N	52	-2
Shkoder	AL	Albania	62000	19.2000008	42.2000008
Durres	AL	Albania	60000	19.2999992	41.2000008
Vlore	AL	Albania	56000	19.2999992	40.2999992
Elbasan	AL	Albania	53000	20.1000004	41.0999985
Korce	AL	Albania	52000	20.5	40.4000015
Thessaloniki	GR	Greece	406413	22.9500008	40.6166992
Strasbourg	F	Alsace	252338	7.76667023	48.5833015
Nantes	F	Pays de la Loire	244995	-1.56666994	47.25
Nice	F	Provence Cote dAzur	342439	7.26667023	43.7000008
Lyon	F	Rhone Alpes	415487	4.78332996	45.7000008
Ajaccio	F	Corse	53500	8.39999962	41.4000015
Poitiers	F	Poitou Charentes	79300	0.200000003	46.4000015
Barcelona	E	Catalonia	1630867	2.1500001	41.4000015
Barcelona	YV	Anzoategui	221792	\N	\N
Valencia	E	Valencia	764293	-0.383332998	39.4667015
Valencia	YV	Carabobo	903621	\N	\N
Toledo	E	Castile La Mancha	\N	\N	\N
Toledo	USA	Ohio	317606	-83.8000031	41.5999985
Merida	E	Estremadura	\N	\N	\N
Merida	MEX	Yucatan	523422	-89.6333008	20.9666996
Merida	YV	Merida	170902	\N	\N
Eisenstadt	A	Burgenland	10102	16	48
Klagenfurt	A	Carinthia	87321	14.21	46.3800011
Bregenz	A	Vorarlberg	\N	9.44999981	47.2999992
Hamburg	D	Hamburg	1705872	9.96667004	53.5499992
Hannover	D	Niedersachsen	525763	9.66666985	52.4000015
Munich	D	Bayern	1244676	11.5667	48.1500015
Mannheim	D	Baden Wurttemberg	316223	8.46667004	49.5667
Saarbruecken	D	Saarland	183945	6.5999999	49.0999985
Muenchen	D	Bayern	1290079	11.3000002	48.0999985
Bekescaba	H	Bekes	\N	\N	\N
Hodmezovasarhely	H	Csongrad	\N	\N	\N
Eger	H	Heves	\N	\N	\N
Tatabanya	H	Komarom Esztergom	\N	\N	\N
Salgotarjan	H	Nograd	\N	\N	\N
Kaposvar	H	Somogy	\N	\N	\N
Szolnok	H	Szolnok	\N	\N	\N
Szekszard	H	Tolna	\N	\N	\N
Szombathely	H	Vas	\N	\N	\N
Veszprem	H	Veszprem	\N	\N	\N
Zalaegerszeg	H	Zala	\N	\N	\N
Milan	I	Lombardia	1432184	9.28332996	45.4500008
Aosta	I	Valle dAosta	\N	7.21999979	45.4500008
LAquila	I	Abruzzo	\N	13.1999998	42.2400017
Campobasso	I	Molise	\N	14.5	41.5
Potenza	I	Basilicata	\N	15.4700003	40.4000015
Aarau	CH	AG	\N	\N	\N
Herisau	CH	AR	\N	\N	\N
Appenzell	CH	AI	\N	\N	\N
Liestal	CH	BL	\N	\N	\N
Fribourg	CH	FR	\N	\N	\N
Glarus	CH	GL	\N	\N	\N
Chur	CH	GR	\N	\N	\N
Delemont	CH	JU	\N	\N	\N
Neuchatel	CH	NE	\N	\N	\N
Stans	CH	NW	\N	\N	\N
Sarnen	CH	OW	\N	\N	\N
Schaffhausen	CH	SH	\N	\N	\N
Schwyz	CH	SZ	\N	\N	\N
Solothurn	CH	SO	\N	\N	\N
Frauenfeld	CH	TG	\N	\N	\N
Bellinzona	CH	TI	\N	\N	\N
Altdorf	CH	UR	\N	\N	\N
Sion	CH	VS	\N	\N	\N
Zug	CH	ZG	\N	\N	\N
Krakow	PL	Krakowskie	748000	19.9500008	50.0667
Chelm	PL	Chelmskie	\N	\N	\N
Ciechanow	PL	Ciechanowskie	\N	\N	\N
Konin	PL	Koninskie	\N	\N	\N
Krosno	PL	Krosnienskie	\N	\N	\N
Leszno	PL	Leszczynskie	\N	\N	\N
Lomza	PL	Lomzynskie	\N	\N	\N
Ostroleka	PL	Ostroleckie	\N	\N	\N
Pila	PL	Pilskie	\N	\N	\N
Przemysl	PL	Przemyskie	\N	\N	\N
Siedlce	PL	Siedleckie	\N	\N	\N
Sieradz	PL	Sieradzkie	\N	\N	\N
Skierniewice	PL	Skierniewickie	\N	\N	\N
Slupsk	PL	Slupskie	\N	\N	\N
Suwalki	PL	Suwalskie	\N	\N	\N
Tarnobrzeg	PL	Tarnobrzeskie	\N	\N	\N
Zamosc	PL	Zamojskie	\N	\N	\N
Kharkiv	UA	Kharkivska	1618000	36.2332993	50
Odesa	UA	Odeska	1106000	30.7332993	46.4832993
Uzhhorod	UA	Zakarpatska	\N	\N	\N
Arkhangelsk	R	Arkhangelskaya oblast	374000	40.5332985	64.5500031
Kaliningrad	R	Kaliningradskaya oblast	419000	20.5	54.7167015
Volgograd	R	Volgogradskaya oblast	1003000	44.5167007	48.7000008
Krasnoyarsk	R	Krasnoyarskiy kray	869000	92.9499969	56.0167007
Vladivostok	R	Primorsky kray	632000	131.917007	43.1166992
Elista	R	Rep. of Kalmykiya	\N	\N	\N
Nazran	R	Rep. of Ingushetiya	\N	\N	\N
Kyzyl	R	Rep. of Tyva	\N	\N	\N
Birobidzhan	R	Yevreyskaya avt. oblast	\N	\N	\N
Anadyr	R	Chukotsky ao	\N	\N	\N
Mons	B	Hainaut	90720	3.5999999	50.2999992
Hasselt	B	Limburg	65348	5.19999981	50.7000008
Arlon	B	Luxembourg	23150	5.5	49.4000015
Brugge	B	West Flanders	117799	2.07999992	51.0999985
Leeuwarden	NL	Friesland	\N	\N	\N
Assen	NL	Drenthe	\N	\N	\N
Zwolle	NL	Overijssel	\N	\N	\N
Lelystad	NL	Flevoland	\N	\N	\N
Middelburg	NL	Zeeland	\N	\N	\N
Bistrita	RO	Bistrita Nasaud	\N	\N	\N
Botosani	RO	Botosani	\N	\N	\N
Calarasi	RO	Calarasi	\N	\N	\N
Resita	RO	Caras Severin	\N	\N	\N
Tirgoviste	RO	Dimbovita	\N	\N	\N
Giurgiu	RO	Giurgiu	\N	\N	\N
Deva	RO	Hunedoara	\N	\N	\N
Slobozia	RO	Ialomita	\N	\N	\N
Slatina	RO	Olt	\N	\N	\N
Ploiesti	RO	Prahova	\N	\N	\N
Zalau	RO	Salaj	\N	\N	\N
Suceava	RO	Suceava	\N	\N	\N
Alexandria	RO	Teleorman	\N	\N	\N
Alexandria	ET	El Iskandariya (munic.)	2917000	30	31
Alexandria	USA	Virginia	117586	\N	\N
Tulcea	RO	Tulcea	\N	\N	\N
Vaslui	RO	Vaslui	\N	\N	\N
Focsani	RO	Vrancea	\N	\N	\N
Adana	TR	Adana	1047300	35.2999992	36.9832993
Istanbul	TR	Istanbul	7615500	28.8332996	40.9667015
Izmir	TR	Izmir	1985300	27.1667004	38.4333
Afyon	TR	Afyon	\N	\N	\N
Agri	TR	Agri	\N	\N	\N
Aksaray	TR	Aksaray	\N	\N	\N
Amasya	TR	Amasya	\N	\N	\N
Artvin	TR	Artvin	\N	\N	\N
Bayburt	TR	Bayburt	\N	\N	\N
Bilecik	TR	Bilecik	\N	\N	\N
Bingol	TR	Bingol	\N	\N	\N
Bitlis	TR	Bitlis	\N	\N	\N
Bolu	TR	Bolu	\N	\N	\N
Burdur	TR	Burdur	\N	\N	\N
Canakkale	TR	Canakkale	\N	\N	\N
Cankiri	TR	Cankiri	\N	\N	\N
Corum	TR	Corum	\N	\N	\N
Erzincan	TR	Erzincan	\N	\N	\N
Giresun	TR	Giresun	\N	\N	\N
Gumushane	TR	Gumushane	\N	\N	\N
Hakkari	TR	Hakkari	\N	\N	\N
Karaman	TR	Karaman	\N	\N	\N
Kars	TR	Kars	\N	\N	\N
Kastamonu	TR	Kastamonu	\N	\N	\N
Kirklareli	TR	Kirklareli	\N	\N	\N
Kirsehir	TR	Kirsehir	\N	\N	\N
Mardin	TR	Mardin	\N	\N	\N
Mugla	TR	Mugla	\N	\N	\N
Mus	TR	Mus	\N	\N	\N
Nevsehir	TR	Nevsehir	\N	\N	\N
Nigde	TR	Nigde	\N	\N	\N
Rize	TR	Rize	\N	\N	\N
Sakarya	TR	Sakarya	\N	\N	\N
Siirt	TR	Siirt	\N	\N	\N
Sinop	TR	Sinop	\N	\N	\N
Sirnak	TR	Sirnak	\N	\N	\N
Tekirdag	TR	Tekirdag	\N	\N	\N
Tokat	TR	Tokat	\N	\N	\N
Tunceli	TR	Tunceli	\N	\N	\N
Yozgat	TR	Yozgat	\N	\N	\N
Aarhus	DK	Denmark	194345	10.1000004	56.0999985
Odense	DK	Denmark	136803	10.1999998	55.2999992
Aalborg	DK	Denmark	113865	10	57
Esbjerg	DK	Denmark	70975	8.30000019	55.2999992
Randers	DK	Denmark	55780	10	56.2999992
Tampere	SF	Haeme	170097	23.5	61.2999992
Espoo	SF	Uusimaa	160480	24.2999992	60.2000008
Lahti	SF	Haeme	94234	25.2000008	60.5
Pori	SF	Turku-Pori	77763	21.2000008	61.2999992
Lappeenrenta	SF	Kymi	53922	26.5	60.5
Hammerfest	N	Finnmark	7089	23.3999996	70.4000015
Svolvaer	N	Nordland	4500	14.3000002	68.1999969
Narvik	N	Nordland	18754	17.2999992	68.3000031
Vanersborg	S	Alvsborg	35804	12.1999998	58.2000008
Karlskrona	S	Blekinge	59007	15.3000002	56.0999985
Gavle	S	Gavleborg	87431	17	60.4000015
Visby	S	Gotland	20000	18.2000008	57.2999992
Halmstad	S	Halland	77601	13	56.4000015
Ostersund	S	Jamtland	56662	14.3000002	63.2000008
Kalmar	S	Kalmar	54554	16.2999992	56.4000015
Falun	S	Kopparberg	51900	15.3000002	60.2999992
Kristianstad	S	Kristianstad	69941	14	56
Vaxjo	S	Kronoberg	66925	15	56.5
Lulea	S	Norrbotten	66526	22.1000004	65.4000015
Mariestad	S	Skaraborg	24255	13.5	58.4000015
Nykoping	S	Sodermanland	64199	17	58.5
Karlstad	S	Varmland	74669	13.3000002	59.2999992
Umea	S	Vasterbotten	85698	20.1000004	63.5
Harnosand	S	Vasternorrland	27287	18	62.4000015
Jokkmokk	S	Norrbotten	6822	19.5	66.0999985
Keflavik	IS	Iceland	6600	-22.5	64
Hafnarfjoerdur	IS	Iceland	12000	-22	64
Akureyri	IS	Iceland	13000	18.2999992	65.4000015
Truro	GB	Cornwall / Isles of Scilly	\N	\N	\N
Matlock	GB	Derbyshire	\N	\N	\N
Dorchester	GB	Dorset	\N	\N	\N
Durham	GB	Durham	\N	\N	\N
Durham	USA	North Carolina	149799	-78.7833023	35.8666992
Lewes	GB	East Sussex	\N	\N	\N
Glouchester	GB	Gloucestershire	\N	\N	\N
Glouchester	CDN	Ontario	101677	\N	\N
Worcester	GB	Hereford and Worcester	\N	\N	\N
Worcester	USA	Massachusetts	166350	-71.8666992	42.2667007
Hertford	GB	Hertfordshire	\N	\N	\N
Hull	GB	Humberside	\N	\N	\N
Leichester	GB	Leicestershire	\N	\N	\N
Lincoln	GB	Lincolnshire	\N	\N	\N
Lincoln	USA	Nebraska	209192	-96.4000015	40.5
Newcastle	GB	Tyne and Wear	\N	\N	\N
Newcastle	AUS	New South Wales	429000	\N	\N
Northallerton	GB	North Yorkshire	\N	\N	\N
Shrewsbury	GB	Shropshire	\N	\N	\N
Taunton	GB	Somerset	\N	\N	\N
Trowbridge	GB	Wiltshire	\N	\N	\N
Stirling	GB	Central	\N	\N	\N
Dumfries	GB	Dumfries and Galloway	\N	\N	\N
Glenrothes	GB	Fife	\N	\N	\N
Inverness	GB	Highland	\N	\N	\N
Llangefni	GB	Anglesey	\N	\N	\N
Bridgend	GB	Bridgend	\N	\N	\N
Carmarthen	GB	Carmarthenshire	\N	\N	\N
Aberystwyth	GB	Ceredigion	\N	\N	\N
Ruthin	GB	Denbighshire	\N	\N	\N
Mold	GB	Flintshire	\N	\N	\N
Caernarfon	GB	Gwynedd	\N	\N	\N
Cwmbran	GB	Monmouthshire	\N	\N	\N
Haverfordwest	GB	Pembrokeshire	\N	\N	\N
Rhondda	GB	Rhondda Cynon Taff	\N	\N	\N
Pontypool	GB	Torfaen	\N	\N	\N
Barry	GB	Vale of Glamorgan	\N	\N	\N
Wrexham	GB	Wrexham	\N	\N	\N
Shanghai	TJ	Shanghai (munic.)	7830000	121.432999	31.2000008
Xi	TJ	Shaanxi	\N	\N	\N
Yasuj	IR	Boyer Ahmad e Kohkiluyeh	\N	\N	\N
Bushehr	IR	Bushehr	\N	\N	\N
Semnan	IR	Semnan	\N	\N	\N
Lahore	PK	Pakistan	5085000	74.3332977	31.5832996
Karachi	PK	Pakistan	9863000	66.9832993	24.7999992
Khorugh	TAD	Badakhshoni Kuni	\N	\N	\N
Guliston	UZB	Sirdare	\N	\N	\N
Termiz	UZB	Surkhondare	\N	\N	\N
Chittagong	BD	Bangladesh	1599000	91.8332977	22.3500004
Mandalay	MYA	Mandalay	532900	96.0999985	21.9832993
Magway	MYA	Magway	\N	\N	\N
Sagaing	MYA	Sagaing	\N	\N	\N
Tavoy	MYA	Tanintharyi	\N	\N	\N
Hakha	MYA	Chin	\N	\N	\N
Myitkyina	MYA	Kachin	\N	\N	\N
Loikaw	MYA	Kayah	\N	\N	\N
Bangalore	IND	Karnataka	3302296	77.6166992	12.9499998
Calcutta	IND	West Bengal	4399819	88.3332977	22.5333004
Madras	IND	Tamil Nadu	3841396	80.25	13.0667
Nagpur	IND	Maharashtra	1624752	79.1166992	21.1499996
Itanagar	IND	Arunachal Pradesh	\N	93.4000015	27.1000004
Dispur	IND	Assam	\N	91.5	26
Panaji	IND	Goa	\N	74	15.3999996
Gandhinagar	IND	Gujarat	\N	72.1999969	23.2000008
Simla	IND	Himachal Pradesh	\N	77.0999985	31
Bombay	IND	Maharashtra	\N	72.8167038	18.8999996
Imphal	IND	Manipur	\N	94	24.5
Shillong	IND	Meghalaya	\N	91.5	25.3999996
Aijal	IND	Mizoram	\N	92.4000015	23.3999996
Kohima	IND	Nagaland	\N	94.0999985	25.5
Gangtok	IND	Sikkim	\N	88.3000031	27.2999992
Agartala	IND	Tripura	\N	91.1999969	23.5
Silvassa	IND	Dadra and Nagar Haveli	\N	73.0999985	20.2000008
Daman	IND	Daman and Diu	\N	\N	\N
Kavaratti	IND	Lakshadweep Is.	\N	72.4000015	10.3000002
Pondicherry	IND	Pondicherry	\N	79.5	12
Jammu	IND	Jammu and Kashmir	\N	74.3000031	32.2000008
Kangar	MAL	Perlis	\N	\N	\N
Labuan	MAL	Fed. Terr. of Labuan	\N	\N	\N
Da Nang	VN	Vietnam	369734	108.217003	16.0667
Arqalyq	KAZ	Torghay	\N	\N	\N
Zhambyl	KAZ	Zhambyl	\N	\N	\N
Zhezkazghan	KAZ	Zhezkazghan	\N	\N	\N
Leninsk	KAZ	Leninsk (munic.)	\N	\N	\N
Ramla	IL	Central	\N	\N	\N
Haifa	IL	Haifa	\N	\N	\N
Nazareth	IL	North	\N	\N	\N
Tel Aviv	IL	Tel Aviv	\N	34.7832985	32.0999985
Hurghada	ET	El Bahr el Ahmar	\N	\N	\N
Surabaya	RI	Indonesia	2483871	112.717003	-7.21667004
Palembang	RI	Indonesia	1144279	104.766998	-3
Medan	RI	Indonesia	1730752	98.6832962	3.58332992
Mosul	IRQ	Ninawa	664221	43.1500015	36.3167
Samarra	IRQ	Salah ad Din	\N	\N	\N
Dahuk	IRQ	Dahuk	\N	\N	\N
Jeddah	SA	Saudi Arabia	\N	\N	\N
Aleppo	SYR	Syria	976727	36	36
Homs	SYR	Syria	354508	36	35
Sapporo	J	Hokkaido	1748000	141.350006	43.0667
Fukuoka	J	Fukuoka	1273000	130.449997	33.5833015
Aomori	J	Aomori	\N	\N	\N
Morioka	J	Iwate	\N	\N	\N
Akita	J	Akita	\N	\N	\N
Yamagata	J	Yamagata	\N	\N	\N
Fukushima	J	Fukushima	\N	\N	\N
Mito	J	Ibaraki	\N	\N	\N
Utsonomiya	J	Tochigi	\N	\N	\N
Maebashi	J	Gumma	\N	\N	\N
Urawa	J	Saitama	\N	\N	\N
Niigata	J	Niigata	\N	\N	\N
Toyama	J	Toyama	\N	\N	\N
Kanazawa	J	Ishikawa	\N	\N	\N
Fukui	J	Fukui	\N	\N	\N
Kofu	J	Yamanashi	\N	\N	\N
Nagano	J	Nagano	\N	\N	\N
Gifu	J	Gifu	\N	\N	\N
Shizuoka	J	Shizuoka	\N	\N	\N
Tsu	J	Mie	\N	\N	\N
Otsu	J	Shiga	\N	\N	\N
Nara	J	Nara	\N	\N	\N
Wakayama	J	Wakayama	\N	\N	\N
Tottori	J	Tottori	\N	\N	\N
Matsue	J	Shimane	\N	\N	\N
Okayama	J	Okayama	\N	\N	\N
Yamaguchi	J	Yamaguchi	\N	\N	\N
Tokushima	J	Tokushima	\N	\N	\N
Takamatsu	J	Kagawa	\N	\N	\N
Matsuyama	J	Ehime	\N	\N	\N
Kochi	J	Kochi	\N	\N	\N
Saga	J	Saga	\N	\N	\N
Nagasaki	J	Nagasaki	\N	\N	\N
Kumamoto	J	Kumamoto	\N	\N	\N
Oita	J	Oita	\N	\N	\N
Miyazaki	J	Miyazaki	\N	\N	\N
Kagoshima	J	Kagoshima	\N	\N	\N
Naha	J	Okinawa	\N	\N	\N
Rayyan	Q	Qatar	91996	50.5	25.5
Wakrah	Q	Qatar	23682	50.7000008	25.2000008
Tainan	RC	Taiwan	707658	120.199997	22.9500008
Ilan	RC	Taiwan	\N	\N	\N
Miaoli	RC	Taiwan	\N	\N	\N
Nantou	RC	Taiwan	\N	\N	\N
Makung	RC	Taiwan	\N	\N	\N
Hsinying	RC	Taiwan	\N	\N	\N
Touliu	RC	Taiwan	\N	\N	\N
Guadalajara	MEX	Jalisco	1650042	-103.333	20.6833
Monterrey	MEX	Nuevo Leon	1068996	-100.300003	25.6667004
Durango	MEX	Durango	182600	-104.400002	24
Guanajuato	MEX	Guanajuato	36809	-101.199997	21
Chilpancingo	MEX	Guerrero	36193	-99.3000031	17.2999992
Chetumal	MEX	Quintana Roo	23685	-88.1999969	18.2999992
Tlaxcala	MEX	Tlaxcala	116800	-98.0999985	19.2000008
Jalapa	MEX	Veracruz	161400	-97	19.2999992
Fredericton	CDN	New Brunswick	45248	-52.5	45.5
Yellowknife	CDN	Northwest Territories	8256	-114.449997	62.4667015
Charlottetown	CDN	Prince Edward Island	24837	-63.2000008	46.2000008
Whitehorse	CDN	Yukon Territory	13311	-135	60.4000015
Savannah	USA	Georgia	136262	-81.1999969	32.1333008
Juneau	USA	Alaska	19528	-134.582993	58.3666992
Dover	GB	Kent	106100	\N	\N
Dover	USA	Delaware	23512	-75.4666977	39.1333008
Frankfort	USA	Kentucky	25973	-84.5	38.0999985
Augusta	USA	Maine	21819	-69.8000031	44.3167
Annapolis	USA	Maryland	31740	-76.3000031	39
Helena	USA	Montana	23938	-112	46.5999985
Concord	USA	California	114850	-121.983002	37.9667015
Concord	USA	New Hampshire	30400	-71.5	43.2000008
Trenton	USA	New Jersey	92124	-74.7667007	40.2167015
Bismarck	USA	North Dakota	44485	-100.5	46.4000015
Harrisburg	USA	Pennsylvania	53264	-76.7667007	40.2000008
Pierre	USA	South Dakota	11973	-100.282997	44.3833008
Nashville	USA	Tennessee	455657	-86.4000015	36.0999985
Montpelier	USA	Vermont	8241	-72.4000015	44.2000008
Olympia	USA	Washington	27447	-122.900002	46.9667015
Charleston	USA	West Virginia	63968	-81.5999985	38.3666992
Cheyenne	USA	Wyoming	47283	-104.817001	41.1500015
Hilo	USA	Hawaii	\N	-165	20
Ahuachapan	ES	El Salvador	\N	\N	\N
Sensuntepeque	ES	El Salvador	\N	\N	\N
Cojutepeque	ES	El Salvador	\N	\N	\N
Chalatenango	ES	El Salvador	\N	\N	\N
Zacatecoluca	ES	El Salvador	\N	\N	\N
Sonsonate	ES	El Salvador	\N	\N	\N
Usulutan	ES	El Salvador	\N	\N	\N
Trujillo	HCA	Colon	\N	\N	\N
Trujillo	PE	La Libertad	509312	\N	\N
Trujillo	YV	Trujillo	\N	\N	\N
Yuscaran	HCA	El Paraiso	\N	\N	\N
Roatan	HCA	Islas de la Bahia	\N	\N	\N
Gracias	HCA	Lempira	\N	\N	\N
Ocotepeque	HCA	Ocotepeque	\N	\N	\N
Nacaome	HCA	Valle	\N	\N	\N
Yoro	HCA	Yoro	\N	\N	\N
Medellin	CO	Antioquia	1621356	-75.5999985	6.21667004
Cali	CO	Valle de Cauca	1718871	-76.5	3.41667008
Leticia	CO	Amazonas	\N	\N	\N
Arauca	CO	Arauca	\N	\N	\N
Yopal	CO	Casanare	\N	\N	\N
Mocoa	CO	Putumayo	\N	\N	\N
Mitu	CO	Vaupes	\N	\N	\N
Sydney	AUS	New South Wales	3657000	151.199997	-33.8666992
Brisbane	AUS	Queensland	1302000	153.033005	-27.4666996
Adelaide	AUS	South Australia	1050000	138.582993	-34.9333
Melbourne	AUS	Victoria	3081000	144.966995	-37.8167
Perth	AUS	Western Australia	1193000	115.849998	-31.9500008
Darwin	AUS	Northern Territory	68500	130.850006	-12.4666996
Albany	USA	New York	103564	-73.75	42.6500015
Albany	AUS	Western Australia	\N	118	-35
Auckland	NZ	New Zealand	952600	175	-36
Cordoba	E	Andalusia	315948	\N	\N
Cordoba	MEX	Veracruz	130695	\N	\N
Cordoba	RA	Cordoba	1208713	-64.25	-31.3666992
Rawson	RA	Chubut	52000	-65	-43.0999985
Viedma	RA	Rio Negro	25000	-63.0999985	-40.5
Ushuaia	RA	Tierra del Fuego	3000	-68.3000031	-54.5
Sucre	BOL	Bolivia	110000	-65.0999985	-19
Cochabamba	BOL	Bolivia	304000	-66	-17.1000004
Sao Paulo	BR	Sao Paulo	9811776	-46.6333008	-23.5499992
Salvador	BR	Bahia	2209465	-38.5	-13
Belo Horizonte	BR	Minas Gerais	2091770	-43.9500008	-19.9333
Fortaleza	BR	Ceara	1967365	-38.5499992	-3.76666999
Curitiba	BR	Parana	1465698	-49.2832985	-25.4167004
Recife	BR	Pernambuco	1342877	-34.8833008	-8.06667042
Porto Alegre	BR	Rio Grande do Sul	1286251	-51.2167015	-30.0333004
Belem	BR	Para	1142258	-48.4832993	-1.45000005
Palmas	BR	Tocantins	\N	\N	\N
Valparaiso	RCH	Chile	267000	-71.3000031	-33.0999985
Chachapoyas	PE	Amazonas	\N	\N	\N
Huaraz	PE	Ancash	\N	\N	\N
Abancay	PE	Apurimac	\N	\N	\N
Callao	PE	Callao	\N	\N	\N
Huancavelica	PE	Huancavelica	\N	\N	\N
Moquegua	PE	Moquegua	\N	\N	\N
Moyobamba	PE	San Martin	\N	\N	\N
Tumbes	PE	Tumbes	\N	\N	\N
Maracaibo	YV	Zulia	1249670	-71.5999985	10.6499996
Tucupita	YV	Delta Amacuro	\N	\N	\N
Coro	YV	Falcon	\N	\N	\N
Guanare	YV	Portuguesa	\N	\N	\N
Guayaquil	EC	Ecuador	1300868	-80	-2
Bengasi	LAR	Libya	\N	20	32
Casablanca	MA	Morocco	2940623	-7.6500001	33.5833015
Cabinda	ANG	Cabinda	\N	\N	\N
Uige	ANG	Uige	\N	\N	\N
Ndalatando	ANG	Cuanza Norte	\N	\N	\N
Sumbe	ANG	Cuanza Sul	\N	\N	\N
Malanje	ANG	Malanje	\N	\N	\N
Lucapa	ANG	Lunda Norte	\N	\N	\N
Saurimo	ANG	Lunda Sul	\N	\N	\N
Benguela	ANG	Benguela	\N	\N	\N
Huambo	ANG	Huambo	\N	\N	\N
Bie	ANG	Bie	\N	\N	\N
Luena	ANG	Moxico	\N	\N	\N
Menongue	ANG	Cuando Cubango	\N	\N	\N
Namibe	ANG	Namibe	\N	\N	\N
Lubango	ANG	Huila	\N	\N	\N
Caxito	ANG	Bengo	\N	\N	\N
Ngiva	ANG	Cunene	\N	\N	\N
Bandundu	ZRE	Bandundu	\N	\N	\N
Chipata	Z	Eastern	\N	\N	\N
Mansa	Z	Luapula	\N	\N	\N
Kasama	Z	Northern	\N	\N	\N
Solwezi	Z	Northwestern	\N	\N	\N
Livingstone	Z	Southern	\N	\N	\N
Mongu	Z	Western	\N	\N	\N
Lagos	WAN	Nigeria	5686000	3.4000001	6.44999981
Nelspruit	RSA	South Africa	\N	\N	\N
Kimberley	RSA	South Africa	\N	\N	\N
Pietersburg	RSA	South Africa	\N	\N	\N
Mmabatho	RSA	South Africa	\N	\N	\N
Abidjan	CI	Cote dIvoire	\N	-3.5999999	5.30000019
Moshi	EAT	Kilimanjaro	\N	\N	\N
Lindi	EAT	Lindi	\N	\N	\N
Songea	EAT	Ruvuma	\N	\N	\N
Iringa	EAT	Iringa	\N	\N	\N
Singida	EAT	Singida	\N	\N	\N
Tabora	EAT	Tabora	\N	\N	\N
Sumbawanga	EAT	Rukwa	\N	\N	\N
Bukoba	EAT	Kagera	\N	\N	\N
Musoma	EAT	Mara	\N	\N	\N
Mkokotoni	EAT	Kaskazini Ujunga	\N	\N	\N
Koani	EAT	Kusini Ujunga	\N	\N	\N
Wete	EAT	Kaskazini Pemba	\N	\N	\N
Ngaoundere	CAM	Adamaoua	\N	\N	\N
Bertoua	CAM	Est	\N	\N	\N
Ebolowa	CAM	Sud	\N	\N	\N
Buea	CAM	Sudoueste	\N	\N	\N
Malakal	SUD	Aali an Nil	\N	\N	\N
Waw	SUD	Bahr al Ghazal	\N	\N	\N
Embu	BR	Sao Paulo	195676	\N	\N
Embu	EAK	Eastern	\N	\N	\N
Garissa	EAK	North Eastern	\N	\N	\N
Diourbel	SN	Diourbel	\N	\N	\N
Fatick	SN	Fatick	\N	\N	\N
Kolda	SN	Kolda	\N	\N	\N
Louga	SN	Louga	\N	\N	\N
Tambacounda	SN	Tambacounda	\N	\N	\N
Pemba	MOC	Cabo Delgado	\N	\N	\N
Inhambane	MOC	Inhambane	\N	\N	\N
Lichinga	MOC	Niassa	\N	\N	\N
Kisii	EAK	Nyanza	44000	\N	\N
Meru	EAK	Eastern	78100	\N	\N
Salzburg	A	Salzburg	144000	13.1999998	47.4900017
Antwerp	B	Antwerp	459072	4.23000002	51.0999985
Liege	B	Liege	192393	5.5	50.5
Namur	B	Namur	105014	4.5	50.2999992
Kuopio	SF	Kuopio	78571	27.3999996	62.5
Mikkeli	SF	Mikkeli	28000	27.2000008	61.4000015
Oulu	SF	Oulu	97898	25.2000008	65.3000031
Vaasa	SF	Vaasa	54275	21.2999992	63
Bremen	D	Bremen	549182	8.5	53.7000008
Groningen	NL	Groningen	210708	\N	\N
Utrecht	NL	Utrecht	547070	\N	\N
Braga	P	Braga	63033	\N	\N
Coimbra	P	Coimbra	74616	\N	\N
Porto	P	Porto	327368	\N	\N
Santarem	BR	Para	242765	\N	\N
Setubal	P	Setubal	77885	\N	\N
Arad	RO	Arad	191000	\N	\N
Bacau	RO	Bacau	193000	\N	\N
Braila	RO	Braila	243000	\N	\N
Brasov	RO	Brasov	353000	\N	\N
Buzau	RO	Buzau	145000	\N	\N
Constanta	RO	Constanta	316000	\N	\N
Galati	RO	Galati	307000	\N	\N
Iasi	RO	Iasi	330000	\N	\N
Satu Mare	RO	Satu Mare	137000	\N	\N
Sibiu	RO	Sibiu	184000	\N	\N
Murcia	E	Murcia	341531	\N	\N
Jonkoping	S	Jonkoping	115429	14	57.4000015
Orebro	S	Orebro	119635	15	59.2000008
Uppsala	S	Uppsala	183472	17.3999996	59.5
Cleveland	USA	Ohio	498246	\N	\N
Norfolk	USA	Virginia	233430	-76.1999969	36.9000015
Cardiff	GB	Cardiff	300000	-3.16667008	51.4667015
Merthyr Tydfil	GB	Merthyr Tydfil	\N	\N	\N
Newport	GB	Newport	137000	\N	\N
Swansea	GB	Swansea	189300	\N	\N
Bago	MYA	Bago	150500	\N	\N
Jilin	TJ	Jilin	1270000	\N	\N
Chandigarh	IND	Chandigarh	510565	76.5	30.5
Bakhtaran	IR	Bakhtaran	665636	47.0999985	34.2000008
Esfahan	IR	Esfahan	1220595	51.4000015	32.4000015
Hamadan	IR	Hamadan	406070	48.2999992	34.5
Ilam	IR	Ilam	116428	\N	\N
Kerman	IR	Kerman	349626	\N	\N
Yazd	IR	Yazd	306268	\N	\N
Zanjan	IR	Zanjan	280691	\N	\N
Al Basrah	IRQ	Al Basrah	406296	\N	\N
Karbala	IRQ	Karbala	296705	\N	\N
An Najaf	IRQ	An Najaf	309010	\N	\N
Irbil	IRQ	Irbil	485968	\N	\N
As Sulaymaniyah	IRQ	As Sulaymaniyah	364096	\N	\N
Chiba	J	Chiba	843000	\N	\N
Kyoto	J	Kyoto	1415000	135.449997	35
Osaka	J	Osaka	2492000	\N	\N
Hiroshima	J	Hiroshima	1099000	132.300003	34.2999992
Almaty	KAZ	Almaty (munic.)	1172400	76.8833008	43.2332993
Aqmola	KAZ	Aqmola	280200	\N	\N
Aqtobe	KAZ	Aqtobe	258900	\N	\N
Atyrau	KAZ	Atyrau	146900	\N	\N
Kokchetau	KAZ	Kokchetau	141400	\N	\N
Pavlodar	KAZ	Pavlodar	340700	\N	\N
Qostanay	KAZ	Qostanay	232100	\N	\N
Qyzylorda	KAZ	Qyzylorda	162000	\N	\N
Semey	KAZ	Semey	320200	\N	\N
Taldyqorghan	KAZ	Taldyqorghan	116100	\N	\N
Melaka	MAL	Melaka	295999	\N	\N
Sankt Peterburg	R	Sankt Peterburg	4838000	\N	\N
Changhua	RC	Taiwan	221090	\N	\N
Chiai	RC	Taiwan	261941	\N	\N
Hsinchu	RC	Taiwan	341128	\N	\N
Hualien	RC	Taiwan	107824	\N	\N
Kaohsiung	RC	Taiwan	1426518	\N	\N
Pingtung	RC	Taiwan	214728	\N	\N
Taichung	RC	Taiwan	857590	\N	\N
Taitung	RC	Taiwan	109189	\N	\N
Taoyuan	RC	Taiwan	260680	\N	\N
Kulob	TAD	Kulob	79300	\N	\N
Chiang Mai	THA	Thailand	167000	\N	\N
Nakhon Sawan	THA	Thailand	152000	\N	\N
Khon Kaen	THA	Thailand	206000	\N	\N
Nakhon Ratchasima	THA	Thailand	278000	\N	\N
Ubon Ratchathani	THA	Thailand	137000	\N	\N
Nonthaburi	THA	Thailand	233000	\N	\N
Saraburi	THA	Thailand	107000	\N	\N
Songkhla	THA	Thailand	243000	\N	\N
Adiyaman	TR	Adiyaman	128000	\N	\N
Antalya	TR	Antalya	497200	\N	\N
Aydin	TR	Aydin	121200	\N	\N
Balikesir	TR	Balikesir	187600	\N	\N
Batman	TR	Batman	182800	\N	\N
Bursa	TR	Bursa	996600	\N	\N
Denizli	TR	Denizli	234500	\N	\N
Diyarbakir	TR	Diyarbakir	448300	\N	\N
Edirne	TR	Edirne	115500	\N	\N
Elazig	TR	Elazig	222800	\N	\N
Erzurum	TR	Erzurum	250100	\N	\N
Eskisehir	TR	Eskisehir	451000	\N	\N
Gaziantep	TR	Gaziantep	716000	\N	\N
Isparta	TR	Isparta	120900	\N	\N
Kayseri	TR	Kayseri	454000	\N	\N
Kirikkale	TR	Kirikkale	170300	\N	\N
Kocaeli	TR	Kocaeli	256882	\N	\N
Konya	TR	Konya	576000	\N	\N
Kutahya	TR	Kutahya	140700	\N	\N
Malatya	TR	Malatya	319700	\N	\N
Manisa	TR	Manisa	187500	\N	\N
Ordu	TR	Ordu	121300	\N	\N
Samsun	TR	Samsun	326900	\N	\N
Sivas	TR	Sivas	240100	\N	\N
Trabzon	TR	Trabzon	145400	\N	\N
Usak	TR	Usak	119900	\N	\N
Van	TR	Van	194600	\N	\N
Zonguldak	TR	Zonguldak	115900	\N	\N
Mary	TM	Mary	94900	\N	\N
Abu Dhabi	UAE	United Arab Emirates	363432	54.3600006	24.2700005
Andijon	UZB	Andijon	303000	\N	\N
Bukhoro	UZB	Bukhoro	236000	\N	\N
Farghona	UZB	Farghona	191000	\N	\N
Jizzakh	UZB	Jizzakh	116000	\N	\N
Namangan	UZB	Namangan	341000	\N	\N
Nawoiy	UZB	Nawoiy	115000	\N	\N
Samarqand	UZB	Samarqand	368000	\N	\N
Haiphong	VN	Vietnam	1447523	\N	\N
Can Tho	VN	Vietnam	284306	\N	\N
Ontario	USA	California	144854	-117.599998	34.0499992
Quebec	CDN	Quebec	167517	-71.3833008	46.7999992
San Jose	USA	California	838744	-121.932999	37.3666992
San Jose	CR	San Jose	296600	-84.1999969	10
Alajuela	CR	Alajuela	158300	\N	\N
Cartago	CR	Cartago	109000	\N	\N
Cartago	CO	Valle de Cauca	117166	\N	\N
Heredia	CR	Heredia	67400	\N	\N
Limon	CR	Limon	67800	\N	\N
Camaguey	C	Camaguey	293961	\N	\N
Ciego de Avila	C	Ciego de Avila	\N	\N	\N
Cienfuegos	C	Cienfuegos	132038	\N	\N
Guantanamo	C	Guantanamo	207796	\N	\N
Holguin	C	Holguin	242085	\N	\N
Matanzas	C	Matanzas	123843	\N	\N
Pinar del Rio	C	Pinar del Rio	128570	\N	\N
Sancti Spiritus	C	Sancti Spiritus	\N	\N	\N
Santiago de Cuba	C	Santiago de Cuba	440084	\N	\N
La Union	ES	El Salvador	\N	\N	\N
San Miguel	ES	El Salvador	182817	\N	\N
San Salvador	ES	El Salvador	422570	-89.2166977	13.6999998
San Vicente	ES	El Salvador	\N	\N	\N
Santa Ana	USA	California	302419	-117.866997	33.75
Santa Ana	ES	El Salvador	202337	\N	\N
Colon	PA	Colon	140900	\N	\N
Comayagua	HCA	Comayagua	44300	\N	\N
Choluteca	HCA	Choluteca	63200	\N	\N
Santa Barbara	HCA	Santa Barbara	\N	\N	\N
Aguascalientes	MEX	Aguascalientes	440425	-102.199997	21.5
Campeche	MEX	Campeche	150518	-90.3000031	19.5
Chihuahua	MEX	Chihuahua	516153	-106.099998	28.3999996
Colima	MEX	Colima	106967	-103.400002	19.1000004
Oaxaca	MEX	Oaxaca	212818	-96.4000015	17
Puebla	MEX	Puebla	1007170	-98.0999985	19
Queretaro	MEX	Queretaro	385503	-100.199997	20.3999996
San Luis Potosi	MEX	San Luis Potosi	488238	-101	22.1000004
Zacatecas	MEX	Zacatecas	100051	-102.400002	22.5
Bocas del Toro	PA	Bocas del Toro	\N	\N	\N
New York	USA	New York	7380906	-74	40.4000015
Washington	USA	Distr. Columbia	543213	-77	38.5
Corrientes	RA	Corrientes	258103	-58.4000015	-27.2999992
Formosa	RA	Formosa	148074	-58.0999985	-26.5
La Rioja	RA	La Rioja	103727	-67	-29.2999992
Mendoza	RA	Mendoza	773113	-69	-33
Neuquen	RA	Neuquen	243803	-68	-39
Salta	RA	Salta	370904	-65.3000031	-24.5
San Juan	RA	San Juan	352691	-68.3000031	-31.2999992
San Juan	YV	Guarico	\N	\N	\N
San Luis	RA	San Luis	110136	-66.1999969	-33.2000008
Santa Fe	USA	New Mexico	48899	-106	35.4000015
Santa Fe	RA	Santa Fe	406388	-60.5	-31.5
Parana	RA	Entre Rios	211936	-60	-32
Rio de Janeiro	BR	Rio de Janeiro	5533011	-43.2000008	-23
Arequipa	PE	Arequipa	619156	\N	\N
Ayacucho	PE	Ayacucho	105918	\N	\N
Cajamarca	PE	Cajamarca	92447	\N	\N
Cuzco	PE	Cuzco	255568	-72	-13.1999998
Huanuco	PE	Huanuco	118814	\N	\N
Ica	PE	Ica	161406	\N	\N
Piura	PE	Piura	277964	\N	\N
Puno	PE	Puno	91877	\N	\N
Tacna	PE	Tacna	174336	\N	\N
Barinas	YV	Barinas	153630	\N	\N
Dumyat	ET	Dumyat	121000	\N	\N
Ismailiya	ET	Ismailiya	236000	\N	\N
Kafr el Sheikh	ET	Kafr el Sheikh	\N	\N	\N
Aswan	ET	Aswan	196000	\N	\N
Asyut	ET	Asyut	291000	\N	\N
Beni Suef	ET	Beni Suef	163000	\N	\N
El Faiyum	ET	El Faiyum	227000	\N	\N
El Giza	ET	El Giza	1671000	\N	\N
El Minya	ET	El Minya	203000	\N	\N
Qena	ET	Qena	142000	\N	\N
Sohag	ET	Sohag	142000	\N	\N
Antsiranana	RM	Antsiranana	220000	\N	\N
Antananarivo	RM	Antananarivo	1250000	47.4000015	-18.6000004
Fianarantsoa	RM	Fianarantsoa	300000	\N	\N
Toliary	RM	Toliary	150000	\N	\N
Maputo	MOC	Maputo (munic.)	931591	33	-26
Nampula	MOC	Nampula	250473	\N	\N
Tete	MOC	Tete	112221	\N	\N
Kaolack	SN	Kaolack	132000	\N	\N
Saint Louis	SN	Saint Louis	122000	\N	\N
Thies	SN	Thies	156000	\N	\N
Ziguinchor	SN	Ziguinchor	107000	\N	\N
Dodoma	EAT	Dodoma	203833	\N	\N
Arusha	EAT	Arusha	134708	\N	\N
Tanga	EAT	Tanga	187155	\N	\N
Morogoro	EAT	Morogoro	117760	\N	\N
Mbeya	EAT	Mbeya	152844	\N	\N
Shinyanga	EAT	Shinyanga	100724	\N	\N
Mwanza	EAT	Mwanza	223013	\N	\N
Kinshasa	ZRE	Kinshasa	4655313	15.1999998	-4.30000019
Lusaka	Z	Lusaka	982362	28.2000008	-15.3000002
Mariehamn	SF	Aland	9500	19.5	60.0999985
Haemeenlinna	SF	Haeme	42000	24.2999992	61
Kotka	SF	Kymi	58345	26.5	60.2999992
Rovaniemi	SF	Lappia	31000	24.3999996	66.3000031
Jyvaeskylae	SF	Suomi	65511	25.2000008	62.0999985
Joensuu	SF	Pohjols-Karjala	44000	29.5	62.4000015
Turku	SF	Turku-Pori	161292	22.1000004	60.2999992
Moss	N	Oestfold	24517	10.3999996	59.2999992
Hamar	N	Hedmark	15685	11.5	60.5
Lillehammer	N	Oppland	22118	10.3000002	61.0999985
Drammen	N	Buskerud	50855	10.1000004	59.4000015
Toensberg	N	Vestfold	8984	10.1999998	59.2000008
Skien	N	Telemark	47010	9.39999962	59.0999985
Arendal	N	Aust Agder	12174	8.39999962	58.2999992
Kristiansand	N	Vest Agder	62640	8	58.0999985
Stavanger	N	Rogaland	95089	5.5	59
Bergen	N	Hordaland	207916	5.19999981	60.2000008
Hermannsverk	N	Sogn og Fjordane	706	6.5	61.0999985
Molde	N	Moere og Romsdal	21448	7.0999999	62.5
Trondheim	N	Soer Trondelag	134426	10.1999998	63.2999992
Steinkjer	N	Nord Trondelag	20480	11.3000002	64
Bodoe	N	Nordland	34479	14.1999998	67.1999969
Tromsoe	N	Troms	48109	19	69.4000015
Vadsoe	N	Finnmark	5961	29.5	70.5
Andorra la Vella	AND	Andorra	15600	1.29999995	42.2999992
Linz	A	Upper Austria	203000	14.1800003	48.1800003
Innsbruck	A	Tyrol	118000	11.2200003	47.1699982
Graz	A	Styria	238000	15.2600002	47.4000015
St. Polten	A	Lower Austria	51102	15.3800001	48.1300011
Ghent	B	East Flanders	227483	3.5	51.4000015
Charleroi	B	Hainaut	206491	\N	\N
Prague	CZ	Praha	1215000	14.4167004	50.0833015
Ceske Budejovice	CZ	Jihocesky	174000	\N	\N
Brno	CZ	Jihomoravsky	393000	\N	\N
Ostrava	CZ	Severomoravsky	332000	\N	\N
Plzen	CZ	Zapadocesky	175000	\N	\N
Olomouc	CZ	Severomoravsky	225000	\N	\N
Zlin	CZ	Jihomoravsky	198000	\N	\N
Hradec Kralove	CZ	Vychodocesky	164000	\N	\N
Pardubice	CZ	Vychodocesky	163000	\N	\N
Liberec	CZ	Severocesky	160000	\N	\N
Usti nad Labem	CZ	Severocesky	\N	\N	\N
Bordeaux	F	Aquitaine	210336	-0.400000006	44.5099983
Caen	F	Basse Normandie	112846	-0.200000003	49.2999992
Rennes	F	Bretagne	197536	-1.39999998	48.0999985
Dijon	F	Bourgogne	146703	5.19999981	47.2000008
Orleans	F	Centre	105111	1.5	47.5
Tours	F	Centre	129509	\N	\N
Rouen	F	Haute Normandie	102723	1.5	49.2999992
Montpellier	F	Languedoc Rousillon	207996	3.5	43.2999992
Nimes	F	Languedoc Rousillon	128471	\N	\N
Perpignan	F	Languedoc Rousillon	105983	\N	\N
Limoges	F	Limousin	133464	1.20000005	45.5
Metz	F	Lorraine	119594	\N	\N
Nancy	F	Lorraine	99351	6.0999999	48.4000015
Toulouse	F	Midi Pyrenees	358688	1.20000005	43.4000015
Lille	F	Nord Pas de Calais	172142	3.29999995	50.3699989
Angers	F	Pays de la Loire	141404	\N	\N
Le Mans	F	Pays de la Loire	145502	\N	\N
Amiens	F	Picardie	131872	2.19000006	49.5499992
Marseille	F	Provence Cote dAzur	800550	5.19999981	43.2000008
Toulon	F	Provence Cote dAzur	167619	\N	\N
Grenoble	F	Rhone Alpes	150758	\N	\N
Saint Etienne	F	Rhone Alpes	199396	\N	\N
Le Havre	F	Haute Normandie	195854	\N	\N
Reims	F	Champagne Ardenne	180620	4.5	49.0999985
Brest	F	Bretagne	147956	\N	\N
Clermont Ferrand	F	Auvergne	136181	3.4000001	45.5
Aix en Provence	F	Provence Cote dAzur	123842	\N	\N
Villeurbanne	F	Rhone Alpes	116872	\N	\N
Besancon	F	Franche Comte	113828	6.19999981	47.0999985
Mulhouse	F	Alsace	108357	\N	\N
Boulogne Billancourt	F	Ile de France	101743	\N	\N
Chalons sur Marne	F	Champagne Ardenne	\N	\N	\N
Stuttgart	D	Baden Wurttemberg	588482	9.10000038	48.7000008
Potsdam	D	Brandenburg	138268	\N	\N
Wiesbaden	D	Hessen	266081	8.17000008	50.0699997
Schwerin	D	Mecklenburg Vorpommern	118291	\N	\N
Dusseldorf	D	Nordrhein Westfalen	572638	\N	\N
Mainz	D	Rheinland Pfalz	184627	8.10000038	50
Saarbrucken	D	Saarland	189012	\N	\N
Dresden	D	Sachsen	474443	\N	\N
Magdeburg	D	Sachsen Anhalt	265379	\N	\N
Kiel	D	Schleswig Holstein	246586	10.6999998	54.2000008
Erfurt	D	Thuringen	213472	\N	\N
Koln	D	Nordrhein Westfalen	963817	\N	\N
Frankfurt am Main	D	Hessen	652412	\N	\N
Essen	D	Nordrhein Westfalen	617955	\N	\N
Dortmund	D	Nordrhein Westfalen	600918	\N	\N
Duisburg	D	Nordrhein Westfalen	536106	\N	\N
Nurnberg	D	Bayern	495845	\N	\N
Leipzig	D	Sachsen	481121	\N	\N
Bochum	D	Nordrhein Westfalen	401129	\N	\N
Wuppertal	D	Nordrhein Westfalen	383776	\N	\N
Bielefeld	D	Nordrhein Westfalen	324067	\N	\N
Gelsenkirchen	D	Nordrhein Westfalen	293542	\N	\N
Bonn	D	Nordrhein Westfalen	293072	7.5	50.4000015
Halle	D	Sachsen Anhalt	290051	\N	\N
Karlsruhe	D	Baden Wurttemberg	277011	\N	\N
Chemnitz	D	Sachsen	274162	\N	\N
Monchengladbach	D	Nordrhein Westfalen	266073	\N	\N
Munster	D	Nordrhein Westfalen	264887	\N	\N
Augsburg	D	Bayern	262110	\N	\N
Braunschweig	D	Niedersachsen	254130	\N	\N
Krefeld	D	Nordrhein Westfalen	249662	\N	\N
Aachen	D	Nordrhein Westfalen	247113	\N	\N
Rostock	D	Mecklenburg Vorpommern	232634	\N	\N
Oberhausen	D	Nordrhein Westfalen	225443	\N	\N
Lubeck	D	Schleswig Holstein	216854	\N	\N
Hagen	D	Nordrhein Westfalen	213747	\N	\N
Kassel	D	Hessen	201789	\N	\N
Freiburg im Breisgau	D	Baden Wurttemberg	198496	\N	\N
Hamm	D	Nordrhein Westfalen	184020	\N	\N
Herne	D	Nordrhein Westfalen	180029	\N	\N
Mulheim an der Ruhr	D	Nordrhein Westfalen	176513	\N	\N
Osnabruck	D	Niedersachsen	168050	\N	\N
Ludwigshafen	D	Rheinland Pfalz	167883	\N	\N
Solingen	D	Nordrhein Westfalen	165973	\N	\N
Leverkusen	D	Nordrhein Westfalen	161832	\N	\N
Oldenburg	D	Niedersachsen	149691	\N	\N
Neuss	D	Nordrhein Westfalen	148870	\N	\N
Darmstadt	D	Hessen	139063	\N	\N
Heidelberg	D	Baden Wurttemberg	138964	\N	\N
Paderborn	D	Nordrhein Westfalen	131513	\N	\N
Bremerhaven	D	Bremen	130847	\N	\N
Wurzburg	D	Bayern	127946	\N	\N
Gottingen	D	Niedersachsen	127519	\N	\N
Recklinghausen	D	Nordrhein Westfalen	127139	\N	\N
Wolfsburg	D	Niedersachsen	126965	\N	\N
Gera	D	Thuringen	126035	\N	\N
Cottbus	D	Brandenburg	125643	\N	\N
Regensburg	D	Bayern	125608	\N	\N
Remscheid	D	Nordrhein Westfalen	123069	\N	\N
Heilbronn	D	Baden Wurttemberg	122253	\N	\N
Bottrop	D	Nordrhein Westfalen	119669	\N	\N
Pforzheim	D	Baden Wurttemberg	117960	\N	\N
Salzgitter	D	Niedersachsen	117842	\N	\N
Offenbach am Main	D	Hessen	116482	\N	\N
Ulm	D	Baden Wurttemberg	115123	\N	\N
Siegen	D	Nordrhein Westfalen	111541	\N	\N
Ingolstadt	D	Bayern	110910	\N	\N
Koblenz	D	Rheinland Pfalz	109550	\N	\N
Furth	D	Bayern	107799	\N	\N
Reutlingen	D	Baden Wurttemberg	107782	\N	\N
Moers	D	Nordrhein Westfalen	107011	\N	\N
Hildesheim	D	Niedersachsen	106095	\N	\N
Witten	D	Nordrhein Westfalen	105423	\N	\N
Bergisch Gladbach	D	Nordrhein Westfalen	105122	\N	\N
Zwickau	D	Sachsen	104921	\N	\N
Jena	D	Thuringen	102204	\N	\N
Kaiserslautern	D	Rheinland Pfalz	101910	\N	\N
Erlangen	D	Bayern	101450	\N	\N
Piraeus	GR	Greece	196389	\N	\N
Patrai	GR	Greece	142163	\N	\N
Larisa	GR	Greece	102426	\N	\N
Iraklion	GR	Greece	102398	\N	\N
Volos	GR	Greece	71378	\N	\N
Kavalla	GR	Greece	56705	\N	\N
Vatican City	V	Holy See	392	12.3000002	41.5
Pecs	H	Pecs (munic.)	171000	\N	\N
Kecskemet	H	Bacs Kiskun	105000	\N	\N
Miskolc	H	Miskolc (munic.)	192000	\N	\N
Szekesfehervar	H	Fejer	109000	\N	\N
Gyor	H	Gyor (munic.)	130000	\N	\N
Debrecen	H	Debrecen (munic.)	216000	\N	\N
Nyiregyhaza	H	Szabolcs Szatmar	115000	\N	\N
Szeged	H	Szeged (munic.)	178000	\N	\N
Novara	I	Piemonte	103349	\N	\N
Bergamo	I	Lombardia	117886	\N	\N
Brescia	I	Lombardia	196766	\N	\N
Bolzano	I	Trentino Alto Adige	100380	11.5	46
Trento	I	Trentino Alto Adige	102124	11.5	46
Padova	I	Veneto	218186	\N	\N
Verona	I	Veneto	258946	\N	\N
Vicenza	I	Veneto	109333	\N	\N
Trieste	I	Friuli Venezia Giulia	231047	13.4499998	45.3899994
La Spezia	I	Liguria	103008	\N	\N
Bologna	I	Emilia Romagna	411803	11.2200003	44.2999992
Ferrara	I	Emilia Romagna	140600	\N	\N
Modena	I	Emilia Romagna	177501	\N	\N
Parma	I	Emilia Romagna	173991	\N	\N
Piacenza	I	Emilia Romagna	103536	\N	\N
Ravenna	I	Emilia Romagna	136724	\N	\N
Reggio nellEmilia	I	Emilia Romagna	131880	\N	\N
Livorno	I	Toscana	171265	\N	\N
Pisa	I	Toscana	101500	\N	\N
Perugia	I	Umbria	150576	12.1999998	43.0999985
Terni	I	Umbria	109809	\N	\N
Ancona	I	Marche	103268	13.2799997	43.3800011
Latina	I	Lazio	103630	\N	\N
Pescara	I	Abruzzo	128553	\N	\N
Salerno	I	Campania	151374	\N	\N
Bari	I	Puglia	353032	16.5	41.7999992
Foggia	I	Puglia	159541	\N	\N
Lecce	I	Puglia	102344	\N	\N
Taranto	I	Puglia	244033	\N	\N
Catanzaro	I	Calabria	103802	16.3500004	38.5499992
Cosenza	I	Calabria	104483	\N	\N
Palermo	I	Sicilia	734238	13.1999998	38.0999985
Catania	I	Sicilia	364176	\N	\N
Messina	I	Calabria	274846	\N	\N
Siracusa	I	Sicilia	125444	\N	\N
Cagliari	I	Sardegna	211719	9.5	39.1500015
Sassari	I	Sardegna	120011	\N	\N
Napoli	I	Campania	1206013	14.1499996	40.5
Turin	I	Piemonte	991870	7.38999987	45.5
Genua	I	Liguria	701032	8.57999992	44.25
Firenze	I	Toscana	408403	11.1700001	43.4799995
Venice	I	Veneto	317837	12.1999998	45.2700005
Reggio di Calabria	I	Calabria	178496	\N	\N
Prato	I	Toscana	166688	\N	\N
Rimini	I	Emilia Romagna	130896	\N	\N
Monza	I	Lombardia	123188	\N	\N
Torre del Greco	I	Campania	102647	\N	\N
Arnhem	NL	Gelderland	314159	\N	\N
Haarlem	NL	Noord Holland	212631	\N	\N
s Gravenhage	NL	Zuid Holland	694249	\N	\N
s Hertogenbosch	NL	Noord Brabant	199127	\N	\N
Maastricht	NL	Limburg	164701	\N	\N
Rotterdam	NL	Zuid Holland	1078747	\N	\N
Eindhoven	NL	Noord Brabant	395612	\N	\N
Heerlen	NL	Limburg	270952	\N	\N
Enschede	NL	Overijssel	254480	\N	\N
Nijmegen	NL	Gelderland	249490	\N	\N
Tilburg	NL	Noord Brabant	237958	\N	\N
Dordrecht	NL	Zuid Holland	213963	\N	\N
Leiden	NL	Zuid Holland	194935	\N	\N
Geleen	NL	Limburg	186011	\N	\N
Breda	NL	Noord Brabant	166616	\N	\N
Zaanstreek	NL	Noord Holland	147917	\N	\N
Velsen	NL	Noord Holland	134973	\N	\N
Hilversum	NL	Noord Holland	102023	\N	\N
Bialystok	PL	Bialostockie	268000	\N	\N
Bielsko Biala	PL	Bielskie	180000	\N	\N
Bydgoszcz	PL	Bydgoskie	380000	\N	\N
Czestochowa	PL	Czestochowskie	258000	\N	\N
Elblag	PL	Elblaskie	125000	\N	\N
Gdansk	PL	Gdanskie	465000	\N	\N
Kalisz	PL	Kaliskie	106000	\N	\N
Katowice	PL	Katowickie	367000	\N	\N
Kielce	PL	Kieleckie	213000	\N	\N
Koszalin	PL	Koszalinskie	108000	\N	\N
Legnica	PL	Legnickie	104000	\N	\N
Lublin	PL	Lubelskie	350000	\N	\N
Olsztyn	PL	Olsztynskie	161000	\N	\N
Opole	PL	Opolskie	128000	\N	\N
Plock	PL	Plockie	122000	\N	\N
Poznan	PL	Poznanskie	589000	\N	\N
Radom	PL	Radomskie	226000	\N	\N
Rzeszow	PL	Rzeszowskie	151000	\N	\N
Szczecin	PL	Szczecinskie	412000	\N	\N
Tarnow	PL	Tarnowskie	120000	\N	\N
Torun	PL	Torunskie	201000	\N	\N
Walbrzych	PL	Walbrzyskie	141000	\N	\N
Wloclawek	PL	Wloclawskie	121000	\N	\N
Wroclaw	PL	Wroclawskie	642000	\N	\N
Zielona Gora	PL	Zielonogorskie	113000	\N	\N
Lodz	PL	Lodzkie	852000	\N	\N
Sosnowiec	PL	Katowickie	259000	\N	\N
Gdynia	PL	Gdanskie	251000	\N	\N
Bytom	PL	Katowickie	230000	\N	\N
Gliwice	PL	Katowickie	216000	\N	\N
Zabrze	PL	Katowickie	203000	\N	\N
Tychy	PL	Katowickie	190000	\N	\N
Ruda Slaska	PL	Katowickie	170000	\N	\N
Rybnik	PL	Katowickie	143000	\N	\N
Chorzow	PL	Katowickie	133000	\N	\N
Gorzow Wielkopolski	PL	Gorzowskie	123000	\N	\N
Wodzilaw Slaski	PL	Katowickie	111000	\N	\N
Grudziadz	PL	Torunskie	101000	\N	\N
Biala Podlaska	PL	Bialskopodlaskie	\N	\N	\N
Gorzow Wielkopolskie	PL	Gorzowskie	\N	\N	\N
Jelenia Gora	PL	Jeleniogorskie	\N	\N	\N
Nowy Sacz	PL	Nowosadeckie	\N	\N	\N
Piottrkow Trybunalski	PL	Piotrkowskie	\N	\N	\N
Amadora	P	Lisbon	95518	\N	\N
Vila Nova de Gaia	P	Porto	62468	\N	\N
Barreiro	P	Lisbon	50863	\N	\N
Funchal	P	Madeira	44111	\N	\N
Almada	P	Lisbon	42607	\N	\N
Bucharest	RO	Bucuresti	2037000	26.1000004	44.4166985
Pitesti	RO	Arges	162000	\N	\N
Oradea	RO	Bihor	225000	\N	\N
Cluj Napoca	RO	Cluj	318000	\N	\N
Craiova	RO	Dolj	300000	\N	\N
Baia Mare	RO	Maramures	150000	\N	\N
Tirgu Mures	RO	Mures	165000	\N	\N
Timisoara	RO	Timis	333000	\N	\N
Alba Iulia	RO	Alba	\N	\N	\N
Sfintu Gheorghe	RO	Covasha	\N	\N	\N
Tirgu Jiu	RO	Gorj	\N	\N	\N
Miercurea Ciuc	RO	Harghita	\N	\N	\N
Drobeta Turnu Severin	RO	Mehedinti	\N	\N	\N
Piatra Neamt	RO	Neamt	\N	\N	\N
Rimnicu Vilcea	RO	Vilcea	\N	\N	\N
Sevilla	E	Andalusia	714148	\N	\N
Zaragoza	E	Aragon	606620	\N	\N
Oviedo	E	Asturias	201712	\N	\N
Palma de Mallorca	E	Balearic Islands	322008	\N	\N
Vitoria Gasteiz	E	Basque Country	214148	\N	\N
Santa Cruz de Tenerife	E	Canary Islands	203929	\N	\N
Santander	E	Cantabria	194822	\N	\N
Valladolid	E	Castile and Leon	336917	\N	\N
Logrono	E	Rioja	124823	\N	\N
Almeria	E	Andalusia	167361	\N	\N
Cadiz	E	Andalusia	155438	-6.19999981	36.2999992
Granada	E	Andalusia	271180	\N	\N
Huelva	E	Andalusia	145049	\N	\N
Malaga	E	Andalusia	531443	\N	\N
Albacete	E	Castile and Leon	141179	\N	\N
Burgos	E	Castile and Leon	166251	\N	\N
Leon	E	Castile and Leon	147311	\N	\N
Leon	MEX	Guanajuato	758279	\N	\N
Leon	NIC	Nicaragua	171375	\N	\N
Salamanca	E	Castile and Leon	167382	\N	\N
Salamanca	MEX	Guanajuato	123190	\N	\N
Lleida	E	Catalonia	114234	\N	\N
Tarragona	E	Catalonia	114630	\N	\N
Badajoz	E	Estremadura	130153	\N	\N
La Coruna	E	Galicia	255087	\N	\N
Bilbao	E	Basque Country	371876	\N	\N
Las Palmas de Gran Canaria	E	Canary Islands	371787	\N	\N
Vigo	E	Galicia	288573	\N	\N
Alacant	E	Valencia	274964	\N	\N
Gijon	E	Asturias	269644	\N	\N
Hospitalet de Llobregat	E	Catalonia	266242	\N	\N
Badalona	E	Catalonia	219340	\N	\N
Mostoles	E	Madrid	199141	\N	\N
Elx	E	Valencia	191305	\N	\N
Jerez de la Frontera	E	Andalusia	190390	\N	\N
Sabadell	E	Catalonia	189006	\N	\N
Pamplona	E	Navarre	182465	\N	\N
Cartagena	E	Murcia	179659	\N	\N
Cartagena	CO	Bolivar	745689	\N	\N
Leganes	E	Madrid	178162	\N	\N
Donostia	E	Basque Country	177929	\N	\N
Alcala de Henares	E	Madrid	166250	\N	\N
Terrassa	E	Catalonia	161428	\N	\N
Fuenlabrada	E	Madrid	158212	\N	\N
Getafe	E	Madrid	144368	\N	\N
Alcorcon	E	Madrid	142165	\N	\N
Castellon de la Plana	E	Valencia	139094	\N	\N
Santa Coloma de Gramanet	E	Catalonia	131764	\N	\N
La Laguna	E	Canary Islands	125183	\N	\N
Jaen	E	Andalusia	112772	\N	\N
Orense	E	Galicia	108547	\N	\N
Algeciras	E	Andalusia	103787	\N	\N
Baracaldo	E	Catalonia	103594	\N	\N
Mataro	E	Catalonia	102117	\N	\N
Santiago de Compostella	E	Galicia	\N	\N	\N
Goteborg	S	Goteborg och Bohus	449189	12	57.4000015
Malmo	S	Malmohus	245699	13	55.2999992
Linkoping	S	Ostergotland	131370	15.3000002	58.2999992
Vasteras	S	Vastmanland	123728	16.2999992	59.4000015
Norrkoping	S	Ostergotland	123795	\N	\N
Helsingborg	S	Malmohus	114339	\N	\N
Bern	CH	BE	134393	7.30000019	46.5999985
Basel	CH	BS	172768	\N	\N
Geneva	CH	GE	167697	6.9000001	46.1199989
Luzern	CH	LU	59811	\N	\N
Sankt Gallen	CH	SG	74106	\N	\N
Lausanne	CH	VD	123149	\N	\N
Zurich	CH	ZH	343106	\N	\N
Winterthur	CH	ZH	86340	\N	\N
Biel	CH	BE	53308	\N	\N
Cherkasy	UA	Cherkaska	297000	\N	\N
Chernihiv	UA	Chernihivska	301000	\N	\N
Chernivtsi	UA	Chernivetska	257000	\N	\N
Dnipropetrovsk	UA	Dnipropetrovska	1187000	\N	\N
Donetsk	UA	Donetska	1117000	\N	\N
Kherson	UA	Khersonska	361000	\N	\N
Khmelnytskyy	UA	Khmelnytska	241000	\N	\N
Kirovohrad	UA	Kirovohradska	274000	\N	\N
Lviv	UA	Lvivska	798000	\N	\N
Mykolayiv	UA	Mykolayivska	508000	\N	\N
Poltava	UA	Poltavska	317000	\N	\N
Rivne	UA	Rivnenska	233000	\N	\N
Sumy	UA	Sumska	296000	\N	\N
Ternopil	UA	Ternopilska	212000	\N	\N
Vinnytsya	UA	Vinnytska	379000	\N	\N
Lutsk	UA	Volynska	204000	\N	\N
Zaporizhzhya	UA	Zaporizka	891000	\N	\N
Zhytomyr	UA	Zhytomyrska	296000	\N	\N
Simferopol	UA	Krym	349000	\N	\N
Kryvyy Rih	UA	Dnipropetrovska	717000	\N	\N
Mariupol	UA	Donetska	520000	\N	\N
Luhansk	UA	Luhanska	501000	\N	\N
Makiyivka	UA	Donetska	427000	\N	\N
Sevastopol	UA	Krym	361000	\N	\N
Horlivka	UA	Donetska	338000	\N	\N
Dniprodzerzhynsk	UA	Dnipropetrovska	284000	\N	\N
Kremenchuk	UA	Poltavska	238000	\N	\N
Ivano Frankivsk	UA	Ivano Frankivska	220000	\N	\N
London	GB	Greater London	6967500	0	51.4832993
London	CDN	Ontario	303165	-81.1500015	43.0332985
Bristol	GB	Avon	399200	\N	\N
Bedford	GB	Bedfordshire	137300	\N	\N
Reading	GB	Berkshire	137700	\N	\N
Aylesbury	GB	Buckinghamshire	151600	\N	\N
Cambridge	GB	Cambridgeshire	113800	\N	\N
Chester	GB	Cheshire	120800	\N	\N
Middlesbrough	GB	Cleveland	145800	\N	\N
Carlisle	GB	Cumbria	102900	\N	\N
Exeter	GB	Devon	105100	\N	\N
Chelmsford	GB	Essex	155700	\N	\N
Manchester	GB	Greater Manchester	431100	\N	\N
Manchester	USA	New Hampshire	100967	\N	\N
Winchester	GB	Hampshire	100500	\N	\N
Maidstone	GB	Kent	138500	\N	\N
Preston	GB	Lancashire	132200	\N	\N
Liverpool	GB	Merseyside	474000	\N	\N
Norwich	GB	Norfolk	128100	\N	\N
Northampton	GB	Northamptonshire	187200	\N	\N
Nottingham	GB	Nottinghamshire	282400	\N	\N
Oxford	GB	Oxfordshire	132000	\N	\N
Barnsley	GB	South Yorkshire	226500	\N	\N
Stafford	GB	Staffordshire	121500	\N	\N
Ipswich	GB	Suffolk	114800	\N	\N
Warwick	GB	Warwickshire	118600	\N	\N
Birmingham	GB	West Midlands	1008400	-1.93333006	52.4832993
Birmingham	USA	Alabama	258543	-86.75	33.5667
Chichester	GB	West Sussex	102500	\N	\N
Wakefield	GB	West Yorkshire	317300	\N	\N
Aberdeen	GB	Grampian	219100	\N	\N
Edinburgh	GB	Lothian	447600	-3.18333006	55.9166985
Glasgow	GB	Strathclyde	674800	-4.28332996	55.8666992
Dundee	GB	Tayside	167600	\N	\N
Belfast	GB	Northern Ireland	297100	-5.91666985	54.5999985
Leeds	GB	West Yorkshire	724400	\N	\N
Sheffield	GB	South Yorkshire	530100	\N	\N
Bradford	GB	West Yorkshire	481700	\N	\N
Kirklees	GB	West Yorkshire	386900	\N	\N
Wiral	GB	Merseyside	331100	\N	\N
Dudley	GB	West Midlands	312200	\N	\N
Wigan	GB	Greater Manchester	310000	\N	\N
Coventry	GB	West Midlands	302500	\N	\N
Leicester	GB	Leicestershire	293400	\N	\N
Doncaster	GB	South Yorkshire	292500	\N	\N
Sefton	GB	Merseyside	292400	\N	\N
Sunderland	GB	Tyne and Wear	292200	\N	\N
Stockport	GB	Greater Manchester	291400	\N	\N
Newcastle upon Tyne	GB	Tyne and Wear	283600	\N	\N
Bolton	GB	Greater Manchester	265200	\N	\N
Walsall	GB	West Midlands	263900	\N	\N
Kingston upon Hull	GB	Humberside	269100	\N	\N
Rotherham	GB	South Yorkshire	256300	\N	\N
Stoke on Trent	GB	Staffordshire	254200	\N	\N
Wolverhampton	GB	West Midlands	245100	\N	\N
Salford	GB	Greater Manchester	230700	\N	\N
Derby	GB	Derbyshire	230500	\N	\N
Tameside	GB	Greater Manchester	221800	\N	\N
Oldham	GB	Greater Manchester	220400	\N	\N
Trafford	GB	Greater Manchester	218100	\N	\N
Southampton	GB	Hampshire	211700	\N	\N
Rochdale	GB	Greater Manchester	207100	\N	\N
Gateshead	GB	Tyne and Wear	202400	\N	\N
Solihull	GB	West Midlands	202000	\N	\N
Renfrew	GB	Strathclyde	201700	\N	\N
Rochester upon Medway	GB	Kent	148200	\N	\N
Portsmouth	GB	Hampshire	189100	\N	\N
Portsmouth	USA	Virginia	101308	\N	\N
Warrington	GB	Cheshire	185000	\N	\N
Milton Keynes	GB	Buckinghamshire	184400	\N	\N
Bury	GB	Greater Manchester	181400	\N	\N
Saint Helens	GB	Merseyside	180200	\N	\N
Luton	GB	Bedfordshire	178600	\N	\N
Stockton on Tees	GB	Cleveland	177800	\N	\N
Southend on Sea	GB	Essex	167500	\N	\N
Basildon	GB	Essex	161700	\N	\N
Wycombe	GB	Buckinghamshire	161400	\N	\N
Bournemouth	GB	Dorset	159900	\N	\N
Peterborough	GB	Cambridgeshire	156400	\N	\N
Knowsley	GB	Merseyside	155300	\N	\N
West Bromwich	GB	West Midlands	154500	\N	\N
Brighton	GB	East Sussex	154400	\N	\N
Blackpool	GB	Lancashire	153600	\N	\N
Macclesfield	GB	Cheshire	151400	\N	\N
Colchester	GB	Essex	149100	\N	\N
Huntingdon	GB	Cambridgeshire	148800	\N	\N
Huddersfield	GB	West Yorkshire	148500	\N	\N
Basingstoke	GB	Hampshire	146500	\N	\N
Harrogate	GB	North Yorkshire	146500	\N	\N
Wokingham	GB	Berkshire	142900	\N	\N
Newbury	GB	Berkshire	141000	\N	\N
Blackburn	GB	Lancashire	139500	\N	\N
Poole	GB	Dorset	137200	\N	\N
Windsor	GB	Berkshire	136700	\N	\N
Windsor	CDN	Ontario	191435	-82.9666977	42.2667007
Lancaster	GB	Lancashire	133600	\N	\N
Lancaster	USA	California	115675	\N	\N
Canterbury	GB	Kent	132400	\N	\N
Kings Lynn	GB	Norfolk	131600	\N	\N
Saint Albans	GB	Hertfordshire	127700	\N	\N
Guildford	GB	Surrey	126200	\N	\N
Newcastle under Lyme	GB	Staffordshire	123000	\N	\N
Braintree	GB	Essex	121800	\N	\N
Reigate	GB	Surrey	118800	\N	\N
Nuneaton	GB	Warwickshire	118500	\N	\N
Epping Forest	GB	Essex	118200	\N	\N
Havant	GB	Hampshire	117500	\N	\N
Elmbridge	GB	Surrey	117300	\N	\N
Swale	GB	Kent	117200	\N	\N
Beverley	GB	Humberside	115800	\N	\N
Horsham	GB	West Sussex	112300	\N	\N
Salisbury	GB	Wiltshire	109800	\N	\N
Sutton in Ashfield	GB	Derbyshire	109800	\N	\N
Eastleigh	GB	Hampshire	109600	\N	\N
Crewe	GB	Cheshire	109500	\N	\N
Sevenoaks	GB	Kent	109400	\N	\N
Scarborough	GB	North Yorkshire	108700	\N	\N
Scarborough	CDN	Ontario	524598	\N	\N
Stratford on Avon	GB	Warwickshire	108600	\N	\N
Cheltenham	GB	Gloucestershire	106700	\N	\N
Stroud	GB	Gloucestershire	105400	\N	\N
Gloucester	GB	Gloucestershire	104800	\N	\N
Newark on Trent	GB	Nottinghamshire	104400	\N	\N
Rhymney Valley	GB	Vale of Glamorgan	104300	\N	\N
York	GB	North Yorkshire	104000	\N	\N
York	CDN	Ontario	140525	\N	\N
Slough	GB	Berkshire	103500	\N	\N
Mansfield	GB	Nottinghamshire	102100	\N	\N
Tonbridge	GB	Kent	102100	\N	\N
Bracknell	GB	Berkshire	101900	\N	\N
Tunbridge Wells	GB	Kent	101800	\N	\N
Chesterfield	GB	Derbyshire	101200	\N	\N
Fareham	GB	Hampshire	101000	\N	\N
Darlington	GB	Durham	100200	\N	\N
Newtown St. Boswells	GB	Borders	\N	\N	\N
Island Areas	GB	Island Areas (munic.)	\N	\N	\N
Colwyn Bay	GB	Aberconwy and Colwyn	\N	\N	\N
Ebbw Vale	GB	Blaenau Gwent	\N	\N	\N
Ystrad Fawr	GB	Caerphilly	\N	\N	\N
Port Talbot	GB	Neath and Port Talbot	\N	\N	\N
Llandrindod Wells	GB	Powys	\N	\N	\N
Dhaka	BD	Bangladesh	3839000	90.5	24
Khulna	BD	Bangladesh	731000	\N	\N
Rajshahi	BD	Bangladesh	318000	\N	\N
Narayanganj	BD	Bangladesh	296000	\N	\N
Rangpur	BD	Bangladesh	207000	\N	\N
Mymensingh	BD	Bangladesh	202000	\N	\N
Barisal	BD	Bangladesh	188000	\N	\N
Tongi	BD	Bangladesh	181000	\N	\N
Comilla	BD	Bangladesh	156000	\N	\N
Jessore	BD	Bangladesh	154000	\N	\N
Nawabganj	BD	Bangladesh	141000	\N	\N
Dinajpur	BD	Bangladesh	138000	\N	\N
Bogra	BD	Bangladesh	130000	\N	\N
Brahmanbaria	BD	Bangladesh	125000	\N	\N
Savar	BD	Bangladesh	115000	\N	\N
Tangail	BD	Bangladesh	114000	\N	\N
Pabna	BD	Bangladesh	112000	\N	\N
Jamalpur	BD	Bangladesh	111000	\N	\N
Naogaon	BD	Bangladesh	110000	\N	\N
Sylhet	BD	Bangladesh	109000	\N	\N
Sirajganj	BD	Bangladesh	108000	\N	\N
Narsinghdi	BD	Bangladesh	106000	\N	\N
Saidpur	BD	Bangladesh	105000	\N	\N
Gazipur	BD	Bangladesh	104000	\N	\N
Bandar Seri Begawan	BRU	Brunei	56300	115	5
Pathein	MYA	Ayeyarwady	144100	\N	\N
Moulmein	MYA	Mon	220000	\N	\N
Akyab	MYA	Rakhine	107600	\N	\N
Taunggyi	MYA	Shan	108200	\N	\N
Monywa	MYA	Sagaing	106800	\N	\N
Hpa an	MYA	Kayin	\N	\N	\N
Beijing	TJ	Beijing (munic.)	7000000	116.199997	39.5
Hefei	TJ	Anhui	1000000	117	32
Huainan	TJ	Anhui	1200000	\N	\N
Suzhou	TJ	Anhui	151862	\N	\N
Suzhou	TJ	Jiangsu	706459	\N	\N
Bengbu	TJ	Anhui	449245	\N	\N
Wuhu	TJ	Anhui	425740	\N	\N
Huaibei	TJ	Anhui	366549	\N	\N
Maanshan	TJ	Anhui	305421	\N	\N
Anqing	TJ	Anhui	250718	\N	\N
Tongling	TJ	Anhui	228017	\N	\N
Fuyang	TJ	Anhui	179572	\N	\N
Luan	TJ	Anhui	144248	\N	\N
Chuxian	TJ	Anhui	125341	\N	\N
Chaoxian	TJ	Anhui	123676	\N	\N
Xuancheng	TJ	Anhui	112673	\N	\N
Fuzhou	TJ	Fujian	874809	119	26
Fuzhou	TJ	Jiangxi	1290000	\N	\N
Xiamen	TJ	Fujian	368786	\N	\N
Nanping	TJ	Fujian	195064	\N	\N
Quanzhou	TJ	Fujian	185154	\N	\N
Zhangzhou	TJ	Fujian	181424	\N	\N
Sanming	TJ	Fujian	160691	\N	\N
Longyan	TJ	Fujian	134481	\N	\N
Yongan	TJ	Fujian	111762	\N	\N
Lanzhou	TJ	Gansu	1510000	104	36
Tianshui	TJ	Gansu	244974	\N	\N
Baiyin	TJ	Gansu	204970	\N	\N
Wuwei	TJ	Gansu	133101	\N	\N
Yumen	TJ	Gansu	109234	\N	\N
Guangzhou	TJ	Guangdong	3580000	114	23
Shantou	TJ	Guangdong	578630	\N	\N
Zhanjiang	TJ	Guangdong	400997	\N	\N
Shenzhen	TJ	Guangdong	350727	\N	\N
Shaoguan	TJ	Guangdong	350043	\N	\N
Chaozhou	TJ	Guangdong	313469	\N	\N
Dongguan	TJ	Guangdong	308669	\N	\N
Foshan	TJ	Guangdong	303160	\N	\N
Zhongshan	TJ	Guangdong	278829	\N	\N
Jiangmen	TJ	Guangdong	230587	\N	\N
Yangjiang	TJ	Guangdong	215196	\N	\N
Zhaoqing	TJ	Guangdong	194784	\N	\N
Maoming	TJ	Guangdong	178683	\N	\N
Zhuhai	TJ	Guangdong	164747	\N	\N
Huizhou	TJ	Guangdong	161023	\N	\N
Meixian	TJ	Guangdong	132156	\N	\N
Heyuan	TJ	Guangdong	120101	\N	\N
Shanwei	TJ	Guangdong	107847	\N	\N
Guiyang	TJ	Guizhou	1530000	106	26
Liupanshui	TJ	Guizhou	363954	\N	\N
Zunyi	TJ	Guizhou	261862	\N	\N
Anshun	TJ	Guizhou	174142	\N	\N
Duyun	TJ	Guizhou	132971	\N	\N
Kaili	TJ	Guizhou	113958	\N	\N
Haikou	TJ	Hainan	280153	\N	\N
Sanya	TJ	Hainan	102820	\N	\N
Shijiazhuang	TJ	Hebei	1320000	114.5	38
Tangshan	TJ	Hebei	1500000	\N	\N
Handan	TJ	Hebei	1110000	\N	\N
Zhangjiakou	TJ	Hebei	529136	\N	\N
Baoding	TJ	Hebei	483155	\N	\N
Qinhuangdao	TJ	Hebei	364972	\N	\N
Xingtai	TJ	Hebei	302789	\N	\N
Chengde	TJ	Hebei	246799	\N	\N
Renqiu	TJ	Hebei	114256	\N	\N
Quzhou	TJ	Hebei	112373	\N	\N
Hengshui	TJ	Hebei	104269	\N	\N
Harbin	TJ	Heilongjiang	2830000	126.400002	45.4000015
Qiqihar	TJ	Heilongjiang	1380000	\N	\N
Yichun	TJ	Heilongjiang	795789	\N	\N
Yichun	TJ	Jiangxi	151585	\N	\N
Jixi	TJ	Heilongjiang	683885	\N	\N
Daqing	TJ	Heilongjiang	657297	\N	\N
Mudanjiang	TJ	Heilongjiang	571705	\N	\N
Hegang	TJ	Heilongjiang	522747	\N	\N
Jiamusi	TJ	Heilongjiang	493409	\N	\N
Shuangyashan	TJ	Heilongjiang	386081	\N	\N
Suihua	TJ	Heilongjiang	227881	\N	\N
Shangzhi	TJ	Heilongjiang	215373	\N	\N
Qitaihe	TJ	Heilongjiang	214957	\N	\N
Beian	TJ	Heilongjiang	204899	\N	\N
Acheng	TJ	Heilongjiang	197595	\N	\N
Zhaodong	TJ	Heilongjiang	179976	\N	\N
Fuling	TJ	Heilongjiang	173878	\N	\N
Shuangcheng	TJ	Heilongjiang	142659	\N	\N
Anda	TJ	Heilongjiang	136446	\N	\N
Mishan	TJ	Heilongjiang	132744	\N	\N
Zhengzhou	TJ	Henan	1710000	114	34.5
Luoyang	TJ	Henan	1190000	\N	\N
Kaifeng	TJ	Henan	507763	\N	\N
Xinxiang	TJ	Henan	473762	\N	\N
Anyang	TJ	Henan	420332	\N	\N
Pingdingshan	TJ	Henan	410775	\N	\N
Jiaozuo	TJ	Henan	409100	\N	\N
Nanyang	TJ	Henan	243303	\N	\N
Hebi	TJ	Henan	212976	\N	\N
Xuchang	TJ	Henan	208815	\N	\N
Xinyang	TJ	Henan	192509	\N	\N
Puyang	TJ	Henan	175988	\N	\N
Shangqiu	TJ	Henan	164880	\N	\N
Zhoukou	TJ	Henan	146288	\N	\N
Luohe	TJ	Henan	126438	\N	\N
Zhumadian	TJ	Henan	123232	\N	\N
Sanmenxia	TJ	Henan	120523	\N	\N
Wuhan	TJ	Hubei	3750000	114.150002	30.4500008
Huangshi	TJ	Hubei	457601	\N	\N
Xiangfan	TJ	Hubei	410407	\N	\N
Yichang	TJ	Hubei	371601	\N	\N
Shashi	TJ	Hubei	281352	\N	\N
Shiyan	TJ	Hubei	273786	\N	\N
Cangzhou	TJ	Hubei	242708	\N	\N
Honghu	TJ	Hubei	190772	\N	\N
Echeng	TJ	Hubei	190123	\N	\N
Tianmen	TJ	Hubei	186332	\N	\N
Xiaogan	TJ	Hubei	166280	\N	\N
Zaoyang	TJ	Hubei	162198	\N	\N
Xianning	TJ	Hubei	136811	\N	\N
Laohekou	TJ	Hubei	123366	\N	\N
Puqi	TJ	Hubei	117264	\N	\N
Shishou	TJ	Hubei	104571	\N	\N
Guangshui	TJ	Hubei	102770	\N	\N
Changsha	TJ	Hunan	1330000	113.5	28.1000004
Hengyang	TJ	Hunan	487148	\N	\N
Xiangtan	TJ	Hunan	441968	\N	\N
Zhuzhou	TJ	Hunan	409924	\N	\N
Yueyang	TJ	Hunan	302800	\N	\N
Changde	TJ	Hunan	301276	\N	\N
Shaoyang	TJ	Hunan	247227	\N	\N
Yiyang	TJ	Hunan	185818	\N	\N
Lengshuijiang	TJ	Hunan	137994	\N	\N
Leiyang	TJ	Hunan	130115	\N	\N
Loudi	TJ	Hunan	128418	\N	\N
Huaihua	TJ	Hunan	126785	\N	\N
Zixing	TJ	Hunan	110048	\N	\N
Liling	TJ	Hunan	108504	\N	\N
Yuanjiang	TJ	Hunan	107004	\N	\N
Nanjing	TJ	Jiangsu	2500000	119	32.5
Wuxi	TJ	Jiangsu	826833	\N	\N
Xuzhou	TJ	Jiangsu	805695	\N	\N
Changzhou	TJ	Jiangsu	531470	\N	\N
Zhenjiang	TJ	Jiangsu	368316	\N	\N
Lianyungang	TJ	Jiangsu	354139	\N	\N
Nantong	TJ	Jiangsu	343341	\N	\N
Yangzhou	TJ	Jiangsu	312892	\N	\N
Yancheng	TJ	Jiangsu	296831	\N	\N
Huaiyin	TJ	Jiangsu	239675	\N	\N
Jiangyin	TJ	Jiangsu	213659	\N	\N
Yixing	TJ	Jiangsu	200824	\N	\N
Dongtai	TJ	Jiangsu	192247	\N	\N
Changshu	TJ	Jiangsu	181805	\N	\N
Danyang	TJ	Jiangsu	169603	\N	\N
Xinghua	TJ	Jiangsu	161910	\N	\N
Taizhou	TJ	Jiangsu	152442	\N	\N
Huaian	TJ	Jiangsu	131149	\N	\N
Liyang	TJ	Jiangsu	109520	\N	\N
Yizheng	TJ	Jiangsu	109268	\N	\N
Suqian	TJ	Jiangsu	105021	\N	\N
Kunshan	TJ	Jiangsu	102052	\N	\N
Nanchang	TJ	Jiangxi	1350000	115.5	28.3999996
Pingxiang	TJ	Jiangxi	425579	\N	\N
Jiujiang	TJ	Jiangxi	291187	\N	\N
Jingdezhen	TJ	Jiangxi	281183	\N	\N
Ganzhou	TJ	Jiangxi	220129	\N	\N
Xinyu	TJ	Jiangxi	173524	\N	\N
Shangrao	TJ	Jiangxi	132455	\N	\N
Changchun	TJ	Jilin	2110000	125.150002	43.5
Hunjiang	TJ	Jilin	482043	\N	\N
Liaoyuan	TJ	Jilin	354141	\N	\N
Tonghua	TJ	Jilin	324600	\N	\N
Siping	TJ	Jilin	317223	\N	\N
Dunhua	TJ	Jilin	235100	\N	\N
Yanji	TJ	Jilin	230892	\N	\N
Gongzhuling	TJ	Jilin	226569	\N	\N
Baicheng	TJ	Jilin	217987	\N	\N
Meihekou	TJ	Jilin	209038	\N	\N
Fuyu	TJ	Jilin	192981	\N	\N
Jiutai	TJ	Jilin	180130	\N	\N
Huadian	TJ	Jilin	175873	\N	\N
Longjing	TJ	Jilin	139417	\N	\N
Daan	TJ	Jilin	138963	\N	\N
Shenyang	TJ	Liaoning	4540000	123.300003	42
Dalian	TJ	Liaoning	2400000	\N	\N
Anshan	TJ	Liaoning	1390000	\N	\N
Fushun	TJ	Liaoning	1350000	\N	\N
Benxi	TJ	Liaoning	768778	\N	\N
Fuxin	TJ	Liaoning	635473	\N	\N
Jinzhou	TJ	Liaoning	569518	\N	\N
Dandong	TJ	Liaoning	523699	\N	\N
Liaoyang	TJ	Liaoning	492559	\N	\N
Yingkou	TJ	Liaoning	421589	\N	\N
Panshan	TJ	Liaoning	362773	\N	\N
Jinxi	TJ	Liaoning	357052	\N	\N
Tieling	TJ	Liaoning	254842	\N	\N
Wafangdian	TJ	Liaoning	251733	\N	\N
Chaoyang	TJ	Liaoning	222394	\N	\N
Haicheng	TJ	Liaoning	205560	\N	\N
Beipiao	TJ	Liaoning	194301	\N	\N
Fengcheng	TJ	Liaoning	193784	\N	\N
Xingcheng	TJ	Liaoning	102384	\N	\N
Xining	TJ	Qinghai	551776	102	37
Yushu	TJ	Qinghai	131861	\N	\N
Xian	TJ	Shaanxi	2760000	109	34
Xianyang	TJ	Shaanxi	352125	\N	\N
Baoji	TJ	Shaanxi	337765	\N	\N
Tongchuan	TJ	Shaanxi	280657	\N	\N
Hanzhong	TJ	Shaanxi	169930	\N	\N
Ankang	TJ	Shaanxi	142170	\N	\N
Weinan	TJ	Shaanxi	140169	\N	\N
Yanan	TJ	Shaanxi	113277	\N	\N
Jinan	TJ	Shandong	2320000	117	36.5
Zibo	TJ	Shandong	2460000	\N	\N
Qingdao	TJ	Shandong	2060000	\N	\N
Yantai	TJ	Shandong	452127	\N	\N
Weifang	TJ	Shandong	428522	\N	\N
Zaozhuang	TJ	Shandong	380846	\N	\N
Taian	TJ	Shandong	350696	\N	\N
Linyi	TJ	Shandong	324720	\N	\N
Tengxian	TJ	Shandong	315083	\N	\N
Dongying	TJ	Shandong	281728	\N	\N
Xintai	TJ	Shandong	281248	\N	\N
Jining	TJ	Shandong	265248	\N	\N
Jining	TJ	Nei Monggol	163552	\N	\N
Laiwu	TJ	Shandong	246833	\N	\N
Liaocheng	TJ	Shandong	207844	\N	\N
Dezhou	TJ	Shandong	195485	\N	\N
Heze	TJ	Shandong	189293	\N	\N
Rizhao	TJ	Shandong	185048	\N	\N
Liancheng	TJ	Shandong	156307	\N	\N
Jiaoxian	TJ	Shandong	153364	\N	\N
Pingdu	TJ	Shandong	150123	\N	\N
Longkou	TJ	Shandong	148362	\N	\N
Laiyang	TJ	Shandong	137080	\N	\N
Wendeng	TJ	Shandong	133910	\N	\N
Weihai	TJ	Shandong	128888	\N	\N
Linqing	TJ	Shandong	123958	\N	\N
Jiaonan	TJ	Shandong	121397	\N	\N
Zhucheng	TJ	Shandong	102134	\N	\N
Taiyuan	TJ	Shanxi	1960000	112.300003	38
Datong	TJ	Shanxi	1110000	\N	\N
Yangquan	TJ	Shanxi	362268	\N	\N
Changzhi	TJ	Shanxi	317144	\N	\N
Yuci	TJ	Shanxi	191356	\N	\N
Linfen	TJ	Shanxi	187309	\N	\N
Jincheng	TJ	Shanxi	136396	\N	\N
Chengdu	TJ	Sichuan	2810000	107.150002	33.1500015
Chongqing	TJ	Sichuan	2980000	\N	\N
Dukou	TJ	Sichuan	415466	\N	\N
Zigong	TJ	Sichuan	393184	\N	\N
Leshan	TJ	Sichuan	341128	\N	\N
Mianyang	TJ	Sichuan	262947	\N	\N
Luzhou	TJ	Sichuan	262892	\N	\N
Neijiang	TJ	Sichuan	256012	\N	\N
Yibin	TJ	Sichuan	241019	\N	\N
Qianjiang	TJ	Sichuan	205504	\N	\N
Daxian	TJ	Sichuan	188101	\N	\N
Deyang	TJ	Sichuan	182488	\N	\N
Guangyuan	TJ	Sichuan	182241	\N	\N
Nanchong	TJ	Sichuan	180273	\N	\N
Jiangyou	TJ	Sichuan	175753	\N	\N
Wanxian	TJ	Sichuan	156823	\N	\N
Xichang	TJ	Sichuan	134419	\N	\N
Kunming	TJ	Yunnan	1520000	102.400002	25.5
Gejiu	TJ	Yunnan	214294	\N	\N
Qujing	TJ	Yunnan	178669	\N	\N
Hangzhou	TJ	Zhejiang	1340000	125.5	30.2000008
Ningbo	TJ	Zhejiang	1090000	\N	\N
Wenzhou	TJ	Zhejiang	401871	\N	\N
Huzhou	TJ	Zhejiang	218071	\N	\N
Jiaxing	TJ	Zhejiang	211526	\N	\N
Shaoxing	TJ	Zhejiang	179818	\N	\N
Xiaoshan	TJ	Zhejiang	162930	\N	\N
Ruian	TJ	Zhejiang	156468	\N	\N
Zhoushan	TJ	Zhejiang	156317	\N	\N
Jinhua	TJ	Zhejiang	144280	\N	\N
Yuyao	TJ	Zhejiang	114056	\N	\N
Cixi	TJ	Zhejiang	107329	\N	\N
Haining	TJ	Zhejiang	100478	\N	\N
Tianjin	TJ	Tianjin (munic.)	5770000	\N	\N
Hohhot	TJ	Nei Monggol	652534	113	41
Baotou	TJ	Nei Monggol	1200000	\N	\N
Yakeshi	TJ	Nei Monggol	377869	\N	\N
Chifeng	TJ	Nei Monggol	350077	\N	\N
Wuhai	TJ	Nei Monggol	264081	\N	\N
Tongliao	TJ	Nei Monggol	255129	\N	\N
Hailar	TJ	Nei Monggol	180650	\N	\N
Ulanhot	TJ	Nei Monggol	159538	\N	\N
Linhe	TJ	Nei Monggol	133183	\N	\N
Manzhouli	TJ	Nei Monggol	120023	\N	\N
Urumqi	TJ	Xinjiang Uygur	1160000	88	44
Shihezi	TJ	Xinjiang Uygur	299676	\N	\N
Karamay	TJ	Xinjiang Uygur	197602	\N	\N
Yining	TJ	Xinjiang Uygur	177193	\N	\N
Kashi	TJ	Xinjiang Uygur	174570	\N	\N
Aksu	TJ	Xinjiang Uygur	164092	\N	\N
Hami	TJ	Xinjiang Uygur	161315	\N	\N
Korla	TJ	Xinjiang Uygur	159344	\N	\N
Nanning	TJ	Guangxi Zhuangzu	1070000	108.5	22.5
Liuzhou	TJ	Guangxi Zhuangzu	609320	\N	\N
Guilin	TJ	Guangxi Zhuangzu	364130	\N	\N
Wuzhou	TJ	Guangxi Zhuangzu	210452	\N	\N
Yinchuan	TJ	Ningxia Huizu	356652	106.199997	38.2999992
Shizuishan	TJ	Ningxia Huizu	257862	\N	\N
Qinzhou	TJ	Guangxi Zhuangzu	114586	\N	\N
Guixian	TJ	Guangxi Zhuangzu	114025	\N	\N
Beihai	TJ	Guangxi Zhuangzu	112673	\N	\N
Lhasa	TJ	Tibet	106885	91	29.5
Hyderabad	PK	Pakistan	1107000	\N	\N
Hyderabad	IND	Andhra Pradesh	3145939	78.1999969	17.1000004
Patna	IND	Bihar	917243	85	25.3999996
Bhopal	IND	Madhya Pradesh	1062771	77.4000015	23.1000004
Bhubaneswar	IND	Orissa	411542	85.5	20.2000008
Jaipur	IND	Rajasthan	1458183	75.5	27
Lucknow	IND	Uttar Pradesh	1619115	81	27
Mumbai	IND	Maharashtra	9925891	72.5	19
Ahmadabad	IND	Gujarat	2954526	\N	\N
Kanpur	IND	Uttar Pradesh	1879420	\N	\N
Pune	IND	Maharashtra	1566651	\N	\N
Surat	IND	Gujarat	1505872	\N	\N
Indore	IND	Madhya Pradesh	1091674	\N	\N
Vadodara	IND	Gujarat	1061598	\N	\N
Ludhiana	IND	Punjab	1042740	\N	\N
Kalyan	IND	Maharashtra	1014557	\N	\N
Haora	IND	West Bengal	950435	\N	\N
Madurai	IND	Tamil Nadu	940989	\N	\N
Varanasi	IND	Uttar Pradesh	932399	\N	\N
Agra	IND	Uttar Pradesh	891790	\N	\N
Coimbatore	IND	Tamil Nadu	816321	\N	\N
Allahabad	IND	Uttar Pradesh	806486	\N	\N
Thane	IND	Maharashtra	803389	\N	\N
Jabalpur	IND	Madhya Pradesh	764586	\N	\N
Meerut	IND	Uttar Pradesh	753778	\N	\N
Vishakhapatnam	IND	Andhra Pradesh	752037	\N	\N
Amritsar	IND	Punjab	708835	\N	\N
Vijayawada	IND	Andhra Pradesh	701827	\N	\N
Trivandrum	IND	Kerala	699872	77	8.19999981
Gwalior	IND	Madhya Pradesh	690765	\N	\N
Jodhpur	IND	Rajasthan	666279	\N	\N
Nasik	IND	Maharashtra	656925	\N	\N
Hubli	IND	Karnataka	648298	\N	\N
Faridabad	IND	Uttar Pradesh	617717	\N	\N
Rajkot	IND	Gujarat	612458	\N	\N
Mysore	IND	Karnataka	606755	\N	\N
Sholapur	IND	Maharashtra	604215	\N	\N
Ranchi	IND	Bihar	599306	\N	\N
Srinagar	IND	Jammu and Kashmir	594775	74.3000031	34
Bareilly	IND	Uttar Pradesh	590661	\N	\N
Gauhati	IND	Assam	584342	\N	\N
Cochin	IND	Kerala	582588	\N	\N
Aurangabad	IND	Maharashtra	573272	\N	\N
Kota	IND	Rajasthan	537371	\N	\N
Jalandhar	IND	Punjab	509510	\N	\N
Gorakhpur	IND	Uttar Pradesh	505566	\N	\N
Aligarh	IND	Uttar Pradesh	480520	\N	\N
Jamshedpur	IND	Bihar	478950	\N	\N
Guntur	IND	Andhra Pradesh	471051	\N	\N
Kozhikode	IND	Kerala	456618	\N	\N
Ghaziabad	IND	Delhi	454156	\N	\N
Warangal	IND	Andhra Pradesh	447653	\N	\N
Raipur	IND	Madhya Pradesh	438639	\N	\N
Moradabad	IND	Uttar Pradesh	429214	\N	\N
Durgapur	IND	West Bengal	425836	\N	\N
Amravati	IND	Maharashtra	421576	\N	\N
Bikaner	IND	Rajasthan	416289	\N	\N
Kolhapur	IND	Maharashtra	406370	\N	\N
Cuttack	IND	Orissa	403418	\N	\N
Ajmer	IND	Rajasthan	402700	\N	\N
Bhavnagar	IND	Gujarat	402338	\N	\N
Bhilai	IND	Madhya Pradesh	395360	\N	\N
Bhiwandi	IND	Maharashtra	392214	\N	\N
Tiruchchirappalli	IND	Tamil Nadu	387223	\N	\N
Saharanpur	IND	Uttar Pradesh	374945	\N	\N
Ulhasnagar	IND	Maharashtra	369077	\N	\N
Salem	IND	Tamil Nadu	366712	\N	\N
Salem	USA	Oregon	122566	-123.016998	44.9166985
Ujjain	IND	Madhya Pradesh	362633	\N	\N
Jamnagar	IND	Gujarat	350544	\N	\N
Bokara Steel City	IND	Bihar	333683	\N	\N
Rajahmundry	IND	Andhra Pradesh	324881	\N	\N
Bhatpara	IND	Madhya Pradesh	315976	\N	\N
Jhansi	IND	Uttar Pradesh	313491	\N	\N
New Bombay	IND	Maharashtra	307724	\N	\N
Port Blair	IND	Andaman and Nicobar Is.	\N	92.5	11.3999996
Jakarta	RI	Indonesia	8259266	106.5	-6.0999999
Bandung	RI	Indonesia	2058649	107.400002	-6.57999992
Semarang	RI	Indonesia	1250971	\N	\N
Yogyakarta	RI	Indonesia	412392	\N	\N
Banda Aceh	RI	Indonesia	184699	\N	\N
Bengkulu	RI	Indonesia	170327	\N	\N
Jambi	RI	Indonesia	339944	\N	\N
Bandar Lampung	RI	Indonesia	636706	\N	\N
Padang	RI	Indonesia	631543	\N	\N
Pontianak	RI	Indonesia	397343	\N	\N
Banjarmasin	RI	Indonesia	481371	\N	\N
Palangkaraya	RI	Indonesia	112562	\N	\N
Samarinda	RI	Indonesia	407339	\N	\N
Ujung Pandang	RI	Indonesia	944685	\N	\N
Ambon	RI	Indonesia	276955	\N	\N
Malang	RI	Indonesia	695618	\N	\N
Surakarta	RI	Indonesia	504176	\N	\N
Pekan Baru	RI	Indonesia	398694	\N	\N
Balikpapan	RI	Indonesia	344405	\N	\N
Manado	RI	Indonesia	320990	\N	\N
Bogor	RI	Indonesia	271711	\N	\N
Cirebon	RI	Indonesia	254878	\N	\N
Kediri	RI	Indonesia	249807	\N	\N
Pekalongan	RI	Indonesia	242874	\N	\N
Tegal	RI	Indonesia	229713	\N	\N
Pematang Siantar	RI	Indonesia	219328	\N	\N
Binjai	RI	Indonesia	181904	\N	\N
Probolinggo	RI	Indonesia	177120	\N	\N
Madiun	RI	Indonesia	170242	\N	\N
Pasuruan	RI	Indonesia	152409	\N	\N
Magelang	RI	Indonesia	123213	\N	\N
Sukabumi	RI	Indonesia	119981	\N	\N
Gorontalo	RI	Indonesia	119780	\N	\N
Blitar	RI	Indonesia	119011	\N	\N
Tebing Tinggi	RI	Indonesia	116767	\N	\N
Pangkal Pinang	RI	Indonesia	113163	\N	\N
Tanjung Balai	RI	Indonesia	108202	\N	\N
Batam	RI	Indonesia	106667	\N	\N
Pare Pare	RI	Indonesia	101527	\N	\N
Orumiyeh	IR	Azarbayian e Gharbt	396392	45	37.2999992
Tabriz	IR	Azarbayian e Sharqi	1166203	46.2000008	38.0999985
Shiraz	IR	Fars	1042801	52.2999992	29.3999996
Rasht	IR	Gilan	374475	49.4000015	37.2000008
Bandar Abbas	IR	Hormozgan	383515	\N	\N
Mashhad	IR	Khorasan	1964489	59.4000015	36.2000008
Ahvaz	IR	Khuzestan	828380	48.4000015	31.2000008
Sanandaj	IR	Kordestan	277314	\N	\N
Khorramabad	IR	Lorestan	277370	\N	\N
Arak	IR	Markazi	378597	\N	\N
Sari	IR	Mazandaran	167602	\N	\N
Zahedan	IR	Sistan e Baluchestan	419886	\N	\N
Qom	IR	Tehran	780453	50.5	34.4000015
Karaj	IR	Tehran	588287	\N	\N
Ardabil	IR	Azarbayian e Sharqi	329869	\N	\N
Qazvin	IR	Tehran	298705	\N	\N
Borujerd	IR	Lorestan	201016	\N	\N
Khorramshahr	IR	Khuzestan	197241	\N	\N
Dezful	IR	Khuzestan	181309	\N	\N
Gorgan	IR	Mazandaran	162468	\N	\N
Najafabad	IR	Esfahan	160004	\N	\N
Kashan	IR	Tehran	155188	\N	\N
Sabzevar	IR	Khorasan	148065	\N	\N
Amol	IR	Mazandaran	139923	\N	\N
Khvoy	IR	Azarbayian e Gharbt	137885	\N	\N
Babol	IR	Mazandaran	137348	\N	\N
Neyshabur	IR	Khorasan	135681	\N	\N
Bandar e Bushehr	IR	Bushehr	132824	\N	\N
Malayer	IR	Hamadan	130458	\N	\N
Qaemshahr	IR	Mazandaran	123684	\N	\N
Khomeynishahr	IR	Esfahan	118348	\N	\N
Maragheh	IR	Azarbayian e Gharbt	117388	\N	\N
Bojnurd	IR	Khorasan	112426	\N	\N
Sirjan	IR	Kerman	107887	\N	\N
Masjed e Soleyman	IR	Khuzestan	107539	\N	\N
Gonbad e Kavus	IR	Mazandaran	102768	\N	\N
Birjand	IR	Khorasan	101177	\N	\N
Shahr e Kord	IR	Chahar Mahal e Bakhtiari	\N	\N	\N
Kirkuk	IRQ	Ad Tamim	418624	\N	\N
Al Hillah	IRQ	Babil	268834	\N	\N
An Nasiriyah	IRQ	Dhi Qar	265937	\N	\N
Al Amarah	IRQ	Maysan	208797	\N	\N
Diwaniyah	IRQ	Al Qadisiyah	196519	\N	\N
Ar Ramadi	IRQ	Al Anbar	192556	\N	\N
Al Kut	IRQ	Wasit	183183	\N	\N
Baqubah	IRQ	Diyala	114516	\N	\N
As Samawah	IRQ	Al Muthanna	\N	\N	\N
Al Mawsil	IRQ	Ninawa	\N	\N	\N
Ad Diwaniyah	IRQ	Al Qadisiyah	\N	\N	\N
Beer Sheva	IL	South	\N	\N	\N
Sendai	J	Miyagi	967000	\N	\N
Yokohama	J	Kanagawa	3256000	139.320007	35.2999992
Nagoya	J	Aichi	2108000	\N	\N
Kobe	J	Hyogo	1388000	\N	\N
Kawasaki	J	Kanagawa	1187000	\N	\N
Kita kyushu	J	Fukuoka	1012000	\N	\N
Karaganda	KAZ	Qaraghandy	573700	\N	\N
Shymkent	KAZ	Ongtustik Qazaqstan	397600	\N	\N
Oskemen	KAZ	Shyghys Qazaqstan	326300	\N	\N
Petropavl	KAZ	Soltustik Qazaqstan	239000	\N	\N
Oral	KAZ	Batys Qazaqstan	219100	\N	\N
Temirtau	KAZ	Qaraghandy	206100	\N	\N
Aqtau	KAZ	Mangghystau	151300	\N	\N
Ekibastuz	KAZ	Pavlodar	141100	\N	\N
Dzhambul	KAZ	Zhambyl	130600	\N	\N
Rudny	KAZ	Qostanay	125700	\N	\N
Zhezqazghan	KAZ	Zhezkazghan	108700	\N	\N
Pyongyang	NOK	North Korea	2335000	125.682999	39.0332985
Hamhung Hungnam	NOK	North Korea	701000	\N	\N
Chongjin	NOK	North Korea	520000	\N	\N
Nampo	NOK	North Korea	370000	\N	\N
Sunchon	NOK	North Korea	356000	\N	\N
Sinuiju	NOK	North Korea	289000	\N	\N
Tanchon	NOK	North Korea	284000	\N	\N
Wonsan	NOK	North Korea	274000	\N	\N
Tokchon	NOK	North Korea	217000	\N	\N
Kanggye	NOK	North Korea	211000	\N	\N
Haeju	NOK	North Korea	195000	\N	\N
Anju	NOK	North Korea	186000	\N	\N
Songjin	NOK	North Korea	179000	\N	\N
Kusong	NOK	North Korea	177000	\N	\N
Huichon	NOK	North Korea	163000	\N	\N
Sinpo	NOK	North Korea	158000	\N	\N
Kaesong	NOK	North Korea	120000	\N	\N
Seoul	ROK	South Korea	10229262	126.967003	37.5667
Pusan	ROK	South Korea	3813814	\N	\N
Taegu	ROK	South Korea	2449139	\N	\N
Inchon	ROK	South Korea	2307618	\N	\N
Kwangju	ROK	South Korea	1257504	\N	\N
Taejon	ROK	South Korea	1272143	\N	\N
Ulsan	ROK	South Korea	967394	\N	\N
Suwon	ROK	South Korea	755502	\N	\N
Songnam	ROK	South Korea	869243	\N	\N
Chonju	ROK	South Korea	563406	\N	\N
Masan	ROK	South Korea	441358	\N	\N
Chongju	ROK	South Korea	531195	\N	\N
Chinju	ROK	South Korea	329913	\N	\N
Mokpo	ROK	South Korea	247524	\N	\N
Cheju	ROK	South Korea	258509	\N	\N
Kunsan	ROK	South Korea	266517	\N	\N
Chunchon	ROK	South Korea	235067	\N	\N
Yosu	ROK	South Korea	183557	\N	\N
George Town	MAL	Pulau Pinang	219376	\N	\N
Johor Baharu	MAL	Johor	328646	\N	\N
Alor Setar	MAL	Kedah	125026	\N	\N
Kota Baharu	MAL	Kelantan	219713	\N	\N
Seremban	MAL	Negeri Sembilan	182584	\N	\N
Kuantan	MAL	Pahang	198356	\N	\N
Ipoh	MAL	Perak	382633	\N	\N
Kota Kinabalu	MAL	Sabah	208484	\N	\N
Kuching	MAL	Sarawak	147729	\N	\N
Shah Alam	MAL	Selangor	101733	\N	\N
Kuala Terengganu	MAL	Terengganu	228654	\N	\N
Petaling Jaya	MAL	Fed. Terr. of Kuala Lumpur	254849	\N	\N
Tawai	MAL	Sabah	244765	\N	\N
Kelang	MAL	Selangor	243698	\N	\N
Sandakan	MAL	Sabah	223432	\N	\N
Taiping	MAL	Perak	183165	\N	\N
Sibu	MAL	Sarawak	126384	\N	\N
Islamabad	PK	Pakistan	204364	73	34
Quetta	PK	Pakistan	285719	\N	\N
Peshawar	PK	Pakistan	1676000	\N	\N
Lyallpur	PK	Pakistan	1875000	\N	\N
Gujranwala	PK	Pakistan	1663000	\N	\N
Rawalpindi	PK	Pakistan	1290000	\N	\N
Multan	PK	Pakistan	1257000	\N	\N
Sialkot	PK	Pakistan	302009	\N	\N
Sargodha	PK	Pakistan	291362	\N	\N
Lahore Cantonment	PK	Pakistan	237000	\N	\N
Jhang	PK	Pakistan	195558	\N	\N
Sukkur	PK	Pakistan	190551	\N	\N
Bahawalpur	PK	Pakistan	180263	\N	\N
Kasur	PK	Pakistan	155523	\N	\N
Gujrat	PK	Pakistan	155058	\N	\N
Okara	PK	Pakistan	153483	\N	\N
Sahiwal	PK	Pakistan	150954	\N	\N
Mardan	PK	Pakistan	147977	\N	\N
Sheikhupura	PK	Pakistan	141168	\N	\N
Mirpur Khas	PK	Pakistan	124371	\N	\N
Larkana	PK	Pakistan	123890	\N	\N
Wah Cantonment	PK	Pakistan	122335	\N	\N
Rahim Yar Khan	PK	Pakistan	119036	\N	\N
Jhelum	PK	Pakistan	106462	\N	\N
Chiniot	PK	Pakistan	105559	\N	\N
Nawabshah	PK	Pakistan	102139	\N	\N
Dera Ghazi Khan	PK	Pakistan	102007	\N	\N
Port Moresby	PNG	Papua New Guinea	141500	147.149994	-9.48332977
Quezon	RP	Philippines	1989000	\N	\N
Kalookan	RP	Philippines	1023000	\N	\N
Davao	RP	Philippines	1007000	\N	\N
Cebu	RP	Philippines	662000	\N	\N
Zamboanga	RP	Philippines	511000	\N	\N
Makati	RP	Philippines	484000	\N	\N
Pasig	RP	Philippines	471000	\N	\N
Cagayan de Oro	RP	Philippines	428000	\N	\N
Pasay	RP	Philippines	409000	\N	\N
Petrozavodsk	R	Rep. of Karelia	280000	\N	\N
Syktyvkar	R	Rep. of Komi	229000	\N	\N
Vologda	R	Vologodskaya oblast	299000	\N	\N
Murmansk	R	Murmanskaya oblast	407000	\N	\N
Novgorod	R	Novgorodskaya oblast	233000	\N	\N
Pskov	R	Pskovskaya oblast	207000	\N	\N
Bryansk	R	Bryanskaya oblast	462000	\N	\N
Vladimir	R	Vladimirskaya oblast	339000	\N	\N
Ivanovo	R	Ivanovskaya oblast	474000	\N	\N
Kaluga	R	Kaluzhskaya oblast	347000	\N	\N
Kostroma	R	Kostromskaya oblast	285000	\N	\N
Ryazan	R	Ryazanskaya oblast	536000	\N	\N
Smolensk	R	Smolenskaya oblast	355000	\N	\N
Tver	R	Tverskaya oblast	455000	\N	\N
Tula	R	Tulskaya oblast	532000	\N	\N
Yaroslavl	R	Yaroslavskaya oblast	629000	\N	\N
Yoshkar Ola	R	Rep. of Mariy El	251000	\N	\N
Saransk	R	Rep. of Mordovia	320000	\N	\N
Cheboksary	R	Chuvash Republic	450000	\N	\N
Kirov	R	Kirovskaya oblast	464000	\N	\N
Nizhniy Novgorod	R	Nizhegorodskaya oblast	1383000	\N	\N
Belgorod	R	Belgorodskaya oblast	322000	\N	\N
Voronezh	R	Voronezhskaya oblast	908000	\N	\N
Kursk	R	Kurskaya oblast	442000	\N	\N
Lipetsk	R	Lipetskaya oblast	474000	\N	\N
Tambov	R	Tambovskaya oblast	316000	\N	\N
Kazan	R	Rep. of Tatarstan	1085000	\N	\N
Astrakhan	R	Astrakhanskaya oblast	486000	\N	\N
Penza	R	Penzenskaya oblast	534000	\N	\N
Samara	R	Samarskaya oblast	1184000	\N	\N
Saratov	R	Saratovskaya oblast	895000	\N	\N
Ufa	R	Rep. of Bashkortostan	1094000	\N	\N
Izhevsk	R	Udmurt Republic	654000	\N	\N
Orenburg	R	Orenburgskaya oblast	532000	\N	\N
Perm	R	Permskaya oblast	1032000	\N	\N
Maykop	R	Rep. of Adygeya	165000	\N	\N
Makhachkala	R	Rep. of Dagestan	339000	\N	\N
Nalchik	R	Kabardino Balkar Rep.	239000	\N	\N
Cherkessk	R	Karachayevo Cherkessk Rep.	119000	\N	\N
Vladikavkaz	R	Rep. of North Ossetiya	312000	\N	\N
Krasnodar	R	Krasnodarsky kray	646000	\N	\N
Stavropol	R	Stavropolsky kray	342000	\N	\N
Kurgan	R	Kurganskaya oblast	363000	\N	\N
Yekaterinburg	R	Sverdlovskaya oblast	1280000	\N	\N
Chelyabinsk	R	Chelyabinskaya oblast	1086000	\N	\N
Barnaul	R	Altayskiy kray	596000	\N	\N
Kemerovo	R	Kemerovskaya oblast	503000	\N	\N
Novosibirsk	R	Novosibirskaya oblast	1369000	\N	\N
Omsk	R	Omskaya oblast	1163000	\N	\N
Tomsk	R	Tomskaya oblast	470000	\N	\N
Tyumen	R	Tyumenskaya oblast	494000	\N	\N
Ulan Ude	R	Rep. of Buryatiya	366000	\N	\N
Abakan	R	Rep. of Khakassiya	161000	\N	\N
Irkutsk	R	Irkutskaya oblast	585000	\N	\N
Chita	R	Chitinskaya oblast	322000	\N	\N
Yakutsk	R	Rep. of Sakha	192000	\N	\N
Khabarovsk	R	Khabarovskiy kray	618000	\N	\N
Blagoveshchensk	R	Amurskaya oblast	214000	\N	\N
Magadan	R	Magadanskaya oblast	128000	\N	\N
Yuzhno Sakhalinsk	R	Sakhalinskaya oblast	160000	\N	\N
Rostov na Donu	R	Rostovskaya oblast	1026000	\N	\N
Tolyatti	R	Samarskaya oblast	702000	\N	\N
Simbirsk	R	Ulyanovskaya oblast	678000	\N	\N
Novokuznetsk	R	Kemerovskaya oblast	572000	\N	\N
Naberezhnye Chelny	R	Rep. of Tatarstan	526000	\N	\N
Magnitogorsk	R	Chelyabinskaya oblast	427000	\N	\N
Nizhniy Tagil	R	Sverdlovskaya oblast	409000	\N	\N
Grozny	R	Chechen Rep.	364000	\N	\N
Sochi	R	Krasnodarsky kray	355000	\N	\N
Orel	R	Orlovskaya oblast	348000	\N	\N
Cherepovets	R	Vologodskaya oblast	320000	\N	\N
Komsomolsk na Amure	R	Khabarovskiy kray	309000	\N	\N
Taganrog	R	Rostovskaya oblast	292000	\N	\N
Volzhsky	R	Volgogradskaya oblast	288000	\N	\N
Dzerzhinsk	R	Nizhegorodskaya oblast	285000	\N	\N
Orsk	R	Orenburgskaya oblast	275000	\N	\N
Angarsk	R	Irkutskaya oblast	267000	\N	\N
Surgut	R	Tyumenskaya oblast	263000	\N	\N
Sterlitamak	R	Rep. of Bashkortostan	259000	\N	\N
Bratsk	R	Irkutskaya oblast	257000	\N	\N
Prokopyevsk	R	Kemerovskaya oblast	253000	\N	\N
Rybinsk	R	Yaroslavskaya oblast	248000	\N	\N
Severodvinsk	R	Arkhangelskaya oblast	241000	\N	\N
Nizhnevartovsk	R	Tyumenskaya oblast	238000	\N	\N
Shakhty	R	Rostovskaya oblast	230000	\N	\N
Biysk	R	Altayskiy kray	228000	\N	\N
Nizhnekamsk	R	Rep. of Tatarstan	210000	\N	\N
Petropavlovsk Kamchatsky	R	Kamchatskaya oblast	210000	\N	\N
Balakovo	R	Saratovskaya oblast	206000	\N	\N
Zlatoust	R	Chelyabinskaya oblast	203000	\N	\N
Novorossiysk	R	Krasnodarsky kray	202000	\N	\N
Podolsk	R	Moskovskaya oblast	202000	\N	\N
Stary Oskol	R	Belgorodskaya oblast	198000	\N	\N
Kamensk Uralskiy	R	Sverdlovskaya oblast	197000	\N	\N
Zelenograd	R	Moskovskaya oblast	191000	\N	\N
Novocherkassk	R	Rostovskaya oblast	190000	\N	\N
Engels	R	Saratovskaya oblast	186000	\N	\N
Berezniki	R	Permskaya oblast	184000	\N	\N
Volgodonsk	R	Rostovskaya oblast	183000	\N	\N
Syzran	R	Samarskaya oblast	177000	\N	\N
Rubtsovsk	R	Altayskiy kray	170000	\N	\N
Miass	R	Chelyabinskaya oblast	167000	\N	\N
Lyubertsy	R	Moskovskaya oblast	166000	\N	\N
Armavir	R	Krasnodarsky kray	164000	\N	\N
Nakhodka	R	Primorsky kray	163000	\N	\N
Kovrov	R	Vladimirskaya oblast	162000	\N	\N
Ussuriysk	R	Primorsky kray	162000	\N	\N
Norilsk	R	Krasnoyarskiy kray	159000	\N	\N
Salavat	R	Rep. of Bashkortostan	156000	\N	\N
Kolomna	R	Moskovskaya oblast	154000	\N	\N
Mytishchi	R	Moskovskaya oblast	152000	\N	\N
Elektrostal	R	Moskovskaya oblast	150000	\N	\N
Novomoskovsk	R	Tulskaya oblast	144000	\N	\N
Kolpino	R	Leningradskaya oblast	143000	\N	\N
Serpukhov	R	Moskovskaya oblast	139000	\N	\N
Almetyevsk	R	Rep. of Tatarstan	138000	\N	\N
Pervouralsk	R	Sverdlovskaya oblast	137000	\N	\N
Balashikha	R	Moskovskaya oblast	136000	\N	\N
Dimitrovgrad	R	Ulyanovskaya oblast	135000	\N	\N
Khimki	R	Moskovskaya oblast	134000	\N	\N
Pyatigorsk	R	Stavropolsky kray	133000	\N	\N
Nevinnomyssk	R	Stavropolsky kray	131000	\N	\N
Odintsovo	R	Moskovskaya oblast	129000	\N	\N
Kamyshin	R	Volgogradskaya oblast	128000	\N	\N
Murom	R	Vladimirskaya oblast	126000	\N	\N
Orekhovo Zuyevo	R	Moskovskaya oblast	126000	\N	\N
Achinsk	R	Krasnoyarskiy kray	123000	\N	\N
Novocheboksarsk	R	Chuvash Republic	123000	\N	\N
Leninsk Kuznetskiy	R	Kemerovskaya oblast	121000	\N	\N
Kislovodsk	R	Stavropolsky kray	120000	\N	\N
Yelets	R	Lipetskaya oblast	119000	\N	\N
Noginsk	R	Moskovskaya oblast	119000	\N	\N
Neftekamsk	R	Stavropolsky kray	117000	\N	\N
Velikiye Luki	R	Pskovskaya oblast	116000	\N	\N
Kiselyovsk	R	Kemerovskaya oblast	116000	\N	\N
Novokuybyshevsk	R	Samarskaya oblast	115000	\N	\N
Arzamas	R	Nizhegorodskaya oblast	112000	\N	\N
Novotroitsk	R	Orenburgskaya oblast	110000	\N	\N
Oktyabrsky	R	Rep. of Bashkortostan	110000	\N	\N
Ust Ilimsk	R	Irkutskaya oblast	110000	\N	\N
Kansk	R	Krasnoyarskiy kray	109000	\N	\N
Sarapul	R	Udmurt Republic	109000	\N	\N
Michurinsk	R	Tambovskaya oblast	108000	\N	\N
Obninsk	R	Kaluzhskaya oblast	108000	\N	\N
Solikamsk	R	Permskaya oblast	108000	\N	\N
Shchyolkovo	R	Moskovskaya oblast	108000	\N	\N
Glazov	R	Udmurt Republic	107000	\N	\N
Novoshakhtinsk	R	Rostovskaya oblast	107000	\N	\N
Usolye Sibirskoye	R	Irkutskaya oblast	106000	\N	\N
Ukhta	R	Rep. of Komi	106000	\N	\N
Mezhdurechensk	R	Kemerovskaya oblast	105000	\N	\N
Vorkuta	R	Rep. of Komi	104000	\N	\N
Votkinsk	R	Udmurt Republic	104000	\N	\N
Kineshma	R	Ivanovskaya oblast	103000	\N	\N
Anzhero Sudzhensk	R	Kemerovskaya oblast	101000	\N	\N
Zelenodolysk	R	Rep. of Tatarstan	101000	\N	\N
Kuznetsk	R	Penzenskaya oblast	100000	\N	\N
Serov	R	Sverdlovskaya oblast	100000	\N	\N
Rostov no Donu	R	Rostovskaya oblast	\N	\N	\N
Gorno Altaysk	R	Rep. of Altay	\N	\N	\N
Fengshan	RC	Taiwan	301374	\N	\N
Fengyuan	RC	Taiwan	157548	\N	\N
Panchiao	RC	Taiwan	539115	\N	\N
Chilung	RC	Taiwan	370049	\N	\N
Chungho	RC	Taiwan	387123	\N	\N
Sanchuung	RC	Taiwan	382880	\N	\N
Hsinchuang	RC	Taiwan	328758	\N	\N
Chungli	RC	Taiwan	295825	\N	\N
Yungho	RC	Taiwan	241104	\N	\N
Hsintien	RC	Taiwan	248822	\N	\N
Dushanbe	TAD	Dushanbe (munic.)	582400	68.4800034	38.2999992
Qurghonteppa	TAD	Khatlon	58400	\N	\N
Khujand	TAD	Leninobod	164500	\N	\N
Nakhon si Thammarat	THA	Thailand	112000	\N	\N
Mersin	TR	Icel	523000	\N	\N
Karaman Maras	TR	Karamanmaras	242200	\N	\N
Izmit	TR	Kocaeli	275800	\N	\N
Urfa	TR	Sanliurfa	357900	\N	\N
Gebze	TR	Kocaeli	237300	\N	\N
Tarsus	TR	Icel	225000	\N	\N
Adapazari	TR	Kocaeli	186000	\N	\N
Iskenderun	TR	Hatay	156800	\N	\N
Osmaniye	TR	Adana	138000	\N	\N
Antakya	TR	Hatay	137200	\N	\N
Karabuk	TR	Zonguldak	113900	\N	\N
Ashgabat	TM	Ahal	416400	58.2000008	37.5800018
Nebitdag	TM	Balkan	89100	\N	\N
Charjew	TM	Leban	166400	\N	\N
Tashauz	TM	Dashhowuz	117000	\N	\N
Dubai	UAE	United Arab Emirates	585189	55	25
Al Ayn	UAE	United Arab Emirates	176441	\N	\N
Sharjah	UAE	United Arab Emirates	125123	\N	\N
Urganch	UZB	Khorazm	135000	\N	\N
Qarshi	UZB	Qasqadare	177000	\N	\N
Nukus	UZB	Qoraqalpoghiston	185000	\N	\N
Quqon	UZB	Farghona	184000	\N	\N
Chirchiq	UZB	Toshkent	156000	\N	\N
Angren	UZB	Toshkent	132000	\N	\N
Marghilon	UZB	Farghona	129000	\N	\N
Olmaliq	UZB	Toshkent	116000	\N	\N
Saigon	VN	Vietnam	3924435	106.5	10.5
Nha Trang	VN	Vietnam	263093	\N	\N
Hue	VN	Vietnam	260489	\N	\N
Nam Dinh	VN	Vietnam	219615	\N	\N
Long Xuyen	VN	Vietnam	214037	\N	\N
Qui Nhon	VN	Vietnam	201912	\N	\N
Thai Nguyen	VN	Vietnam	171815	\N	\N
Vung Tau	VN	Vietnam	133558	\N	\N
Hong Gai	VN	Vietnam	129394	\N	\N
Cam Pha	VN	Vietnam	127408	\N	\N
Viet Tri	VN	Vietnam	116084	\N	\N
Saint Johns	AG	Antigua and Barbuda	36000	-61.5	17.2999992
Saint Johns	CDN	Newfoundland	143390	-52.5	47.2999992
Ottawa	CDN	Ontario	313987	-75.5	45.2999992
Vaughan	CDN	Ontario	111359	\N	\N
Laval	CDN	Quebec	314398	\N	\N
Montreal	CDN	Quebec	1017666	-73.5	45.2999992
Longueuil	CDN	Quebec	129874	\N	\N
Edmonton	CDN	Alberta	616741	-113.516998	53.5667
Calgary	CDN	Alberta	710677	-114.016998	51.0999985
Toronto	CDN	Ontario	635395	-79.5	43.5
Kitchener	CDN	Ontario	168282	-80.5	43.4333
Oshawa	CDN	Ontario	129344	-78.8666992	43.9000015
North York	CDN	Ontario	562564	\N	\N
Mississauga	CDN	Ontario	463388	\N	\N
Etobicoke	CDN	Ontario	309993	\N	\N
Brampton	CDN	Ontario	234445	\N	\N
Markham	CDN	Ontario	153811	\N	\N
Burlington	CDN	Ontario	129575	\N	\N
Saint Catharines	CDN	Ontario	129300	\N	\N
Thunder Bay	CDN	Ontario	113746	-89.3167038	48.3666992
Nepean	CDN	Ontario	107627	\N	\N
East York	CDN	Ontario	102696	\N	\N
Winnipeg	CDN	Manitoba	616790	-97.0999985	49.5
Vancouver	CDN	British Columbia	471844	-122.400002	48.5
Burnaby	CDN	British Columbia	158858	\N	\N
Richmond	CDN	Quebec	126624	\N	\N
Richmond	USA	Virginia	198267	-77.3332977	37.5
Regina	CDN	Saskatchewan	179178	-104.667	50.4333
Saskatoon	CDN	Saskatchewan	186058	-107	52
Halifax	CDN	Nova Scotia	114455	-63.4000015	44.4000015
Puntarenas	CR	Punarenas	92400	\N	\N
Bayamo	C	Granma	137663	\N	\N
Victoria de las Tunas	C	Las Tunas	126930	\N	\N
Santa Clara	C	Villa Clara	205400	\N	\N
Manzanillo	C	Granma	107650	\N	\N
Nueva Gerona	C	Isla de la Juventud	\N	\N	\N
Santo Domingo	DOM	Dominican Republic	1400000	-69.9000015	18.4832993
Nueva San Salvador	ES	El Salvador	116575	\N	\N
Soyapango	ES	El Salvador	251811	\N	\N
Mejicanos	ES	El Salvador	145000	\N	\N
Delgado	ES	El Salvador	104790	\N	\N
Apopa	ES	El Salvador	100763	\N	\N
San Francisco Gotera	ES	El Salvador	\N	\N	\N
Saint Georges	WG	Grenada	30000	-61.4000015	12.3999996
Mixco	GCA	Guatemala	209791	\N	\N
Villa Nueva	GCA	Guatemala	101295	\N	\N
El Progreso	HCA	Yoro	70000	\N	\N
La Ceiba	HCA	Atlantida	77100	\N	\N
Santa Rosa de Copan	HCA	Copan	21500	\N	\N
San Pedro Sula	HCA	Cortes	325900	\N	\N
Jutigalpa	HCA	Olancho	22500	\N	\N
Danli	HCA	El Paraiso	35500	\N	\N
Puerto Cortes	HCA	Cortes	32500	\N	\N
Siguatepeque	HCA	Francisco Morazan	32200	\N	\N
Tela	HCA	Atlantida	24000	\N	\N
Olanchito	HCA	Yoro	15900	\N	\N
Puerto Lempira	HCA	Gracias a Dios	\N	\N	\N
La Esperanza	HCA	Intibuca	\N	\N	\N
Mexicali	MEX	Baja California	438377	-115.300003	32.4000015
Tuxtla Gutierrez	MEX	Chiapas	289626	-93.0999985	16.5
Saltillo	MEX	Coahuila	420947	-101	25.2999992
Morelia	MEX	Michoacan	428486	-101.099998	19.3999996
Cuernavaca	MEX	Morelos	279187	-99.1999969	19
Tepic	MEX	Nayarit	206967	-104.5	21.2999992
Culiacan	MEX	Sinaloa	415046	-107.400002	24.5
Hermosillo	MEX	Sonora	406417	-111	29
Villahermosa	MEX	Tabasco	261231	-93	18
Ciudad Victoria	MEX	Tamaulipas	194996	-99.0999985	23.3999996
Nezahualcoyotl	MEX	Chiapas	1255456	\N	\N
Juarez	MEX	Chihuahua	789522	\N	\N
Tijuana	MEX	Baja California	698752	\N	\N
Zapopan	MEX	Jalisco	668323	\N	\N
Guadalupe	MEX	Nuevo Leon	535332	\N	\N
Acapulco	MEX	Guerrero	515374	\N	\N
Torreon	MEX	Coahuila	439436	\N	\N
San Nicolas de los Garza	MEX	Nuevo Leon	436603	\N	\N
Victoria de Durango	MEX	Durango	348036	\N	\N
Tlaquepaque	MEX	Jalisco	328031	\N	\N
Toluca	MEX	Mexico, Estado de	327865	\N	\N
Xalapa Enriquez	MEX	Veracruz	279451	\N	\N
Tampico	MEX	Tamaulipas	272690	\N	\N
Matamoros	MEX	Tamaulipas	266055	\N	\N
Reynosa	MEX	Tamaulipas	265663	\N	\N
Irapuato	MEX	Guanajuato	265042	\N	\N
Mazatlan	MEX	Sinaloa	262705	\N	\N
Ciudad Obregon	MEX	Sonora	219980	\N	\N
Nuevo Laredo	MEX	Tamaulipas	218413	\N	\N
Celaya	MEX	Guanajuato	214856	\N	\N
Coatzacoalcos	MEX	Veracruz	198817	\N	\N
Uruapan	MEX	Michoacan	187623	\N	\N
Monclova	MEX	Coahuila	177792	\N	\N
Pachuca	MEX	Hidalgo	174013	\N	\N
Ensenada	MEX	Baja California	169426	\N	\N
Cancun	MEX	Quintana Roo	167730	\N	\N
Gomez Palacio	MEX	Durango	164092	\N	\N
Ciudad Santa Catarina	MEX	Nuevo Leon	162707	\N	\N
Los Mochis	MEX	Sinaloa	162659	\N	\N
Ciudad Madero	MEX	Tamaulipas	160331	\N	\N
Poza Rica	MEX	Veracruz	151739	\N	\N
Tonala	MEX	Chiapas	151190	\N	\N
Minatitlan	MEX	Veracruz	142060	\N	\N
Tehuacan	MEX	Puebla	139450	\N	\N
Tapachula	MEX	Chiapas	138858	\N	\N
Orizaba	MEX	Veracruz	114216	\N	\N
Cuautla	MEX	Jalisco	110242	\N	\N
Zamora	MEX	Michoacan	109751	\N	\N
Heroica Nogales	MEX	Sonora	105873	\N	\N
Pachuca de Soto	MEX	Hidalgo	83892	-98.4000015	20.1000004
Toluca de Lerdo	MEX	Mexico, Estado de	136100	-99.4000015	19.2000008
Chinandega	NIC	Nicaragua	101211	\N	\N
Masaya	NIC	Nicaragua	100646	\N	\N
Penonome	PA	Cocle	61000	\N	\N
David	PA	Chiriqui	102700	\N	\N
Chitre	PA	Herrera	34700	\N	\N
Las Tablas	PA	Los Santos	21100	\N	\N
San Miguelito	PA	Panama	243000	\N	\N
El Porvenir	PA	Comarca de San Blas	\N	\N	\N
La Palma	PA	Darien	\N	\N	\N
Los Angeles	USA	California	3553638	-118	34
Chicago	USA	Illinois	2721547	-87.6333008	41.8833008
Houston	USA	Texas	1744058	-95.3499985	29.9666996
Philadelphia	USA	Pennsylvania	1478002	-75.25	39.8833008
San Diego	USA	California	1171121	-117.167	32.7332993
Phoenix	USA	Arizona	1159014	-112.199997	33.2000008
San Antonio	USA	Texas	1067816	-98.4000015	29.2999992
Dallas	USA	Texas	1053292	-96.8499985	32.8499985
Detroit	USA	Michigan	1000272	-83.0167007	42.4166985
Indianapolis	USA	Indiana	746737	-86.2833023	39.7332993
San Francisco	USA	California	735315	-122.383003	37.6166992
Jacksonville	USA	Florida	679792	-81.6999969	30.5
Baltimore	USA	Maryland	675401	-76.4167023	39.3333015
Columbus	USA	Georgia	182828	\N	\N
Columbus	USA	Ohio	657053	-83	39.5
El Paso	USA	Texas	599865	\N	\N
Memphis	USA	Tennessee	596725	-90	35.0499992
Milwaukee	USA	Wisconsin	590503	-87.9000015	42.9500008
Boston	USA	Massachusetts	558394	-71.0333023	42.3666992
Austin	USA	Texas	541278	-97.6999969	30.2999992
Seattle	USA	Washington	524704	\N	\N
Nashville Davidson	USA	Tennessee	511263	\N	\N
Denver	USA	Colorado	497840	-104.866997	39.75
Portland	USA	Oregon	480824	-122.599998	45.5999985
Fort Worth	USA	Texas	479716	-97.0999985	32.4000015
New Orleans	USA	Louisiana	476625	-90.25	29.9832993
Oklahoma City	USA	Oklahoma	469852	-97.3000031	35.2999992
Tucson	USA	Arizona	449002	\N	\N
Charlotte	USA	North Carolina	441297	-80.9332962	35.2167015
Kansas City	USA	Kansas	142654	\N	\N
Kansas City	USA	Missouri	441259	-94.5832977	39.1166992
Virginia Beach	USA	Virginia	430385	\N	\N
Honolulu	USA	Hawaii	423475	-157.917007	21.3332996
Long Beach	USA	California	421904	-118.150002	33.8167
Albuquerque	USA	New Mexico	419681	\N	\N
Atlanta	USA	Georgia	401907	-84.4000015	33.4000015
Fresno	USA	California	396011	\N	\N
Tulsa	USA	Oklahoma	378491	-95.9000015	36.2000008
Las Vegas	USA	Nevada	376906	-115.199997	36.2000008
Sacramento	USA	California	376243	-121.5	38.5167007
Oakland	USA	California	367230	-122.317001	37.8167
Miami	USA	Florida	365127	-80.0999985	25.3999996
Omaha	USA	Nebraska	364253	-95.9000015	41.2999992
Minneapolis	USA	Minnesota	358785	\N	\N
St. Louis	USA	Missouri	351565	-90.3833008	38.75
Pittsburgh	USA	Pennsylvania	350363	-80	40.4500008
Cincinnati	USA	Ohio	345818	-84.5167007	39.1500015
Colorado Springs	USA	Colorado	345127	-104.717003	38.8167
Mesa	USA	Arizona	344764	\N	\N
Wichita	USA	Kansas	320395	-97.4167023	37.6500015
Buffalo	USA	New York	310548	-78.7332993	42.9333
Arlington	USA	Texas	294816	\N	\N
Arlington	USA	Virginia	175334	\N	\N
Anaheim	USA	California	288945	\N	\N
Tampa	USA	Florida	285206	\N	\N
Corpus Christi	USA	Texas	280260	-97.5	27.7667007
Newark	USA	New Jersey	268510	-74.1667023	40.7000008
Louisville	USA	Kentucky	260689	-85.7332993	38.1833
St. Paul	USA	Minnesota	259606	-93	45
Riverside	USA	California	255069	\N	\N
Aurora	USA	Colorado	252341	\N	\N
Aurora	USA	Illinois	116405	-88.3332977	41.75
Anchorage	USA	Alaska	250505	-150.016998	61.1666985
Raleigh	USA	North Carolina	243835	-78.4000015	35.5
Lexington Fayette	USA	Kentucky	239942	\N	\N
St. Petersburg	USA	Florida	235988	-83.3332977	27.7667007
Stockton	USA	California	232660	-121.25	37.9000015
Jersey City	USA	New Jersey	229039	\N	\N
Rochester	USA	New York	221594	-77.6667023	43.1166992
Akron	USA	Ohio	216882	\N	\N
Baton Rouge	USA	Louisiana	215882	-91.1500015	30.5333004
Bakersfield	USA	California	205508	-119.050003	35.4166985
Hialeah	USA	Florida	204684	\N	\N
Mobile	USA	Alabama	202581	-88.25	30.6833
Madison	USA	Wisconsin	197630	-89.1999969	43
Montgomery	USA	Alabama	196363	-86.3666992	32.3833008
Greensboro	USA	North Carolina	195426	\N	\N
Lubbock	USA	Texas	193565	-101.817001	33.6500015
Des Moines	USA	Iowa	193422	-93.6500015	41.5332985
Jackson	USA	Mississippi	192923	-90.0832977	32.3167
Chesapeake	USA	Virginia	192342	\N	\N
Plano	USA	Texas	192280	\N	\N
Shreveport	USA	Louisiana	191558	\N	\N
Huntington Beach	USA	California	190751	\N	\N
Yonkers	USA	New York	190316	\N	\N
Garland	USA	Texas	190055	\N	\N
Grand Rapids	USA	Michigan	188242	-85.5167007	42.8833008
Fremont	USA	California	187800	\N	\N
Spokane	USA	Washington	186562	\N	\N
Fort Wayne	USA	Indiana	184783	-85.1999969	41
Glendale	USA	Arizona	182219	\N	\N
Glendale	USA	California	184321	\N	\N
San Bernardino	USA	California	183474	\N	\N
Tacoma	USA	Washington	179114	\N	\N
Scottsdale	USA	Arizona	179012	\N	\N
Modesto	USA	California	178559	-121	37.6500015
Irving	USA	Texas	176993	\N	\N
Newport News	USA	Virginia	176122	\N	\N
Little Rock	USA	Arkansas	175752	-92.3000031	34.4000015
Orlando	USA	Florida	173902	-81.3833008	28.5499992
Dayton	USA	Ohio	172947	-84.2166977	39.9000015
Salt Lake City	USA	Utah	172575	-112	40.4000015
Huntsville	USA	Alabama	170424	-86.5832977	34.7000008
Amarillo	USA	Texas	169588	-100.699997	35.2332993
Knoxville	USA	Tennessee	167535	-83.9832993	35.8167
Laredo	USA	Texas	164899	-99.4499969	27.5333004
Tempe	USA	Arizona	162701	\N	\N
Syracuse	USA	New York	155865	-76.1166992	43.1166992
Reno	USA	Nevada	155499	-119.782997	39.5
Winston Salem	USA	North Carolina	153541	\N	\N
Boise	USA	Idaho	152737	-116.199997	43.4000015
Providence	USA	Rhode Island	152558	-71.4332962	41.7332993
Chula Vista	USA	California	151963	\N	\N
Fort Lauderdale	USA	Florida	151805	\N	\N
Oxnard	USA	California	151009	-119.182999	34.2000008
Chattanooga	USA	Tennessee	150425	-85.1999969	35.0332985
Paterson	USA	New Jersey	150270	-74.1500015	40.9000015
Springfield	USA	Illinois	112921	-89.6667023	39.8333015
Springfield	USA	Massachusetts	149948	\N	\N
Springfield	USA	Missouri	143407	-93.3833008	37.2332993
Garden Grove	USA	California	149208	\N	\N
Oceanside	USA	California	145941	-117.417	33.2332993
Rockford	USA	Illinois	143531	-89.0500031	42.3499985
Chandler	USA	Arizona	142918	\N	\N
Moreno Valley	USA	California	140932	\N	\N
Hampton	USA	Virginia	138757	\N	\N
Warren	USA	Michigan	138078	\N	\N
Bridgeport	USA	Connecticut	137990	-73.1832962	41.1833
Tallahassee	USA	Florida	136812	-84.0999985	30.2000008
Torrance	USA	California	136183	\N	\N
Lakewood	USA	Colorado	134999	\N	\N
Flint	USA	Michigan	134881	-83.7332993	42.9667015
Pomona	USA	California	134706	-117.75	34.0499992
Pasadena	USA	California	134116	-118.150002	34.1500015
Pasadena	USA	Texas	131620	\N	\N
Hartford	USA	Connecticut	133086	-72.4000015	41.2999992
Brownsville	USA	Texas	132091	\N	\N
Overland Park	USA	Kansas	131053	\N	\N
Hollywood	USA	Florida	127894	\N	\N
Irvine	USA	California	127873	\N	\N
Lansing	USA	Michigan	125736	-84.5999985	42.7832985
Sunnyvale	USA	California	125156	\N	\N
Santa Clarita	USA	California	125153	\N	\N
New Haven	USA	Connecticut	124665	-73.9167023	41.3167
Eugene	USA	Oregon	123718	-123.217003	44.1166992
Evansville	USA	Indiana	123456	-87.5333023	38.0499992
Henderson	USA	Nevada	122339	\N	\N
Santa Rosa	USA	California	121879	-122.817001	38.5167007
Santa Rosa	RA	La Pampa	107000	-64.1999969	-36.4000015
Hayward	USA	California	121631	\N	\N
Fullerton	USA	California	120188	\N	\N
Orange	USA	California	119890	\N	\N
Topeka	USA	Kansas	119658	-95.6333008	39.0667
Sterling Heights	USA	Michigan	118698	\N	\N
Rancho Cucamonga	USA	California	116613	\N	\N
Escondido	USA	California	116184	-117.083	33.1166992
Cedar Rapids	USA	Iowa	113482	-91.6999969	41.8833008
Thousand Oaks	USA	California	113368	\N	\N
Macon	USA	Georgia	113352	-83.6500015	32.7000008
Sioux Falls	USA	South Dakota	113223	-96.7332993	43.5667
Columbia	USA	South Carolina	112773	-81.1166992	33.9500008
Peoria	USA	Illinois	112306	-89.6832962	40.6666985
Mesquite	USA	Texas	111947	\N	\N
Salinas	USA	California	111757	-121.599998	36.6666985
Beaumont	USA	Texas	111224	-94.0167007	29.9500008
Inglewood	USA	California	111040	\N	\N
Gary	USA	Indiana	110975	\N	\N
Independence	USA	Missouri	110303	\N	\N
Elizabeth	USA	New Jersey	110149	\N	\N
Stamford	USA	Connecticut	110056	\N	\N
El Monte	USA	California	110026	\N	\N
Vallejo	USA	California	109593	\N	\N
Grand Prairie	USA	Texas	109231	\N	\N
Ann Arbor	USA	Michigan	108758	\N	\N
Abilene	USA	Texas	108476	-99.6832962	32.4166985
Waco	USA	Texas	108412	-97.2166977	31.6166992
Naperville	USA	Illinois	107001	\N	\N
Simi Valley	USA	California	106974	\N	\N
Palmdale	USA	California	106540	-118.099998	34.6333008
Waterbury	USA	Connecticut	106412	-73.0667038	41.5833015
Coral Springs	USA	Florida	105275	\N	\N
Erie	USA	Pennsylvania	105270	-80.1832962	42.0833015
Livonia	USA	Michigan	105099	\N	\N
Lafayette	USA	Louisiana	104899	-92	30.2000008
Fort Collins	USA	Colorado	104196	-105.083	40.75
Fontana	USA	California	104124	\N	\N
McAllen	USA	Texas	103352	\N	\N
Berkeley	USA	California	103243	\N	\N
Allentown	USA	Pennsylvania	102211	-75.4332962	40.6500015
South Bend	USA	Indiana	102100	-86.3167038	41.7000008
Green Bay	USA	Wisconsin	102076	-88.1333008	44.4832993
West Covina	USA	California	101526	\N	\N
Lowell	USA	Massachusetts	100973	-71.3167038	42.6500015
Costa Mesa	USA	California	100938	\N	\N
Pembroke Pines	USA	Florida	100662	\N	\N
Norwalk	USA	California	100209	\N	\N
Corona	USA	California	100208	\N	\N
Wichita Falls	USA	Texas	100138	-98.4832993	33.9667015
Clearwater	USA	Florida	100132	\N	\N
Jefferson City	USA	Missouri	33619	-92.1832962	38.5667
Carson City	USA	Nevada	32022	-119.766998	39.1666985
Canberra	AUS	Australia Capital Territory	310000	149.080002	-35.0999985
Hobart	AUS	Tasmania	184000	147.139999	-42.5
Gold Coast	AUS	Queensland	266000	\N	\N
Wollongong	AUS	New South Wales	238000	\N	\N
Geelong	AUS	New South Wales	151000	\N	\N
Townsville	AUS	Queensland	114000	\N	\N
Sunshine Coast	AUS	New South Wales	110000	\N	\N
Bantam Village	AUS	Cocos Islands	\N	\N	\N
Flying Fish Cove	AUS	Kirimati	\N	\N	\N
Yaren	NAU	Nauru	\N	168	0
La Plata	RA	Buenos Aires	642979	-58	-35
San Fernando del Valle de Catamarca	RA	Catamarca	110269	\N	\N
Resistencia	RA	Chaco	292350	-59	-27.2999992
San Salvador de Jujuy	RA	Jujuy	180102	-65.1999969	-24.1000004
Posadas	RA	Misiones	210755	-56	-27.2999992
San Miguel de Tucuman	RA	Tucuman	622324	-65.1999969	-26.5
Rosario	RA	Santa Fe	1118984	-60.5	-33
La Matanza	RA	Buenos Aires	1111811	\N	\N
Moron	RA	Buenos Aires	641541	\N	\N
Lomas de Zamoras	RA	Buenos Aires	572769	\N	\N
Mar del Plata	RA	Buenos Aires	512880	\N	\N
Quilmes	RA	Buenos Aires	509445	\N	\N
Lanus	RA	Buenos Aires	466755	\N	\N
General San Martin	RA	Buenos Aires	407506	\N	\N
Avellaneda	RA	Buenos Aires	346620	\N	\N
San Isidro	RA	Buenos Aires	299022	\N	\N
Vicente Lopez	RA	Buenos Aires	289142	\N	\N
Santiago del Estero La Banda	RA	Santiago de Estero	263471	\N	\N
Bahia Blanca	RA	Buenos Aires	260096	\N	\N
Rio Cuarto	RA	Cordoba	138853	\N	\N
San Fernando	RA	Catamarca	132626	-65.5	-28.2999992
San Fernando	YV	Apure	\N	\N	\N
Comodoro Rivadavia	RA	Chubut	124104	\N	\N
San Nicolas de los Arroyos	RA	Buenos Aires	119302	\N	\N
Concordia	RA	Entre Rios	116485	\N	\N
Rio Gallegos	RA	Santa Cruz	43000	-69.1999969	-51.4000015
Santiago del Estero	RA	Santiago de Estero	148000	-64.1999969	-28
Manaus	BR	Amazonas	1158265	-60	-3
Goiania	BR	Goias	998520	-49.2000008	-16.2999992
Guarulhos	BR	Sao Paulo	972766	\N	\N
Campinas	BR	Sao Paulo	907996	\N	\N
Sao Goncalo	BR	Rio de Janeiro	827967	\N	\N
Novo Iguacu	BR	Rio de Janeiro	801036	\N	\N
Sao Luis	BR	Maranhao	781068	-44.0999985	-2.29999995
Maceio	BR	Alagoas	723156	-35.5	-9.30000019
Duque de Caxias	BR	Rio de Janeiro	712370	\N	\N
Sao Bernardo do Campo	BR	Sao Paulo	658791	\N	\N
Natal	BR	Rio Grande do Norte	656244	-35.0999985	-5.5
Teresina	BR	Piaui	653994	-42.5	-5
Santo Andre	BR	Sao Paulo	625294	\N	\N
Osasco	BR	Sao Paulo	622374	\N	\N
Campo Grande	BR	Mato Grosso do Sul	598216	\N	\N
Joao Pessoa	BR	Paraiba	549270	-35	-7.0999999
Jaboatao dos Guararapes	BR	Pernambuco	528973	\N	\N
Sao Jose dos Campos	BR	Sao Paulo	485780	\N	\N
Ribeirao Preto	BR	Sao Paulo	452804	\N	\N
Niteroi	BR	Rio de Janeiro	450129	\N	\N
Feira de Santana	BR	Bahia	449960	\N	\N
Uberlandia	BR	Minas Gerais	437111	\N	\N
Sao Joao de Meriti	BR	Rio de Janeiro	433713	\N	\N
Cuiaba	BR	Mato Grosso	433101	-56	-15.3000002
Sorocaba	BR	Sao Paulo	431370	\N	\N
Aracaju	BR	Sergipe	426580	-37.0999985	-11
Juiz de Fora	BR	Minas Gerais	423913	\N	\N
Londrina	BR	Parana	412894	\N	\N
Santos	BR	Sao Paulo	412288	\N	\N
Joinvile	BR	Santa Catarina	397987	\N	\N
Belfort Roxo	BR	Rio de Janeiro	393520	\N	\N
Olinda	BR	Rio de Janeiro	355741	\N	\N
Maua	BR	Sao Paulo	344684	\N	\N
Ananindeua	BR	Para	342905	\N	\N
Campina Grande	BR	Paraiba	340412	\N	\N
Carapicuiba	BR	Sao Paulo	328015	\N	\N
Caxias do Sul	BR	Rio Grande do Sul	326222	\N	\N
Sao Jose do Rio Preto	BR	Sao Paulo	323418	\N	\N
Diadema	BR	Sao Paulo	323221	\N	\N
Moji das Cruzes	BR	Sao Paulo	314947	\N	\N
Pelotas	BR	Rio Grande do Sul	304285	\N	\N
Piracicaba	BR	Sao Paulo	302605	\N	\N
Cariacica	BR	Espirito Santo	300085	\N	\N
Vila Velha	BR	Espirito Santo	297052	\N	\N
Porto Velho	BR	Rondonia	293815	-63.5	-8.5
Jundiai	BR	Sao Paulo	293237	\N	\N
Bauru	BR	Sao Paulo	293026	\N	\N
Canoas	BR	Rio Grande do Sul	284114	\N	\N
Sao Vicente	BR	Sao Paulo	279620	\N	\N
Montes Claros	BR	Minas Gerais	271324	\N	\N
Florianopolis	BR	Santa Catarina	268551	-58.2999992	-27.2999992
Maringa	BR	Parana	267878	\N	\N
Petropolis	BR	Rio de Janeiro	267604	\N	\N
Franca	BR	Sao Paulo	266909	\N	\N
Serra	BR	Espirito Santo	266851	\N	\N
Aparecida de Goiania	BR	Sao Paulo	265446	\N	\N
Anapolis	BR	Goias	264873	\N	\N
Vitoria	BR	Espirito Santo	263708	-40.2999992	-20.2000008
Ponta Grossa	BR	Parana	252674	\N	\N
Ilheus	BR	Bahia	242589	\N	\N
Vitoria da Conquista	BR	Bahia	241776	\N	\N
Paulista	BR	Pernambuco	234706	\N	\N
Uberaba	BR	Minas Gerais	232134	\N	\N
Caruaru	BR	Pernambuco	231874	\N	\N
Foz do Iguacu	BR	Parana	231596	\N	\N
Governador Valadares	BR	Minas Gerais	231077	\N	\N
Blumenau	BR	Santa Catarina	230988	\N	\N
Limeira	BR	Sao Paulo	230292	\N	\N
Volta Redonda	BR	Rio de Janeiro	228939	\N	\N
Rio Branco	BR	Acre	228907	-67.5	-9.5
Itaquaquecetuba	BR	Sao Paulo	228533	\N	\N
Imperatriz	BR	Maranhao	227731	\N	\N
Santa Maria	BR	Rio Grande do Sul	226226	\N	\N
Guaruja	BR	Sao Paulo	226185	\N	\N
Novo Hamburgo	BR	Rio Grande do Sul	225082	\N	\N
Taubate	BR	Sao Paulo	220179	\N	\N
Cascavel	BR	Parana	219623	\N	\N
Macapa	BR	Amapa	214197	-52	0.5
Caucaia	BR	Ceara	208902	\N	\N
Mossoro	BR	Rio Grande do Norte	205732	\N	\N
Gravatai	BR	Pernambuco	205657	\N	\N
Viamao	BR	Rio Grande do Sul	195880	\N	\N
Ipatinga	BR	Minas Gerais	195736	\N	\N
Petrolina	BR	Pernambuco	190453	\N	\N
Varzea Grande	BR	Mato Grosso	190374	\N	\N
Juazeiro do Norte	BR	Ceara	186490	\N	\N
Itabuna	BR	Bahia	183237	\N	\N
Taboao da Serra	BR	Sao Paulo	182441	\N	\N
Sao Leopoldo	BR	Rio Grande do Sul	180741	\N	\N
Suzano	BR	Sao Paulo	180703	\N	\N
Mage	BR	Rio de Janeiro	180550	\N	\N
Rio Grande	BR	Rio Grande do Sul	178223	\N	\N
Marilia	BR	Sao Paulo	177503	\N	\N
Presidente Prudente	BR	Sao Paulo	177236	\N	\N
Barueri	BR	Sao Paulo	176740	\N	\N
Sao Carlos	BR	Sao Paulo	175295	\N	\N
Arapiraca	BR	Sergipe	173351	\N	\N
Juazeiro	BR	Bahia	171904	\N	\N
Divinopolis	BR	Minas Gerais	171562	\N	\N
Nova Friburgo	BR	Rio de Janeiro	169218	\N	\N
Jacarei	BR	Sao Paulo	168030	\N	\N
Americana	BR	Sao Paulo	167901	\N	\N
Sete Lagoas	BR	Minas Gerais	167112	\N	\N
Jequie	BR	Bahia	165361	\N	\N
Barra Mansa	BR	Rio de Janeiro	164768	\N	\N
Araraquara	BR	Sao Paulo	163831	\N	\N
Aracatuba	BR	Sao Paulo	162546	\N	\N
Maracanau	BR	Ceara	160088	\N	\N
Criciuma	BR	Santa Catarina	159033	\N	\N
Itaborai	BR	Rio de Janeiro	156631	\N	\N
Passo Fundo	BR	Rio Grande do Sul	156352	\N	\N
Nilopolis	BR	Rio de Janeiro	155190	\N	\N
Boa Vista	BR	Roraima	154166	-60.4000015	2.5
Dourados	BR	Mato Grosso do Sul	153165	\N	\N
Rio Claro	BR	Sao Paulo	153025	\N	\N
Santa Luzia	BR	Paraiba	152682	\N	\N
Praia Grande	BR	Santa Catarina	150574	\N	\N
Guarapuava	BR	Parana	149158	\N	\N
Sao Jose	BR	Santa Catarina	147490	\N	\N
Cachoeiro de Itapemirim	BR	Espirito Santo	147283	\N	\N
Maraba	BR	Para	147030	\N	\N
Rondonopolis	BR	Mato Grosso	142221	\N	\N
Sao Caetano do Sul	BR	Sao Paulo	140808	\N	\N
Lages	BR	Santa Catarina	140005	\N	\N
Sobral	BR	Ceara	138274	\N	\N
Itajai	BR	Santa Catarina	134797	\N	\N
Camacari	BR	Bahia	134768	\N	\N
Itapevi	BR	Sao Paulo	133769	\N	\N
Caxias	BR	Maranhao	133710	\N	\N
Chapeco	BR	Santa Catarina	130458	\N	\N
Teofilo Otoni	BR	Minas Gerais	127214	\N	\N
Cotia	BR	Sao Paulo	127047	\N	\N
Parnaiba	BR	Mato Grosso do Sul	124641	\N	\N
Alagoinhas	BR	Bahia	122882	\N	\N
Teresopolis	BR	Rio de Janeiro	122614	\N	\N
Itu	BR	Sao Paulo	122544	\N	\N
Indaiatuba	BR	Sao Paulo	122159	\N	\N
Ferraz de Vasconcelos	BR	Sao Paulo	121992	\N	\N
Pocos de Caldas	BR	Minas Gerais	121845	\N	\N
Uruguaiana	BR	Rio Grande do Sul	121825	\N	\N
Timon	BR	Maranhao	118332	\N	\N
Castanhal	BR	Para	117747	\N	\N
Paranagua	BR	Parana	115394	\N	\N
Moji Guacu	BR	Sao Paulo	114555	\N	\N
Pindamonhangaba	BR	Sao Paulo	114092	\N	\N
Bage	BR	Rio Grande do Sul	114091	\N	\N
Barreiras	BR	Bahia	113544	\N	\N
Macae	BR	Rio de Janeiro	112966	\N	\N
Patos de Minas	BR	Minas Gerais	112690	\N	\N
Itapetininga	BR	Sao Paulo	111909	\N	\N
Vitoria de Santo Antao	BR	Pernambuco	111575	\N	\N
Camaragibe	BR	Pernambuco	111190	\N	\N
Itapecerica da Serra	BR	Minas Gerais	110362	\N	\N
Garanhuns	BR	Pernambuco	110190	\N	\N
Braganca Paulista	BR	Sao Paulo	109863	\N	\N
Queimados	BR	Rio de Janeiro	108531	\N	\N
Barbacena	BR	Minas Gerais	107843	\N	\N
Francisco Morato	BR	Sao Paulo	106328	\N	\N
Santa Rita	BR	Paraiba	105584	\N	\N
Araguaina	BR	Goias	105000	\N	\N
Itaituba	BR	Para	104896	\N	\N
Luziania	BR	Goias	104840	\N	\N
Codo	BR	Maranhao	104825	\N	\N
Barretos	BR	Sao Paulo	104782	\N	\N
Colatina	BR	Espirito Santo	103621	\N	\N
Jau	BR	Sao Paulo	103605	\N	\N
Linhares	BR	Espirito Santo	103030	\N	\N
Cabo Frio	BR	Rio de Janeiro	101142	\N	\N
Apucarana	BR	Parana	101005	\N	\N
Catanduva	BR	Sao Paulo	100913	\N	\N
Botucatu	BR	Sao Paulo	100826	\N	\N
Sabara	BR	Minas Gerais	100570	\N	\N
Santa Cruz do Sul	BR	Rio Grande do Sul	100562	\N	\N
Ribeirao Pires	BR	Sao Paulo	100335	\N	\N
Rio Verde	BR	Goias	100223	\N	\N
Varginha	BR	Minas Gerais	100079	\N	\N
Tunja	CO	Boyaca	120210	\N	\N
Manizales	CO	Caldas	335125	\N	\N
Florencia	CO	Caqueta	118027	\N	\N
Popayan	CO	Cauca	223128	\N	\N
Valledupar	CO	Cesar	265505	\N	\N
Quibdo	CO	Choco	130921	\N	\N
Neiva	CO	Huila	248178	\N	\N
Santa Marta	CO	Magdalena	309372	\N	\N
Villavicencio	CO	Meta	252711	\N	\N
Pasto	CO	Narino	325540	\N	\N
Cucuta	CO	Norte de Santander	479309	\N	\N
Pereira	CO	Risaralda	352530	\N	\N
Bucaramanga	CO	Santander del Sur	351737	\N	\N
Sincelejo	CO	Sucre	180076	\N	\N
Ibague	CO	Tolima	346632	\N	\N
Barranquilla	CO	Atlantico	1064255	\N	\N
Bello	CO	Antioquia	304819	\N	\N
Monteria	CO	Cordoba	276074	\N	\N
Buenaventura	CO	Valle de Cauca	266988	\N	\N
Soacha	CO	Cundinamarca	266817	\N	\N
Soledad	CO	Atlantico	264583	\N	\N
Palmira	CO	Valle de Cauca	256823	\N	\N
Floridablanca	CO	Santander del Sur	246834	\N	\N
Barrancabermeja	CO	Santander del Sur	180653	\N	\N
Itagui	CO	Antioquia	169374	\N	\N
Dosquebradas	CO	Risaralda	163599	\N	\N
Cienaga	CO	Guajira, La	144340	\N	\N
Riohacha	CO	Guajira, La	142455	\N	\N
Tulua	CO	Valle de Cauca	138124	\N	\N
Turbo	CO	Antioquia	127045	\N	\N
Tumaco	CO	Narino	114802	\N	\N
Malambo	CO	Atlantico	112289	\N	\N
Envigado	CO	Antioquia	109240	\N	\N
Mangangue	CO	Bolivar	104496	\N	\N
Puerto Inirida	CO	Guainia	\N	\N	\N
San Jose del Guaviare	CO	Guaviare	\N	\N	\N
San Andres	CO	San Andres y Providencia	\N	\N	\N
Puerto Carreno	CO	Vichada	\N	\N	\N
Huancayo	PE	Junin	258209	\N	\N
Chiclayo	PE	Lambayeque	411536	\N	\N
Iquitos	PE	Loreto	274759	-73.1999969	-3.4000001
Pucallpa	PE	Ucayali	172286	\N	\N
Chimbote	PE	Ancash	268979	\N	\N
Sullana	PE	Piura	147361	\N	\N
Juliaca	PE	Puno	142576	\N	\N
Chincha Alta	PE	Ica	110016	\N	\N
Talara	PE	Piura	82228	\N	\N
Puerto Maldonado	PE	Madre de Dios	\N	\N	\N
Cerro de Pasco	PE	Pasco	\N	\N	\N
Maracay	YV	Aragua	354196	\N	\N
Ciudad Bolivar	YV	Bolivar	225340	\N	\N
Barquisimeto	YV	Lara	625450	\N	\N
Los Teques	YV	Miranda	140617	\N	\N
Maturin	YV	Monagas	206654	\N	\N
Cumana	YV	Sucre	212432	\N	\N
San Cristobal	YV	Tachira	220675	\N	\N
Ciudad Guayana	YV	Bolivar	453047	\N	\N
Petare	YV	Miranda	338417	\N	\N
Baruta	YV	Miranda	182941	\N	\N
Cabimas	YV	Zulia	165755	\N	\N
Puerto La Cruz	YV	Anzoategui	155731	\N	\N
Guarenas	YV	Miranda	134158	\N	\N
Puerto Cabello	YV	Carabobo	128825	\N	\N
Acarigua	YV	Portuguesa	116551	\N	\N
Guacara	YV	Carabobo	100766	\N	\N
Catia La Mar	YV	Distrito Federal	100104	\N	\N
Puerto Ayacucho	YV	Amazonas	\N	\N	\N
San Carlos	YV	Cojedes	\N	\N	\N
La Ascuncion	YV	Nueva Esparta	\N	\N	\N
San Felipe	YV	Yaracuy	\N	\N	\N
Annaba	DZ	Algeria	222518	\N	\N
Batna	DZ	Algeria	181601	\N	\N
Bechar	DZ	Algeria	107311	\N	\N
Sidi bel Abbes	DZ	Algeria	152778	\N	\N
Skikda	DZ	Algeria	128747	\N	\N
Tebessa	DZ	Algeria	107559	\N	\N
Oran	DZ	Algeria	609823	0.400000006	35.4000015
Constantine	DZ	Algeria	440842	\N	\N
Setif	DZ	Algeria	170182	\N	\N
Blida	DZ	Algeria	127284	\N	\N
Bejaia	DZ	Algeria	114534	\N	\N
Mostaganem	DZ	Algeria	114037	\N	\N
Tlemcen	DZ	Algeria	107632	\N	\N
Mbanza Congo	ANG	Zaire	\N	\N	\N
Yaounde	CAM	Centre	750000	12	3.5
Maroua	CAM	Nord extreme	143000	\N	\N
Douala	CAM	Cote	884000	10	3.5
Garoua	CAM	Nord	177000	\N	\N
Bamenda	CAM	Nordoueste	138000	\N	\N
Bafoussam	CAM	Ouest	131000	\N	\N
Damanhur	ET	El Buhayra	226000	\N	\N
El Mansura	ET	El Daqahliya	358000	\N	\N
Tanta	ET	El Gharbiya	374000	\N	\N
Shibin el Kom	ET	El Minufiya	136000	\N	\N
Benha	ET	El Qalubiya	120000	\N	\N
Zagazig	ET	Sharqiya	274000	\N	\N
Shubra el Kheima	ET	El Qalubiya	533000	\N	\N
El Mahalla el Kubra	ET	El Gharbiya	385000	\N	\N
Port Said	ET	Bur Said (munic.)	382000	\N	\N
Helwan	ET	El Qahira (munic.)	352000	\N	\N
Suez	ET	El Suweiz (munic.)	265000	\N	\N
Kafr el Dauwar	ET	El Buhayra	161000	\N	\N
El Uqsur	ET	Qena	148000	\N	\N
Marsa Matruh	ET	Matruh	\N	\N	\N
El Tur	ET	Sina al Janubiyah	\N	\N	\N
El Arish	ET	Sina ash Shamaliyah	\N	\N	\N
El Kharga	ET	El Wadi el Jadid	\N	\N	\N
Bur Said	ET	Bur Said (munic.)	\N	\N	\N
El Iskandariya	ET	El Iskandariya (munic.)	\N	\N	\N
El Qahira	ET	El Qahira (munic.)	\N	\N	\N
El Suweiz	ET	El Suweiz (munic.)	\N	\N	\N
Sta. Isabel	GQ	Equatorial Guinea	\N	8.5	3.5
Dire Dawa	ETH	Ethiopia	194587	\N	\N
Gonder	ETH	Ethiopia	166593	\N	\N
Nazret	ETH	Ethiopia	147088	\N	\N
Harer	ETH	Ethiopia	122932	\N	\N
Mekele	ETH	Ethiopia	119779	\N	\N
Jima	ETH	Ethiopia	119717	\N	\N
Dese	ETH	Ethiopia	117268	\N	\N
Bahir Dar	ETH	Ethiopia	115531	\N	\N
Debrezit	ETH	Ethiopia	105963	\N	\N
Kumasi	GH	Ghana	376249	\N	\N
Cape Coast	GH	Ghana	57224	\N	\N
Tamale	GH	Ghana	135952	\N	\N
Tema	GH	Ghana	131528	\N	\N
Takoradi	GH	Ghana	61484	\N	\N
Sekondi	GH	Ghana	31916	\N	\N
Nyeri	EAK	Central	88600	\N	\N
Mombasa	EAK	Coast	600000	39.4000015	-4
Kisumu	EAK	Nyanza	201100	\N	\N
Nakuru	EAK	Rift Valley	124200	\N	\N
Kakamega	EAK	Western	47300	\N	\N
Machakos	EAK	Eastern	116100	\N	\N
Eldoret	EAK	Rift Valley	104900	\N	\N
Thika	EAK	Central	57100	\N	\N
Kitale	EAK	Rift Valley	53000	\N	\N
Kericho	EAK	Rift Valley	40000	\N	\N
Malindi	EAK	Coast	35200	\N	\N
Tamatave	RM	Toamasina	230000	\N	\N
Majunga	RM	Mahajanga	200000	\N	\N
Antsirabe	RM	Antananarivo	100000	\N	\N
Port Louis	MS	Mauritius	\N	-3.20000005	47.2999992
Rabat	MA	Morocco	1385872	-6.5	33.5999985
Agadir	MA	Morocco	550200	\N	\N
Fes	MA	Morocco	774754	\N	\N
Kenitra	MA	Morocco	448785	\N	\N
Khouribga	MA	Morocco	294680	\N	\N
Marrakech	MA	Morocco	745541	\N	\N
Meknes	MA	Morocco	530171	\N	\N
Oujda	MA	Morocco	678778	\N	\N
Safi	MA	Morocco	376038	\N	\N
Tanger	MA	Morocco	526215	\N	\N
Beni Mellal	MA	Morocco	386505	\N	\N
Tetouan	MA	Morocco	367349	\N	\N
Chimoio	MOC	Manica	108818	\N	\N
Beira	MOC	Sofala	298847	\N	\N
Quelimane	MOC	Zambezia	146206	\N	\N
Nacala	MOC	Maputo	125208	\N	\N
Xai Xai	MOC	Gaza	\N	\N	\N
Makurdi	WAN	Nigeria	109000	\N	\N
Maiduguri	WAN	Nigeria	282000	\N	\N
Calabar	WAN	Nigeria	154000	\N	\N
Benin City	WAN	Nigeria	203000	\N	\N
Enugu	WAN	Nigeria	279000	\N	\N
Kaduna	WAN	Nigeria	302000	\N	\N
Kano	WAN	Nigeria	595000	\N	\N
Katsina	WAN	Nigeria	182000	\N	\N
Ilorin	WAN	Nigeria	420000	\N	\N
Minna	WAN	Nigeria	120000	\N	\N
Abeokuta	WAN	Nigeria	377000	\N	\N
Ondo	WAN	Nigeria	150000	\N	\N
Akure	WAN	Nigeria	143000	\N	\N
Oshogbo	WAN	Nigeria	421000	\N	\N
Oyo	WAN	Nigeria	226000	\N	\N
Ibadan	WAN	Nigeria	1263000	\N	\N
Jos	WAN	Nigeria	182000	\N	\N
Port Harcourt	WAN	Nigeria	362000	\N	\N
Sokoto	WAN	Nigeria	181000	\N	\N
Ogbomosho	WAN	Nigeria	644000	\N	\N
Zaria	WAN	Nigeria	335000	\N	\N
Ilesha	WAN	Nigeria	334000	\N	\N
Onitsha	WAN	Nigeria	328000	\N	\N
Iwo	WAN	Nigeria	320000	\N	\N
Ado Ekiti	WAN	Nigeria	317000	\N	\N
Mushin	WAN	Nigeria	294000	\N	\N
Ede	WAN	Nigeria	271000	\N	\N
Aba	WAN	Nigeria	264000	\N	\N
Ife	WAN	Nigeria	262000	\N	\N
Ila	WAN	Nigeria	233000	\N	\N
Ikerre	WAN	Nigeria	216000	\N	\N
Iseyin	WAN	Nigeria	192000	\N	\N
Ilobu	WAN	Nigeria	176000	\N	\N
Offa	WAN	Nigeria	175000	\N	\N
Ikorodu	WAN	Nigeria	163000	\N	\N
Ilawe Ekiti	WAN	Nigeria	163000	\N	\N
Owo	WAN	Nigeria	162000	\N	\N
Ikirun	WAN	Nigeria	160000	\N	\N
Shaki	WAN	Nigeria	154000	\N	\N
Gusau	WAN	Nigeria	139000	\N	\N
Ijebu Ode	WAN	Nigeria	138000	\N	\N
Effon Alaiye	WAN	Nigeria	135000	\N	\N
Kumo	WAN	Nigeria	131000	\N	\N
Shomolu	WAN	Nigeria	130000	\N	\N
Oka	WAN	Nigeria	126000	\N	\N
Ikare	WAN	Nigeria	124000	\N	\N
Sapele	WAN	Nigeria	123000	\N	\N
Deba Habe	WAN	Nigeria	122000	\N	\N
Aarri	WAN	Nigeria	111000	\N	\N
Bida	WAN	Nigeria	111000	\N	\N
Ikire	WAN	Nigeria	109000	\N	\N
Lafia	WAN	Nigeria	108000	\N	\N
Inisa	WAN	Nigeria	106000	\N	\N
Shagamu	WAN	Nigeria	104000	\N	\N
Sao Tome	STP	Sao Tome and Principe	\N	7	0
Pretoria	RSA	South Africa	526000	28.2332993	-25.75
Bloemfontein	RSA	South Africa	127000	\N	\N
Johannesburg	RSA	South Africa	713000	28.0499992	-26.1833
Cape Town	RSA	South Africa	855000	18.4832993	-33.9333
Pietermaritzburg	RSA	South Africa	156000	\N	\N
Durban	RSA	South Africa	716000	\N	\N
Soweto	RSA	South Africa	597000	\N	\N
Port Elizabeth	RSA	South Africa	303000	\N	\N
Ibhayi	RSA	South Africa	257000	\N	\N
Diepmeadow	RSA	South Africa	241000	\N	\N
Lekoa	RSA	South Africa	218000	\N	\N
Tembisa	RSA	South Africa	209000	\N	\N
Katlehong	RSA	South Africa	202000	\N	\N
Evaton	RSA	South Africa	201000	\N	\N
Khayalitsha	RSA	South Africa	190000	\N	\N
Roodepoort	RSA	South Africa	163000	\N	\N
Mamelodi	RSA	South Africa	155000	\N	\N
Daveyton	RSA	South Africa	152000	\N	\N
Soshanguve	RSA	South Africa	146000	\N	\N
Germiston	RSA	South Africa	134000	\N	\N
Mangaung	RSA	South Africa	126000	\N	\N
Alexandra	RSA	South Africa	125000	\N	\N
Boksburg	RSA	South Africa	120000	\N	\N
Carletonville	RSA	South Africa	119000	\N	\N
Benoni	RSA	South Africa	114000	\N	\N
Kempton Park	RSA	South Africa	107000	\N	\N
East London	RSA	South Africa	102000	\N	\N
Sandton	RSA	South Africa	101000	\N	\N
King Williams Town	RSA	South Africa	\N	\N	\N
Juba	SUD	al Istiwaiyah	114980	\N	\N
al Ubayyid	SUD	Kurdufan	228096	\N	\N
Kassala	SUD	ash Sharqiyah	234270	\N	\N
Wad Madani	SUD	al Wusta	218714	\N	\N
Omdurman	SUD	al Khartum	1267077	\N	\N
Khartoum North	SUD	al Khartum	879105	\N	\N
Port Sudan	SUD	ash Sharqiyah	305385	\N	\N
Nyala	SUD	Darfur	228778	\N	\N
al Qadarif	SUD	ash Sharqiyah	189384	\N	\N
al Fasher	SUD	Darfur	\N	\N	\N
ad Damir	SUD	ash Shamaliyah	\N	\N	\N
Zanzibar	EAT	Mjini Magharibi	157634	\N	\N
Mtwara Mikandani	EAT	Mtwara	\N	\N	\N
Kigoma Ujiji	EAT	Kigoma	\N	\N	\N
Chake Cahke	EAT	Kusini Pemba	\N	\N	\N
El Alaiun	WSA	Western Sahara	\N	\N	\N
Matadi	ZRE	Bas Zaire	172730	\N	\N
Mbandaka	ZRE	Equateur	169841	\N	\N
Kisangani	ZRE	Haut Zaire	417517	\N	\N
Kananga	ZRE	Kasai Occidental	393030	\N	\N
Mbuji Mayi	ZRE	Kasai Oriental	806475	\N	\N
Bukavu	ZRE	Kivu	201569	\N	\N
Lubumbashi	ZRE	Shaba	851381	\N	\N
Kolwezi	ZRE	Shaba	417810	\N	\N
Likasi	ZRE	Shaba	299118	\N	\N
Kikwit	ZRE	Bandundu	182142	\N	\N
Tshikapa	ZRE	Kasai Occidental	180860	\N	\N
Mwene Ditu	ZRE	Kasai Oriental	137459	\N	\N
Boma	ZRE	Bas Zaire	135284	\N	\N
Uvira	ZRE	Kivu	115590	\N	\N
Butembo	ZRE	Kivu	109406	\N	\N
Goma	ZRE	Kivu	109094	\N	\N
Kalemi	ZRE	Kasai Oriental	101309	\N	\N
Kabwe	Z	Central	166519	\N	\N
Ndola	Z	Copperbelt	376311	\N	\N
Kitwe	Z	Copperbelt	338207	\N	\N
Chingola	Z	Copperbelt	167954	\N	\N
Mufulira	Z	Copperbelt	152944	\N	\N
Luanshya	Z	Copperbelt	146275	\N	\N
\.


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 195
-- Name: encuesta_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('encuesta_detalle_id_seq', 1, false);


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 194
-- Name: encuesta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('encuesta_id_seq', 1, false);


--
-- TOC entry 2133 (class 0 OID 886944)
-- Dependencies: 174
-- Data for Name: encuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY encuestas (id, fecha, id_usuarios, pais, estado, ciudad, codigo, intensidad) FROM stdin;
\.


--
-- TOC entry 2134 (class 0 OID 886947)
-- Dependencies: 175
-- Data for Name: encuestas_detalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY encuestas_detalles (id, id_encuestas, id_intensidades, id_preguntas) FROM stdin;
\.


--
-- TOC entry 2135 (class 0 OID 886950)
-- Dependencies: 176
-- Data for Name: intensidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY intensidades (id, nombre, valor) FROM stdin;
2	-	0
3	I	1
4	II	2
5	III	3
6	IV	4
7	V	5
8	VI	6
\.


--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 193
-- Name: intensidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('intensidades_id_seq', 8, true);


--
-- TOC entry 2136 (class 0 OID 886953)
-- Dependencies: 177
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pais (nombre, codigo, capital, provincia, area, poblacion) FROM stdin;
Albania	AL	Tirane	Albania	28750	3249136
Greece	GR	Athens	Greece	131940	10538594
Macedonia	MK	Skopje	Macedonia	25333	2104035
Serbia and Montenegro	YU	Belgrade	Serbia and Montenegro	102350	10614558
Andorra	AND	Andorra la Vella	Andorra	450	72766
France	F	Paris	Ile de France	547030	58317450
Spain	E	Madrid	Madrid	504750	39181114
Austria	A	Vienna	Vienna	83850	8023244
Czech Republic	CZ	Prague	Praha	78703	10321120
Germany	D	Berlin	Berlin	356910	83536115
Hungary	H	Budapest	Budapest (munic.)	93030	10002541
Italy	I	Rome	Lazio	301230	57460274
Liechtenstein	FL	Vaduz	Liechtenstein	160	31122
Slovakia	SK	Bratislava	Slovakia	48845	5374362
Slovenia	SLO	Ljubljana	Slovenia	20256	1951443
Switzerland	CH	Bern	BE	41290	7207060
Belarus	BY	Minsk	Belarus	207600	10415973
Latvia	LV	Riga	Latvia	64100	2468982
Lithuania	LT	Vilnius	Lithuania	65200	3646041
Poland	PL	Warsaw	Warszwaskie	312683	38642565
Ukraine	UA	Kiev	Kyyivska	603700	50864009
Russia	R	Moscow	Moskva	17075200	148178487
Belgium	B	Brussels	Brabant	30510	10170241
Luxembourg	L	Luxembourg	Luxembourg	2586	415870
Netherlands	NL	Amsterdam	Noord Holland	37330	15568034
Bosnia and Herzegovina	BIH	Sarajevo	Bosnia and Herzegovina	51233	2656240
Croatia	HR	Zagreb	Croatia	56538	5004112
Bulgaria	BG	Sofia	Bulgaria	110910	8612757
Romania	RO	Bucharest	Bucuresti	237500	21657162
Turkey	TR	Ankara	Ankara	780580	62484478
Denmark	DK	Copenhagen	Denmark	43070	5249632
Estonia	EW	Tallinn	Estonia	45100	1459428
Finland	SF	Helsinki	Uusimaa	337030	5105230
Norway	N	Oslo	Oslo	324220	4383807
Sweden	S	Stockholm	Stockholm	449964	8900954
Monaco	MC	Monaco	Monaco	2	31719
Holy See	V	Vatican City	Holy See	0	840
Iceland	IS	Reykjavik	Iceland	103000	270292
Ireland	IRL	Dublin	Ireland	70280	3566833
San Marino	RSM	San Marino	San Marino	60	24521
Malta	M	Valletta	Malta	320	375576
Moldova	MD	Chisinau	Moldova	33700	4463847
Portugal	P	Lisbon	Lisbon	92080	9865114
United Kingdom	GB	London	Greater London	244820	58489975
Afghanistan	AFG	Kabul	Afghanistan	647500	22664136
China	TJ	Beijing	Beijing (munic.)	9596960	1210004956
Iran	IR	Tehran	Tehran	1648000	66094264
Pakistan	PK	Islamabad	Pakistan	803940	129275660
Tajikistan	TAD	Dushanbe	Dushanbe (munic.)	143100	5916373
Turkmenistan	TM	Ashgabat	Ahal	488100	4149283
Uzbekistan	UZB	Tashkent	Toshkent	447400	23418381
Armenia	ARM	Yerevan	Armenia	29800	3463574
Georgia	GE	Tbilisi	Georgia	69700	5219810
Azerbaijan	AZ	Baku	Azerbaijan	86600	7676953
Bahrain	BRN	Manama	Bahrain	620	590042
Bangladesh	BD	Dhaka	Bangladesh	144000	123062800
Burma	MYA	Rangoon	Yangon	678500	45975625
India	IND	New Delhi	Delhi	3287590	952107694
Bhutan	BHT	Thimphu	Bhutan	47000	1822625
Brunei	BRU	Bandar Seri Begawan	Brunei	5770	299939
Malaysia	MAL	Kuala Lumpur	Fed. Terr. of Kuala Lumpur	329750	19962893
Laos	LAO	Vientiane	Laos	236800	4975772
Thailand	THA	Bangkok	Thailand	514000	58851357
Cambodia	K	Phnom Penh	Cambodia	181040	10861218
Vietnam	VN	Hanoi	Vietnam	329560	73976973
Kazakstan	KAZ	Almaty	Almaty (munic.)	2717300	16916463
North Korea	NOK	Pyongyang	North Korea	120540	23904124
Kyrgyzstan	KGZ	Bishkek	Kyrgyzstan	198500	4529648
Mongolia	MNG	Ulaanbaatar	Mongolia	1565000	2496617
Nepal	NEP	Kathmandu	Nepal	140800	22094033
Cyprus	CY	Nicosia	Cyprus	9250	744609
Israel	IL	Jerusalem	Central	20770	5421995
Egypt	ET	Cairo	El Qahira (munic.)	1001450	63575107
Indonesia	RI	Jakarta	Indonesia	1919440	206611600
Papua New Guinea	PNG	Port Moresby	Papua New Guinea	461690	4394537
Iraq	IRQ	Baghdad	Baghdad	437072	21422292
Jordan	JOR	Amman	Jordan	89213	4212152
Kuwait	KWT	Kuwait	Kuwait	17820	1950047
Saudi Arabia	SA	Riyadh	Saudi Arabia	1960582	19409058
Syria	SYR	Damascus	Syria	185180	15608648
Lebanon	RL	Beirut	Lebanon	10400	3776317
Japan	J	Tokyo	Tokyo	377835	125449703
South Korea	ROK	Seoul	South Korea	98480	45482291
Maldives	MV	Male	Maldives	300	270758
Oman	OM	Muscat	Oman	212460	2186548
United Arab Emirates	UAE	Abu Dhabi	United Arab Emirates	75581	3057337
Yemen	YE	Sanaa	Yemen	527970	13483178
Philippines	RP	Manila	Philippines	300000	74480848
Qatar	Q	Doha	Qatar	11000	547761
Singapore	SGP	Singapore	Singapore	633	3396924
Sri Lanka	CL	Colombo	Sri Lanka	65610	18553074
Taiwan	RC	Taipei	Taiwan	35980	21465881
Antigua and Barbuda	AG	Saint Johns	Antigua and Barbuda	440	65647
Bahamas	BS	Nassau	Bahamas	13940	259367
Barbados	BDS	Bridgetown	Barbados	430	257030
Belize	BZ	Belmopan	Belize	22960	219296
Guatemala	GCA	Guatemala City	Guatemala	108890	11277614
Mexico	MEX	Mexico City	Distrito Federal	1972550	95772462
Canada	CDN	Ottawa	Ontario	9976140	28820671
United States	USA	Washington	Distr. Columbia	9372610	266476278
Costa Rica	CR	San Jose	San Jose	51100	3463083
Nicaragua	NIC	Managua	Nicaragua	129494	4272352
Panama	PA	Panama City	Panama	78200	2655094
Cuba	C	Havana	Ciudad de la Habana	110860	10951334
Dominica	WD	Roseau	Dominica	750	82926
Dominican Republic	DOM	Santo Domingo	Dominican Republic	48730	8088881
Haiti	RH	Port-au-Prince	Haiti	27750	6731539
El Salvador	ES	San Salvador	El Salvador	21040	5828987
Honduras	HCA	Tegucigalpa	Francisco Morazan	112090	5605193
Grenada	WG	Saint Georges	Grenada	340	94961
Jamaica	JA	Kingston	Jamaica	10990	2595275
Colombia	CO	Bogota	Santa Fe de Bogota, DC	1138910	36813161
Saint Kitts and Nevis	KN	Basseterre	Saint Kitts and Nevis	269	41369
Saint Lucia	WL	Castries	Saint Lucia	620	157862
Saint Vincent and the Grenadines	WV	Kingstown	Saint Vincent and the Grenadines	340	118344
Trinidad and Tobago	TT	Port-of-Spain	Trinidad and Tobago	5130	1272385
Australia	AUS	Canberra	Australia Capital Territory	7686850	18260863
Fiji	FJI	Suva	Fiji	18270	782381
Kiribati	KIR	Tarawa	Kiribati	717	80919
Marshall Islands	MH	Majuro	Marshall Islands	181	58363
Micronesia	FSM	Kolonia	Micronesia	702	125377
Nauru	NAU	Yaren	Nauru	21	10273
New Caledonia	NCA	Noumea	New Caledonia	19060	187784
New Zealand	NZ	Wellington	New Zealand	268680	3547983
Palau	PAL	Koror	Palau	458	16952
Solomon Islands	SLB	Honiara	Solomon Islands	28450	412902
Tonga	TO	Nukualofa	Tonga	748	106466
Tuvalu	TUV	Funafuti	Tuvalu	26	10146
Vanuatu	VU	Port-Vila	Vanuatu	14760	177504
Western Samoa	WS	Apia	Western Samoa	2860	214384
Argentina	RA	Buenos Aires	Distrito Federal	2766890	34672997
Bolivia	BOL	La Paz	Bolivia	1098580	7165257
Brazil	BR	Brasilia	Distrito Federal	8511965	162661214
Chile	RCH	Santiago	Chile	756950	14333258
Paraguay	PY	Asuncion	Paraguay	406750	5504146
Uruguay	ROU	Montevideo	Uruguay	176220	3238952
Peru	PE	Lima	Lima	1285220	24523408
French Guiana	FGU	Cayenne	French Guiana	91000	151187
Guyana	GUY	Georgetown	Guyana	214970	712091
Suriname	SME	Paramaribo	Suriname	163270	436418
Venezuela	YV	Caracas	Distrito Federal	912050	21983188
Ecuador	EC	Quito	Ecuador	283560	11466291
Algeria	DZ	Algiers	Algeria	2381740	29183032
Libya	LAR	Tripoli	Libya	1759540	5445436
Mali	RMM	Bamako	Mali	1240000	9653261
Mauritania	RIM	Nouakchott	Mauritania	1030700	2336048
Morocco	MA	Rabat	Morocco	446550	29779156
Niger	RN	Niamey	Niger	1267000	9113001
Tunisia	TN	Tunis	Tunisia	163610	9019687
Western Sahara	WSA	El Alaiun	Western Sahara	266000	222631
Angola	ANG	Luanda	Luanda	1246700	10342899
Congo	RCB	Brazzaville	Congo	342000	2527841
Namibia	NAM	Windhoek	Namibia	825418	1677243
Zaire	ZRE	Kinshasa	Kinshasa	2345410	46498539
Zambia	Z	Lusaka	Lusaka	752610	9159072
Benin	BEN	Porto-Novo	Benin	112620	5709529
Burkina Faso	BF	Ouagadougou	Burkina Faso	274200	10623323
Nigeria	WAN	Abuja	Nigeria	923770	103912489
Togo	RT	Lome	Togo	56790	4570530
Botswana	RB	Gaborone	Botswana	600370	1477630
South Africa	RSA	Pretoria	South Africa	1219912	41743459
Zimbabwe	ZW	Harare	Zimbabwe	390580	11271314
Cote dIvoire	CI	Yamoussoukro	Cote dIvoire	322460	14762445
Ghana	GH	Accra	Ghana	238540	17698271
Burundi	BI	Bujumbura	Burundi	27830	5943057
Rwanda	RWA	Kigali	Rwanda	26340	6853359
Tanzania	EAT	Dar es Salaam	Daressalam	945090	29058470
Cameroon	CAM	Yaounde	Centre	475440	14261557
Central African Republic	RCA	Bangui	Central African Republic	622980	3274426
Chad	TCH	NDjamena	Chad	1284000	6976845
Equatorial Guinea	GQ	Malabo	Equatorial Guinea	28050	431282
Gabon	G	Libreville	Gabon	267670	1172798
Cape Verde	CV	Praia	Cape Verde	4030	449066
Sudan	SUD	Khartoum	al Khartum	2505810	31547543
Comoros	COM	Moroni	Comoros	2170	569237
Guinea	RG	Conakry	Guinea	245860	7411981
Liberia	LB	Monrovia	Liberia	111370	2109789
Djibouti	DJI	Djibouti	Djibouti	22000	427642
Eritrea	ER	Asmara	Eritrea	121320	3427883
Ethiopia	ETH	Addis Ababa	Ethiopia	1127127	57171662
Somalia	SP	Mogadishu	Somalia	637660	9639151
Kenya	EAK	Nairobi	Nairobi	582650	28176686
Gambia	WAG	Banjul	Gambia	11300	1204984
Senegal	SN	Dakar	Dakar	196190	9092749
Guinea-Bissau	GNB	Bissau	Guinea-Bissau	36120	1151330
Sierra Leone	WAL	Freetown	Sierra Leone	71740	4793121
Uganda	EAU	Kampala	Uganda	236040	20158176
Lesotho	LS	Maseru	Lesotho	30350	1970781
Madagascar	RM	Antananarivo	Antananarivo	587040	13670507
Malawi	MW	Lilongwe	Malawi	118480	9452844
Mozambique	MOC	Maputo	Maputo (munic.)	801590	17877927
Mauritius	MS	Port Louis	Mauritius	1860	1140256
Swaziland	SD	Mbabane	Swaziland	17360	998730
Sao Tome and Principe	STP	Sao Tome	Sao Tome and Principe	960	144128
Seychelles	SY	Victoria	Seychelles	455	77575
\.


--
-- TOC entry 2137 (class 0 OID 886959)
-- Dependencies: 178
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permisos (id, nombre) FROM stdin;
1	admin_crear_usuarios
2	admin_buscar_usuarios
3	admin_buscar_usuarios_id
4	admin_eliminar_usuarios
5	admin_modificar_usuarios
6	admin_cambiar_password
7	usuario_salvar_imagen
9	admin_buscar_roles
10	admin_buscar_roles_id
11	admin_eliminar_roles
12	admin_modificar_roles
13	admin_crear_permisos
14	admin_buscar_permisos
15	admin_buscar_permisos_id
16	admin_eliminar_permisos
17	admin_actualizar_permisos
8	admin_crear_roles
19	usuario_buscar_geografia
20	usuario_buscar_preguntas
\.


--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 179
-- Name: permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permisos_id_seq', 20, true);


--
-- TOC entry 2139 (class 0 OID 886964)
-- Dependencies: 180
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY preguntas (nombre, orden, id) FROM stdin;
¿que es el terremoto?	1	1
¿como te llamas?	2	3
\.


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 192
-- Name: preguntas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_id_seq', 3, true);


--
-- TOC entry 2150 (class 0 OID 887108)
-- Dependencies: 191
-- Data for Name: preguntas_intensidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY preguntas_intensidades (id, id_preguntas, id_intensidades) FROM stdin;
2	1	2
3	1	3
8	3	4
9	3	5
\.


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 190
-- Name: preguntas_intensidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('preguntas_intensidades_id_seq', 11, true);


--
-- TOC entry 2140 (class 0 OID 886970)
-- Dependencies: 181
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (nombre, pais, poblacion, area, capital, cap_prov) FROM stdin;
Albania	AL	3249136	28750	Tirane	Albania
Greece	GR	10538594	131940	Athens	Greece
Macedonia	MK	2104035	25333	Skopje	Macedonia
Serbia and Montenegro	YU	10614558	102350	Belgrade	Serbia and Montenegro
Andorra	AND	72766	450	Andorra la Vella	Andorra
Liechtenstein	FL	31122	160	Vaduz	Liechtenstein
Slovakia	SK	5374362	48845	Bratislava	Slovakia
Slovenia	SLO	1951443	20256	Ljubljana	Slovenia
Belarus	BY	10415973	207600	Minsk	Belarus
Latvia	LV	2468982	64100	Riga	Latvia
Lithuania	LT	3646041	65200	Vilnius	Lithuania
Luxembourg	B	234664	4441	Arlon	Luxembourg
Luxembourg	L	415870	2586	Luxembourg	Luxembourg
Bosnia and Herzegovina	BIH	2656240	51233	Sarajevo	Bosnia and Herzegovina
Croatia	HR	5004112	56538	Zagreb	Croatia
Bulgaria	BG	8612757	110910	Sofia	Bulgaria
Denmark	DK	5249632	43070	Copenhagen	Denmark
Estonia	EW	1459428	45100	Tallinn	Estonia
Monaco	MC	31719	2	Monaco	Monaco
Holy See	V	840	0	Vatican City	Holy See
Iceland	IS	270292	103000	Reykjavik	Iceland
Ireland	IRL	3566833	70280	Dublin	Ireland
San Marino	RSM	24521	60	San Marino	San Marino
Malta	M	375576	320	Valletta	Malta
Moldova	MD	4463847	33700	Chisinau	Moldova
Afghanistan	AFG	22664136	647500	Kabul	Afghanistan
Pakistan	PK	129275660	803940	Islamabad	Pakistan
Armenia	ARM	3463574	29800	Yerevan	Armenia
Georgia	GE	5219810	69700	Tbilisi	Georgia
Georgia	USA	7486242	152576	Atlanta	Georgia
Azerbaijan	AZ	7676953	86600	Baku	Azerbaijan
Bahrain	BRN	590042	620	Manama	Bahrain
Bangladesh	BD	123062800	144000	Dhaka	Bangladesh
Bhutan	BHT	1822625	47000	Thimphu	Bhutan
Brunei	BRU	299939	5770	Bandar Seri Begawan	Brunei
Laos	LAO	4975772	236800	Vientiane	Laos
Thailand	THA	58851357	514000	Bangkok	Thailand
Cambodia	K	10861218	181040	Phnom Penh	Cambodia
Vietnam	VN	73976973	329560	Hanoi	Vietnam
North Korea	NOK	23904124	120540	Pyongyang	North Korea
Kyrgyzstan	KGZ	4529648	198500	Bishkek	Kyrgyzstan
Mongolia	MNG	2496617	1565000	Ulaanbaatar	Mongolia
Nepal	NEP	22094033	140800	Kathmandu	Nepal
Cocos Islands	AUS	600	14	Bantam Village	Cocos Islands
Cyprus	CY	744609	9250	Nicosia	Cyprus
Indonesia	RI	206611600	1919440	Jakarta	Indonesia
Papua New Guinea	PNG	4394537	461690	Port Moresby	Papua New Guinea
Jordan	JOR	4212152	89213	Amman	Jordan
Kuwait	KWT	1950047	17820	Kuwait	Kuwait
Saudi Arabia	SA	19409058	1960582	Riyadh	Saudi Arabia
Syria	SYR	15608648	185180	Damascus	Syria
Lebanon	RL	3776317	10400	Beirut	Lebanon
South Korea	ROK	45482291	98480	Seoul	South Korea
Maldives	MV	270758	300	Male	Maldives
Oman	OM	2186548	212460	Muscat	Oman
United Arab Emirates	UAE	3057337	75581	Abu Dhabi	United Arab Emirates
Yemen	YE	13483178	527970	Sanaa	Yemen
Philippines	RP	74480848	300000	Manila	Philippines
Qatar	Q	547761	11000	Doha	Qatar
Singapore	SGP	3396924	633	Singapore	Singapore
Sri Lanka	CL	18553074	65610	Colombo	Sri Lanka
Taiwan	RC	21465881	35980	Taipei	Taiwan
Antigua and Barbuda	AG	65647	440	Saint Johns	Antigua and Barbuda
Bahamas	BS	259367	13940	Nassau	Bahamas
Barbados	BDS	257030	430	Bridgetown	Barbados
Belize	BZ	219296	22960	Belmopan	Belize
Guatemala	GCA	11277614	108890	Guatemala City	Guatemala
Nicaragua	NIC	4272352	129494	Managua	Nicaragua
Panama	PA	1168500	11887	Panama City	Panama
Dominica	WD	82926	750	Roseau	Dominica
Dominican Republic	DOM	8088881	48730	Santo Domingo	Dominican Republic
Haiti	RH	6731539	27750	Port-au-Prince	Haiti
El Salvador	ES	5828987	21040	San Salvador	El Salvador
Grenada	WG	94961	340	Saint Georges	Grenada
Jamaica	JA	2595275	10990	Kingston	Jamaica
Saint Kitts and Nevis	KN	41369	269	Basseterre	Saint Kitts and Nevis
Saint Lucia	WL	157862	620	Castries	Saint Lucia
Saint Vincent and the Grenadines	WV	118344	340	Kingstown	Saint Vincent and the Grenadines
Trinidad and Tobago	TT	1272385	5130	Port-of-Spain	Trinidad and Tobago
Fiji	FJI	782381	18270	Suva	Fiji
Kiribati	KIR	80919	717	Tarawa	Kiribati
Marshall Islands	MH	58363	181	Majuro	Marshall Islands
Micronesia	FSM	125377	702	Kolonia	Micronesia
Nauru	NAU	10273	21	Yaren	Nauru
New Caledonia	NCA	187784	19060	Noumea	New Caledonia
New Zealand	NZ	3547983	268680	Wellington	New Zealand
Norfolk Island	AUS	1980	35	Kingston	Norfolk Island
Palau	PAL	16952	458	Koror	Palau
Solomon Islands	SLB	412902	28450	Honiara	Solomon Islands
Tonga	TO	106466	748	Nukualofa	Tonga
Tuvalu	TUV	10146	26	Funafuti	Tuvalu
Vanuatu	VU	177504	14760	Port-Vila	Vanuatu
Western Samoa	WS	214384	2860	Apia	Western Samoa
Bolivia	BOL	7165257	1098580	La Paz	Bolivia
Chile	RCH	14333258	756950	Santiago	Chile
Paraguay	PY	5504146	406750	Asuncion	Paraguay
Uruguay	ROU	3238952	176220	Montevideo	Uruguay
French Guiana	FGU	151187	91000	Cayenne	French Guiana
Guyana	GUY	712091	214970	Georgetown	Guyana
Suriname	SME	436418	163270	Paramaribo	Suriname
Ecuador	EC	11466291	283560	Quito	Ecuador
Algeria	DZ	29183032	2381740	Algiers	Algeria
Libya	LAR	5445436	1759540	Tripoli	Libya
Mali	RMM	9653261	1240000	Bamako	Mali
Mauritania	RIM	2336048	1030700	Nouakchott	Mauritania
Morocco	MA	29779156	446550	Rabat	Morocco
Niger	RN	9113001	1267000	Niamey	Niger
Tunisia	TN	9019687	163610	Tunis	Tunisia
Western Sahara	WSA	222631	266000	El Alaiun	Western Sahara
Congo	RCB	2527841	342000	Brazzaville	Congo
Namibia	NAM	1677243	825418	Windhoek	Namibia
Zaire	ANG	192000	40130	Mbanza Congo	Zaire
Benin	BEN	5709529	112620	Porto-Novo	Benin
Burkina Faso	BF	10623323	274200	Ouagadougou	Burkina Faso
Nigeria	WAN	103912489	923770	Abuja	Nigeria
Togo	RT	4570530	56790	Lome	Togo
Botswana	RB	1477630	600370	Gaborone	Botswana
South Africa	RSA	41743459	1219912	Pretoria	South Africa
Zimbabwe	ZW	11271314	390580	Harare	Zimbabwe
Cote dIvoire	CI	14762445	322460	Yamoussoukro	Cote dIvoire
Ghana	GH	17698271	238540	Accra	Ghana
Burundi	BI	5943057	27830	Bujumbura	Burundi
Rwanda	RWA	6853359	26340	Kigali	Rwanda
Central African Republic	RCA	3274426	622980	Bangui	Central African Republic
Chad	TCH	6976845	1284000	NDjamena	Chad
Equatorial Guinea	GQ	431282	28050	Malabo	Equatorial Guinea
Gabon	G	1172798	267670	Libreville	Gabon
Cape Verde	CV	449066	4030	Praia	Cape Verde
Comoros	COM	569237	2170	Moroni	Comoros
Guinea	RG	7411981	245860	Conakry	Guinea
Liberia	LB	2109789	111370	Monrovia	Liberia
Djibouti	DJI	427642	22000	Djibouti	Djibouti
Eritrea	ER	3427883	121320	Asmara	Eritrea
Ethiopia	ETH	57171662	1127127	Addis Ababa	Ethiopia
Somalia	SP	9639151	637660	Mogadishu	Somalia
Gambia	WAG	1204984	11300	Banjul	Gambia
Guinea-Bissau	GNB	1151330	36120	Bissau	Guinea-Bissau
Sierra Leone	WAL	4793121	71740	Freetown	Sierra Leone
Uganda	EAU	20158176	236040	Kampala	Uganda
Lesotho	LS	1970781	30350	Maseru	Lesotho
Malawi	MW	9452844	118480	Lilongwe	Malawi
Mauritius	MS	1140256	1860	Port Louis	Mauritius
Swaziland	SD	998730	17360	Mbabane	Swaziland
Sao Tome and Principe	STP	144128	960	Sao Tome	Sao Tome and Principe
Seychelles	SY	77575	455	Victoria	Seychelles
Madrid	E	5034548	8028	Madrid	Madrid
Vienna	A	1583000	415	Vienna	Vienna
Berlin	D	3472009	889	Berlin	Berlin
Ankara	TR	3236626	25706	Ankara	Ankara
Oslo	N	449337	\N	Oslo	Oslo
Stockholm	S	1654511	6488	Stockholm	Stockholm
Lisbon	P	2063800	2761	\N	\N
Tehran	IR	9982309	29993	Tehran	Tehran
Baghdad	IRQ	4648609	734	Baghdad	Baghdad
Tokyo	J	11773605	2164	Tokyo	Tokyo
Buenos Aires	RA	12594974	307571	La Plata	Buenos Aires
La Paz	HCA	117400	2331	La Paz	La Paz
Lima	PE	6941672	34801	Lima	Lima
Luanda	ANG	1629000	2418	Luanda	Luanda
Nairobi	EAK	1346000	684	Nairobi	Nairobi
Dakar	SN	1490500	550	Dakar	Dakar
Victoria	AUS	4502200	227600	Melbourne	Victoria
GR	CH	185063	7105	Chur	GR
GE	CH	395466	282	Geneva	GE
AG	CH	528887	1403	Aarau	AG
BS	CH	195759	37	Basel	BS
Valencia	E	3909047	23255	Valencia	Valencia
Merida	YV	680503	11300	Merida	Merida
Hamburg	D	1705872	755	Hamburg	Hamburg
Szolnok	H	420900	5608	Szolnok	Szolnok
Veszprem	H	378300	4689	Veszprem	Veszprem
Botosani	RO	468000	4965	Botosani	Botosani
Calarasi	RO	351000	5075	Calarasi	Calarasi
Giurgiu	RO	325000	3810	Giurgiu	Giurgiu
Suceava	RO	699000	8555	Suceava	Suceava
Tulcea	RO	275000	8430	Tulcea	Tulcea
Vaslui	RO	468000	5297	Vaslui	Vaslui
Adana	TR	1934907	17253	Adana	Adana
Istanbul	TR	7309190	5712	Istanbul	Istanbul
Izmir	TR	2694770	11973	Izmir	Izmir
Afyon	TR	739223	14230	Afyon	Afyon
Agri	TR	437093	11376	Agri	Agri
Aksaray	TR	326399	7626	Aksaray	Aksaray
Amasya	TR	357191	5520	Amasya	Amasya
Artvin	TR	212833	7436	Artvin	Artvin
Bayburt	TR	107330	3652	Bayburt	Bayburt
Bilecik	TR	175526	4307	Bilecik	Bilecik
Bingol	TR	250966	8125	Bingol	Bingol
Bitlis	TR	330115	6707	Bitlis	Bitlis
Bolu	TR	536869	11051	Bolu	Bolu
Burdur	TR	254899	6887	Burdur	Burdur
Canakkale	TR	432263	9737	Canakkale	Canakkale
Cankiri	TR	279129	8454	Cankiri	Cankiri
Corum	TR	609863	12820	Corum	Corum
Erzincan	TR	299251	11903	Erzincan	Erzincan
Giresun	TR	499087	6934	Giresun	Giresun
Gumushane	TR	169375	6575	Gumushane	Gumushane
Hakkari	TR	172479	7121	Hakkari	Hakkari
Karaman	TR	217536	9163	Karaman	Karaman
Kars	TR	662155	18557	Kars	Kars
Kastamonu	TR	423611	13108	Kastamonu	Kastamonu
Kirklareli	TR	309512	6550	Kirklareli	Kirklareli
Kirsehir	TR	256862	6570	Kirsehir	Kirsehir
Mardin	TR	557727	8891	Mardin	Mardin
Mugla	TR	562809	13338	Mugla	Mugla
Mus	TR	376543	8196	Mus	Mus
Nevsehir	TR	289509	5467	Nevsehir	Nevsehir
Nigde	TR	305861	7312	Nigde	Nigde
Rize	TR	348776	3920	Rize	Rize
Sakarya	TR	683061	4817	Sakarya	Sakarya
Siirt	TR	243435	5406	Siirt	Siirt
Sinop	TR	265153	5862	Sinop	Sinop
Sirnak	TR	262006	7172	Sirnak	Sirnak
Tekirdag	TR	468842	6218	Tekirdag	Tekirdag
Tokat	TR	719251	9958	Tokat	Tokat
Tunceli	TR	133143	7774	Tunceli	Tunceli
Yozgat	TR	579150	14123	Yozgat	Yozgat
Kalmar	S	241883	11170	Kalmar	Kalmar
Kristianstad	S	291468	6087	Kristianstad	Kristianstad
Durham	GB	604300	2436	Durham	Durham
Bridgend	GB	130900	246	Bridgend	Bridgend
Wrexham	GB	123500	499	Wrexham	Wrexham
Bushehr	IR	694252	27653	Bushehr	Bushehr
Semnan	IR	458125	90905	Semnan	Semnan
Mandalay	MYA	4577800	37024	Mandalay	Mandalay
Magway	MYA	3243200	44820	Magway	Magway
Sagaing	MYA	3862200	94625	Sagaing	Sagaing
Pondicherry	IND	807785	492	Pondicherry	Pondicherry
Zhambyl	KAZ	1039600	144300	Zhambyl	Zhambyl
Zhezkazghan	KAZ	484400	312600	Zhezkazghan	Zhezkazghan
Haifa	IL	602800	854	Haifa	Haifa
Tel Aviv	IL	1029700	170	Tel Aviv	Tel Aviv
Dahuk	IRQ	292931	6553	Dahuk	Dahuk
Fukuoka	J	4933393	4961	Fukuoka	Fukuoka
Aomori	J	1481663	9619	Aomori	Aomori
Akita	J	1213667	11612	Akita	Akita
Yamagata	J	1256958	9327	Yamagata	Yamagata
Fukushima	J	2133592	13784	Fukushima	Fukushima
Niigata	J	2488364	12579	Niigata	Niigata
Toyama	J	1123125	4252	Toyama	Toyama
Fukui	J	826996	4192	Fukui	Fukui
Nagano	J	2193984	13585	Nagano	Nagano
Gifu	J	2100315	10596	Gifu	Gifu
Shizuoka	J	3737689	7773	Shizuoka	Shizuoka
Nara	J	1430862	3692	Nara	Nara
Wakayama	J	1080435	4725	Wakayama	Wakayama
Tottori	J	614929	3494	Tottori	Tottori
Okayama	J	1950750	7090	Okayama	Okayama
Yamaguchi	J	1555543	6106	Yamaguchi	Yamaguchi
Tokushima	J	832427	4145	Tokushima	Tokushima
Kochi	J	816704	7107	Kochi	Kochi
Saga	J	884316	2433	Saga	Saga
Nagasaki	J	1544934	4112	Nagasaki	Nagasaki
Kumamoto	J	1859793	7408	Kumamoto	Kumamoto
Oita	J	1231306	6338	Oita	Oita
Miyazaki	J	1175819	7735	Miyazaki	Miyazaki
Kagoshima	J	1794224	9166	Kagoshima	Kagoshima
Durango	MEX	1431748	119648	Durango	Durango
Guanajuato	MEX	4406568	30589	Guanajuato	Guanajuato
Tlaxcala	MEX	883924	3914	Tlaxcala	Tlaxcala
Trujillo	YV	562752	7400	Trujillo	Trujillo
Ocotepeque	HCA	81800	1680	Ocotepeque	Ocotepeque
Yoro	HCA	370700	7939	Yoro	Yoro
Arauca	CO	89972	23818	Arauca	Arauca
Cordoba	CO	1013247	25020	Monteria	Cordoba
Cordoba	RA	2766683	165321	Cordoba	Cordoba
Sucre	CO	561649	10917	Sincelejo	Sucre
Sucre	YV	781756	11800	Cumana	Sucre
Sao Paulo	BR	34055715	248808	Sao Paulo	Sao Paulo
Callao	PE	701022	146	Callao	Callao
Huancavelica	PE	413136	22131	Huancavelica	Huancavelica
Moquegua	PE	137747	15733	Moquegua	Moquegua
Tumbes	PE	173616	4669	Tumbes	Tumbes
Cabinda	ANG	163000	7270	Cabinda	Cabinda
Uige	ANG	837000	58698	Uige	Uige
Malanje	ANG	892000	87246	Malanje	Malanje
Benguela	ANG	644000	31788	Benguela	Benguela
Huambo	ANG	1524000	34274	Huambo	Huambo
Bie	ANG	1125000	70314	Bie	Bie
Namibe	ANG	115000	58137	Namibe	Namibe
Bandundu	ZRE	4644758	295658	Bandundu	Bandundu
Lindi	EAT	646600	66046	Lindi	Lindi
Iringa	EAT	1208900	58864	Iringa	Iringa
Singida	EAT	791800	49341	Singida	Singida
Tabora	EAT	1036300	76151	Tabora	Tabora
Diourbel	SN	619700	4359	Diourbel	Diourbel
Fatick	SN	476000	7935	Fatick	Fatick
Kolda	SN	606800	21011	Kolda	Kolda
Louga	SN	490400	29188	Louga	Louga
Tambacounda	SN	370000	59602	Tambacounda	Tambacounda
Inhambane	MOC	1157000	68615	Inhambane	Inhambane
Shan	MYA	3716800	155801	Taunggyi	Shan
Rakhine	MYA	2045600	36778	Akyab	Rakhine
Mon	MYA	1680200	12297	Moulmein	Mon
Beja	P	167900	10225	\N	\N
Burgenland	A	273000	3965	Eisenstadt	Burgenland
Carinthia	A	559000	9533	Klagenfurt	Carinthia
Vorarlberg	A	341000	2601	Bregenz	Vorarlberg
Upper Austria	A	1373000	11979	Linz	Upper Austria
Tyrol	A	649000	12647	Innsbruck	Tyrol
Styria	A	1203000	16386	Graz	Styria
Salzburg	A	501000	7154	Salzburg	Salzburg
Lower Austria	A	1507000	19170	St. Polten	Lower Austria
Antwerp	B	1610695	2867	Antwerp	Antwerp
Brabant	B	2253794	3358	Brussels	Brabant
East Flanders	B	1340056	2982	Ghent	East Flanders
Hainaut	B	1283252	3787	Mons	Hainaut
Liege	B	1006081	3862	Liege	Liege
Limburg	B	755593	2422	Hasselt	Limburg
Limburg	NL	1130050	2167	Maastricht	Limburg
Namur	B	426305	3665	Namur	Namur
West Flanders	B	1111557	3134	Brugge	West Flanders
Jihocesky	CZ	702000	11345	Ceske Budejovice	Jihocesky
Jihomoravsky	CZ	2059000	15028	Brno	Jihomoravsky
Severocesky	CZ	1190000	7819	Usti nad Labem	Severocesky
Severomoravsky	CZ	1976000	11067	Ostrava	Severomoravsky
Praha	CZ	2329000	11490	Prague	Praha
Vychodocesky	CZ	1240000	11240	Hradec Kralove	Vychodocesky
Zapadocesky	CZ	869000	10875	Plzen	Zapadocesky
Aland	SF	23000	\N	Mariehamn	Aland
Haeme	SF	662000	\N	Haemeenlinna	Haeme
Kuopio	SF	252000	\N	Kuopio	Kuopio
Kymi	SF	345000	\N	Kotka	Kymi
Lappia	SF	195000	\N	Rovaniemi	Lappia
Mikkeli	SF	209000	\N	Mikkeli	Mikkeli
Suomi	SF	242000	\N	Jyvaeskylae	Suomi
Pohjols-Karjala	SF	177000	\N	Joensuu	Pohjols-Karjala
Oulu	SF	415000	\N	Oulu	Oulu
Turku-Pori	SF	702000	\N	Turku	Turku-Pori
Uusimaa	SF	1119000	\N	Helsinki	Uusimaa
Vaasa	SF	430000	\N	Vaasa	Vaasa
Alsace	F	1624000	8280	Strasbourg	Alsace
Aquitaine	F	2796000	41309	Bordeaux	Aquitaine
Auvergne	F	1321000	26013	Clermont Ferrand	Auvergne
Basse Normandie	F	1391000	17589	Caen	Basse Normandie
Bretagne	F	2796000	27209	Rennes	Bretagne
Bourgogne	F	1609000	31582	Dijon	Bourgogne
Centre	F	2371000	39151	Orleans	Centre
Centre	CAM	1651600	68926	Yaounde	Centre
Champagne Ardenne	F	1348000	25606	Chalons sur Marne	Champagne Ardenne
Corse	F	250000	8680	Ajaccio	Corse
Franche Comte	F	1097000	16202	Besancon	Franche Comte
Haute Normandie	F	1737000	12318	Rouen	Haute Normandie
Ile de France	F	10660000	12011	Paris	Ile de France
Languedoc Rousillon	F	2115000	27376	Montpellier	Languedoc Rousillon
Limousin	F	723000	16942	Limoges	Limousin
Lorraine	F	2306000	23547	Metz	Lorraine
Midi Pyrenees	F	2431000	45349	Toulouse	Midi Pyrenees
Nord Pas de Calais	F	3965000	12413	Lille	Nord Pas de Calais
Pays de la Loire	F	3059000	32082	Nantes	Pays de la Loire
Picardie	F	1811000	19399	Amiens	Picardie
Poitou Charentes	F	1595000	25809	Poitiers	Poitou Charentes
Provence Cote dAzur	F	4258000	31400	Marseille	Provence Cote dAzur
Rhone Alpes	F	5351000	43698	Lyon	Rhone Alpes
Baden Wurttemberg	D	10272069	35742	Stuttgart	Baden Wurttemberg
Bayern	D	11921944	70546	Munich	Bayern
Brandenburg	D	2536747	29480	Potsdam	Brandenburg
Bremen	D	680000	404	Bremen	Bremen
Hessen	D	5980693	21115	Wiesbaden	Hessen
Mecklenburg Vorpommern	D	1832298	23170	Schwerin	Mecklenburg Vorpommern
Niedersachsen	D	7715363	47609	Hannover	Niedersachsen
Nordrhein Westfalen	D	17816079	34077	Dusseldorf	Nordrhein Westfalen
Rheinland Pfalz	D	3951573	19851	Mainz	Rheinland Pfalz
Saarland	D	1084201	2570	Saarbrucken	Saarland
Sachsen	D	4584345	18412	Dresden	Sachsen
Sachsen Anhalt	D	2759213	20446	Magdeburg	Sachsen Anhalt
Schleswig Holstein	D	2708392	15738	Kiel	Schleswig Holstein
Thuringen	D	2517776	16171	Erfurt	Thuringen
Baranya	H	417100	4487	Pecs	Pecs (munic.)
Bacs Kiskun	H	540800	8363	Kecskemet	Bacs Kiskun
Bekes	H	404000	5632	Bekescaba	Bekes
Borsod Abauj Zemplen	H	749100	7248	Miskolc	Miskolc (munic.)
Csongrad	H	437600	4263	Hodmezovasarhely	Csongrad
Fejer	H	422500	4374	Szekesfehervar	Fejer
Gyor Sopron	H	426800	4012	Gyor	Gyor (munic.)
Hajdu Bihar	H	549700	6212	Debrecen	Debrecen (munic.)
Heves	H	330200	3637	Eger	Heves
Komarom Esztergom	H	312900	2250	Tatabanya	Komarom Esztergom
Nograd	H	222700	2544	Salgotarjan	Nograd
Pest	H	957900	6394	Budapest	Budapest (munic.)
Somogy	H	340000	6035	Kaposvar	Somogy
Szabolcs Szatmar	H	563500	5938	Nyiregyhaza	Szabolcs Szatmar
Tolna	H	251000	3702	Szekszard	Tolna
Vas	H	273900	3337	Szombathely	Vas
Zala	H	302600	3786	Zalaegerszeg	Zala
Budapest (munic.)	H	2008500	525	Budapest	Budapest (munic.)
Debrecen (munic.)	H	217300	446	Debrecen	Debrecen (munic.)
Gyor (munic.)	H	130600	175	Gyor	Gyor (munic.)
Miskolc (munic.)	H	191000	224	Miskolc	Miskolc (munic.)
Pecs (munic.)	H	171600	113	Pecs	Pecs (munic.)
Szeged (munic.)	H	178500	145	Szeged	Szeged (munic.)
Piemonte	I	4307000	25399	Turin	Piemonte
Valle dAosta	I	118000	3262	Aosta	Valle dAosta
Lombardia	I	8901000	23857	Milan	Lombardia
Trentino Alto Adige	I	904000	13618	Bolzano	Trentino Alto Adige
Veneto	I	4415000	18364	Venice	Veneto
Friuli Venezia Giulia	I	1193000	7845	Trieste	Friuli Venezia Giulia
Liguria	I	1663000	5418	Genua	Liguria
Emilia Romagna	I	3924000	22123	Bologna	Emilia Romagna
Toscana	I	3528000	22992	Firenze	Toscana
Umbria	I	819000	8456	Perugia	Umbria
Marche	I	1438000	9693	Ancona	Marche
Lazio	I	5185000	17203	Rome	Lazio
Abruzzo	I	1263000	10794	LAquila	Abruzzo
Molise	I	332000	4438	Campobasso	Molise
Campania	I	5709000	13595	Napoli	Campania
Puglia	I	4066000	19348	Bari	Puglia
Basilicata	I	611000	9992	Potenza	Basilicata
Calabria	I	2080000	15080	Catanzaro	Calabria
Sicilia	I	5025000	25709	Palermo	Sicilia
Sardegna	I	1657000	24090	Cagliari	Sardegna
Groningen	NL	557995	2344	Groningen	Groningen
Friesland	NL	609579	3361	Leeuwarden	Friesland
Drenthe	NL	454864	2652	Assen	Drenthe
Overijssel	NL	1050389	3337	Zwolle	Overijssel
Flevoland	NL	262325	1425	Lelystad	Flevoland
Gelderland	NL	1864732	4995	Arnhem	Gelderland
Utrecht	NL	1063460	1356	Utrecht	Utrecht
Noord Holland	NL	2463611	265978	Haarlem	Noord Holland
Zuid Holland	NL	3325064	2859	s Gravenhage	Zuid Holland
Zeeland	NL	365846	1791	Middelburg	Zeeland
Noord Brabant	NL	2276207	4938	s Hertogenbosch	Noord Brabant
Akershus	N	393217	\N	Oslo	Oslo
Oestfold	N	234941	\N	Moss	Oestfold
Hedmark	N	186355	\N	Hamar	Hedmark
Oppland	N	181791	\N	Lillehammer	Oppland
Buskerud	N	219967	\N	Drammen	Buskerud
Vestfold	N	191600	\N	Toensberg	Vestfold
Telemark	N	162547	\N	Skien	Telemark
Aust Agder	N	94688	\N	Arendal	Aust Agder
Vest Agder	N	140232	\N	Kristiansand	Vest Agder
Rogaland	N	323365	\N	Stavanger	Rogaland
Hordaland	N	399702	\N	Bergen	Hordaland
Sogn og Fjordane	N	106116	\N	Hermannsverk	Sogn og Fjordane
Moere og Romsdal	N	237290	\N	Molde	Moere og Romsdal
Soer Trondelag	N	246824	\N	Trondheim	Soer Trondelag
Nord Trondelag	N	126692	\N	Steinkjer	Nord Trondelag
Nordland	N	242268	\N	Bodoe	Nordland
Troms	N	146736	\N	Tromsoe	Troms
Finnmark	N	75667	\N	Vadsoe	Finnmark
Warszwaskie	PL	2421000	3788	Warsaw	Warszwaskie
Bialskopodlaskie	PL	306700	5348	Biala Podlaska	Bialskopodlaskie
Bialostockie	PL	697000	10055	Bialystok	Bialostockie
Bielskie	PL	911500	3704	Bielsko Biala	Bielskie
Bydgoskie	PL	1120300	10349	Bydgoszcz	Bydgoskie
Chelmskie	PL	248500	3866	Chelm	Chelmskie
Ciechanowskie	PL	431400	6362	Ciechanow	Ciechanowskie
Czestochowskie	PL	748000	6182	Czestochowa	Czestochowskie
Elblaskie	PL	483200	6103	Elblag	Elblaskie
Gdanskie	PL	1445000	7394	Gdansk	Gdanskie
Gorzowskie	PL	505600	8484	Gorzow Wielkopolskie	Gorzowskie
Jeleniogorskie	PL	519200	4379	Jelenia Gora	Jeleniogorskie
Kaliskie	PL	715600	6512	Kalisz	Kaliskie
Katowickie	PL	4013200	6650	Katowice	Katowickie
Kieleckie	PL	1127700	9211	Kielce	Kieleckie
Koninskie	PL	472400	5139	Konin	Koninskie
Koszalinskie	PL	513700	8470	Koszalin	Koszalinskie
Krakowskie	PL	1238100	3254	Krakow	Krakowskie
Krosnienskie	PL	500700	5702	Krosno	Krosnienskie
Legnickie	PL	521500	4037	Legnica	Legnickie
Leszczynskie	PL	391500	4154	Leszno	Leszczynskie
Lubelskie	PL	1022600	6792	Lublin	Lubelskie
Lomzynskie	PL	349000	6684	Lomza	Lomzynskie
Lodzkie	PL	1132400	1523	Lodz	Lodzkie
Nowosadeckie	PL	709500	5576	Nowy Sacz	Nowosadeckie
Olsztynskie	PL	761300	12327	Olsztyn	Olsztynskie
Opolskie	PL	1023800	8535	Opole	Opolskie
Ostroleckie	PL	400500	6498	Ostroleka	Ostroleckie
Pilskie	PL	485700	8205	Pila	Pilskie
Piotrkowskie	PL	644200	6266	Piottrkow Trybunalski	Piotrkowskie
Plockie	PL	518600	5117	Plock	Plockie
Poznanskie	PL	1344200	8151	Poznan	Poznanskie
Przemyskie	PL	409600	4437	Przemysl	Przemyskie
Radomskie	PL	755500	7294	Radom	Radomskie
Rzeszowskie	PL	734100	4397	Rzeszow	Rzeszowskie
Siedleckie	PL	655300	8499	Siedlce	Siedleckie
Sieradzkie	PL	408700	4869	Sieradz	Sieradzkie
Skierniewickie	PL	421700	3960	Skierniewice	Skierniewickie
Slupskie	PL	419300	7453	Slupsk	Slupskie
Suwalskie	PL	477100	10490	Suwalki	Suwalskie
Szczecinskie	PL	979500	9982	Szczecin	Szczecinskie
Tarnobrzeskie	PL	604300	6283	Tarnobrzeg	Tarnobrzeskie
Tarnowskie	PL	678400	4151	Tarnow	Tarnowskie
Torunskie	PL	662600	5348	Torun	Torunskie
Walbrzyskie	PL	740000	4168	Walbrzych	Walbrzyskie
Wloclawskie	PL	430800	4402	Wloclawek	Wloclawskie
Wroclawskie	PL	1132800	6287	Wroclaw	Wroclawskie
Zamojskie	PL	490800	6980	Zamosc	Zamojskie
Zielonogorskie	PL	664700	8868	Zielona Gora	Zielonogorskie
Aveiro	P	656000	2808	\N	\N
Braga	P	746100	2673	\N	\N
Braganca	P	158300	6608	\N	\N
Castelo Branco	P	214700	6675	\N	\N
Coimbra	P	427600	3947	\N	\N
Evora	P	173500	7393	\N	\N
Faro	P	340100	4960	\N	\N
Guarda	P	187800	5518	\N	\N
Leiria	P	427800	3515	\N	\N
Portalegre	P	134300	6065	\N	\N
Porto	P	1622300	2395	\N	\N
Santarem	P	442700	6747	\N	\N
Setubal	P	713700	5064	\N	\N
Viana do Castelo	P	248700	2255	\N	\N
Vila Real	P	237100	4328	\N	\N
Viseu	P	401000	5007	\N	\N
Azores, The	P	236700	2247	\N	\N
Madeira	P	253000	794	\N	\N
Alba	RO	428000	6231	Alba Iulia	Alba
Arad	RO	507000	7652	Arad	Arad
Arges	RO	678000	6801	Pitesti	Arges
Bacau	RO	731000	6606	Bacau	Bacau
Bihor	RO	660000	7535	Oradea	Bihor
Bistrita Nasaud	RO	328000	5305	Bistrita	Bistrita Nasaud
Braila	RO	404000	4724	Braila	Braila
Brasov	RO	695000	5351	Brasov	Brasov
Bucuresti	RO	2319000	1521	Bucharest	Bucuresti
Buzau	RO	524000	6072	Buzau	Buzau
Caras Severin	RO	408000	8503	Resita	Caras Severin
Cluj	RO	743000	6650	Cluj Napoca	Cluj
Constanta	RO	737000	7055	Constanta	Constanta
Covasha	RO	238000	3705	Sfintu Gheorghe	Covasha
Dimbovita	RO	570000	4035	Tirgoviste	Dimbovita
Dolj	RO	772000	7413	Craiova	Dolj
Galati	RO	642000	4425	Galati	Galati
Gorj	RO	388000	5641	Tirgu Jiu	Gorj
Harghita	RO	363000	6610	Miercurea Ciuc	Harghita
Hunedoara	RO	567000	7016	Deva	Hunedoara
Ialomita	RO	309000	4449	Slobozia	Ialomita
Iasi	RO	810000	5469	Iasi	Iasi
Maramures	RO	556000	6215	Baia Mare	Maramures
Mehedinti	RO	329000	4900	Drobeta Turnu Severin	Mehedinti
Mures	RO	621000	6696	Tirgu Mures	Mures
Neamt	RO	580000	5890	Piatra Neamt	Neamt
Olt	RO	535000	5507	Slatina	Olt
Prahova	RO	877000	4694	Ploiesti	Prahova
Salaj	RO	269000	3850	Zalau	Salaj
Satu Mare	RO	417000	4405	Satu Mare	Satu Mare
Sibiu	RO	509000	5422	Sibiu	Sibiu
Teleorman	RO	504000	5760	Alexandria	Teleorman
Timis	RO	726000	8692	Timisoara	Timis
Vilcea	RO	430000	5705	Rimnicu Vilcea	Vilcea
Vrancea	RO	394000	4863	Focsani	Vrancea
Andalusia	E	7053043	87600	Sevilla	Andalusia
Aragon	E	1183576	47720	Zaragoza	Aragon
Asturias	E	1083388	10604	Oviedo	Asturias
Balearic Islands	E	736865	4992	Palma de Mallorca	Balearic Islands
Basque Country	E	2075561	7235	Vitoria Gasteiz	Basque Country
Canary Islands	E	1534897	7447	Santa Cruz de Tenerife	Canary Islands
Cantabria	E	526090	5321	Santander	Cantabria
Castile and Leon	E	2504371	94224	Valladolid	Castile and Leon
Castile La Mancha	E	1656179	79462	Toledo	Castile La Mancha
Catalonia	E	6090107	32113	Barcelona	Catalonia
Estremadura	E	1050590	41635	Merida	Estremadura
Galicia	E	2720761	29574	Santiago de Compostella	Galicia
Murcia	E	1070401	11314	Murcia	Murcia
Navarre	E	523614	10391	Pamplona	Navarre
Rioja	E	263437	5045	Logrono	Rioja
Alvsborg	S	444259	11395	Vanersborg	Alvsborg
Blekinge	S	151168	2941	Karlskrona	Blekinge
Gavleborg	S	289339	18191	Gavle	Gavleborg
Goteborg och Bohus	S	742550	5141	Goteborg	Goteborg och Bohus
Gotland	S	57383	3140	Visby	Gotland
Halland	S	257874	5454	Halmstad	Halland
Jamtland	S	136009	49443	Ostersund	Jamtland
Jonkoping	S	309738	9944	Jonkoping	Jonkoping
Kopparberg	S	290388	28194	Falun	Kopparberg
Kronoberg	S	178612	8458	Vaxjo	Kronoberg
Malmohus	S	786757	4938	Malmo	Malmohus
Norrbotten	S	264834	98913	Lulea	Norrbotten
Orebro	S	273608	8519	Orebro	Orebro
Ostergotland	S	406100	10562	Linkoping	Ostergotland
Skaraborg	S	278162	7937	Mariestad	Skaraborg
Sodermanland	S	256818	6060	Nykoping	Sodermanland
Uppsala	S	273918	6989	Uppsala	Uppsala
Varmland	S	284187	17584	Karlstad	Varmland
Vasterbotten	S	253835	55401	Umea	Vasterbotten
Vasternorrland	S	261280	21678	Harnosand	Vasternorrland
Vastmanland	S	259438	6302	Vasteras	Vastmanland
AR	CH	54104	242	Herisau	AR
AI	CH	14750	172	Appenzell	AI
BL	CH	252331	517	Liestal	BL
BE	CH	941952	5960	Bern	BE
FR	CH	224552	1670	Fribourg	FR
GL	CH	39410	685	Glarus	GL
JU	CH	69188	836	Delemont	JU
LU	CH	340536	1493	Luzern	LU
NE	CH	165258	803	Neuchatel	NE
NW	CH	36466	276	Stans	NW
OW	CH	31310	490	Sarnen	OW
SG	CH	442350	2025	Sankt Gallen	SG
SH	CH	74035	298	Schaffhausen	SH
SZ	CH	122409	908	Schwyz	SZ
SO	CH	239264	790	Solothurn	SO
TG	CH	223372	990	Frauenfeld	TG
TI	CH	305199	2812	Bellinzona	TI
UR	CH	35876	1076	Altdorf	UR
VS	CH	271291	5224	Sion	VS
VD	CH	605677	3211	Lausanne	VD
ZG	CH	92392	238	Zug	ZG
ZH	CH	1175457	1728	Zurich	ZH
Cherkaska	UA	1530900	20900	Cherkasy	Cherkaska
Chernihivska	UA	938600	31900	Chernihiv	Chernihivska
Chernivetska	UA	1405800	8100	Chernivtsi	Chernivetska
Dnipropetrovska	UA	3908700	31900	Dnipropetrovsk	Dnipropetrovska
Donetska	UA	5346700	26500	Donetsk	Donetska
Ivano Frankivska	UA	1442900	13900	Ivano Frankivsk	Ivano Frankivska
Kharkivska	UA	3194800	31400	Kharkiv	Kharkivska
Khersonska	UA	1258700	28500	Kherson	Khersonska
Khmelnytska	UA	1520600	20600	Khmelnytskyy	Khmelnytska
Kyyivska	UA	4589800	28900	Kiev	Kyyivska
Kirovohradska	UA	1245300	24600	Kirovohrad	Kirovohradska
Luhanska	UA	2871100	26700	Luhansk	Luhanska
Lvivska	UA	2764400	21800	Lviv	Lvivska
Mykolayivska	UA	1342400	24600	Mykolayiv	Mykolayivska
Odeska	UA	2635300	33300	Odesa	Odeska
Poltavska	UA	1756900	28800	Poltava	Poltavska
Rivnenska	UA	1176800	20100	Rivne	Rivnenska
Sumska	UA	1430200	23800	Sumy	Sumska
Ternopilska	UA	1175100	13800	Ternopil	Ternopilska
Vinnytska	UA	1914400	26500	Vinnytsya	Vinnytska
Volynska	UA	1069000	20200	Lutsk	Volynska
Zakarpatska	UA	1265900	12800	Uzhhorod	Zakarpatska
Zaporizka	UA	2099600	27200	Zaporizhzhya	Zaporizka
Zhytomyrska	UA	1510700	29900	Zhytomyr	Zhytomyrska
Krym	UA	2549800	27000	Simferopol	Krym
Avon	GB	962000	1346	Bristol	Avon
Bedfordshire	GB	534300	1235	Bedford	Bedfordshire
Berkshire	GB	752500	1259	Reading	Berkshire
Buckinghamshire	GB	640200	1883	Aylesbury	Buckinghamshire
Cambridgeshire	GB	669900	3409	Cambridge	Cambridgeshire
Cheshire	GB	966500	2329	Chester	Cheshire
Cleveland	GB	557500	583	Middlesbrough	Cleveland
Cornwall / Isles of Scilly	GB	475200	3564	Truro	Cornwall / Isles of Scilly
Cumbria	GB	489700	6810	Carlisle	Cumbria
Derbyshire	GB	938800	2631	Matlock	Derbyshire
Devon	GB	1040000	6711	Exeter	Devon
Dorset	GB	662900	2654	Dorchester	Dorset
East Sussex	GB	716500	1795	Lewes	East Sussex
Essex	GB	1548800	3672	Chelmsford	Essex
Gloucestershire	GB	538800	2643	Glouchester	Gloucestershire
Greater London	GB	6803100	1579	London	Greater London
Greater Manchester	GB	2561600	1287	Manchester	Greater Manchester
Hampshire	GB	1578700	3777	Winchester	Hampshire
Hereford and Worcester	GB	696000	3927	Worcester	Hereford and Worcester
Hertfordshire	GB	989500	1634	Hertford	Hertfordshire
Humberside	GB	874400	3512	Hull	Humberside
Isle of Wight	GB	126600	381	Newport	Newport
Kent	GB	1538800	3731	Maidstone	Kent
Lancashire	GB	1408300	3064	Preston	Lancashire
Leicestershire	GB	890800	2553	Leichester	Leicestershire
Lincolnshire	GB	592600	5915	Lincoln	Lincolnshire
Merseyside	GB	1441100	652	Liverpool	Merseyside
Norfolk	GB	759400	5368	Norwich	Norfolk
Northamptonshire	GB	587100	2367	Northampton	Northamptonshire
Northumberland	GB	307100	5032	Newcastle	Tyne and Wear
North Yorkshire	GB	720900	8309	Northallerton	North Yorkshire
Nottinghamshire	GB	1015500	2164	Nottingham	Nottinghamshire
Oxfordshire	GB	597700	2608	Oxford	Oxfordshire
Shropshire	GB	412500	3490	Shrewsbury	Shropshire
Somerset	GB	469400	3451	Taunton	Somerset
South Yorkshire	GB	1292700	1560	Barnsley	South Yorkshire
Staffordshire	GB	1047400	2716	Stafford	Staffordshire
Suffolk	GB	661900	3797	Ipswich	Suffolk
Surrey	GB	1035500	1679	Kingston	Surrey
Tyne and Wear	GB	1125600	540	Newcastle	Tyne and Wear
Warwickshire	GB	489900	1981	Warwick	Warwickshire
West Midlands	GB	2619000	899	Birmingham	West Midlands
West Sussex	GB	713600	1989	Chichester	West Sussex
West Yorkshire	GB	2066200	2039	Wakefield	West Yorkshire
Wiltshire	GB	575100	3480	Trowbridge	Wiltshire
Borders	GB	105700	4698	Newtown St. Boswells	Borders
Central	GB	273400	2700	Stirling	Central
Central	IL	938000	1242	Ramla	Central
Central	Z	722400	94395	Kabwe	Central
Central	EAK	3110000	13176	Nyeri	Central
Dumfries and Galloway	GB	147800	6425	Dumfries	Dumfries and Galloway
Fife	GB	352100	1319	Glenrothes	Fife
Grampian	GB	532500	8752	Aberdeen	Grampian
Highland	GB	207500	26137	Inverness	Highland
Lothian	GB	758600	1770	Edinburgh	Lothian
Strathclyde	GB	2287800	13773	Glasgow	Strathclyde
Tayside	GB	395000	7643	Dundee	Tayside
Island Areas (munic.)	GB	72000	5566	Island Areas	Island Areas (munic.)
Aberconwy and Colwyn	GB	110700	1130	Colwyn Bay	Aberconwy and Colwyn
Anglesey	GB	68500	719	Llangefni	Anglesey
Blaenau Gwent	GB	73300	109	Ebbw Vale	Blaenau Gwent
Caerphilly	GB	171000	279	Ystrad Fawr	Caerphilly
Cardiff	GB	306600	139	Cardiff	Cardiff
Carmarthenshire	GB	169000	2398	Carmarthen	Carmarthenshire
Ceredigion	GB	69700	1797	Aberystwyth	Ceredigion
Denbighshire	GB	91300	844	Ruthin	Denbighshire
Flintshire	GB	145300	437	Mold	Flintshire
Gwynedd	GB	117000	2548	Caernarfon	Gwynedd
Merthyr Tydfil	GB	59500	111	Merthyr Tydfil	Merthyr Tydfil
Monmouthshire	GB	84200	851	Cwmbran	Monmouthshire
Neath and Port Talbot	GB	140100	441	Port Talbot	Neath and Port Talbot
Newport	GB	137400	191	Newport	Newport
Pembrokeshire	GB	113600	1590	Haverfordwest	Pembrokeshire
Powys	GB	121800	5204	Llandrindod Wells	Powys
Rhondda Cynon Taff	GB	239000	424	Rhondda	Rhondda Cynon Taff
Swansea	GB	230900	378	Swansea	Swansea
Torfaen	GB	90600	126	Pontypool	Torfaen
Vale of Glamorgan	GB	119200	337	Barry	Vale of Glamorgan
Northern Ireland	GB	1594400	14120	Belfast	Northern Ireland
Ayeyarwady	MYA	4994100	35138	Pathein	Ayeyarwady
Bago	MYA	3799800	39404	Bago	Bago
Yangon	MYA	3965900	10171	Rangoon	Yangon
Tanintharyi	MYA	917200	43343	Tavoy	Tanintharyi
Chin	MYA	368900	36019	Hakha	Chin
Kachin	MYA	904800	89041	Myitkyina	Kachin
Kayin	MYA	1055400	30383	Hpa an	Kayin
Kayah	MYA	168400	11733	Loikaw	Kayah
Anhui	TJ	59550000	139000	Hefei	Anhui
Fujian	TJ	31830000	120000	Fuzhou	Fujian
Gansu	TJ	23780000	450000	Lanzhou	Gansu
Guangdong	TJ	66890000	186000	Guangzhou	Guangdong
Guizhou	TJ	34580000	170000	Guiyang	Guizhou
Hainan	TJ	7110000	34000	Haikou	Hainan
Hebei	TJ	63880000	190000	Shijiazhuang	Hebei
Heilongjiang	TJ	36720000	469000	Harbin	Heilongjiang
Henan	TJ	90270000	167000	Zhengzhou	Henan
Hubei	TJ	57190000	187400	Wuhan	Hubei
Hunan	TJ	63550000	210000	Changsha	Hunan
Jiangsu	TJ	70210000	102600	Nanjing	Jiangsu
Jiangxi	TJ	40150000	166600	Nanchang	Jiangxi
Jilin	TJ	25740000	187000	Changchun	Jilin
Liaoning	TJ	40670000	145700	Shenyang	Liaoning
Qinghai	TJ	4740000	720000	Xining	Qinghai
Shaanxi	TJ	34810000	205000	Xi	Shaanxi
Shandong	TJ	86710000	153000	Jinan	Shandong
Shanxi	TJ	30450000	156000	Taiyuan	Shanxi
Sichuan	TJ	112140000	570000	Chengdu	Sichuan
Yunnan	TJ	39390000	394000	Kunming	Yunnan
Zhejiang	TJ	42940000	101800	Hangzhou	Zhejiang
Guangxi Zhuangzu	TJ	44930000	236300	Nanning	Guangxi Zhuangzu
Nei Monggol	TJ	22600000	1183000	Hohhot	Nei Monggol
Ningxia Huizu	TJ	5040000	66400	Yinchuan	Ningxia Huizu
Xinjiang Uygur	TJ	16320000	1600000	Urumqi	Xinjiang Uygur
Tibet	TJ	2360000	1220000	Lhasa	Tibet
Beijing (munic.)	TJ	11250000	16800	Beijing	Beijing (munic.)
Shanghai (munic.)	TJ	13560000	6200	Shanghai	Shanghai (munic.)
Tianjin (munic.)	TJ	9350000	11300	Tianjin	Tianjin (munic.)
Andhra Pradesh	IND	66508008	275045	Hyderabad	Andhra Pradesh
Arunachal Pradesh	IND	864558	83743	Itanagar	Arunachal Pradesh
Assam	IND	22414322	78438	Dispur	Assam
Bihar	IND	86374465	173877	Patna	Bihar
Goa	IND	1169793	3702	Panaji	Goa
Gujarat	IND	41309582	196024	Gandhinagar	Gujarat
Haryana	IND	16463648	44212	Chandigarh	Chandigarh
Himachal Pradesh	IND	5170877	55673	Simla	Himachal Pradesh
Jammu and Kashmir	IND	7718700	101387	Srinagar	Jammu and Kashmir
Karnataka	IND	44977201	191791	Bangalore	Karnataka
Kerala	IND	29098518	38863	Trivandrum	Kerala
Madhya Pradesh	IND	66181170	443446	Bhopal	Madhya Pradesh
Maharashtra	IND	78937187	307713	Bombay	Maharashtra
Manipur	IND	1837149	22327	Imphal	Manipur
Meghalaya	IND	1774778	22429	Shillong	Meghalaya
Mizoram	IND	689756	21081	Aijal	Mizoram
Nagaland	IND	1209546	16579	Kohima	Nagaland
Orissa	IND	31659736	155707	Bhubaneswar	Orissa
Punjab	IND	20281969	50362	Chandigarh	Chandigarh
Rajasthan	IND	44005990	342239	Jaipur	Rajasthan
Sikkim	IND	406457	7096	Gangtok	Sikkim
Tamil Nadu	IND	55858946	130058	Madras	Tamil Nadu
Tripura	IND	2757205	10486	Agartala	Tripura
Uttar Pradesh	IND	139112287	294411	Lucknow	Uttar Pradesh
West Bengal	IND	68077965	88752	Calcutta	West Bengal
Andaman and Nicobar Is.	IND	280661	8249	Port Blair	Andaman and Nicobar Is.
Chandigarh	IND	642015	114	Chandigarh	Chandigarh
Dadra and Nagar Haveli	IND	138477	491	Silvassa	Dadra and Nagar Haveli
Daman and Diu	IND	101586	112	Daman	Daman and Diu
Delhi	IND	9420644	1483	New Delhi	Delhi
Lakshadweep Is.	IND	51707	32	Kavaratti	Lakshadweep Is.
Azarbayian e Gharbt	IR	2284208	38850	Orumiyeh	Azarbayian e Gharbt
Azarbayian e Sharqi	IR	4420343	67102	Tabriz	Azarbayian e Sharqi
Bakhtaran	IR	1622159	23667	Bakhtaran	Bakhtaran
Boyer Ahmad e Kohkiluyeh	IR	496739	14261	Yasuj	Boyer Ahmad e Kohkiluyeh
Chahar Mahal e Bakhtiari	IR	747297	14870	Shahr e Kord	Chahar Mahal e Bakhtiari
Esfahan	IR	3682444	104650	Esfahan	Esfahan
Fars	IR	3543828	133298	Shiraz	Fars
Gilan	IR	2204047	14709	Rasht	Gilan
Hamadan	IR	1651320	19784	Hamadan	Hamadan
Hormozgan	IR	924433	66780	Bandar Abbas	Hormozgan
Ilam	IR	440693	19044	Ilam	Ilam
Kerman	IR	1862542	179916	Kerman	Kerman
Khorasan	IR	6013200	313337	Mashhad	Khorasan
Khuzestan	IR	3175852	67282	Ahvaz	Khuzestan
Kordestan	IR	1233480	24998	Sanandaj	Kordestan
Lorestan	IR	1501778	28803	Khorramabad	Lorestan
Markazi	IR	1182611	29080	Arak	Markazi
Mazandaran	IR	3793149	46456	Sari	Mazandaran
Sistan e Baluchestan	IR	1455102	181578	Zahedan	Sistan e Baluchestan
Yazd	IR	691119	70011	Yazd	Yazd
Zanjan	IR	1776133	36398	Zanjan	Zanjan
Al Anbar	IRQ	817868	138501	Ar Ramadi	Al Anbar
Babil	IRQ	1108773	6468	Al Hillah	Babil
Al Basrah	IRQ	872211	19070	Al Basrah	Al Basrah
Dhi Qar	IRQ	917880	12900	An Nasiriyah	Dhi Qar
Diyala	IRQ	955112	19076	Baqubah	Diyala
Karbala	IRQ	455868	5034	Karbala	Karbala
Maysan	IRQ	499842	16072	Al Amarah	Maysan
Al Muthanna	IRQ	312911	51740	As Samawah	Al Muthanna
An Najaf	IRQ	583493	28824	An Najaf	An Najaf
Ninawa	IRQ	1507926	35899	Al Mawsil	Ninawa
Al Qadisiyah	IRQ	560797	8153	Ad Diwaniyah	Al Qadisiyah
Salah ad Din	IRQ	723500	26175	Samarra	Salah ad Din
Ad Tamim	IRQ	592869	10282	Kirkuk	Ad Tamim
Wasit	IRQ	546676	17153	Al Kut	Wasit
Irbil	IRQ	742538	14471	Irbil	Irbil
As Sulaymaniyah	IRQ	942513	17023	As Sulaymaniyah	As Sulaymaniyah
North	IL	739500	4501	Nazareth	North
South	IL	529300	14107	Beer Sheva	South
Hokkaido	J	5692321	83519	Sapporo	Hokkaido
Iwate	J	1419505	15277	Morioka	Iwate
Miyagi	J	2328739	7292	Sendai	Miyagi
Ibaraki	J	2955530	6094	Mito	Ibaraki
Tochigi	J	1984390	6414	Utsonomiya	Tochigi
Gumma	J	2003540	6356	Maebashi	Gumma
Saitama	J	6759311	3799	Urawa	Saitama
Chiba	J	5797782	5150	Chiba	Chiba
Kanagawa	J	8245900	2402	Yokohama	Kanagawa
Ishikawa	J	1180068	4197	Kanazawa	Ishikawa
Yamanashi	J	881996	4463	Kofu	Yamanashi
Aichi	J	6868336	5138	Nagoya	Aichi
Mie	J	1841358	5778	Tsu	Mie
Shiga	J	1287005	4016	Otsu	Shiga
Kyoto	J	2629592	4613	Kyoto	Kyoto
Osaka	J	8797268	1868	Osaka	Osaka
Hyogo	J	5401877	8381	Kobe	Hyogo
Shimane	J	771441	6628	Matsue	Shimane
Hiroshima	J	2881748	8467	Hiroshima	Hiroshima
Kagawa	J	1027006	1882	Takamatsu	Kagawa
Ehime	J	1506700	5672	Matsuyama	Ehime
Okinawa	J	1273440	2255	Naha	Okinawa
Almaty	KAZ	963100	105700	Almaty	Almaty (munic.)
Aqmola	KAZ	845700	92000	Aqmola	Aqmola
Aqtobe	KAZ	752800	300600	Aqtobe	Aqtobe
Atyrau	KAZ	459600	118600	Atyrau	Atyrau
Batys Qazaqstan	KAZ	669800	151300	Oral	Batys Qazaqstan
Kokchetau	KAZ	657000	78200	Kokchetau	Kokchetau
Mangghystau	KAZ	324400	165600	Aqtau	Mangghystau
Ongtustik Qazaqstan	KAZ	1987800	117300	Shymkent	Ongtustik Qazaqstan
Pavlodar	KAZ	943600	124800	Pavlodar	Pavlodar
Qaraghandy	KAZ	1270100	115400	Karaganda	Qaraghandy
Qostanay	KAZ	1055300	113900	Qostanay	Qostanay
Qyzylorda	KAZ	606100	226000	Qyzylorda	Qyzylorda
Semey	KAZ	811000	185800	Semey	Semey
Shyghys Qazaqstan	KAZ	939500	97500	Oskemen	Shyghys Qazaqstan
Soltustik Qazaqstan	KAZ	600900	45000	Petropavl	Soltustik Qazaqstan
Taldyqorghan	KAZ	721500	118500	Taldyqorghan	Taldyqorghan
Torghay	KAZ	305900	111800	Arqalyq	Torghay
Almaty (munic.)	KAZ	1172400	0	Almaty	Almaty (munic.)
Leninsk (munic.)	KAZ	68600	0	Leninsk	Leninsk (munic.)
Johor	MAL	2074297	18986	Johor Baharu	Johor
Kedah	MAL	1304800	9426	Alor Setar	Kedah
Kelantan	MAL	1181680	14943	Kota Baharu	Kelantan
Melaka	MAL	504502	1650	Melaka	Melaka
Negeri Sembilan	MAL	691150	6643	Seremban	Negeri Sembilan
Pahang	MAL	1036724	35965	Kuantan	Pahang
Perak	MAL	1880016	21005	Ipoh	Perak
Perlis	MAL	184070	795	Kangar	Perlis
Pulau Pinang	MAL	1065075	1031	George Town	Pulau Pinang
Sabah	MAL	1736902	73620	Kota Kinabalu	Sabah
Sarawak	MAL	1648217	124449	Kuching	Sarawak
Selangor	MAL	2289236	7956	Shah Alam	Selangor
Terengganu	MAL	770931	12955	Kuala Terengganu	Terengganu
Fed. Terr. of Kuala Lumpur	MAL	1145075	243	Kuala Lumpur	Fed. Terr. of Kuala Lumpur
Fed. Terr. of Labuan	MAL	54307	91	Labuan	Fed. Terr. of Labuan
Rep. of Karelia	R	785000	172400	Petrozavodsk	Rep. of Karelia
Rep. of Komi	R	1185500	415900	Syktyvkar	Rep. of Komi
Arkhangelskaya oblast	R	1520800	587400	Arkhangelsk	Arkhangelskaya oblast
Vologodskaya oblast	R	1349800	145700	Vologda	Vologodskaya oblast
Murmanskaya oblast	R	1048000	144900	Murmansk	Murmanskaya oblast
Kaliningradskaya oblast	R	932200	15100	Kaliningrad	Kaliningradskaya oblast
Sankt Peterburg	R	4801500	0	Sankt Peterburg	Sankt Peterburg
Leningradskaya oblast	R	1675900	85900	Sankt Peterburg	Sankt Peterburg
Novgorodskaya oblast	R	742600	55300	Novgorod	Novgorodskaya oblast
Pskovskaya oblast	R	832300	55300	Pskov	Pskovskaya oblast
Bryanskaya oblast	R	1479700	34900	Bryansk	Bryanskaya oblast
Vladimirskaya oblast	R	1644700	29000	Vladimir	Vladimirskaya oblast
Ivanovskaya oblast	R	1266400	23900	Ivanovo	Ivanovskaya oblast
Kaluzhskaya oblast	R	1097300	29900	Kaluga	Kaluzhskaya oblast
Kostromskaya oblast	R	805700	60100	Kostroma	Kostromskaya oblast
Moskva	R	8664400	0	Moscow	Moskva
Moskovskaya oblast	R	6596600	47000	Moscow	Moskva
Orlovskaya oblast	R	914000	24700	Orel	Orlovskaya oblast
Ryazanskaya oblast	R	1325300	39600	Ryazan	Ryazanskaya oblast
Smolenskaya oblast	R	1172400	49800	Smolensk	Smolenskaya oblast
Tverskaya oblast	R	1650600	84100	Tver	Tverskaya oblast
Tulskaya oblast	R	1814500	25700	Tula	Tulskaya oblast
Yaroslavskaya oblast	R	1451400	36400	Yaroslavl	Yaroslavskaya oblast
Rep. of Mariy El	R	766300	23200	Yoshkar Ola	Rep. of Mariy El
Rep. of Mordovia	R	955800	26200	Saransk	Rep. of Mordovia
Chuvash Republic	R	1360800	18300	Cheboksary	Chuvash Republic
Kirovskaya oblast	R	1634500	120800	Kirov	Kirovskaya oblast
Nizhegorodskaya oblast	R	3726400	74800	Nizhniy Novgorod	Nizhegorodskaya oblast
Belgorodskaya oblast	R	1469100	27100	Belgorod	Belgorodskaya oblast
Voronezhskaya oblast	R	2503800	52400	Voronezh	Voronezhskaya oblast
Kurskaya oblast	R	1346900	29800	Kursk	Kurskaya oblast
Kansas	USA	2594840	213097	Topeka	Kansas
Lipetskaya oblast	R	1250200	24100	Lipetsk	Lipetskaya oblast
Tambovskaya oblast	R	1310600	34300	Tambov	Tambovskaya oblast
Rep. of Kalmykiya	R	318500	76100	Elista	Rep. of Kalmykiya
Rep. of Tatarstan	R	3760500	68000	Kazan	Rep. of Tatarstan
Astrakhanskaya oblast	R	1028900	44100	Astrakhan	Astrakhanskaya oblast
Volgogradskaya oblast	R	2703700	113900	Volgograd	Volgogradskaya oblast
Penzenskaya oblast	R	1562300	43200	Penza	Penzenskaya oblast
Samarskaya oblast	R	3311500	53600	Samara	Samarskaya oblast
Saratovskaya oblast	R	2739500	100200	Saratov	Saratovskaya oblast
Ulyanovskaya oblast	R	1495200	37300	Simbirsk	Ulyanovskaya oblast
Rostovskaya oblast	R	4426400	100800	Rostov no Donu	Rostovskaya oblast
Rep. of Bashkortostan	R	4096600	143600	Ufa	Rep. of Bashkortostan
Udmurt Republic	R	1639100	42100	Izhevsk	Udmurt Republic
Orenburgskaya oblast	R	2228600	124000	Orenburg	Orenburgskaya oblast
Permskaya oblast	R	3009400	160600	Perm	Permskaya oblast
Rep. of Adygeya	R	450500	7600	Maykop	Rep. of Adygeya
Rep. of Dagestan	R	2097500	50300	Makhachkala	Rep. of Dagestan
Rep. of Ingushetiya	R	299700	3750	Nazran	Rep. of Ingushetiya
Kabardino Balkar Rep.	R	789900	12500	Nalchik	Kabardino Balkar Rep.
Karachayevo Cherkessk Rep.	R	436300	14100	Cherkessk	Karachayevo Cherkessk Rep.
Rep. of North Ossetiya	R	662600	8000	Vladikavkaz	Rep. of North Ossetiya
Chechen Rep.	R	865100	12300	Grozny	Chechen Rep.
Krasnodarsky kray	R	5043900	76000	Krasnodar	Krasnodarsky kray
Stavropolsky kray	R	2667000	66500	Stavropol	Stavropolsky kray
Kurganskaya oblast	R	1112200	71000	Kurgan	Kurganskaya oblast
Sverdlovskaya oblast	R	4686300	194300	Yekaterinburg	Sverdlovskaya oblast
Chelyabinskaya oblast	R	3688700	87900	Chelyabinsk	Chelyabinskaya oblast
Rep. of Altay	R	201600	92600	Gorno Altaysk	Rep. of Altay
Altayskiy kray	R	2690100	169100	Barnaul	Altayskiy kray
Kemerovskaya oblast	R	3063500	95500	Kemerovo	Kemerovskaya oblast
Novosibirskaya oblast	R	2748600	178200	Novosibirsk	Novosibirskaya oblast
Omskaya oblast	R	2176400	139700	Omsk	Omskaya oblast
Tomskaya oblast	R	1077600	316900	Tomsk	Tomskaya oblast
Tyumenskaya oblast	R	3169900	1435200	Tyumen	Tyumenskaya oblast
Rep. of Buryatiya	R	1052500	351300	Ulan Ude	Rep. of Buryatiya
Rep. of Tyva	R	309700	170500	Kyzyl	Rep. of Tyva
Rep. of Khakassiya	R	585800	61900	Abakan	Rep. of Khakassiya
Krasnoyarskiy kray	R	3105900	2339700	Krasnoyarsk	Krasnoyarskiy kray
Irkutskaya oblast	R	2795200	767900	Irkutsk	Irkutskaya oblast
Chitinskaya oblast	R	1295000	431500	Chita	Chitinskaya oblast
Rep. of Sakha	R	1022800	3103200	Yakutsk	Rep. of Sakha
Yevreyskaya avt. oblast	R	209900	36000	Birobidzhan	Yevreyskaya avt. oblast
Chukotsky ao	R	90500	737700	Anadyr	Chukotsky ao
Primorsky kray	R	2255400	165900	Vladivostok	Primorsky kray
Khabarovskiy kray	R	1571200	752600	Khabarovsk	Khabarovskiy kray
Amurskaya oblast	R	1037800	363700	Blagoveshchensk	Amurskaya oblast
Kamchatskaya oblast	R	411100	472300	Petropavlovsk Kamchatsky	Kamchatskaya oblast
Magadanskaya oblast	R	258200	461400	Magadan	Magadanskaya oblast
Sakhalinskaya oblast	R	647800	87100	Yuzhno Sakhalinsk	Sakhalinskaya oblast
Leninobod	TAD	1635900	26100	Khujand	Leninobod
Kulob	TAD	668100	12000	Kulob	Kulob
Khatlon	TAD	1113500	12600	Qurghonteppa	Khatlon
Badakhshoni Kuni	TAD	167100	63700	Khorugh	Badakhshoni Kuni
Dushanbe (munic.)	TAD	591900	300	Dushanbe	Dushanbe (munic.)
Adiyaman	TR	513131	7614	Adiyaman	Adiyaman
Antalya	TR	1132211	20591	Antalya	Antalya
Aydin	TR	824816	8007	Aydin	Aydin
Balikesir	TR	973314	14292	Balikesir	Balikesir
Batman	TR	344669	4694	Batman	Batman
Bursa	TR	1603137	11043	Bursa	Bursa
Denizli	TR	750882	11868	Denizli	Denizli
Diyarbakir	TR	1094996	15355	Diyarbakir	Diyarbakir
Edirne	TR	404599	6276	Edirne	Edirne
Elazig	TR	498225	9153	Elazig	Elazig
Erzurum	TR	848201	25066	Erzurum	Erzurum
Eskisehir	TR	641057	13652	Eskisehir	Eskisehir
Gaziantep	TR	1140594	7642	Gaziantep	Gaziantep
Hatay	TR	1109754	5403	Antakya	Hatay
Icel	TR	1266995	15853	Mersin	Icel
Isparta	TR	434771	8933	Isparta	Isparta
Karamanmaras	TR	892952	14327	Karaman Maras	Karamanmaras
Kayseri	TR	943484	16917	Kayseri	Kayseri
Kirikkale	TR	349396	4365	Kirikkale	Kirikkale
Kocaeli	TR	936163	3626	Izmit	Kocaeli
Konya	TR	1750303	38257	Konya	Konya
Kutahya	TR	578020	11875	Kutahya	Kutahya
Malatya	TR	702055	12313	Malatya	Malatya
Manisa	TR	1154418	13810	Manisa	Manisa
Ordu	TR	830105	6001	Ordu	Ordu
Samsun	TR	1158400	9579	Samsun	Samsun
Sanliurfa	TR	1001455	18584	Urfa	Sanliurfa
Sivas	TR	767481	28488	Sivas	Sivas
Trabzon	TR	795849	4685	Trabzon	Trabzon
Usak	TR	290283	5341	Usak	Usak
Van	TR	637433	19069	Van	Van
Zonguldak	TR	1073560	8629	Zonguldak	Zonguldak
Ahal	TM	416400	0	Ashgabat	Ahal
Balkan	TM	925500	233900	Nebitdag	Balkan
Dashhowuz	TM	738000	73600	Tashauz	Dashhowuz
Leban	TM	774700	93800	Charjew	Leban
Mary	TM	859500	86800	Mary	Mary
Andijon	UZB	1899000	4200	Andijon	Andijon
Bukhoro	UZB	1262000	39400	Bukhoro	Bukhoro
Farghona	UZB	2338000	7100	Farghona	Farghona
Jizzakh	UZB	831000	20500	Jizzakh	Jizzakh
Khorazm	UZB	1135000	6300	Urganch	Khorazm
Namangan	UZB	1652000	7900	Namangan	Namangan
Nawoiy	UZB	715000	110800	Nawoiy	Nawoiy
Qasqadare	UZB	1812000	28400	Qarshi	Qasqadare
Samarqand	UZB	2322000	16400	Samarqand	Samarqand
Sirdare	UZB	600000	5100	Guliston	Sirdare
Surkhondare	UZB	1437000	20800	Termiz	Surkhondare
Toshkent	UZB	4450000	15600	Tashkent	Toshkent
Qoraqalpoghiston	UZB	1343000	164900	Nukus	Qoraqalpoghiston
Alberta	CDN	2696826	661185	Edmonton	Alberta
British Columbia	CDN	3724500	948596	Victoria	British Columbia
Manitoba	CDN	1113898	650086	Winnipeg	Manitoba
New Brunswick	CDN	738133	73437	Fredericton	New Brunswick
Newfoundland	CDN	551792	404517	Saint Johns	Newfoundland
Northwest Territories	CDN	64402	3379683	Yellowknife	Northwest Territories
Nova Scotia	CDN	909282	55490	Halifax	Nova Scotia
Ontario	CDN	10753573	1068582	Toronto	Ontario
Prince Edward Island	CDN	134557	5657	Charlottetown	Prince Edward Island
Quebec	CDN	7138795	1540680	Quebec	Quebec
Saskatchewan	CDN	990237	651900	Regina	Saskatchewan
Yukon Territory	CDN	30766	536324	Whitehorse	Yukon Territory
San Jose	CR	1163943	4960	San Jose	San Jose
Alajuela	CR	569984	9753	Alajuela	Alajuela
Cartago	CR	359765	3125	Cartago	Cartago
Heredia	CR	256726	2656	Heredia	Heredia
Guanacaste	CR	254530	10141	Liberia	Guanacaste
Punarenas	CR	357103	11277	Puntarenas	Punarenas
Limon	CR	237183	9189	Limon	Limon
Camaguey	C	723000	15990	Camaguey	Camaguey
Ciego de Avila	C	353000	6910	Ciego de Avila	Ciego de Avila
Cienfuegos	C	354000	4178	Cienfuegos	Cienfuegos
Ciudad de la Habana	C	2059000	727	Havana	Ciudad de la Habana
Granma	C	773000	8372	Bayamo	Granma
Guantanamo	C	484000	6186	Guantanamo	Guantanamo
Holguin	C	972000	9301	Holguin	Holguin
La Habana	C	630000	5731	Havana	Ciudad de la Habana
Las Tunas	C	478000	6589	Victoria de las Tunas	Las Tunas
Matanzas	C	596000	11978	Matanzas	Matanzas
Pinar del Rio	C	678000	10925	Pinar del Rio	Pinar del Rio
Sancti Spiritus	C	420000	6744	Sancti Spiritus	Sancti Spiritus
Santiago de Cuba	C	968000	6170	Santiago de Cuba	Santiago de Cuba
Villa Clara	C	796000	8662	Santa Clara	Villa Clara
Isla de la Juventud	C	71000	2396	Nueva Gerona	Isla de la Juventud
La Libertad	PE	1366125	25569	Trujillo	La Libertad
Atlantida	HCA	263700	4251	La Ceiba	Atlantida
Colon	PA	222600	7247	Colon	Colon
Colon	HCA	167900	8875	Trujillo	Colon
Comayagua	HCA	267000	5196	Comayagua	Comayagua
Copan	HCA	241400	3203	Santa Rosa de Copan	Copan
Cortes	HCA	732600	3954	San Pedro Sula	Cortes
Choluteca	HCA	326100	4211	Choluteca	Choluteca
El Paraiso	HCA	284100	7218	Yuscaran	El Paraiso
Francisco Morazan	HCA	908300	7946	Tegucigalpa	Francisco Morazan
Gracias a Dios	HCA	39000	16630	Puerto Lempira	Gracias a Dios
Intibuca	HCA	137800	3072	La Esperanza	Intibuca
Islas de la Bahia	HCA	24500	261	Roatan	Islas de la Bahia
Lempira	HCA	194600	4290	Gracias	Lempira
Olancho	HCA	318000	24351	Jutigalpa	Olancho
Santa Barbara	HCA	307500	5113	Santa Barbara	Santa Barbara
Valle	HCA	130900	1565	Nacaome	Valle
Aguascalientes	MEX	862720	5589	Aguascalientes	Aguascalientes
Baja California	MEX	2112140	70113	Mexicali	Baja California
Baja California Sur	MEX	375494	73677	La Paz	Baja California Sur
Campeche	MEX	642516	51833	Campeche	Campeche
Chiapas	MEX	3584786	73887	Tuxtla Gutierrez	Chiapas
Chihuahua	MEX	2793537	247087	Chihuahua	Chihuahua
Coahuila	MEX	2173775	151571	Saltillo	Coahuila
Colima	MEX	488028	5455	Colima	Colima
Guerrero	MEX	2916567	63749	Chilpancingo	Guerrero
Hidalgo	MEX	2112473	20987	Pachuca de Soto	Hidalgo
Jalisco	MEX	5991176	80137	Guadalajara	Jalisco
Mexico, Estado de	MEX	11707964	21461	Toluca de Lerdo	Mexico, Estado de
Michoacan	MEX	3870604	59864	Morelia	Michoacan
Morelos	MEX	1442662	4941	Cuernavaca	Morelos
Nayarit	MEX	896702	27621	Tepic	Nayarit
Nuevo Leon	MEX	3550114	64555	Monterrey	Nuevo Leon
Oaxaca	MEX	3228895	95364	Oaxaca	Oaxaca
Puebla	MEX	4624365	33919	Puebla	Puebla
Queretaro	MEX	1250476	11769	Queretaro	Queretaro
Quintana Roo	MEX	703536	50350	Chetumal	Quintana Roo
San Luis Potosi	MEX	2200763	62848	San Luis Potosi	San Luis Potosi
Sinaloa	MEX	2425675	58092	Culiacan	Sinaloa
Sonora	MEX	2085536	184934	Hermosillo	Sonora
Tabasco	MEX	1748769	24661	Villahermosa	Tabasco
Tamaulipas	MEX	2527328	79829	Ciudad Victoria	Tamaulipas
Veracruz	MEX	6737324	72815	Jalapa	Veracruz
Yucatan	MEX	1556622	39340	Merida	Yucatan
Zacatecas	MEX	1336496	75040	Zacatecas	Zacatecas
Distrito Federal	MEX	8489007	1499	Mexico City	Distrito Federal
Distrito Federal	RA	2965403	200	Buenos Aires	Distrito Federal
Distrito Federal	BR	1817001	5822	Brasilia	Distrito Federal
Distrito Federal	YV	2279677	1930	Caracas	Distrito Federal
Bocas del Toro	PA	88400	8745	Bocas del Toro	Bocas del Toro
Cocle	PA	177100	4927	Penonome	Cocle
Comarca de San Blas	PA	0	2357	El Porvenir	Comarca de San Blas
Chiriqui	PA	396800	8653	David	Chiriqui
Darien	PA	45000	16671	La Palma	Darien
Herrera	PA	108700	2341	Chitre	Herrera
Los Santos	PA	82800	3806	Las Tablas	Los Santos
Veraguas	PA	224700	11239	Santiago	Veraguas
Alabama	USA	4319154	133915	Montgomery	Alabama
Alaska	USA	609311	1530694	Juneau	Alaska
Arizona	USA	4554966	295259	Phoenix	Arizona
Arkansas	USA	2522819	137754	Little Rock	Arkansas
California	USA	32268301	411047	Sacramento	California
Colorado	USA	3892644	269595	Denver	Colorado
Connecticut	USA	3269858	12997	Hartford	Connecticut
Delaware	USA	731581	5297	Dover	Delaware
Florida	USA	14653945	151939	Tallahassee	Florida
Hawaii	USA	1183723	16760	Honolulu	Hawaii
Idaho	USA	1186602	216430	Boise	Idaho
Illinois	USA	11895849	145933	Springfield	Illinois
Indiana	USA	5864108	93719	Indianapolis	Indiana
Iowa	USA	2852423	145752	Des Moines	Iowa
Kentucky	USA	3908124	104661	Frankfort	Kentucky
Louisiana	USA	4351769	123677	Baton Rouge	Louisiana
Maine	USA	1242051	86156	Augusta	Maine
Maryland	USA	5094289	27091	Annapolis	Maryland
Massachusetts	USA	6117520	21455	Boston	Massachusetts
Michigan	USA	9773892	151584	Lansing	Michigan
Minnesota	USA	4685549	218600	St. Paul	Minnesota
Mississippi	USA	2730501	123514	Jackson	Mississippi
Missouri	USA	5402058	180514	Jefferson City	Missouri
Montana	USA	878810	380848	Helena	Montana
Nebraska	USA	1656870	200349	Lincoln	Nebraska
Nevada	USA	1676809	286352	Carson City	Nevada
New Hampshire	USA	1172709	24033	Concord	New Hampshire
New Jersey	USA	8052849	20168	Trenton	New Jersey
New Mexico	USA	1729751	314925	Santa Fe	New Mexico
New York	USA	18137226	127189	Albany	New York
North Carolina	USA	7425183	136412	Raleigh	North Carolina
North Dakota	USA	640883	183117	Bismarck	North Dakota
Ohio	USA	11186331	107044	Columbus	Ohio
Oklahoma	USA	3317091	181185	Oklahoma City	Oklahoma
Oregon	USA	3243487	251418	Salem	Oregon
Pennsylvania	USA	12019661	117347	Harrisburg	Pennsylvania
Rhode Island	USA	987429	3139	Providence	Rhode Island
South Carolina	USA	3760181	80582	Columbia	South Carolina
South Dakota	USA	737973	199730	Pierre	South Dakota
Tennessee	USA	5368198	109153	Nashville	Tennessee
Texas	USA	19439337	691027	Austin	Texas
Utah	USA	2059148	219888	Salt Lake City	Utah
Vermont	USA	588978	24900	Montpelier	Vermont
Virginia	USA	6733996	105586	Richmond	Virginia
Washington	USA	5610362	176479	Olympia	Washington
West Virginia	USA	1815787	62761	Charleston	West Virginia
Wisconsin	USA	5169677	145436	Madison	Wisconsin
Wyoming	USA	479743	253324	Cheyenne	Wyoming
Distr. Columbia	USA	528964	179	Washington	Distr. Columbia
New South Wales	AUS	6115100	801428	Sydney	New South Wales
Northern Territory	AUS	173878	1346200	Darwin	Northern Territory
Queensland	AUS	3277000	1727000	Brisbane	Queensland
South Australia	AUS	1474000	984377	Adelaide	South Australia
Tasmania	AUS	473022	67800	Hobart	Tasmania
Western Australia	AUS	1731700	2525500	Perth	Western Australia
Australia Capital Territory	AUS	304100	2452	Canberra	Australia Capital Territory
Kirimati	AUS	1770	135	Flying Fish Cove	Kirimati
Catamarca	RA	264324	102602	San Fernando del Valle de Catamarca	Catamarca
Chaco	RA	839677	99633	Resistencia	Chaco
Chubut	RA	357189	224686	Rawson	Chubut
Corrientes	RA	795594	88199	Corrientes	Corrientes
Entre Rios	RA	1020257	78781	Parana	Entre Rios
Formosa	RA	398413	72066	Formosa	Formosa
Jujuy	RA	512329	53219	San Salvador de Jujuy	Jujuy
La Pampa	RA	259996	143440	Santa Rosa	La Pampa
La Rioja	RA	220729	89680	La Rioja	La Rioja
Mendoza	RA	1412481	148827	Mendoza	Mendoza
Misiones	RA	788915	29801	Posadas	Misiones
Neuquen	RA	388833	94078	Neuquen	Neuquen
Rio Negro	RA	506772	203013	Viedma	Rio Negro
Salta	RA	866153	155488	Salta	Salta
San Juan	RA	528715	89651	San Juan	San Juan
San Luis	RA	286458	76748	San Luis	San Luis
Santa Cruz	RA	159839	243943	Rio Gallegos	Santa Cruz
Santa Fe	RA	2798422	133007	Santa Fe	Santa Fe
Santiago de Estero	RA	671988	136351	Santiago del Estero	Santiago de Estero
Tierra del Fuego	RA	69369	21571	Ushuaia	Tierra del Fuego
Tucuman	RA	1142105	22524	San Miguel de Tucuman	Tucuman
Acre	BR	483483	153149	Rio Branco	Acre
Alagoas	BR	2637843	27933	Maceio	Alagoas
Amapa	BR	373994	143453	Macapa	Amapa
Amazonas	CO	39937	109665	Leticia	Amazonas
Amazonas	BR	2390102	1577820	Manaus	Amazonas
Amazonas	PE	374587	39249	Chachapoyas	Amazonas
Amazonas	YV	94590	175750	Puerto Ayacucho	Amazonas
Bahia	BR	12531895	567295	Salvador	Bahia
Ceara	BR	6803567	146348	Fortaleza	Ceara
Espirito Santo	BR	2786126	46184	Vitoria	Espirito Santo
Goias	BR	4501538	341289	Goiania	Goias
Maranhao	BR	5218442	333365	Sao Luis	Maranhao
Mato Grosso	BR	2227983	906806	Cuiaba	Mato Grosso
Mato Grosso do Sul	BR	1922258	358158	Campo Grande	Mato Grosso do Sul
Minas Gerais	BR	16660691	588383	Belo Horizonte	Minas Gerais
Para	BR	5522783	1253164	Belem	Para
Paraiba	BR	3305562	56584	Joao Pessoa	Paraiba
Parana	BR	8985981	199709	Curitiba	Parana
Pernambuco	BR	7404559	98937	Recife	Pernambuco
Piaui	BR	2676098	252378	Teresina	Piaui
Rio de Janeiro	BR	13316455	43909	Rio de Janeiro	Rio de Janeiro
Rio Grande do Norte	BR	2556939	53306	Natal	Rio Grande do Norte
Rio Grande do Sul	BR	9623003	282062	Porto Alegre	Rio Grande do Sul
Rondonia	BR	1221290	238512	Porto Velho	Rondonia
Roraima	BR	247724	225116	Boa Vista	Roraima
Santa Catarina	BR	4865090	95442	Florianopolis	Santa Catarina
Sergipe	BR	1617368	22050	Aracaju	Sergipe
Tocantins	BR	1049742	278420	Palmas	Tocantins
Antioquia	CO	4067207	63612	Medellin	Antioquia
Atlantico	CO	1478213	3388	Barranquilla	Atlantico
Bolivar	CO	1288985	25978	Cartagena	Bolivar
Bolivar	YV	1142210	238000	Ciudad Bolivar	Bolivar
Boyaca	CO	1209739	23189	Tunja	Boyaca
Caldas	CO	883024	7888	Manizales	Caldas
Caqueta	CO	264507	88965	Florencia	Caqueta
Casanare	CO	147472	44640	Yopal	Casanare
Cauca	CO	857751	29308	Popayan	Cauca
Cesar	CO	699428	22905	Valledupar	Cesar
Choco	CO	313567	46530	Quibdo	Choco
Cundinamarca	CO	1512928	22623	Bogota	Santa Fe de Bogota, DC
Guainia	CO	12345	72238	Puerto Inirida	Guainia
Guajira, La	CO	299995	20848	Riohacha	Guajira, La
Guaviare	CO	47073	42327	San Jose del Guaviare	Guaviare
Huila	CO	693712	19890	Neiva	Huila
Huila	ANG	869000	75002	Lubango	Huila
Magdalena	CO	890934	23188	Santa Marta	Magdalena
Meta	CO	474046	85635	Villavicencio	Meta
Narino	CO	1085173	33268	Pasto	Narino
Norte de Santander	CO	913491	21658	Cucuta	Norte de Santander
Putumayo	CO	174219	24885	Mocoa	Putumayo
Quindio	CO	392208	1845	Armenia	Quindio
Risaralda	CO	652872	4140	Pereira	Risaralda
San Andres y Providencia	CO	35818	44	San Andres	San Andres y Providencia
Santa Fe de Bogota, DC	CO	4236490	1587	Bogota	Santa Fe de Bogota, DC
Santander del Sur	CO	1511392	30537	Bucaramanga	Santander del Sur
Tolima	CO	1142220	23562	Ibague	Tolima
Valle de Cauca	CO	3027247	22140	Cali	Valle de Cauca
Vaupes	CO	26178	65268	Mitu	Vaupes
Vichada	CO	18702	100242	Puerto Carreno	Vichada
Ancash	PE	1024398	35825	Huaraz	Ancash
Apurimac	PE	409630	20895	Abancay	Apurimac
Arequipa	PE	999851	63345	Arequipa	Arequipa
Ayacucho	PE	517397	43814	Ayacucho	Ayacucho
Cajamarca	PE	1349129	33247	Cajamarca	Cajamarca
Cuzco	PE	1107473	71891	Cuzco	Cuzco
Huanuco	PE	722669	36938	Huanuco	Huanuco
Ica	PE	608609	21327	Ica	Ica
Junin	PE	1132448	44409	Huancayo	Junin
Lambayeque	PE	1009655	14231	Chiclayo	Lambayeque
Loreto	PE	789235	368851	Iquitos	Loreto
Madre de Dios	PE	74306	85182	Puerto Maldonado	Madre de Dios
Pasco	PE	243366	25319	Cerro de Pasco	Pasco
Piura	PE	1468337	35892	Piura	Piura
Puno	PE	1144151	71999	Puno	Puno
San Martin	PE	627781	51253	Moyobamba	San Martin
Tacna	PE	245843	16075	Tacna	Tacna
Ucayali	PE	364596	102410	Pucallpa	Ucayali
Anzoategui	YV	1034311	43300	Barcelona	Anzoategui
Apure	YV	382572	76500	San Fernando	Apure
Aragua	YV	1344099	7014	Maracay	Aragua
Barinas	YV	519197	35200	Barinas	Barinas
Carabobo	YV	1823767	4650	Valencia	Carabobo
Cojedes	YV	227741	14800	San Carlos	Cojedes
Delta Amacuro	YV	114390	40200	Tucupita	Delta Amacuro
Falcon	YV	699232	24800	Coro	Falcon
Guarico	YV	583221	64986	San Juan	Guarico
Lara	YV	1430968	19800	Barquisimeto	Lara
Miranda	YV	2303302	7950	Los Teques	Miranda
Monagas	YV	555705	28900	Maturin	Monagas
Nueva Esparta	YV	330307	1150	La Ascuncion	Nueva Esparta
Portuguesa	YV	720865	15200	Guanare	Portuguesa
Tachira	YV	946949	11100	San Cristobal	Tachira
Yaracuy	YV	466152	7100	San Felipe	Yaracuy
Zulia	YV	2820250	63100	Maracaibo	Zulia
Cuanza Norte	ANG	378000	24110	Ndalatando	Cuanza Norte
Cuanza Sul	ANG	651000	55660	Sumbe	Cuanza Sul
Lunda Norte	ANG	292000	102783	Lucapa	Lunda Norte
Lunda Sul	ANG	155000	56985	Saurimo	Lunda Sul
Moxico	ANG	316000	223023	Luena	Moxico
Cuando Cubango	ANG	130000	199049	Menongue	Cuando Cubango
Bengo	ANG	166000	31371	Caxito	Bengo
Cunene	ANG	232000	88342	Ngiva	Cunene
Adamaoua	CAM	495200	63691	Ngaoundere	Adamaoua
Est	CAM	517200	109011	Bertoua	Est
Nord extreme	CAM	1855700	34246	Maroua	Nord extreme
Cote	CAM	1354800	20239	Douala	Cote
Nord	CAM	832200	65576	Garoua	Nord
Nordoueste	CAM	1237300	17810	Bamenda	Nordoueste
Ouest	CAM	1339800	13872	Bafoussam	Ouest
Sud	CAM	373800	47110	Ebolowa	Sud
Sudoueste	CAM	838000	24471	Buea	Sudoueste
El Bahr el Ahmar	ET	108000	203685	Hurghada	El Bahr el Ahmar
Matruh	ET	182000	212112	Marsa Matruh	Matruh
Sina al Janubiyah	ET	33000	33140	El Tur	Sina al Janubiyah
Sina ash Shamaliyah	ET	196000	27574	El Arish	Sina ash Shamaliyah
El Wadi el Jadid	ET	126000	376505	El Kharga	El Wadi el Jadid
El Buhayra	ET	3602000	10130	Damanhur	El Buhayra
El Daqahliya	ET	3828000	3471	El Mansura	El Daqahliya
Dumyat	ET	808000	589	Dumyat	Dumyat
El Gharbiya	ET	3113000	1942	Tanta	El Gharbiya
Ismailiya	ET	623000	1442	Ismailiya	Ismailiya
Kafr el Sheikh	ET	1968000	3437	Kafr el Sheikh	Kafr el Sheikh
El Minufiya	ET	2449000	1532	Shibin el Kom	El Minufiya
El Qalubiya	ET	2868000	1001	Benha	El Qalubiya
Sharqiya	ET	3766000	4180	Zagazig	Sharqiya
Aswan	ET	883000	679	Aswan	Aswan
Asyut	ET	2456000	1553	Asyut	Asyut
Beni Suef	ET	1586000	1322	Beni Suef	Beni Suef
El Faiyum	ET	1720000	1827	El Faiyum	El Faiyum
El Giza	ET	4265000	85153	El Giza	El Giza
El Minya	ET	2916000	2262	El Minya	El Minya
Qena	ET	2493000	1851	Qena	Qena
Sohag	ET	2689000	1547	Sohag	Sohag
Bur Said (munic.)	ET	461000	72	Bur Said	Bur Said (munic.)
El Iskandariya (munic.)	ET	3170000	2679	El Iskandariya	El Iskandariya (munic.)
El Qahira (munic.)	ET	6452000	214	El Qahira	El Qahira (munic.)
El Suweiz (munic.)	ET	392000	17840	El Suweiz	El Suweiz (munic.)
Coast	EAK	1880000	83603	Mombasa	Coast
Eastern	Z	826100	69106	Chipata	Eastern
Eastern	EAK	3724000	159891	Embu	Eastern
North Eastern	EAK	372000	126090	Garissa	North Eastern
Nyanza	EAK	3558000	16162	Kisumu	Nyanza
Rift Valley	EAK	4894000	173868	Nakuru	Rift Valley
Western	Z	575500	126386	Mongu	Western
Western	EAK	2543000	8360	Kakamega	Western
Antsiranana	RM	689800	43046	Antsiranana	Antsiranana
Antananarivo	RM	3195800	58283	Antananarivo	Antananarivo
Fianarantsoa	RM	2209700	102373	Fianarantsoa	Fianarantsoa
Mahajanga	RM	1075300	150023	Majunga	Mahajanga
Toamasina	RM	1444700	71911	Tamatave	Toamasina
Toliary	RM	1396700	161405	Toliary	Toliary
Cabo Delgado	MOC	1202200	82625	Pemba	Cabo Delgado
Gaza	MOC	1401500	75709	Xai Xai	Gaza
Manica	MOC	609500	61661	Chimoio	Manica
Maputo	MOC	840800	25756	Maputo	Maputo (munic.)
Nampula	MOC	2841400	81606	Nampula	Nampula
Niassa	MOC	686700	129055	Lichinga	Niassa
Sofala	MOC	1427500	68018	Beira	Sofala
Tete	MOC	734600	100724	Tete	Tete
Zambezia	MOC	2619300	105008	Quelimane	Zambezia
Maputo (munic.)	MOC	931600	602	Maputo	Maputo (munic.)
Kaolack	SN	816400	16010	Kaolack	Kaolack
Saint Louis	SN	680200	44127	Saint Louis	Saint Louis
Thies	SN	948100	6601	Thies	Thies
Ziguinchor	SN	394700	7339	Ziguinchor	Ziguinchor
Aali an Nil	SUD	1599605	238792	Malakal	Aali an Nil
Bahr al Ghazal	SUD	2265510	200894	Waw	Bahr al Ghazal
Darfur	SUD	3093699	508684	al Fasher	Darfur
al Istiwaiyah	SUD	1406181	197969	Juba	al Istiwaiyah
al Khartum	SUD	1802299	28165	Khartoum	al Khartum
Kurdufan	SUD	3093294	380255	al Ubayyid	Kurdufan
ash Shamaliyah	SUD	1083024	476040	ad Damir	ash Shamaliyah
ash Sharqiyah	SUD	2208209	334074	Kassala	ash Sharqiyah
al Wusta	SUD	4012543	139017	Wad Madani	al Wusta
Dodoma	EAT	1237800	41311	Dodoma	Dodoma
Arusha	EAT	1351700	82306	Arusha	Arusha
Kilimanjaro	EAT	1108700	13309	Moshi	Kilimanjaro
Tanga	EAT	1283600	26808	Tanga	Tanga
Morogoro	EAT	1222700	70799	Morogoro	Morogoro
Pwani	EAT	638000	32407	Dar es Salaam	Daressalam
Daressalam	EAT	1360900	1393	Dar es Salaam	Daressalam
Mtwara	EAT	889500	16707	Mtwara Mikandani	Mtwara
Ruvuma	EAT	783300	63498	Songea	Ruvuma
Mbeya	EAT	1476200	60350	Mbeya	Mbeya
Rukwa	EAT	684000	68635	Sumbawanga	Rukwa
Kigoma	EAT	854800	37037	Kigoma Ujiji	Kigoma
Shinyanga	EAT	1772500	50781	Shinyanga	Shinyanga
Kagera	EAT	1326200	28388	Bukoba	Kagera
Mwanza	EAT	1878300	19592	Mwanza	Mwanza
Mara	EAT	970900	19566	Musoma	Mara
Kaskazini Ujunga	EAT	97000	470	Mkokotoni	Kaskazini Ujunga
Kusini Ujunga	EAT	70200	854	Koani	Kusini Ujunga
Mjini Magharibi	EAT	208300	230	Zanzibar	Mjini Magharibi
Kaskazini Pemba	EAT	137400	574	Wete	Kaskazini Pemba
Kusini Pemba	EAT	127600	332	Chake Cahke	Kusini Pemba
Bas Zaire	ZRE	2158595	53920	Matadi	Bas Zaire
Equateur	ZRE	3960187	403293	Mbandaka	Equateur
Haut Zaire	ZRE	5119750	503239	Kisangani	Haut Zaire
Kasai Occidental	ZRE	3465756	156967	Kananga	Kasai Occidental
Kasai Oriental	ZRE	2859220	168216	Mbuji Mayi	Kasai Oriental
Kivu	ZRE	5232442	256662	Bukavu	Kivu
Shaba	ZRE	4452618	496965	Lubumbashi	Shaba
Kinshasa	ZRE	2778281	9965	Kinshasa	Kinshasa
Copperbelt	Z	1866400	31328	Ndola	Copperbelt
Luapula	Z	526300	50567	Mansa	Luapula
Lusaka	Z	1151300	21896	Lusaka	Lusaka
Northern	Z	832700	147826	Kasama	Northern
Northwestern	Z	396100	125827	Solwezi	Northwestern
Southern	Z	906900	85283	Livingstone	Southern
\.


--
-- TOC entry 2141 (class 0 OID 886975)
-- Dependencies: 182
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, nombre) FROM stdin;
1	Administrador
2	Usuario
\.


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 183
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 11, true);


--
-- TOC entry 2143 (class 0 OID 886980)
-- Dependencies: 184
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles_permisos (id, id_roles, id_permisos) FROM stdin;
11	1	1
12	1	2
13	1	3
14	1	4
15	1	5
16	1	6
17	1	7
18	1	8
19	1	9
20	1	10
21	1	11
22	1	12
23	1	13
24	1	14
25	1	15
26	1	16
27	1	17
34	2	19
35	2	20
\.


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 185
-- Name: roles_permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_permisos_id_seq', 35, true);


--
-- TOC entry 2145 (class 0 OID 886985)
-- Dependencies: 186
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (id, nombre, apellido, foto, direccion, telefono, correo, password, activo, codigo_activacion) FROM stdin;
70	yamil	orozco	foto	esquina pineda a toro piso	0212-8606877	yamiloro1@gmail.com	$2b$10$omPtnC0CuOUe68Mk45yMyeBJq0Nf97Xiep1cNvr4ZQ3G/4KrO8NXO	t	\N
4	yamil	orozco	foto	callo la pastora	333333	yamiloro@gmail.com	$2b$10$I.Zi9Wyxrp23RHfsBRrS/egRzsEW2hW5ht0NLiArbgo0b6V/ANQNq	t	
73	yamil	orozco	avatar.png	esquina pineda a toro piso	0212-8606877	yamiloro2@gmail.com	$2b$10$gCZeq.dc4zUbrvssBieFHeyatsGhITfxpuzJIbCkb2o9WKr0lhPYe	t	\N
76	yamil	orozco	avatar.png	esquina pineda a toro piso	0212-8606877	yamiloro12@gmail.com	$2b$10$A98sB5FO.6.6LKQ3ouVYVOr6BCa6rA4uR0UnjkXohK4fLtPWi6GR6	t	\N
\.


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_id_seq', 76, true);


--
-- TOC entry 2147 (class 0 OID 886993)
-- Dependencies: 188
-- Data for Name: usuarios_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios_roles (id, id_roles, id_usuarios) FROM stdin;
46	1	4
47	2	4
\.


--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 189
-- Name: usuarios_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_roles_id_seq', 47, true);


--
-- TOC entry 1969 (class 2606 OID 887004)
-- Name: ciudad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ciudad
    ADD CONSTRAINT ciudad_pk PRIMARY KEY (nombre, pais, provincia);


--
-- TOC entry 1971 (class 2606 OID 887006)
-- Name: encuesta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuesta_pk PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 887008)
-- Name: encuestas_detalles_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuestas_detalles
    ADD CONSTRAINT encuestas_detalles_pk PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2606 OID 887010)
-- Name: intensidad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intensidades
    ADD CONSTRAINT intensidad_pk PRIMARY KEY (id);


--
-- TOC entry 1981 (class 2606 OID 887012)
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pk PRIMARY KEY (codigo);


--
-- TOC entry 1983 (class 2606 OID 887014)
-- Name: pais_un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_un UNIQUE (nombre);


--
-- TOC entry 1986 (class 2606 OID 887016)
-- Name: pk_permisos; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permisos
    ADD CONSTRAINT pk_permisos PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 887210)
-- Name: pk_preguntas; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas
    ADD CONSTRAINT pk_preguntas PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 887113)
-- Name: pk_preguntas_intensidades; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas_intensidades
    ADD CONSTRAINT pk_preguntas_intensidades PRIMARY KEY (id);


--
-- TOC entry 1994 (class 2606 OID 887018)
-- Name: pk_roles; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (id);


--
-- TOC entry 1997 (class 2606 OID 887020)
-- Name: pk_roles_permisos; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_permisos
    ADD CONSTRAINT pk_roles_permisos PRIMARY KEY (id);


--
-- TOC entry 2000 (class 2606 OID 887022)
-- Name: pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (id);


--
-- TOC entry 2003 (class 2606 OID 887024)
-- Name: pk_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios_roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id);


--
-- TOC entry 1992 (class 2606 OID 887028)
-- Name: provincia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT provincia_pk PRIMARY KEY (nombre, pais);


--
-- TOC entry 2009 (class 2606 OID 887115)
-- Name: un_intensidad_preguntas; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas_intensidades
    ADD CONSTRAINT un_intensidad_preguntas UNIQUE (id_preguntas, id_intensidades);


--
-- TOC entry 1977 (class 2606 OID 887103)
-- Name: un_nombre_intensidades; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intensidades
    ADD CONSTRAINT un_nombre_intensidades UNIQUE (nombre);


--
-- TOC entry 1990 (class 2606 OID 887101)
-- Name: un_orden_preguntas; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY preguntas
    ADD CONSTRAINT un_orden_preguntas UNIQUE (orden);


--
-- TOC entry 2005 (class 2606 OID 887030)
-- Name: un_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios_roles
    ADD CONSTRAINT un_usuarios_roles UNIQUE (id_roles, id_usuarios);


--
-- TOC entry 1979 (class 2606 OID 887105)
-- Name: un_valor_intensidades; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intensidades
    ADD CONSTRAINT un_valor_intensidades UNIQUE (valor);


--
-- TOC entry 1984 (class 1259 OID 887031)
-- Name: permisos_nombre_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX permisos_nombre_idx ON permisos USING btree (nombre);


--
-- TOC entry 1995 (class 1259 OID 887032)
-- Name: roles_nombre_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX roles_nombre_idx ON roles USING btree (nombre);


--
-- TOC entry 1998 (class 1259 OID 887033)
-- Name: roles_permisos_id_roles_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX roles_permisos_id_roles_idx ON roles_permisos USING btree (id_roles, id_permisos);


--
-- TOC entry 2001 (class 1259 OID 887034)
-- Name: usuarios_correo_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuarios_correo_idx ON usuarios USING btree (correo);


--
-- TOC entry 2010 (class 2606 OID 887035)
-- Name: ciudad_provincia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ciudad
    ADD CONSTRAINT ciudad_provincia_fk FOREIGN KEY (provincia, pais) REFERENCES provincia(nombre, pais) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2011 (class 2606 OID 887040)
-- Name: encuestas_ciudad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuestas_ciudad_fk FOREIGN KEY (ciudad, pais, estado) REFERENCES ciudad(nombre, pais, provincia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2013 (class 2606 OID 887045)
-- Name: encuestas_detalles_encuesta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas_detalles
    ADD CONSTRAINT encuestas_detalles_encuesta_fk FOREIGN KEY (id_encuestas) REFERENCES encuestas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2014 (class 2606 OID 887050)
-- Name: encuestas_detalles_intensidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas_detalles
    ADD CONSTRAINT encuestas_detalles_intensidades_fk FOREIGN KEY (id_intensidades) REFERENCES intensidades(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2015 (class 2606 OID 887216)
-- Name: encuestas_detalles_preguntas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas_detalles
    ADD CONSTRAINT encuestas_detalles_preguntas_fk FOREIGN KEY (id_preguntas) REFERENCES preguntas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2012 (class 2606 OID 887060)
-- Name: encuestas_usuarios_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuestas
    ADD CONSTRAINT encuestas_usuarios_fk FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2021 (class 2606 OID 887122)
-- Name: fk_preg_inten_intensidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preguntas_intensidades
    ADD CONSTRAINT fk_preg_inten_intensidad FOREIGN KEY (id_intensidades) REFERENCES intensidades(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2022 (class 2606 OID 887211)
-- Name: fk_preg_inten_preguntas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preguntas_intensidades
    ADD CONSTRAINT fk_preg_inten_preguntas FOREIGN KEY (id_preguntas) REFERENCES preguntas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2017 (class 2606 OID 887065)
-- Name: fk_roles_permisos_permisos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_permisos
    ADD CONSTRAINT fk_roles_permisos_permisos FOREIGN KEY (id_permisos) REFERENCES permisos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2018 (class 2606 OID 887070)
-- Name: fk_roles_permisos_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_permisos
    ADD CONSTRAINT fk_roles_permisos_roles FOREIGN KEY (id_roles) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2019 (class 2606 OID 887075)
-- Name: fk_usuarios_roles_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_roles FOREIGN KEY (id_roles) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2020 (class 2606 OID 887080)
-- Name: fk_usuarios_roles_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_usuarios FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2016 (class 2606 OID 887090)
-- Name: provincia_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT provincia_pais_fk FOREIGN KEY (pais) REFERENCES pais(codigo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-03-02 16:19:00 -04

--
-- PostgreSQL database dump complete
--

