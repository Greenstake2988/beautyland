--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Homebrew)
-- Dumped by pg_dump version 14.7 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: oscar
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(100),
    telefono character varying(50)
);


ALTER TABLE public.clientes OWNER TO oscar;

--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: oscar
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientes_id_seq OWNER TO oscar;

--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscar
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: marcas; Type: TABLE; Schema: public; Owner: oscar
--

CREATE TABLE public.marcas (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.marcas OWNER TO oscar;

--
-- Name: marcas_id_seq; Type: SEQUENCE; Schema: public; Owner: oscar
--

CREATE SEQUENCE public.marcas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marcas_id_seq OWNER TO oscar;

--
-- Name: marcas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscar
--

ALTER SEQUENCE public.marcas_id_seq OWNED BY public.marcas.id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: oscar
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    marca_id integer,
    nombre character varying(100),
    color character varying(50)
);


ALTER TABLE public.productos OWNER TO oscar;

--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: oscar
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_id_seq OWNER TO oscar;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscar
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: transacciones; Type: TABLE; Schema: public; Owner: oscar
--

CREATE TABLE public.transacciones (
    id integer NOT NULL,
    producto_id integer,
    monto double precision,
    cantidad integer,
    tipo character varying(10),
    creado_el timestamp without time zone,
    CONSTRAINT check_tipo CHECK (((tipo)::text = ANY ((ARRAY['compra'::character varying, 'venta'::character varying])::text[])))
);


ALTER TABLE public.transacciones OWNER TO oscar;

--
-- Name: transacciones_id_seq; Type: SEQUENCE; Schema: public; Owner: oscar
--

CREATE SEQUENCE public.transacciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_id_seq OWNER TO oscar;

--
-- Name: transacciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oscar
--

