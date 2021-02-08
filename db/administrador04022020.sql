PGDMP         9                y            administrador    9.3.24    9.3.24 2    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    50710    administrador    DATABASE     �   CREATE DATABASE administrador WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Bolivarian Republic of Venezuela.1252' LC_CTYPE = 'Spanish_Bolivarian Republic of Venezuela.1252';
    DROP DATABASE administrador;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6                        3079    11750    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    50720    permisos    TABLE     �   CREATE TABLE public.permisos (
    id integer NOT NULL,
    nombre character varying(100),
    crear boolean,
    modificar boolean,
    eliminar boolean,
    buscar boolean,
    imprimir boolean
);
    DROP TABLE public.permisos;
       public         postgres    false    6            �            1259    50745    permisos_id_seq    SEQUENCE     x   CREATE SEQUENCE public.permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.permisos_id_seq;
       public       postgres    false    6    174            �           0    0    permisos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.permisos_id_seq OWNED BY public.permisos.id;
            public       postgres    false    178            �            1259    50714    roles    TABLE     Z   CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(100)
);
    DROP TABLE public.roles;
       public         postgres    false    6            �            1259    50737    roles_id_seq    SEQUENCE     u   CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public       postgres    false    172    6            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
            public       postgres    false    177            �            1259    50723    roles_permisos    TABLE     o   CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    id_roles integer,
    id_permisos integer
);
 "   DROP TABLE public.roles_permisos;
       public         postgres    false    6            �            1259    50769    roles_permisos_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.roles_permisos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.roles_permisos_id_seq;
       public       postgres    false    6    175            �           0    0    roles_permisos_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.roles_permisos_id_seq OWNED BY public.roles_permisos.id;
            public       postgres    false    180            �            1259    50711    usuarios    TABLE     %  CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100),
    apellido character varying(100),
    foto character varying(1000),
    direccion text,
    telefono character varying(100),
    correo character varying(100),
    password character varying(500)
);
    DROP TABLE public.usuarios;
       public         postgres    false    6            �            1259    50726    usuarios_id_seq    SEQUENCE     x   CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public       postgres    false    171    6            �           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
            public       postgres    false    176            �            1259    50717    usuarios_roles    TABLE     o   CREATE TABLE public.usuarios_roles (
    id integer NOT NULL,
    id_roles integer,
    id_usuarios integer
);
 "   DROP TABLE public.usuarios_roles;
       public         postgres    false    6            �            1259    50753    usuarios_roles_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.usuarios_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.usuarios_roles_id_seq;
       public       postgres    false    173    6            �           0    0    usuarios_roles_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.usuarios_roles_id_seq OWNED BY public.usuarios_roles.id;
            public       postgres    false    179            ;           2604    50747    id    DEFAULT     j   ALTER TABLE ONLY public.permisos ALTER COLUMN id SET DEFAULT nextval('public.permisos_id_seq'::regclass);
 :   ALTER TABLE public.permisos ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    178    174            9           2604    50739    id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    177    172            <           2604    50771    id    DEFAULT     v   ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id SET DEFAULT nextval('public.roles_permisos_id_seq'::regclass);
 @   ALTER TABLE public.roles_permisos ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    180    175            8           2604    50728    id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    176    171            :           2604    50755    id    DEFAULT     v   ALTER TABLE ONLY public.usuarios_roles ALTER COLUMN id SET DEFAULT nextval('public.usuarios_roles_id_seq'::regclass);
 @   ALTER TABLE public.usuarios_roles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    179    173            �          0    50720    permisos 
   TABLE DATA               \   COPY public.permisos (id, nombre, crear, modificar, eliminar, buscar, imprimir) FROM stdin;
    public       postgres    false    174   �5       �           0    0    permisos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.permisos_id_seq', 4, true);
            public       postgres    false    178            �          0    50714    roles 
   TABLE DATA               +   COPY public.roles (id, nombre) FROM stdin;
    public       postgres    false    172   �5       �           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 10, true);
            public       postgres    false    177            �          0    50723    roles_permisos 
   TABLE DATA               C   COPY public.roles_permisos (id, id_roles, id_permisos) FROM stdin;
    public       postgres    false    175   $6       �           0    0    roles_permisos_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.roles_permisos_id_seq', 6, true);
            public       postgres    false    180            �          0    50711    usuarios 
   TABLE DATA               e   COPY public.usuarios (id, nombre, apellido, foto, direccion, telefono, correo, password) FROM stdin;
    public       postgres    false    171   A6       �           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 25, true);
            public       postgres    false    176            �          0    50717    usuarios_roles 
   TABLE DATA               C   COPY public.usuarios_roles (id, id_roles, id_usuarios) FROM stdin;
    public       postgres    false    173   �6       �           0    0    usuarios_roles_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuarios_roles_id_seq', 22, true);
            public       postgres    false    179            F           2606    50752    pk_permisos 
   CONSTRAINT     R   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT pk_permisos PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.permisos DROP CONSTRAINT pk_permisos;
       public         postgres    false    174    174            @           2606    50744    pk_roles 
   CONSTRAINT     L   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.roles DROP CONSTRAINT pk_roles;
       public         postgres    false    172    172            H           2606    50776    pk_roles_permisos 
   CONSTRAINT     ^   ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT pk_roles_permisos PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.roles_permisos DROP CONSTRAINT pk_roles_permisos;
       public         postgres    false    175    175            >           2606    50736    pk_usuarios 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT pk_usuarios;
       public         postgres    false    171    171            B           2606    50766    pk_usuarios_roles 
   CONSTRAINT     ^   ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.usuarios_roles DROP CONSTRAINT pk_usuarios_roles;
       public         postgres    false    173    173            J           2606    50778    un_roles_permisos 
   CONSTRAINT     l   ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT un_roles_permisos UNIQUE (id_roles, id_permisos);
 J   ALTER TABLE ONLY public.roles_permisos DROP CONSTRAINT un_roles_permisos;
       public         postgres    false    175    175    175            D           2606    50768    un_usuarios_roles 
   CONSTRAINT     l   ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT un_usuarios_roles UNIQUE (id_roles, id_usuarios);
 J   ALTER TABLE ONLY public.usuarios_roles DROP CONSTRAINT un_usuarios_roles;
       public         postgres    false    173    173    173            N           2606    50795    fk_roles_permisos_permisos    FK CONSTRAINT     �   ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_permisos FOREIGN KEY (id_permisos) REFERENCES public.permisos(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.roles_permisos DROP CONSTRAINT fk_roles_permisos_permisos;
       public       postgres    false    1862    175    174            M           2606    50790    fk_roles_permisos_roles    FK CONSTRAINT     �   ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT fk_roles_permisos_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.roles_permisos DROP CONSTRAINT fk_roles_permisos_roles;
       public       postgres    false    1856    172    175            K           2606    50780    fk_usuarios_roles_roles    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.usuarios_roles DROP CONSTRAINT fk_usuarios_roles_roles;
       public       postgres    false    1856    173    172            L           2606    50785    fk_usuarios_roles_usuarios    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT fk_usuarios_roles_usuarios FOREIGN KEY (id_usuarios) REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.usuarios_roles DROP CONSTRAINT fk_usuarios_roles_usuarios;
       public       postgres    false    1854    171    173            �   ,   x�3�H-��,�W�ȯ��CF\�Ȓ
���&(�F��1z\\\  2�      �   G   x�3�,-.M,���2���8Sr3�2�K�S����h|#N.N.K��b��<���Բ|����=... :@�      �      x������ � �      �   �   x�3��*M��t��M���SS�0r�v�t�IT(H,.�/J�42� !�,�:��������\�?.
��b�K�V3R��4��o��Z�z��S ��|�����|�AE �r���rR�9������J2�����R��R�<#*�gI]�~1z\\\ ���G      �   .   x�3�4�4���4Q��� �� (jd�eh�F@q ���� ���     