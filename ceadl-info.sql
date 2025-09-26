CREATE EXTENSION pgcrypto;

--TABLES

CREATE TABLE super_user (
    id_super_user UUID DEFAULT gen_random_uuid() NOT NULL,
    super_user varchar(50) NOT NULL,
    password varchar(255) NOT NULL,
    CONSTRAINT super_user_super_user_uk UNIQUE (super_user)
);

CREATE TABLE profiles (
	id_profile UUID DEFAULT gen_random_uuid() NOT NULL,
    profile varchar(50) NOT NULL,
    id_super_user UUID,
    CONSTRAINT profiles_pk PRIMARY KEY (id_profile),
    CONSTRAINT profiles_uk UNIQUE (profile),
    CONSTRAINT profiles_super_user_fk FOREIGN KEY (id_super_user) REFERENCES super_user (id_super_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE users (
    id_user UUID DEFAULT gen_random_uuid() NOT NULL,
	create_user timestamp NOT NULL DEFAULT now(),
    name_user varchar(150) NOT NULL,
    nick_user varchar(50) NOT NULL,
    password_user varchar(255) NOT NULL,
	charge_user varchar(200) NOT NULL,
    signature_user varchar(255) NOT NULL,
	id_profile UUID NOT NULL,
    id_super_user UUID NOT NULL,
	id_project UUID,
    active boolean NOT NULL DEFAULT true,
    CONSTRAINT users_pk PRIMARY KEY (id_user),
    CONSTRAINT users_name_uk UNIQUE (name_user),
    CONSTRAINT users_nick_uk UNIQUE (nick_user),
    CONSTRAINT users_signature_uk UNIQUE (signature_user),
	CONSTRAINT users_profile_fk FOREIGN KEY (id_profile) REFERENCES profiles(id_profile) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT users_super_user_fk FOREIGN KEY (id_super_user) REFERENCES super_user (id_super_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE founders (
    id_founder UUID DEFAULT gen_random_uuid() NOT NULL,
    create_founder timestamp NOT NULL DEFAULT now(),
    cod_founder varchar(50),
    name_founder varchar(255),
    id_user UUID NOT NULL,
    CONSTRAINT founders_pk PRIMARY KEY (id_founder),
    CONSTRAINT founders_name_uk UNIQUE (name_founder),
    CONSTRAINT founders_cod_founder_uk UNIQUE (cod_founder),
    CONSTRAINT founders_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE projects (
    id_project UUID DEFAULT gen_random_uuid() NOT NULL,
    create_proyect timestamp NOT NULL DEFAULT now(),
    cod_proyect varchar(100) NOT NULL,
    name_proyect varchar(200) NOT NULL,
    objetive text NOT NULL,
    id_founder UUID NOT NULL,
    id_user UUID NOT NULL,
    CONSTRAINT projects_pk PRIMARY KEY (id_project),
    CONSTRAINT projects_uk UNIQUE (cod_proyect),
    CONSTRAINT projects_name_uk UNIQUE (name_proyect),
    CONSTRAINT projects_founder_fk FOREIGN KEY (id_founder) REFERENCES founders(id_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT projects_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE especifics (
    id_especific UUID DEFAULT gen_random_uuid() NOT NULL,
    create_especific timestamp NOT NULL DEFAULT now(),
    num_especific smallint NOT NULL,
    especific text NOT NULL,
    id_user UUID NOT NULL,
    id_project UUID NOT NULL,
    CONSTRAINT especifics_pk PRIMARY KEY (id_especific),
    CONSTRAINT especifics_uk UNIQUE (especific),
    CONSTRAINT especifics_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT especifics_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE project_results (
	id_project_result UUID DEFAULT gen_random_uuid() NOT NULL,
	create_project_result timestamp NOT NULL DEFAULT now(),
	num_project_result smallint NOT NULL,
	project_result text NOT NULL,
	id_project UUID NOT NULL,
    id_user UUID NOT NULL,
	CONSTRAINT project_results_pk PRIMARY KEY (id_project_result),
	CONSTRAINT project_result_uk UNIQUE (project_result),
    CONSTRAINT project_result_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT project_result_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE project_activities(
    id_project_activity UUID DEFAULT gen_random_uuid() NOT NULL,
    create_project_activity timestamp NOT NULL DEFAULT now(),
    num_project_activity smallint NOT NULL,
    project_activity text NOT NULL,
    category varchar(100) NOT NULL,
    id_project UUID NOT NULL,
    id_user UUID NOT NULL,
    CONSTRAINT project_activity_pk PRIMARY KEY (id_project_activity),
    CONSTRAINT project_activity_uk UNIQUE (project_activity),
    CONSTRAINT project_activity_category_uk UNIQUE (category),
    CONSTRAINT project_activity_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT project_activity_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE activities (
    id_activity UUID DEFAULT gen_random_uuid() NOT NULL,
    create_activity timestamp NOT NULL DEFAULT now(),
    activity varchar(200) NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    place varchar(200) NOT NULL,
    participants_expected smallint NOT NULL,
    objetive text NOT NULL,
    result_expected text NOT NULL,
    description_activity text NOT NULL,
    id_project UUID NOT NULL,
    id_especific UUID NOT NULL,
    id_user UUID NOT NULL,
    id_project_result UUID NOT NULL,
    id_project_activity UUID NOT NULL,
    CONSTRAINT activities_pk PRIMARY KEY (id_activity),
    CONSTRAINT activities_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_especific_fk FOREIGN KEY (id_especific) REFERENCES especifics (id_especific) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_project_result_fk FOREIGN KEY (id_project_result) REFERENCES project_results (id_project_result) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_project_activity_fk FOREIGN KEY (id_project_activity) REFERENCES project_activities (id_project_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT activities_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE reports (
    id_report UUID DEFAULT gen_random_uuid() NOT NULL,
    presentation date NOT NULL DEFAULT now(),
    issues text NOT NULL,
    results text NOT NULL,
    obstacle text NOT NULL,
    conclusions text NOT NULL,
    anexos text NOT NULL,
    approved boolean,
    id_user UUID NOT NULL,
    id_project UUID NOT NULL,
    id_activity UUID,
    CONSTRAINT reports_pk PRIMARY KEY (id_report),
    CONSTRAINT reports_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT reports_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE quantitatives (
    id_quantitative UUID DEFAULT gen_random_uuid() NOT NULL,
    achieved smallint NOT NULL CHECK (achieved >= 0),
    day date NOT NULL,
    sp_female smallint NOT NULL CHECK (sp_female >= 0),
    sp_male smallint NOT NULL CHECK (sp_male >= 0),
    f_female smallint NOT NULL CHECK (f_female >= 0),
    f_male smallint NOT NULL CHECK (f_male >= 0),
    na_female smallint NOT NULL CHECK (na_female >= 0),
    na_male smallint NOT NULL CHECK (na_male >= 0),
    p_female smallint NOT NULL CHECK (p_female >= 0),
    p_male smallint NOT NULL CHECK (p_male >= 0),
    id_activity UUID NOT NULL,
    id_user UUID NOT NULL,
    CONSTRAINT quantitatives_pk PRIMARY KEY (id_quantitative),
    CONSTRAINT quantitatives_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT quantitatives_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE applications (
    id_application UUID DEFAULT gen_random_uuid() NOT NULL,
    presentation timestamp NOT NULL DEFAULT now(),
    amount numeric(10,2) NOT NULL CHECK (amount > 0),
    approved boolean DEFAULT false,
    id_project UUID NOT NULL,
    id_user UUID NOT NULL,
    id_activity UUID,
    CONSTRAINT applications_pk PRIMARY KEY (id_application),
    CONSTRAINT applications_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT applications_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE budgets (
    id_budget UUID DEFAULT gen_random_uuid() NOT NULL,
    quantity smallint NOT NULL CHECK (quantity > 0),
    code varchar(50) NOT NULL,
    description varchar(200),
    import_usd numeric(10,2),
    import_bob numeric(10,2),
    id_activity UUID NOT NULL,
    id_founder UUID NOT NULL,
    id_user UUID NOT NULL,
    CONSTRAINT budgets_pk PRIMARY KEY (id_budget),
    CONSTRAINT budgets_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT budgets_founder_fk FOREIGN KEY (id_founder) REFERENCES founders (id_founder) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT budgets_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
);

CREATE TABLE accountabilities (
    id_accountability UUID DEFAULT gen_random_uuid() NOT NULL,
    presentation timestamp NOT NULL DEFAULT now(),
    amount numeric(10,2) NOT NULL CHECK (amount > 0),
    reception varchar(100) NOT NULL,
    approved boolean DEFAULT false,
    id_project UUID NOT NULL,
    id_user UUID NOT NULL,
    id_activity UUID NOT NULL,
    CONSTRAINT accountabilities_pk PRIMARY KEY (id_accountability),
    CONSTRAINT accountabilities_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT accountabilities_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE surrenders (
    id_surrender UUID DEFAULT gen_random_uuid() NOT NULL,
    date_invoice date NOT NULL,
    invoice_number varchar(100) NOT NULL,
    code varchar(100) NOT NULL,
    description text NOT NULL,
    import_usd numeric(10,2),
    import_bob numeric(10,2),
    id_activity UUID NOT NULL,
    id_user UUID NOT NULL,
    CONSTRAINT surrenders_pk PRIMARY KEY (id_surrender),
    CONSTRAINT surrenders_id_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT surrenders_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE audit_profile (
    id_audit_profile UUID DEFAULT gen_random_uuid() NOT NULL,
    create_audit_profile timestamp NOT NULL DEFAULT now(),
    id_user UUID NOT NULL,
    action_audit_profile varchar(20) NOT NULL,
	table_audit_profile varchar(50) NOT NULL,
	last_audit_profile json NOT NULL,
	new_audit_profile json,
	CONSTRAINT audit_profile_pk PRIMARY KEY (id_audit_profile),
    CONSTRAINT audit_profile_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE audit (
	id_audit UUID DEFAULT gen_random_uuid() NOT NULL,
	create_audit timestamp NOT NULL DEFAULT now(),
	id_user UUID NOT NULL,
	action_audit varchar(20) NOT NULL,
	table_audit varchar(50) NOT NULL,
	last_audit json NOT NULL,
	new_audit json,
	CONSTRAINT audit_pk PRIMARY KEY (id_audit),
    CONSTRAINT audit_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE audit_activity (
	id_audit_activity UUID DEFAULT gen_random_uuid() NOT NULL,
	create_audit_activity timestamp NOT NULL DEFAULT now(),
	id_user UUID NOT NULL,
	action_audit_activity varchar(20) NOT NULL,
	table_audit_activity varchar(50) NOT NULL,
	last_audit_activity json NOT NULL,
	new_audit_activity json,
	CONSTRAINT audit_activity_pk PRIMARY KEY (id_audit_activity),
    CONSTRAINT audit_activity_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT
);

--Bases de datos
CREATE TABLE data_base_participants (
	id_participant UUID DEFAULT gen_random_uuid() NOT NULL,
	name_participant varchar(200) NOT NULL,
	gender varchar(50) NOT NULL,
	age smallint NOT NULL CHECK (age > 0),
	organization varchar(200) NOT NULL,
	phone varchar(50),
	type_participant varchar(250) NOT NULL,
	id_project UUID NOT NULL,
    id_founder UUID NOT NULL,
    municipality varchar(100),
    type_organization varchar(200),
	id_activity UUID NOT NULL,
	id_user UUID NOT NULL,
	CONSTRAINT data_base_pk PRIMARY KEY (id_participant),
    CONSTRAINT data_base_user_fk FOREIGN KEY (id_user) REFERENCES users (id_user) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT data_base_activity_fk FOREIGN KEY (id_activity) REFERENCES activities (id_activity) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT data_base_proyect_fk FOREIGN KEY (id_project) REFERENCES projects (id_project) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT data_base_founder_fk FOREIGN KEY (id_founder) REFERENCES founders (id_founder) ON UPDATE RESTRICT ON DELETE RESTRICT
);
