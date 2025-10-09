-- test_functions.sql

-- Tests para super_user
SELECT * FROM super_user;
SELECT create_super_user(
    'ceadl'::varchar,
    'mi4v-aee3-5939'::varchar
); -- Funciona

SELECT validate_super_user(
    'ceadl'::varchar,
    'mi4v-aee3-5939'::varchar
); -- Funciona

-- Tests para profile
SELECT * FROM profiles;
SELECT create_profile(
    'Director'::varchar,
    '903f1648-66a3-41a5-8b86-4a2cbaf4a855'::uuid
); --Funciona
SELECT update_profile(
    'e2189724-e5e1-4f69-9d45-f58ae81c1c16'::uuid,
    'Dasd'::varchar
); --Funciona
SELECT delete_profile(
    'e2189724-e5e1-4f69-9d45-f58ae81c1c16'::uuid
); --Funciona

-- Tests para user
SELECT * FROM users;
SELECT create_user(
    'Samuel Alejandro'::varchar,
    'saalcazar654'::varchar,
    'a1b2c3d4c0'::varchar,
    'cargo'::varchar,
    'firmakjh'::varchar,
    'cbcddd45-9db4-4346-a229-4cb9a6e8e545'::uuid,
    '903f1648-66a3-41a5-8b86-4a2cbaf4a855'::uuid,
    'e2189724-e5e1-4f69-9d45-f58ae81c1c16'::uuid
); --Funciona
SELECT update_user(
    'd87bc509-c518-49ce-ac49-2a87b375eb8b'::uuid,
    'saalcazar'::varchar,
    'nickuser'::varchar,
    'pass'::varchar,
    'cargo'::varchar,
    'firma'::varchar,
    'cbcddd45-9db4-4346-a229-4cb9a6e8e545'::uuid,
    '903f1648-66a3-41a5-8b86-4a2cbaf4a855'::uuid,
    'e2189724-e5e1-4f69-9d45-f58ae81c1c16'::uuid
); --Funciona
SELECT delete_user(
    'd87bc509-c518-49ce-ac49-2a87b375eb8b'::uuid
); --Funciona
SELECT validate_user(
    'saalcazar'::varchar,
    '123789'::varchar
); --Funciona

-- Tests para founder
SELECT * FROM founders;
SELECT create_founder(
    'SAIH-01'::varchar,
    'SAIH - Noruega'::varchar,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); --Funciona
SELECT update_founder(
    '241b385e-420b-49c7-a87c-8a5ff9f1e311'::uuid,
    'SAIH-01'::varchar,
    'SAIH - Suecia'::varchar,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); --Funciona
SELECT delete_founder(
    '241b385e-420b-49c7-a87c-8a5ff9f1e311'::uuid
); --Funciona

