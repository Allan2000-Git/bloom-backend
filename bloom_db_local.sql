PGDMP                     
    y            bloom    14.0    14.0 #    0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    16384    bloom    DATABASE     Y   CREATE DATABASE bloom WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE bloom;
                postgres    false                        3079    24576 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            4           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            �            1259    24588 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    24587    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    211            5           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    210            �            1259    24596    partner    TABLE     K  CREATE TABLE public.partner (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "partnerId" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    logo character varying,
    "primaryColour" character varying
);
    DROP TABLE public.partner;
       public         heap    postgres    false    2            �            1259    24630    partner_access    TABLE     U  CREATE TABLE public.partner_access (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "partnerAccessId" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    "partnerId" uuid NOT NULL,
    "partnerAdminId" uuid NOT NULL,
    "activatedAt" timestamp without time zone,
    "featureLiveChat" boolean NOT NULL,
    "featureTherapy" boolean NOT NULL,
    "accessCode" character varying(6) NOT NULL,
    "therapySessionsRemaining" integer NOT NULL,
    "therapySessionsRedeemed" integer NOT NULL
);
 "   DROP TABLE public.partner_access;
       public         heap    postgres    false    2            �            1259    24620    partner_admin    TABLE        CREATE TABLE public.partner_admin (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "partnerAdminId" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    "partnerId" uuid NOT NULL
);
 !   DROP TABLE public.partner_admin;
       public         heap    postgres    false    2            �            1259    24606    user    TABLE     �  CREATE TABLE public."user" (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "firebaseUid" character varying NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    "languageDefault" character varying NOT NULL
);
    DROP TABLE public."user";
       public         heap    postgres    false    2            w           2604    24591    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            )          0    24588 
   migrations 
   TABLE DATA           ;   COPY public.migrations (id, "timestamp", name) FROM stdin;
    public          postgres    false    211   �/       *          0    24596    partner 
   TABLE DATA           e   COPY public.partner ("createdAt", "updatedAt", "partnerId", name, logo, "primaryColour") FROM stdin;
    public          postgres    false    212   �/       -          0    24630    partner_access 
   TABLE DATA           �   COPY public.partner_access ("createdAt", "updatedAt", "partnerAccessId", "userId", "partnerId", "partnerAdminId", "activatedAt", "featureLiveChat", "featureTherapy", "accessCode", "therapySessionsRemaining", "therapySessionsRedeemed") FROM stdin;
    public          postgres    false    215   50       ,          0    24620    partner_admin 
   TABLE DATA           j   COPY public.partner_admin ("createdAt", "updatedAt", "partnerAdminId", "userId", "partnerId") FROM stdin;
    public          postgres    false    214   �2       +          0    24606    user 
   TABLE DATA           s   COPY public."user" ("createdAt", "updatedAt", "userId", "firebaseUid", name, email, "languageDefault") FROM stdin;
    public          postgres    false    213   ,3       6           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 1, true);
          public          postgres    false    210            �           2606    24627 ,   partner_admin PK_0e8e3a3ec7e3f80389ba84a2207 
   CONSTRAINT     z   ALTER TABLE ONLY public.partner_admin
    ADD CONSTRAINT "PK_0e8e3a3ec7e3f80389ba84a2207" PRIMARY KEY ("partnerAdminId");
 X   ALTER TABLE ONLY public.partner_admin DROP CONSTRAINT "PK_0e8e3a3ec7e3f80389ba84a2207";
       public            postgres    false    214            �           2606    24605 &   partner PK_7640657fe5aec85a4120cbfdd09 
   CONSTRAINT     o   ALTER TABLE ONLY public.partner
    ADD CONSTRAINT "PK_7640657fe5aec85a4120cbfdd09" PRIMARY KEY ("partnerId");
 R   ALTER TABLE ONLY public.partner DROP CONSTRAINT "PK_7640657fe5aec85a4120cbfdd09";
       public            postgres    false    212            �           2606    24637 -   partner_access PK_843575c1a183cd4712ec086aa1d 
   CONSTRAINT     |   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "PK_843575c1a183cd4712ec086aa1d" PRIMARY KEY ("partnerAccessId");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "PK_843575c1a183cd4712ec086aa1d";
       public            postgres    false    215            �           2606    24595 )   migrations PK_8c82d7f526340ab734260ea46be 
   CONSTRAINT     i   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.migrations DROP CONSTRAINT "PK_8c82d7f526340ab734260ea46be";
       public            postgres    false    211            �           2606    24615 #   user PK_d72ea127f30e21753c9e229891e 
   CONSTRAINT     k   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_d72ea127f30e21753c9e229891e" PRIMARY KEY ("userId");
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "PK_d72ea127f30e21753c9e229891e";
       public            postgres    false    213            �           2606    24641 -   partner_access REL_25e7860a2eec1f9366fcfe3a95 
   CONSTRAINT     n   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "REL_25e7860a2eec1f9366fcfe3a95" UNIQUE ("userId");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "REL_25e7860a2eec1f9366fcfe3a95";
       public            postgres    false    215            �           2606    24629 ,   partner_admin REL_825f3ea183aebdb95a52f1f972 
   CONSTRAINT     m   ALTER TABLE ONLY public.partner_admin
    ADD CONSTRAINT "REL_825f3ea183aebdb95a52f1f972" UNIQUE ("userId");
 X   ALTER TABLE ONLY public.partner_admin DROP CONSTRAINT "REL_825f3ea183aebdb95a52f1f972";
       public            postgres    false    214            �           2606    24639 -   partner_access UQ_00611e9118387038c2c74f5e718 
   CONSTRAINT     r   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "UQ_00611e9118387038c2c74f5e718" UNIQUE ("accessCode");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "UQ_00611e9118387038c2c74f5e718";
       public            postgres    false    215            �           2606    24617 #   user UQ_905432b2c46bdcfe1a0dd3cdeff 
   CONSTRAINT     k   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_905432b2c46bdcfe1a0dd3cdeff" UNIQUE ("firebaseUid");
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "UQ_905432b2c46bdcfe1a0dd3cdeff";
       public            postgres    false    213            �           2606    24619 #   user UQ_e12875dfb3b1d92d7d7c5377e22 
   CONSTRAINT     c   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22";
       public            postgres    false    213            �           2606    24652 -   partner_access FK_25e7860a2eec1f9366fcfe3a954    FK CONSTRAINT     �   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "FK_25e7860a2eec1f9366fcfe3a954" FOREIGN KEY ("userId") REFERENCES public."user"("userId");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "FK_25e7860a2eec1f9366fcfe3a954";
       public          postgres    false    3209    215    213            �           2606    24657 -   partner_access FK_60f11a3686ca313f1ac25f689f9    FK CONSTRAINT     �   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "FK_60f11a3686ca313f1ac25f689f9" FOREIGN KEY ("partnerId") REFERENCES public.partner("partnerId");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "FK_60f11a3686ca313f1ac25f689f9";
       public          postgres    false    3207    215    212            �           2606    24642 ,   partner_admin FK_825f3ea183aebdb95a52f1f972c    FK CONSTRAINT     �   ALTER TABLE ONLY public.partner_admin
    ADD CONSTRAINT "FK_825f3ea183aebdb95a52f1f972c" FOREIGN KEY ("userId") REFERENCES public."user"("userId");
 X   ALTER TABLE ONLY public.partner_admin DROP CONSTRAINT "FK_825f3ea183aebdb95a52f1f972c";
       public          postgres    false    214    3209    213            �           2606    24647 ,   partner_admin FK_c7ee0521b73218dd1f0b13e23d5    FK CONSTRAINT     �   ALTER TABLE ONLY public.partner_admin
    ADD CONSTRAINT "FK_c7ee0521b73218dd1f0b13e23d5" FOREIGN KEY ("partnerId") REFERENCES public.partner("partnerId");
 X   ALTER TABLE ONLY public.partner_admin DROP CONSTRAINT "FK_c7ee0521b73218dd1f0b13e23d5";
       public          postgres    false    214    3207    212            �           2606    24662 -   partner_access FK_e25f0b4b2c6fbddc8375b02f73e    FK CONSTRAINT     �   ALTER TABLE ONLY public.partner_access
    ADD CONSTRAINT "FK_e25f0b4b2c6fbddc8375b02f73e" FOREIGN KEY ("partnerAdminId") REFERENCES public.partner_admin("partnerAdminId");
 Y   ALTER TABLE ONLY public.partner_access DROP CONSTRAINT "FK_e25f0b4b2c6fbddc8375b02f73e";
       public          postgres    false    215    3215    214            )   ,   x�3�44363�4411�03�L����uJL�N�KA������ i      *   U   x�}�1�0 �����`�R�n�å�1q������vB�ȟ����,q�j3Q������!G���a�ٛ��i���� /ʼ�      -   _  x����n�H�u�W�~@��b���~��き��l����?R�.�Bv����pT����~�!��O��X&����4����B�n�j����W�T���������`F��R3�p��)���3�R!�*h%��\��kIC~����޾��o�x��0N�!Q���T�H���;h�C�B`�fjk�b����?����'9�.����˔
�Q�R��G��9AO��9RQ��Ϗ�|�u�/���m��2m�%���j�R�����0���������}˟~	Q�|��
ՔR4^�?z���@lx+Qh������+?��NK�dL���T��!k��<�Wb@�u��i�������~ܟ�������-�ұM�i�0�P�`��2���.���O�t��ϧ�K�a��EjR��(��骹�G�P�8Tc�c~���Ӗ�g�#q�j�F��șWX�
�!�d��*c̏R�����g���¹�y��U���1�\���ܘ�����)���-[o����z��z�Ѣi�����iST��/���q��-2DT�l�]�wo�O_���iVdq�W����[omq�9�k��� #ծ������{~���'�-������      ,   x   x�}���0�jk��9�H����%)K��g�ܡ��B���|ٸ��f�o�C��n>xդ!fds��h�S��kE���[[�c��՘�*�4�8,��e'��)ev�^=�5/����J�'�      +   h   x�}�1
�0Eg�ك̷l�(S�sdQ
u|�-����H�4����R,f�fiH���)���ky��;���H*8�v�}~���}��E>��F�{oT������ @     