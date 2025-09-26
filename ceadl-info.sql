CREATE EXTENSION pgcrypto;

--TABLES

CREATE TABLE super_user (
    nick varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    CONSTRAINT super_user_nick_uk UNIQUE (nick)
);

CREATE TABLE profiles (
	id_profile smallserial,
    profile varchar(50) NOT NULL,
    nick varchar(50),
    CONSTRAINT profiles_pk PRIMARY KEY (id_profile),
    CONSTRAINT profiles_uk UNIQUE (profile),
    CONSTRAINT profiles_nick_fk FOREIGN KEY (nick) REFERENCES super_user (nick) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE users (
    id_user smallserial,
	create_user date NOT NULL DEFAULT now(),
    name_user varchar(150) NOT NULL,
    nick_user varchar(50) NOT NULL,
    password_user varchar(1000) NOT NULL,
	charge varchar(200) NOT NULL,
    signature varchar(100) NOT NULL,
	profile varchar(50) NOT NULL,
    nick varchar(50),
	name_proyect varchar(200),
    CONSTRAINT users_pk PRIMARY KEY (id_user),
    CONSTRAINT users_name_uk UNIQUE (name_user),
    CONSTRAINT users_uk UNIQUE (nick_user),
    CONSTRAINT users_signature_uk UNIQUE (signature),
	CONSTRAINT users_profile_fk FOREIGN KEY (profile) REFERENCES profiles(profile) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT users_nick_fk FOREIGN KEY (nick) REFERENCES super_user (nick) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE founders (
    id_founder smallserial,
    create_founder date NOT NULL DEFAULT now(),
    cod_founder varchar(50),
    name_founder varchar(200),
    nick_user varchar(50),
    CONSTRAINT founders_pk PRIMARY KEY (id_founder),
    CONSTRAINT founders_name_uk UNIQUE (name_founder),
    CONSTRAINT founders_cod_founder_uk UNIQUE (cod_founder),
    CONSTRAINT founders_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE proyects (
    id_proyect smallserial,
    create_proyect date NOT NULL DEFAULT now(),
    cod_proyect varchar(100) NOT NULL,
    name_proyect varchar(200) NOT NULL,
    objetive text NOT NULL,
    cod_founder varchar(50) NOT NULL,
    nick_user varchar(50),
    CONSTRAINT proyects_pk PRIMARY KEY (id_proyect),
    CONSTRAINT proyects_uk UNIQUE (cod_proyect),
    CONSTRAINT proyects_name_uk UNIQUE (name_proyect),
    CONSTRAINT proyects_cod_founder_fk FOREIGN KEY (cod_founder) REFERENCES founders(cod_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT proyects_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE especifics (
    id_especific smallserial,
    create_especific date NOT NULL DEFAULT now(),
    num_especific smallint NOT NULL,
    especific text NOT NULL,
    nick_user varchar(50),
    name_proyect varchar(100),
    CONSTRAINT especifics_pk PRIMARY KEY (id_especific),
    CONSTRAINT especifics_uk UNIQUE (especific),
    CONSTRAINT especifics_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE project_results (
	id_project_result smallserial,
	create_project_result date NOT NULL DEFAULT now(),
	num_project_result smallint NOT NULL,
	project_result text NOT NULL,
	name_proyect varchar(200) NOT NULL,
    nick_user varchar(100) NOT NULL,
	CONSTRAINT project_results_pk PRIMARY KEY (id_project_result),
	CONSTRAINT project_result_uk UNIQUE (project_result),
    CONSTRAINT project_result_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT project_result_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE project_activities(
    id_project_activity smallserial,
    create_project_activity date NOT NULL DEFAULT now(),
    num_project_activity smallint NOT NULL,
    project_activity text NOT NULL,
    category varchar(100) NOT NULL,
    name_proyect varchar(200) NOT NULL,
    nick_user varchar(100) NOT NULL,
    CONSTRAINT project_activity_pk PRIMARY KEY (id_project_activity),
    CONSTRAINT project_activity_uk UNIQUE (project_activity),
    CONSTRAINT project_activity_category_uk UNIQUE (category),
    CONSTRAINT project_activity_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT project_activity_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE activities (
    id_activity smallserial,
    create_activity timestamp NOT NULL DEFAULT now(),
    activity varchar(200) NOT NULL,
    date_start varchar(50) NOT NULL,
    date_end varchar(50) NOT NULL,
    place varchar(200) NOT NULL,
    expected smallint NOT NULL,
    objetive text NOT NULL,
    result_expected text NOT NULL,
    description text NOT NULL,
    name_proyect varchar(200) NOT NULL,
    cod_founder varchar(200) NOT NULL,
    especific text NOT NULL,
    nick_user varchar(50),
    project_result text,
    project_activity text,
    CONSTRAINT activities_pk PRIMARY KEY (id_activity),
    CONSTRAINT activities_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_cod_founder_fk FOREIGN KEY (cod_founder) REFERENCES founders (cod_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE reports (
    id_report smallserial,
    presentation date NOT NULL DEFAULT now(),
    issues text NOT NULL,
    results text NOT NULL,
    obstacle text NOT NULL,
    conclusions text NOT NULL,
    anexos text NOT NULL,
    approved boolean,
    name_user varchar(200) NOT NULL,
    name_proyect varchar(200) NOT NULL,
    signature varchar(100) NOT NULL,
    cod_founder varchar(200) NOT NULL,
    nick_user varchar(50),
    id_activity smallint,
    CONSTRAINT reports_pk PRIMARY KEY (id_report),
    CONSTRAINT reports_name_user_fk FOREIGN KEY (name_user) REFERENCES users (name_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_signature_fk FOREIGN KEY (signature) REFERENCES users (signature) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE quantitatives (
    id_quantitative smallserial,
    achieved smallint NOT NULL,
    day varchar(50) NOT NULL,
    sp_female smallint NOT NULL,
    sp_male smallint NOT NULL,
    f_female smallint NOT NULL,
    f_male smallint NOT NULL,
    na_female smallint NOT NULL,
    na_male smallint NOT NULL,
    p_female smallint NOT NULL,
    p_male smallint NOT NULL,
    id_activity smallint NOT NULL,
    nick_user varchar(50),
    CONSTRAINT quantitatives_pk PRIMARY KEY (id_quantitative),
    CONSTRAINT quantitatives_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT quantitatives_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE applications (
    id_application smallserial,
    presentation timestamp NOT NULL DEFAULT now(),
    amount smallint NOT NULL,
    approved boolean,
    name_proyect varchar(200) NOT NULL,
    signature varchar(100) NOT NULL,
    name_user varchar(200) NOT NULL,
    nick_user varchar(50),
    id_activity smallint,
    CONSTRAINT applications_pk PRIMARY KEY (id_application),
    CONSTRAINT applications_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_name_user_fk FOREIGN KEY (name_user) REFERENCES users (name_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_signature_fk FOREIGN KEY (signature) REFERENCES users (signature) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE budgets (
    id_budget smallserial,
    quantity smallint NOT NULL,
    code varchar(50) NOT NULL,
    description varchar(200),
    import_usd smallint,
    import_bob smallint,
    id_activity smallint NOT NULL,
    cod_founder varchar(200) NOT NULL,
    nick_user varchar(50),
    CONSTRAINT budgets_pk PRIMARY KEY (id_budget),
    CONSTRAINT budgets_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT budgets_cod_founder_fk FOREIGN KEY (cod_founder) REFERENCES founders (cod_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT budgets_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE accountabilities (
    id_accountability smallserial,
    presentation timestamp NOT NULL DEFAULT now(),
    amount smallint NOT NULL,
    reception varchar(100) NOT NULL,
    cod_founder varchar(200) NOT NULL,
    name_proyect varchar(200) NOT NULL,
    signature varchar(100) NOT NULL,
    name_user varchar(200) NOT NULL,
    nick_user varchar(50),
    id_activity smallint,
    approved boolean,
    CONSTRAINT accountabilities_pk PRIMARY KEY (id_accountability),
    CONSTRAINT accountabilities_cod_founder_fk FOREIGN KEY (cod_founder) REFERENCES founders (cod_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_name_proyect_fk FOREIGN KEY (name_proyect) REFERENCES proyects (name_proyect) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_signature_fk FOREIGN KEY (signature) REFERENCES users (signature) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_name_user_fk FOREIGN KEY (name_user) REFERENCES users (name_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE surrenders (
    id_surrender smallserial,
    date_invoice varchar(50) NOT NULL,
    invoice_number varchar(100) NOT NULL,
    code varchar(100) NOT NULL,
    description text NOT NULL,
    inport_usd smallint,
    inport_bob smallint,
    id_activity smallint NOT NULL,
    nick_user varchar(50),
    CONSTRAINT surrenders_pk PRIMARY KEY (id_surrender),
    CONSTRAINT surrenders_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT surrenders_nick_user_fk FOREIGN KEY (nick_user) REFERENCES users (nick_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE audit_profile (
    id_audit_profile smallserial,
    create_audit_profile timestamp NOT NULL DEFAULT now(),
    nick varchar(50) NOT NULL,
    action_audit_profile varchar(20) NOT NULL,
	table_audit_profile varchar(50) NOT NULL,
	last_audit_profile json NOT NULL,
	new_audit_profile json,
	CONSTRAINT audit_profile_pk PRIMARY KEY (id_audit_profile)
);

CREATE TABLE audit (
	id_audit smallserial,
	create_audit timestamp NOT NULL DEFAULT now(),
	nick_user varchar(50) NOT NULL,
	action_audit varchar(20) NOT NULL,
	table_audit varchar(50) NOT NULL,
	last_audit json NOT NULL,
	new_audit json,
	CONSTRAINT audit_pk PRIMARY KEY (id_audit)
);

CREATE TABLE audit_activity (
	id_audit_activity smallserial,
	create_audit_activity timestamp NOT NULL DEFAULT now(),
	nick_user varchar(50) NOT NULL,
	action_audit_activity varchar(20) NOT NULL,
	table_audit_activity varchar(50) NOT NULL,
	last_audit_activity json NOT NULL,
	new_audit_activity json,
	CONSTRAINT audit_activity_pk PRIMARY KEY (id_audit_activity)
);

--Bases de datos
CREATE TABLE data_base_participants (
	id_participant smallserial,
	name_participant varchar(200) NOT NULL,
	gender varchar(50) NOT NULL,
	age smallint NOT NULL,
	organization varchar(200) NOT NULL,
	phone varchar(50),
	type_participant varchar(250) NOT NULL,
	name_proyect varchar(250) NOT NULL,
    cod_founder varchar(250) NOT NULL,
	activity varchar(250) NOT NULL,
	nick_user varchar(50) NOT NULL,
    municipality varchar(100),
    type_organization varchar(200),
	CONSTRAINT data_base_pk PRIMARY KEY (id_participant)
);