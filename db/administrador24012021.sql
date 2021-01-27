--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.24
-- Dumped by pg_dump version 9.3.24
-- Started on 2021-01-24 20:47:30

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 50720)
-- Name: permisos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.permisos (
    id integer NOT NULL,
    nombre character varying(100),
    crear boolean,
    modificar boolean,
    eliminar boolean,
    buscar boolean,
    imprimir boolean
);


--
-- TOC entry 178 (class 1259 OID 50745)
-- Name: permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 178
-- Name: permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permisos_id_seq OWNED BY public.permisos.id;


--
-- TOC entry 172 (class 1259 OID 50714)
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(100)
);


--
-- TOC entry 177 (class 1259 OID 50737)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 177
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 175 (class 1259 OID 50723)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    id_roles integer,
    id_permisos integer
);


--
-- TOC entry 180 (class 1259 OID 50769)
-- Name: roles_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 180
-- Name: roles_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_permisos_id_seq OWNED BY public.roles_permisos.id;


--
-- TOC entry 171 (class 1259 OID 50711)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100),
    apellido character varying(100),
    foto character varying(1000),
    direccion text,
    telefono character varying(100),
    correo character varying(100)
);


--
-- TOC entry 176 (class 1259 OID 50726)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 176
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 173 (class 1259 OID 50717)
-- Name: usuarios_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.usuarios_roles (
    id integer NOT NULL,
    id_roles integer,
    id_usuarios integer
);


--
-- TOC entry 179 (class 1259 OID 50753)
-- Name: usuarios_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 179
-- Name: usuarios_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_roles_id_seq OWNED BY public.usuarios_roles.id;


--
-- TOC entry 1851 (class 2604 OID 50747)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permisos ALTER COLUMN id SET DEFAULT nextval('public.permisos_id_seq'::regclass);


--
-- TOC entry 1849 (class 2604 OID 50739)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 1852 (class 2604 OID 50771)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id SET DEFAULT nextval('public.roles_permisos_id_seq'::regclass);


--
-- TOC entry 1848 (class 2604 OID 50728)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 1850 (class 2604 OID 50755)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles ALTER COLUMN id SET DEFAULT nextval('public.usuarios_roles_id_seq'::regclass);


--
-- TOC entry 1862 (class 2606 OID 50752)
-- Name: pk_permisos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT pk_permisos PRIMARY KEY (id);


--
-- TOC entry 1856 (class 2606 OID 50744)
-- Name: pk_roles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (id);


--
-- TOC entry 1864 (class 2606 OID 50776)
-- Name: pk_roles_permisos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT pk_roles_permisos PRIMARY KEY (id);


--
-- TOC entry 1854 (class 2606 OID 50736)
-- Name: pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (id);


--
-- TOC entry 1858 (class 2606 OID 50766)
-- Name: pk_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id);


--
-- TOC entry 1866 (class 2606 OID 50778)
-- Name: un_roles_permisos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT un_roles_permisos UNIQUE (id_roles, id_permisos);


--
-- TOC entry 1860 (class 2606 OID 50768)
-- Name: un_usuarios_roles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT un_usuarios_roles UNIQUE (id_roles, id_usuarios);


--
-- TOC entry 1870 (class 2606 OID 50795)
-- Name: fk_roles_permisos_permisos; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_permisos FOREIGN KEY (id_permisos) REFERENCES public.permisos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1869 (class 2606 OID 50790)
-- Name: fk_roles_permisos_roles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1867 (class 2606 OID 50780)
-- Name: fk_usuarios_roles_roles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1868 (class 2606 OID 50785)
-- Name: fk_usuarios_roles_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_usuarios FOREIGN KEY (id_usuarios) REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-01-24 20:47:33

--
-- PostgreSQL database dump complete
--