ALTER SEQUENCE public.transacciones_id_seq OWNED BY public.transacciones.id;


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: marcas id; Type: DEFAULT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.marcas ALTER COLUMN id SET DEFAULT nextval('public.marcas_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Name: transacciones id; Type: DEFAULT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.transacciones ALTER COLUMN id SET DEFAULT nextval('public.transacciones_id_seq'::regclass);


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: oscar
--

COPY public.clientes (id, nombre, telefono) FROM stdin;
9	America Perez Echeverria	9997405144
10	Angel Ricardo Novelo Sarabia	9851254248
11	Annia	9851214227
12	Azucena 	9851096337
13	Amira	9999003550
14	Ani Lizarraga	9851015200
15	Axa Yantli	9851092154
16	Brauila kuyoc	9851022354
17	Consuelo	9851060439
18	Cecy	9996577575
19	Dafne	9851052821
20	Moguel	9851013134
21	Gema	9851225252
22	Isaura	9851200172
23	Graciela	9992735773
24	Kim	9997664503
25	Karli	9858588068
26	Joel	9984039080
27	Alo Ceballos	9851109841
28	Belen	9858085772
29	Glen	9851052939
30	Jessi	9858580897
31	Karen 	9851096845
32	Ross	9991579201
33	Aurora	9997438245
34	Libo	9851126135
35	Lupita Sarabia	9851010436
36	Lupita Torres	9855931719
37	Lorena Quintal	9851001274
38	Layne	9851169043
39	Maria Fernanda Fernandez Cosgaya	9851143812
40	Marcela Aguilar Ontiveros	9858085286
41	Marissa Irigoyen	9999471614
42	Molina	9999494215
43	Mariana Cuevas	9851053521
44	Marisol Vidal Peniche	9991044032
45	Nelly Sansores	9851173582
46	Natalia Novelo Vidal 	9991109628
47	Priscila Garcia Arzapalo	9851053759
48	Pillar Tello	9851147482
49	Leany	9851228399
50	Paola Zarate	9858085318
51	Patricia Garrido	9851096209
52	Rossana	9992391409
53	Sol	9851154306
54	Valeria Ontiveros Sanchez	9851095016
55	Tamara Lanestossa	9997387420
56	Adda Rubi Ontiveros Alcocer	9851117821
57	Lore 	9858529944
58	Susana Alcocer	9851029016
59	Chely	9858087334
60	Oscar Vazquez	9991653413
\.


--
-- Data for Name: marcas; Type: TABLE DATA; Schema: public; Owner: oscar
--

COPY public.marcas (id, nombre) FROM stdin;
3	Loreal
4	Clinique
5	Mac 
2	Tarte
11	Esteè Lauder
12	Mary Kay
13	Urban Decay
14	Kiehls
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: oscar
--

COPY public.productos (id, marca_id, nombre, color) FROM stdin;
141	13	Base líquida Stay Naked Weightless	20WY
142	13	Base líquida Stay Naked Weightless	20NN
148	13	Muestra Spray Mini 	NA
152	14	Age-Defying Essentials Gift Set	NA
153	14	Calendula Deep Cleansing Foaming Face Wash	NA
157	14	Micro-Dose Trmt 4ml DLX 	NA
158	14	Buttermask DLX 	NA
159	14	GWP KHLS SUITCASE 23 	NA
160	14	Powerful-Strength Dark Circle Reducing Vitamin C Eye Serum	NA
163	14	Vital Skin-Strengthening Super Serum Deluxe Sample	NA
17	3	LAN LASH IDOLE WP SV 23	NA
18	3	MINERAL FdT 12 SIENNA 30ML/6L	NA
19	3	LRP Anth TSColor + AMicel50ml VER22	NA
20	3	AnthToque Seco + EFF GEL 50ml VER22	NA
21	3	PILLOWLIPS SOLIDSRM DRM GLS 1111	NA
22	3	BBUE 14.5 LIGHT BUFF (N)	NA
23	3	RDA MATTE 301 /NP/LDI	NA
24	3	RDA MATTE 506 /NP/LDI	NA
25	3	VERNIS A LEVRES WATER GLOW 203 OS	NA
26	3	VERNIS A LEVRES WATER GLOW 211 OS	NA
27	3	CS UVAge TT SPF50+ 40ml ES EL PT RU	NA
28	3	LAN LASH IDOLE WP X22	NA
29	3	CANDY FLORALE EDT V80ML V0	NA
30	3	CA HOL 20 ULTA CELEBRATE YR BEAUTY	NA
31	3	L ABSOLU LACQUER 168	NA
32	3	UD STONED LIP GLOSS-CITRINE	NA
33	3	TIUW SPF15 024 P/B30ML/RP FF	NA
34	3	TIUW SPF15 050 P/B30ML/RP FF	NA
35	3	PILLOWLIPS LPSTK STELLAR MATTE	NA
36	3	BLSH SUBTL MAKE IT POP 541	NA
37	3	LAR INTIMATTE 888 QIXI 2021 OS	NA
38	3	TIUW STICK BLUSH 01 AMBITIOUS PINK	NA
39	3	TIUW STICK BLUSH 03 WILD RUBY	NA
40	3	POWER FABRIC CONCEALER 6 F6ML	NA
41	3	RPC THE SLIM GLOW MATTE 203	NA
42	3	LC LE 8 (01+CILS) BAS X22	NA
43	3	PILLOWLIPS LPSTK LIKEADREAM MATTE	NA
44	3	YSBB FDTN 30ML MED NEUT 33	NA
45	3	CANDY FLORALE EDT V80ML	NA
46	3	LAR INTIMATTE 278 QIXI 2021 OS	NA
80	2	shape tape™ concealer	light-medium
81	2	face tape™ foundation	Light-medium sand
82	2	tartelette™ energy Amazonian clay palette	multi
83	2	hydroflex™ serum foundation	20S light sand
84	2	shape tape™ best-sellers set	light
85	2	face tape™ foundation	light neutral
86	2	shape tape™ concealer	light-medium sand
87	2	maracuja juicy lip balm	honeysuckle
88	2	limited-edition cheek stain	exposed
89	2	party ready lashes curler & mascara set	multi
90	2	secrets from the Amazon brush set	multi
91	2	shape tape™ concealer	light neutral
92	2	maracuja juicy lip plump	honeysuckle (black cherry)
93	2	limited-edition cheek stain	flush
94	2	bloomin' beauties cheek set	multi
95	2	shape tape™ concealer	light sand
96	2	face tape™ foundation	medium sand
97	2	limited-edition cheek stain	tipsy
98	2	maracuja juicy lip plump	poppy (strawberry)
99	2	sugar rush™ fly squad brush	multi
100	2	Amazonian clay 12-hour blush in bloom	bloom
101	2	face tape™ foundation	light-medium sand
102	2	shape tape™ pressed powder	light-medium sand
103	11	Advanced Night Repair Synchronized Multi-Recovery Complex	NA
104	11	Revitalizing Supreme+ Night Creme	NA
105	11	BLUE TILE PRINT TOTE BAG	NA
106	11	ANGLO 3B	NA
107	11	Double Wear Stay-In-Place Makeup Desert Beige 2N1	NA
108	11	Modern Muse Eau de Parfum en Spray	NA
109	2	shape tape™ concealer	29N light-medium
110	2	face tape™ foundation	27S light-medium sand
113	3	shape tape™ best-sellers set	20B light
114	3	deluxe drink of H2O hydrating boost moisturizer	multi
115	5	Powder Kiss Lipstick	Shocking Revelation
116	5	Retro Matte Liquid Lipcolour	Feels So Grand
117	12	Crema Facial para el Día FPS 30 TimeWise® Age Minimize 3D®	NA
118	12	Dúo de Bronceador en Crema Mary Kay® de Edición Limitada 	Bronze & Shimmer
119	12	Labial con Forma de Corazón Mary Kay® de Edición Limitada 	Natural Confidence
120	12	Labial con Forma de Corazón Mary Kay® de Edición Limitada 	Courageous Pink
121	12	Rizador para pestañas Mary Kay® de Edición Limitada	NA
122	12	Polvo Fijador con Acabado Sedoso Mary Kay® 	Deep Beige
123	12	Polvo Fijador con Acabado Sedoso Mary Kay® 	Light Bronze
124	12	Pro Palette Mary Kay®	NA
125	12	Delineador Líquido para Ojos Mary Kay® )	Negro (tintero
126	12	Rubor en Crema para Labios y Mejillas Mary Kay® de Edición Limitada 	Spiced Berry, Luminoso
127	12	Rubor en Crema para Labios y Mejillas Mary Kay® de Edición Limitada 	Luxe Lilac, Luminoso
128	12	Rubor en Crema para Labios y Mejillas Mary Kay® de Edición Limitada 	Peach Shimmer, Con Destellos
129	12	Brocha en Forma de Corazón Mary Kay® de Edición Limitada	NA
130	12	Polvo de Acabado Mate Mary Kay At Play® de Edición Especial 	Banana Cake, Mate
131	12	Mary Kay Perfect Palette®	NA
132	12	Rubor Compacto Mary Kay Chromafusion® 	Wineberry, Con Destellos
133	12	Rubor Compacto Mary Kay Chromafusion® 	Shy Blush, Con Destellos
134	12	Rubor Compacto Mary Kay Chromafusion® 	Rosy Nude
135	12	Esponja Cosmética Mary Kay®	NA
136	12	Maquillaje Líquido TimeWise 3D® con Acabado Mate 	Bronze W 110, Mate
137	12	Corrector Mary Kay Perfecting Concealer® 	Deep Beige
138	12	CC Cream Crema Correctora de Color con FPS 15 Mary Kay® 	Medium to Deep, Natural
139	12	Maquillaje en Polvo Traslúcido Mineral Mary Kay® 	Beige 1, Traslúcido
140	12	Sacapuntas Mary Kay®	NA
143	13	Base líquida Stay Naked Weightless	30WY
144	13	GWP LIPSTICK BACKTALK FULL SIZE 	NA
145	13	Neceser Toranasol Hot Sale Urban Decay 	NA
146	13	Muestra Primer Potion 2POD	NA
151	14	Day-to-Night Line-Reducing Bundle	NA
154	14	BLACK KIEHL'S CANVAS POUCH	NA
155	14	Midnight Recovery Concentrate	sample
156	14	Calendula Foaming Wash 30ML 	NA
161	14	Age Defender Power Serum	NA
162	14	Facial Fuel Energizing Moisture Treatment for Men	NA
\.


--
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: oscar
--

COPY public.transacciones (id, producto_id, monto, cantidad, tipo, creado_el) FROM stdin;
6	17	361.56	1	compra	2023-05-29 19:11:48.537485
7	18	215.0645161	1	compra	2023-05-29 19:15:01.651407
8	19	205.0645161	1	compra	2023-05-29 19:15:26.084908
9	20	205.0645161	1	compra	2023-05-29 19:15:53.991646
11	22	263.0645161	2	compra	2023-05-29 19:17:55.551835
12	23	319.5645161	1	compra	2023-05-29 19:18:31.981775
13	24	319.5645161	1	compra	2023-05-29 19:19:12.696645
14	25	345.0645161	1	compra	2023-05-29 19:19:35.488008
15	26	345.0645161	1	compra	2023-05-29 19:19:58.425669
16	27	224.0645161	1	compra	2023-05-29 19:27:25.416454
17	28	361.5645161	1	compra	2023-05-29 19:27:44.262588
18	29	1135.064516	1	compra	2023-05-29 19:28:04.106115
19	30	840.0645161	1	compra	2023-05-29 19:28:23.28953
20	31	247.0645161	1	compra	2023-05-29 19:28:41.305323
21	32	207.5645161	1	compra	2023-05-29 19:28:56.245333
22	33	330.0645161	1	compra	2023-05-29 19:29:13.988008
23	34	330.0645161	1	compra	2023-05-29 19:29:29.193992
24	35	226.5645161	1	compra	2023-05-29 19:29:47.716289
25	36	335.0645161	1	compra	2023-05-29 19:30:02.560111
26	37	316.5645161	1	compra	2023-05-29 19:30:17.194547
27	38	250.0645161	1	compra	2023-05-29 19:30:31.136703
28	39	344.0645161	1	compra	2023-05-29 19:30:46.760364
29	40	344.0645161	1	compra	2023-05-29 19:31:01.952002
30	41	384.0645161	1	compra	2023-05-29 19:31:17.580901
31	42	370.0645161	1	compra	2023-05-29 19:31:32.045768
32	43	226.5645161	1	compra	2023-05-29 19:31:47.105655
33	44	237.5645161	1	compra	2023-05-29 19:32:14.816849
34	45	1135.064516	1	compra	2023-05-29 19:32:35.01959
35	46	316.5645161	1	compra	2023-05-29 19:33:05.854987
36	21	262.0645161	1	compra	2023-05-29 19:35:07.17042
42	17	750	1	venta	2023-05-29 21:31:14.570463
43	18	600	1	venta	2023-05-29 21:31:31.398545
44	20	600	1	venta	2023-05-29 21:31:46.922406
45	22	700	1	venta	2023-05-29 21:31:59.75946
46	23	800	1	venta	2023-05-29 21:32:45.084353
47	28	750	1	venta	2023-05-29 21:33:36.605359
48	29	3100	1	venta	2023-05-29 21:33:59.185826
49	30	1700	1	venta	2023-05-29 21:34:17.760683
50	39	850	1	venta	2023-05-29 21:36:48.171378
51	42	750	1	venta	2023-05-29 21:37:02.427093
53	108	1500	1	compra	2023-05-29 22:01:39.772074
54	103	952	1	compra	2023-05-29 22:02:23.479372
55	104	1500	1	compra	2023-05-29 22:02:34.926284
56	105	0	1	compra	2023-05-29 22:07:09.996922
57	106	0	1	compra	2023-05-29 22:08:55.260395
58	107	0	1	compra	2023-05-29 22:09:11.60891
59	46	700	1	venta	2023-05-31 15:50:02.998654
60	80	272	1	compra	\N
61	81	352	2	compra	\N
62	82	396	1	compra	\N
63	83	344	1	compra	\N
64	84	264.8	1	compra	\N
65	85	352	1	compra	\N
66	86	272	1	compra	\N
67	87	212	1	compra	\N
68	88	264	1	compra	\N
69	89	228.8	1	compra	\N
70	90	352.8	1	compra	\N
71	91	272	1	compra	\N
72	92	212	1	compra	\N
73	93	264	1	compra	\N
74	94	576.8	2	compra	\N
75	95	272	1	compra	\N
76	96	352	1	compra	\N
77	97	264	1	compra	\N
78	98	212	1	compra	\N
79	99	177.6	1	compra	\N
80	100	352	2	compra	\N
81	96	704	1	compra	\N
82	101	704	1	compra	\N
83	102	616	2	compra	\N
84	101	970	1	venta	2023-05-31 16:44:54.416974
85	85	950	1	venta	2023-05-31 16:45:21.903999
86	89	380	1	venta	2023-05-31 16:45:45.407469
87	90	680	1	venta	2023-05-31 16:46:18.241719
88	91	750	1	venta	2023-05-31 16:46:45.820246
89	93	680	1	venta	2023-05-31 16:47:14.318759
90	96	980	1	venta	2023-05-31 16:47:48.843238
91	97	680	1	venta	2023-05-31 16:48:19.822692
92	98	500	1	venta	2023-05-31 16:48:41.712016
93	99	550	1	venta	2023-05-31 16:49:05.555481
94	102	870	2	venta	2023-05-31 16:50:08.766902
95	81	970	1	venta	2023-05-31 16:51:13.900414
96	109	272	1	compra	2023-05-31 16:56:08.809835
97	110	352	1	compra	2023-05-31 16:56:22.818956
98	82	396	1	compra	2023-05-31 17:00:00.351172
99	83	344	1	compra	2023-05-31 17:00:25.909178
100	113	264.8	1	compra	2023-05-31 17:00:47.49452
101	114	0	1	compra	2023-05-31 17:01:06.649317
102	115	150	1	compra	2023-05-31 17:30:17.354558
103	116	164.3	1	compra	2023-05-31 17:30:45.893452
166	117	198.78187499999999	1	compra	\N
167	118	103.661875	1	compra	\N
168	119	80.46187499999999	1	compra	\N
169	120	80.46187499999999	1	compra	\N
170	121	105.98187499999999	2	compra	\N
171	122	111.78187499999999	1	compra	\N
172	123	111.78187499999999	1	compra	\N
173	124	150.641875	1	compra	\N
174	125	94.96187499999999	1	compra	\N
175	126	96.12187499999999	1	compra	\N
176	127	96.12187499999999	1	compra	\N
177	128	96.12187499999999	1	compra	\N
178	129	140.78187499999999	4	compra	\N
179	130	118.741875	1	compra	\N
180	131	83.36187499999998	1	compra	\N
181	132	73.50187499999998	1	compra	\N
182	133	73.50187499999998	1	compra	\N
183	134	73.50187499999998	1	compra	\N
184	135	33.481875	2	compra	\N
185	136	170.94187499999998	1	compra	\N
186	137	115.84187499999999	2	compra	\N
187	138	176.16187499999998	2	compra	\N
188	139	86.26187499999999	2	compra	\N
189	140	25.361874999999998	1	compra	\N
190	32	400	1	venta	2023-06-05 23:16:57.425653
191	84	650	1	venta	2023-06-05 23:17:31.257696
192	92	500	1	venta	2023-06-05 23:17:56.347856
193	135	54	1	venta	2023-06-05 23:19:32.941938
194	34	1000	1	venta	2023-06-05 23:24:53.828512
195	129	269	2	venta	2023-06-05 23:25:40.997833
196	121	200	1	venta	2023-06-05 23:27:02.797184
197	37	700	1	venta	2023-06-05 23:29:09.975851
198	137	175	1	venta	2023-06-05 23:29:45.312431
199	136	329	1	venta	2023-06-05 23:30:29.224559
200	129	163	1	venta	2023-06-05 23:33:09.093572
201	143	595	1	compra	2023-06-08 19:04:01.508837
202	142	595	1	compra	2023-06-08 19:04:08.238915
204	141	595	1	compra	2023-06-08 19:05:46.418487
205	144	0	1	compra	2023-06-08 19:53:05.736335
206	145	0	1	compra	2023-06-08 19:53:19.172636
209	148	0	1	compra	2023-06-08 20:07:32.234449
210	146	0	1	compra	2023-06-08 20:07:58.67393
211	158	0	1	compra	2023-06-08 21:06:56.247458
213	159	0	1	compra	2023-06-08 21:09:30.898471
214	161	0	1	compra	2023-06-08 21:10:15.849563
215	151	1900	1	compra	2023-06-08 21:10:53.189842
216	153	592	1	compra	2023-06-08 21:11:29.164265
217	152	1930	1	compra	2023-06-08 21:11:54.189259
218	154	0	1	compra	2023-06-08 21:12:23.985161
219	155	0	1	compra	2023-06-08 21:13:18.165819
220	156	0	1	compra	2023-06-08 21:13:30.848624
221	157	0	1	compra	2023-06-08 21:13:40.357638
222	160	0	1	compra	2023-06-08 21:13:58.333088
223	162	0	1	compra	2023-06-08 21:14:37.884395
224	163	0	1	compra	2023-06-08 21:16:45.31763
\.


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscar
--

SELECT pg_catalog.setval('public.clientes_id_seq', 60, true);


--
-- Name: marcas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscar
--

SELECT pg_catalog.setval('public.marcas_id_seq', 14, true);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscar
--

SELECT pg_catalog.setval('public.productos_id_seq', 163, true);


--
-- Name: transacciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: oscar
--

SELECT pg_catalog.setval('public.transacciones_id_seq', 224, true);


--
-- Name: clientes clientes_nombre_key; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_nombre_key UNIQUE (nombre);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: marcas marcas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_nombre_key UNIQUE (nombre);


--
-- Name: marcas marcas_pkey; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_pkey PRIMARY KEY (id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: transacciones transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id);


--
-- Name: productos uq_producto_color_nombre; Type: CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT uq_producto_color_nombre UNIQUE (color, nombre);


--
-- Name: productos productos_marca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_marca_id_fkey FOREIGN KEY (marca_id) REFERENCES public.marcas(id);


--
-- Name: transacciones transacciones_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: oscar
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- PostgreSQL database dump complete
--