-- Tests para projects
SELECT create_project(
    'COD001'::varchar,
    'Proyecto Test'::varchar,
    'Objetivo de prueba'::text,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_projects(); -- Funciona
SELECT read_project(
    '724ca743-104f-40e5-905d-2a89cc683830'::uuid
); -- Funciona
SELECT update_project(
    '724ca743-104f-40e5-905d-2a89cc683830'::uuid,
    'COD002'::varchar,
    'Proyecto Actualizado'::varchar,
    'Nuevo objetivo'::text,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_project(
    '724ca743-104f-40e5-905d-2a89cc683830'::uuid
); -- Funciona

-- Especifics
SELECT create_especific(
    1::smallint,
    'Ejemplo especific'::text,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
);
SELECT list_especifics(); -- Funciona
SELECT read_especific(
    '0d526a8b-9777-475b-b78d-d31d48a6f98a'::uuid
); -- Funciona
SELECT update_especific(
    '0d526a8b-9777-475b-b78d-d31d48a6f98a'::uuid,
    2::smallint,
    'Especificación actualizada'::text,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
); -- Funciona
SELECT delete_especific(
    '0d526a8b-9777-475b-b78d-d31d48a6f98a'::uuid
); -- Funciona

-- Project Results
SELECT create_project_result(
    1::smallint,
    'Resultado ejemplo'::text,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
);
SELECT list_project_results(); -- Funciona
SELECT read_project_result(
    'e50bd1ad-9d4a-4aab-ada9-6685804cbc9d'::uuid
); -- Funciona
SELECT update_project_result(
    'e50bd1ad-9d4a-4aab-ada9-6685804cbc9d'::uuid,
    2::smallint,
    'Resultado actualizado'::text,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_project_result(
    'e50bd1ad-9d4a-4aab-ada9-6685804cbc9d'::uuid
); -- Funciona

-- Project Activities
SELECT create_project_activity(
    1::smallint,
    'Actividad ejemplo'::text,
    'Categoria'::varchar,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_project_activities(); -- Funciona
SELECT read_project_activity(
    '4833195b-06b5-4d0d-99d0-0f8fa21e551d'::uuid
); -- Funciona
SELECT update_project_activity(
    '4833195b-06b5-4d0d-99d0-0f8fa21e551d'::uuid,
    2::smallint,
    'Actividad actualizada'::text,
    'Nueva categoria'::varchar,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_project_activity(
    '4833195b-06b5-4d0d-99d0-0f8fa21e551d'::uuid
); -- Funciona

-- Activities
SELECT create_activity(
    'Actividad'::varchar,
    '2025-09-28'::date,
    '2025-09-29'::date,
    'Lugar'::varchar,
    10::smallint,
    'Objetivo'::text,
    'Resultado esperado'::text,
    'Descripción'::text,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    'f5dce17f-7c8a-4253-8b37-2915b42d6e59'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    'b316872f-83ab-4fe7-99da-5468939ec605'::uuid,
    '50c28fb9-c2b6-4824-912a-fb72d7c3ba73'::uuid
);
SELECT list_activities(); -- Funciona
SELECT read_activity(
    '68420f2d-9b0f-4772-8050-e1a6729d4d7e'::uuid
); -- Funciona
SELECT update_activity(
    '68420f2d-9b0f-4772-8050-e1a6729d4d7e'::uuid,
    'Actividad Actualizada'::varchar,
    '2025-10-01'::date,
    '2025-10-02'::date,
    'Nuevo Lugar'::varchar,
    20::smallint,
    'Nuevo Objetivo'::text,
    'Nuevo Resultado esperado'::text,
    'Nueva Descripción'::text,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    'f5dce17f-7c8a-4253-8b37-2915b42d6e59'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    'b316872f-83ab-4fe7-99da-5468939ec605'::uuid,
    '50c28fb9-c2b6-4824-912a-fb72d7c3ba73'::uuid
); -- Funciona
SELECT delete_activity(
    '68420f2d-9b0f-4772-8050-e1a6729d4d7e'::uuid
); -- Funciona

-- Reports
SELECT create_report(
    'Temáticas'::text,
    'Resultados'::text,
    'Obstáculos'::text,
    'Conclusiones'::text,
    'Anexos'::text,
    true::boolean,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT list_reports(); -- Funciona
SELECT read_report(
    'df75f0ba-2006-40c2-acbb-cafbe2800c95'::uuid
); -- Funciona
SELECT update_report(
    'df75f0ba-2006-40c2-acbb-cafbe2800c95'::uuid,
    'Temáticas actualizadas'::text,
    'Resultados actualizados'::text,
    'Obstáculos actualizados'::text,
    'Conclusiones actualizadas'::text,
    'Anexos actualizados'::text,
    false::boolean,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT delete_report(
    'df75f0ba-2006-40c2-acbb-cafbe2800c95'::uuid
); -- Funciona
SELECT list_reports_by_project(
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
); -- Funciona
SELECT list_reports_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona

-- Quantitatives
SELECT create_quantitative(
    5::smallint,
    '2025-10-01'::date,
    2::smallint,
    3::smallint,
    4::smallint,
    5::smallint,
    6::smallint,
    7::smallint,
    8::smallint,
    6::smallint,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_quantitatives(); -- Funciona
SELECT read_quantitative(
    '904d39b0-6624-4e28-8b79-fcc76a02fc7c'::uuid
); -- Funciona
SELECT update_quantitative(
    '904d39b0-6624-4e28-8b79-fcc76a02fc7c'::uuid,
    10::smallint,
    '2025-10-01'::date,
    3::smallint,
    4::smallint,
    5::smallint,
    6::smallint,
    7::smallint,
    8::smallint,
    9::smallint,
    7::smallint,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_quantitative(
    '904d39b0-6624-4e28-8b79-fcc76a02fc7c'::uuid
); -- Funciona
SELECT list_quantitatives_by_activity(
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT list_quantitatives_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona


-- Applications
SELECT create_application(
    100.50::numeric,
    true::boolean,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT list_applications(); -- Funciona
SELECT read_application(
    '93f81441-c5eb-4044-8745-e16f3e616959'::uuid
); -- Funciona
SELECT update_application(
    'e689a5eb-658b-49c0-b500-6712673055c1'::uuid,
    150.75::numeric,
    false::boolean,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT delete_application(
    'e689a5eb-658b-49c0-b500-6712673055c1'::uuid
); -- Funciona
SELECT list_applications_by_project(
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
); -- Funciona
SELECT list_applications_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_applications_by_activity(
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona

-- Budgets
SELECT create_budget(
    1::smallint,
    'C001'::varchar,
    'Presupuesto ejemplo'::varchar,
    100.00::numeric,
    700.00::numeric,
    '93f81441-c5eb-4044-8745-e16f3e616959'::uuid,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_budgets(); -- Funciona
SELECT read_budget(
    '826db83d-7a0b-4424-a9b1-d2305f464018'::uuid
); -- Funciona
SELECT update_budget(
    '826db83d-7a0b-4424-a9b1-d2305f464018'::uuid,
    2::smallint,
    'C002'::varchar,
    'Presupuesto actualizado'::varchar,
    150.00::numeric,
    1050.00::numeric,
    '93f81441-c5eb-4044-8745-e16f3e616959'::uuid,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_budget(
    '826db83d-7a0b-4424-a9b1-d2305f464018'::uuid
); -- Funciona
SELECT list_budgets_by_application(
    '93f81441-c5eb-4044-8745-e16f3e616959'::uuid
); -- Funciona
SELECT list_budgets_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_budgets_by_founder(
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid
); -- Funciona

-- Accountabilities
SELECT create_accountability(
    100.00::numeric,
    'Recepción'::varchar,
    true::boolean,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT list_accountabilities(); -- Funciona
SELECT read_accountability(
    'bf851d6b-f491-48cb-bdec-6aa8fe297822'::uuid
); -- Funciona
SELECT update_accountability(
    'bf851d6b-f491-48cb-bdec-6aa8fe297822'::uuid,
    150.00::numeric,
    'Nueva Recepción'::varchar,
    false::boolean,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona
SELECT delete_accountability(
    'bf851d6b-f491-48cb-bdec-6aa8fe297822'::uuid
); -- Funciona
SELECT list_accountabilities_by_project(
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
); -- Funciona
SELECT list_accountabilities_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_accountabilities_by_activity(
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
); -- Funciona

-- Surrenders
SELECT create_surrender(
    '2025-09-28'::date,
    'F001'::varchar,
    'C001'::varchar,
    'Descripción'::text,
    100.00::numeric,
    700.00::numeric,
    '866cb325-afda-44f9-821f-b24949c208f4'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT list_surrenders(); -- Funciona
SELECT read_surrender(
    '3f58fceb-a472-4e2f-a0bc-2b35372ef5a5'::uuid
); -- Funciona
SELECT update_surrender(
    '3f58fceb-a472-4e2f-a0bc-2b35372ef5a5'::uuid,
    '2025-10-01'::date,
    'F002'::varchar,
    'C002'::varchar,
    'Descripción actualizada'::text,
    150.00::numeric,
    1050.00::numeric,
    '866cb325-afda-44f9-821f-b24949c208f4'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona
SELECT delete_surrender(
    '3f58fceb-a472-4e2f-a0bc-2b35372ef5a5'::uuid
); -- Funciona
SELECT list_surrenders_by_accountability(
    '866cb325-afda-44f9-821f-b24949c208f4'::uuid
); -- Funciona
SELECT list_surrenders_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
); -- Funciona

-- Tests para data_base_participants

SELECT create_participant(
    'Juan Pérez'::varchar,
    'Masculino'::varchar,
    30::smallint,
    'Organización X'::varchar,
    '555-1234'::varchar,
    'Beneficiario'::varchar,
    'Municipio Y'::varchar,
    'ONG'::varchar,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
);

SELECT read_participant(
    '58996b10-0998-4b98-ab23-868bdd700b10'::uuid
);

SELECT update_participant(
    '58996b10-0998-4b98-ab23-868bdd700b10'::uuid,
    'Juan Pérez Actualizado'::varchar,
    'Masculino'::varchar,
    31::smallint,
    'Organización Y'::varchar,
    '555-5678'::varchar,
    'Voluntario'::varchar,
    'Municipio Z'::varchar,
    'Fundación'::varchar,
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid,
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid,
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid,
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
);

SELECT delete_participant(
    '58996b10-0998-4b98-ab23-868bdd700b10'::uuid
);

SELECT list_participants();

SELECT list_participants_by_project(
    '4cba4850-620b-4889-b19a-c0a3f951c697'::uuid
);

SELECT list_participants_by_founder(
    'd0defc6d-00de-496b-9947-5a18799b4c94'::uuid
);

SELECT list_participants_by_activity(
    '0b1ae499-dfcd-4886-9247-314b65e68bc9'::uuid
);

SELECT list_participants_by_user(
    '38602b0a-5e8a-45ed-b53a-9d330dd704c1'::uuid
);

-- Puedes agregar más pruebas o modificar los valores según tus necesidades.
