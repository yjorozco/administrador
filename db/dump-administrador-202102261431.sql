--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11
-- Dumped by pg_dump version 11.2

-- Started on 2021-02-26 14:01:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2870 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16566)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permisos (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.permisos OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16569)
-- Name: permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permisos_id_seq OWNER TO postgres;

--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 197
-- Name: permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permisos_id_seq OWNED BY public.permisos.id;


--
-- TOC entry 198 (class 1259 OID 16571)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16574)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 199
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 200 (class 1259 OID 16576)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    id_roles integer,
    id_permisos integer
);


ALTER TABLE public.roles_permisos OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16579)
-- Name: roles_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_permisos_id_seq OWNER TO postgres;

--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 201
-- Name: roles_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_permisos_id_seq OWNED BY public.roles_permisos.id;


--
-- TOC entry 202 (class 1259 OID 16581)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
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


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16587)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 203
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 204 (class 1259 OID 16589)
-- Name: usuarios_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_roles (
    id integer NOT NULL,
    id_roles integer,
    id_usuarios integer
);


ALTER TABLE public.usuarios_roles OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16592)
-- Name: usuarios_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_roles_id_seq OWNER TO postgres;

--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 205
-- Name: usuarios_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_roles_id_seq OWNED BY public.usuarios_roles.id;


--
-- TOC entry 2710 (class 2604 OID 16594)
-- Name: permisos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos ALTER COLUMN id SET DEFAULT nextval('public.permisos_id_seq'::regclass);


--
-- TOC entry 2711 (class 2604 OID 16595)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 2712 (class 2604 OID 16596)
-- Name: roles_permisos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id SET DEFAULT nextval('public.roles_permisos_id_seq'::regclass);


--
-- TOC entry 2713 (class 2604 OID 16597)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 2714 (class 2604 OID 16598)
-- Name: usuarios_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles ALTER COLUMN id SET DEFAULT nextval('public.usuarios_roles_id_seq'::regclass);


--
-- TOC entry 2855 (class 0 OID 16566)
-- Dependencies: 196
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permisos (id, nombre) FROM stdin;
1	admin_crear_usuarios
2	admin_buscar_usuarios
3	admin_buscar_usuarios_id
4	admin_eliminar_usuarios
5	admin_modificar_usuarios
6	admin_cambiar_password
7	usuario_salvar_imagen
8	dmin_crear_roles
9	admin_buscar_roles
10	admin_buscar_roles_id
11	admin_eliminar_roles
12	admin_modificar_roles
13	admin_crear_permisos
14	admin_buscar_permisos
15	admin_buscar_permisos_id
16	admin_eliminar_permisos
17	admin_actualizar_permisos
\.


--
-- TOC entry 2857 (class 0 OID 16571)
-- Dependencies: 198
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, nombre) FROM stdin;
1	Administrador
2	Usuario
\.


--
-- TOC entry 2859 (class 0 OID 16576)
-- Dependencies: 200
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_permisos (id, id_roles, id_permisos) FROM stdin;
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
\.


--
-- TOC entry 2861 (class 0 OID 16581)
-- Dependencies: 202
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, apellido, foto, direccion, telefono, correo, password, activo, codigo_activacion) FROM stdin;
4	yamil	orozco	foto	callo la pastora	333333	yamiloro@gmail.com	$2b$10$I.Zi9Wyxrp23RHfsBRrS/egRzsEW2hW5ht0NLiArbgo0b6V/ANQNq	t	
\.


--
-- TOC entry 2863 (class 0 OID 16589)
-- Dependencies: 204
-- Data for Name: usuarios_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios_roles (id, id_roles, id_usuarios) FROM stdin;
\.


--
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 197
-- Name: permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permisos_id_seq', 17, true);


--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 199
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 8, true);


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 201
-- Name: roles_permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_permisos_id_seq', 27, true);


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 203
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 69, true);


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 205
-- Name: usuarios_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_roles_id_seq', 45, true);


--
-- TOC entry 2717 (class 2606 OID 16600)
-- Name: permisos pk_permisos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT pk_permisos PRIMARY KEY (id);


--
-- TOC entry 2719 (class 2606 OID 16602)
-- Name: roles pk_roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (id);


--
-- TOC entry 2722 (class 2606 OID 16604)
-- Name: roles_permisos pk_roles_permisos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT pk_roles_permisos PRIMARY KEY (id);


--
-- TOC entry 2725 (class 2606 OID 16606)
-- Name: usuarios pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (id);


--
-- TOC entry 2727 (class 2606 OID 16608)
-- Name: usuarios_roles pk_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id);


--
-- TOC entry 2729 (class 2606 OID 16612)
-- Name: usuarios_roles un_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT un_usuarios_roles UNIQUE (id_roles, id_usuarios);


--
-- TOC entry 2715 (class 1259 OID 16634)
-- Name: permisos_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX permisos_nombre_idx ON public.permisos USING btree (nombre);


--
-- TOC entry 2720 (class 1259 OID 16635)
-- Name: roles_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX roles_nombre_idx ON public.roles USING btree (nombre);


--
-- TOC entry 2723 (class 1259 OID 16637)
-- Name: roles_permisos_id_roles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX roles_permisos_id_roles_idx ON public.roles_permisos USING btree (id_roles, id_permisos);


--
-- TOC entry 2730 (class 2606 OID 16613)
-- Name: roles_permisos fk_roles_permisos_permisos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_permisos FOREIGN KEY (id_permisos) REFERENCES public.permisos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2731 (class 2606 OID 16618)
-- Name: roles_permisos fk_roles_permisos_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2732 (class 2606 OID 16623)
-- Name: usuarios_roles fk_usuarios_roles_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2733 (class 2606 OID 16628)
-- Name: usuarios_roles fk_usuarios_roles_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_usuarios FOREIGN KEY (id_usuarios) REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2021-02-26 14:02:01

--
-- PostgreSQL database dump complete
--

